import hashlib
import subprocess
import sys
import threading
import time
from Queue import Queue, Empty

import os
from os.path import isfile

from conf import *
from parser import parse_packets_and_times

max_parallel_download = 5
threads = Queue()
lock = threading.Lock()
running = True
files = []
retries = {}
md5s = {}


# Returns the MD5 hash of the given filename
def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


# Read MD5 (to avoid red-downloading the same file)
def read_md5_lines():
    with open(trace_dir + '/' + "md5.md5") as f:
        return f.readlines()


def was_downloaded(fname):
    this_dir = os.path.dirname(os.path.realpath(__file__))
    file_path = this_dir + '/' + trace_dir + '/' + fname
    return isfile(file_path) and md5(file_path) == md5s[fname]


def on_curl_exit_func(fname, return_code):
    with lock:
        if not running:
            return

        elif return_code == 0:
            # Start download of next one.
            if len(files) > 0:
                start_download(files[0], on_curl_exit_func)
            # Trigger parsing.
            trigger_parsing(fname)

        else:
            if fname not in retries:
                retries[fname] = 1
            retry = retries[fname]
            if retry <= 2:
                print "Error ({return_code}) while downloading {fname}, retry {retry}...".format(**locals())
                retries[fname] += 1
                start_download(fname, on_curl_exit_func)
            else:
                print "Error ({return_code}) while downloading {fname}, ABORTED.".format(**locals())


def start_curl(fname, on_exit):
    if was_downloaded(fname):
        print "Skipping %s as it has been already downloaded..." % fname
        on_exit(fname, 0)
    else:
        print "Starting download of %s..." % fname
        # Change working dir to trace dir.
        curr_dir = os.path.dirname(os.path.realpath(__file__))
        if not curr_dir.endswith(trace_dir):
            os.chdir(os.path.dirname(os.path.realpath(__file__)) + '/' + trace_dir)
        cmd = "curl --user %s:%s -O -s %s%s" % (caida_user, caida_passwd, trace_url_prefix, fname)
        # Starts curl (subprocess.call blocks until it terminates)
        return_code = subprocess.call(cmd.split(), stderr=subprocess.STDOUT)
        on_exit(fname, return_code)


def start_download(fname, on_exit):
    if fname in files:
        files.remove(fname)
    thread = threading.Thread(target=start_curl, args=(fname, on_exit)).start()
    threads.put(thread)


def trigger_parsing(fname):
    direction, day, ts, extension = parse_trace_fname(fname)
    if extension == 'pcap.gz':
        other_extension = 'times.gz'
    elif extension == 'times.gz':
        other_extension = 'pcap.gz'
    else:
        # Ignore other extensions
        return

    other_fname = trace_fname(direction=direction, day=day, time=ts, extension=other_extension)

    if was_downloaded(other_fname) and was_downloaded(fname):
        # Trigger parsing
        print "Starting parsing of {direction}-{day}-{ts}".format(**locals)
        curr_dir = os.path.dirname(os.path.realpath(__file__))
        if not curr_dir.endswith(trace_dir):
            os.chdir(os.path.dirname(os.path.realpath(__file__)) + '/' + trace_dir)
        for f in (fname, other_fname):
            retcode = subprocess.call(('gunzip', f), stderr=subprocess.STDOUT)
            assert retcode != 0, "unable to gunzip " + f

        pcap_fname = trace_fname(direction=direction, day=day, time=ts, extension='pcap')
        times_fname = trace_fname(direction=direction, day=day, time=ts, extension='times')

        assert isfile(pcap_fname) and isfile(times_fname), \
            "unable to find '.pcap' or '.times' file for trace {direction}-{day}-{ts}".format(**locals)
        try:
            parse_packets_and_times(day, ts, direction)
            os.remove(pcap_fname)
            os.remove(times_fname)
        finally:
            pass


if __name__ == '__main__':

    # Read MD5 from file and store in a dict (file_names as key)
    for (k, v) in (l.split() for l in (l.strip() for l in read_md5_lines())):
        md5s[k] = v

    curr_dir = os.path.dirname(os.path.realpath(__file__))

    for d in directions:
        for t in timestamps:
            for e in extensions:
                parsed_fname = trace_fname(direction=d, day=trace_day, time=t, extension='parsed')
                if not os.path.isfile(curr_dir + '/' + trace_dir + '/' + parsed_fname):
                    files.append(trace_fname(direction=d, day=trace_day, time=t, extension=e))
                else:
                    print "{d}-{trace_day}-{t} already parsed, skipping...".format(**locals())

    print "Starting download of %d files, with max %d in parallel..." % (len(files), max_parallel_download)

    for i in range(min(max_parallel_download, len(files))):
        start_download(files[i], on_curl_exit_func)

    while True:
        try:
            t = threads.get()
            if t is not None:
                t.join()
            time.sleep(1)
        except Empty:
            print "All done!"
        except KeyboardInterrupt:
            print "Bye! There might be some curl processes still alive."
        finally:
            running = False
            sys.exit()

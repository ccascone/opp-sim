import sys
import os
import threading
import time
from Queue import Queue, Empty

from os.path import isfile

from conf import *
from misc import was_downloaded

max_parallel_download = 5
threads = Queue()
running = True
files = Queue()
retries = {}


def on_curl_exit_func(fname, return_code):
    if not running:
        return

    elif return_code == 0:
        # Start download of next one (if any)
        try:
            start_download(files.get())
        except Empty:
            pass

    else:
        if fname not in retries:
            retries[fname] = 1
        retry = retries[fname]
        if retry <= 2:
            print "Error ({return_code}) while downloading {fname}, retry {retry}...".format(**locals())
            retries[fname] += 1
            start_download(fname)
        else:
            print "Error ({return_code}) while downloading {fname}, ABORTED.".format(**locals())


def start_curl(fname):
    if was_downloaded(fname):
        print "Skipping %s as it has been already downloaded..." % fname
        on_curl_exit_func(fname, 0)
    else:
        print "Starting download of %s..." % fname
        # Change working dir to trace dir.
        curr_dir = os.path.dirname(os.path.realpath(__file__))
        if not curr_dir.endswith(trace_dir):
            os.chdir(os.path.dirname(os.path.realpath(__file__)) + '/' + trace_dir)
        cmd = "curl --user %s:%s -O -s %s%s" % (caida_user, caida_passwd, trace_url_prefix, fname)
        # Starts curl (subprocess.call blocks until it terminates)
        # return_code = subprocess.call(cmd.split(), stderr=subprocess.STDOUT, stdout=)
        return_code = os.system(cmd)
        on_curl_exit_func(fname, return_code)


def start_download(fname):
    threads.put(threading.Thread(target=start_curl, args=(fname,), name='curl-' + fname).start())


if __name__ == '__main__':

    curr_dir = os.path.dirname(os.path.realpath(__file__))

    for d in directions:
        for t in timestamps:
            for e in extensions:
                gzipped_fname = trace_fname(direction=d, day=trace_day, time=t, extension=e)
                parsed_fname = trace_fname(direction=d, day=trace_day, time=t, extension='parsed')
                gunzipped_fname = gzipped_fname[0:-3]
                if not isfile(curr_dir + '/' + trace_dir + '/' + parsed_fname):
                    if not isfile(curr_dir + '/' + trace_dir + '/' + gunzipped_fname):
                        files.put(trace_fname(direction=d, day=trace_day, time=t, extension=e))
                    else:
                        print "found {gunzipped_fname}, skipping {gzipped_fname}...".format(**locals())
                else:
                    print "{d}-{trace_day}-{t} already parsed, skipping...".format(**locals())

    print "Starting download of %d files, with max %d in parallel..." % (files.qsize(), max_parallel_download)

    for i in range(max_parallel_download):
        try:
            start_download(files.get())
        except Empty:
            pass

    while True:
        try:
            t = threads.get()
            if t is not None:
                t.join()
            time.sleep(1)
        except Empty:
            print "Thread queue empty."
            print "Exiting..."
            running = False
            sys.exit()
        except KeyboardInterrupt:
            print "Keyboard interrupt."
            print "Exiting..."
            running = False
            sys.exit()

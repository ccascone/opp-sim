import os
import time

from struct import unpack

import conf as caida_conf
import misc
from simpacket import SimPacket


def main(trace_provider, trace_cluster=None, trace_rack=None, trace_day=None, trace_ts=None):
    if trace_provider == 'caida':

        fname_a = caida_conf.trace_dir + '/' + caida_conf.trace_fname('A', trace_day, trace_ts, 'parsed')
        fname_b = caida_conf.trace_dir + '/' + caida_conf.trace_fname('B', trace_day, trace_ts, 'parsed')

        if not os.path.isfile(fname_a) or not os.path.isfile(fname_b):
            raise Exception("Missing CAIDA trace file for direction A or B")

        try:
            with open(fname_a, 'rb') as fa:
                print('Reading %s...' % fname_a, False)
                dump_a = fa.read()
            with open(fname_b, 'rb') as fb:
                print('Reading %s...' % fname_b, False)
                dump_b = fb.read()
        except IOError:
            raise Exception("Unable to read trace file")

    elif trace_provider == 'fb':

        fname = './fb/%s/%s-%s.parsed' % (trace_cluster, trace_cluster, trace_rack)

        if not os.path.isfile(fname):
            raise Exception("Not such FB trace file: %s" % fname)
        try:
            with open(fname, 'rb') as f:
                print('Reading %s...' % fname, False)
                dump_a = f.read()
        except IOError:
            raise Exception("Unable to read trace file %s" % fname)

        dump_b = ''

    else:
        raise Exception("Invalid trace provider %s" % trace_provider)

    tot_pkt_a, rem_a = divmod(len(dump_a), 32.0)
    tot_pkt_b, rem_b = divmod(len(dump_b), 32.0)

    if (rem_a + rem_b) != 0:
        raise Exception("Invalid byte count in file A or B (file size must be multiple of 32 bytes)")

    tot_pkts = tot_pkt_a + tot_pkt_b

    idx_a = 0  # index of next packet to be read from trace A
    idx_b = 0  # ... from trace B
    pkt_a = None
    pkt_b = None

    start_ts = time.time()  # now

    print("Starting simulation (tot_pkts=%s)..." % misc.hnum(tot_pkts))

    while True:

        # Extract packet from direction A
        if not pkt_a and idx_a < tot_pkt_a:
            pkt_a = SimPacket(dump_a, idx_a * 32)
            idx_a += 1
        # Extract packet from direction B
        if not pkt_b and idx_b < tot_pkt_b:
            pkt_b = SimPacket(dump_b, idx_b * 32)
            idx_b += 1
        # Choose between A and B.
        if pkt_a and (not pkt_b or pkt_a.ts_nano <= pkt_b.ts_nano):
            pkt = pkt_a
            pkt_a = None
        elif pkt_b and (not pkt_a or pkt_b.ts_nano <= pkt_a.ts_nano):
            pkt = pkt_b
            pkt_b = None
        else:
            # No more packets to process.
            return

        direct = pkt.direct
        iplen = pkt.iplen
        ts_nano = pkt.ts_nano
        ipsrc = ".".join([str(ord(c)) for c in pkt.ipsrc()])
        ipdst = ".".join([str(ord(c)) for c in pkt.ipdst()])
        proto = unpack("H", pkt.proto())[0]
        sport = unpack("H", pkt.sport())[0]
        dport = unpack("H", pkt.dport())[0]

        print "direct={direct}\t{ts_nano}\tsize={iplen}B\t{ipsrc}:{sport}->{ipdst}:{dport}\tproto={proto}".format(**locals())

        time.sleep(1)


if __name__ == '__main__':
    main(trace_provider='fb', trace_cluster='A', trace_rack='e43e8c29')

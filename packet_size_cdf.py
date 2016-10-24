import conf
import matplotlib.pyplot as plt
from simpacket import SimPacket
from plot import build_date


def plot_cdf(direction,trace_day,trace_ts):
    fname = conf.trace_dir + '/' + conf.trace_fname(direction, trace_day, trace_ts, 'parsed')
    dump = open(fname, 'rb').read()
    tot_pkt = len(dump)/32

    pkt_lengths = [SimPacket(dump, pkt_id*32).iplen for pkt_id in range(tot_pkt)]

    plt.hist(pkt_lengths, bins=100, normed=1, histtype='step', cumulative=True)
    plt.grid(True)
    plt.ylim(0, 1.05)
    plt.xlabel('Packet size [byte]')
    plt.title('CDF packet size - '+str(build_date(trace_day, str(trace_ts)))+' direction '+direction)
    plt.show()

if __name__ == '__main__':
    plot_cdf(direction='A', trace_day=conf.trace_day, trace_ts=130000)
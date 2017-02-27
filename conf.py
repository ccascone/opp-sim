import glob

caida_user = ""
caida_passwd = ""
trace_dir = 'caida'
trace_link = 'equinix-chicago'
trace_url_prefix = "https://data.caida.org/datasets/passive-2015/equinix-chicago/20150219-130000.UTC/"
trace_day = "20150219"
directions = ('A', 'B')
extensions = ("pcap.gz", "pcap.stats", "times.gz")
timestamps = [130000]


# timestamps = [125911, 130000, 130100, 130200, 130300, 130400, 130500, 130600, 130700, 130800, 130900, 131000,
#               131100, 131200, 131300, 131400, 131500, 131600, 131700, 131800, 131900, 132000, 132100, 132200,
#               132300, 132400, 132500, 132600, 132700, 132800, 132900, 133000, 133100, 133200, 133300, 133400,
#               133500, 133600, 133700, 133800, 133900, 134000, 134100, 134200, 134300, 134400, 134500, 134600,
#               134700, 134800, 134900, 135000, 135100, 135200, 135300, 135400, 135500, 135600, 135700, 135800,
#               135900, 140000, 140100, 140200]


def trace_fname(trace_opts, extension):
    trace_opts['city'] = trace_opts['link'].split('-')[1]
    return "{city}-{day}/{link}.dir{direction}.{day}-{time}.UTC.anon.".format(**trace_opts) + extension


def parse_trace_fname(fname):
    """
    Returns direction, day, time, extension for the given trace file name.
    """
    # drop subdir
    fname_pieces = fname.split('/')
    fname = fname_pieces[-1]
    pieces = fname.split('.', 5)
    assert (pieces[3], pieces[4]) == ('UTC', 'anon')
    date = pieces[2].split('-')
    if len(pieces) > 5:
        ext = pieces[5]
    else:
        ext = ''
    trace = dict(provider='caida', link=pieces[0], direction=pieces[1][-1], day=date[0], time=date[1])
    return trace, ext


# Read MD5 (to avoid red-downloading the same file)
def read_md5_lines(dir):
    with open(trace_dir + '/' + dir + '/' + "md5.md5") as f:
        return f.readlines()


def list_all_trace_couples(subdir):
    """
    Merges all bidirectional traffic traces found in trace dir / subdir.
    """
    fnames = glob.glob('./%s/%s/*.parsed' % (trace_dir, subdir))
    trace_opts = [parse_trace_fname(fname)[0] for fname in fnames]
    trace_per_date = dict()
    for trace_opt in trace_opts:
        date = "%s-%s" % (trace_opt['day'], trace_opt['time'])
        if date not in trace_per_date:
            trace_per_date[date] = []
        trace_per_date[date].append(trace_opt)

    result = []

    for date in sorted(trace_per_date.keys()):
        num_traces = len(trace_per_date[date])
        directs = [trace_per_date[date][i]['direction'] for i in range(num_traces)]
        if 'X' in directs:
            result.append(trace_per_date[date][directs.index('X')])
        elif 'A' in directs and 'B' in directs:
            opt = trace_per_date[date][directs.index('A')]
            del opt['direction']
            result.append(opt)

    return result


# md5s = {}
#
# for sub_dir in os.listdir(trace_dir):
#     if os.path.isdir(sub_dir):
#         for line in read_md5_lines(sub_dir):
#             pieces = line.rstrip().split(" ")
#             md5s[sub_dir + '/' + pieces[0]] = pieces[1]
#
#
# print md5s


if __name__ == '__main__':
    print list_all_trace_couples('chicago-20150219')

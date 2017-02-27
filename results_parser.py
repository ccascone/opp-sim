import glob
import pickle
from sys import stderr

import datetime
import time
import os
import progressbar

from misc import percentile, hnum

translator = dict(
    sched_quota_hazard="% concurrency hazards",
    sched_thrpt="Pipeline throughput",
    key_5tuple="5-tuple",
    key_ipsrc_ipdst="ipsrc,ipdst",
    key_ipsrc="ipsrc",
    key_ipsrc16="ipsrc/16",
    key_ipdst="ipdst",
    key_ipdst16="ipdst/16",
    key_proto_dport="proto,dport",
    key_proto_sport="proto,sport",
    key_const="* (constant)",
    pipe_wc="Worst case (100% util with minimum size packets)",
    pipe_rmt="RMT model (640Gb/s with 95% util and variable size packets)",
    cycle_util="util",
    key="Flow key",
    N="Pipeline depth (clock cycles)",
    perc_99th="99th"
)


def ts(word):
    if isinstance(word, (list, tuple)):
        return '-'.join([ts(w) for w in word])
    elif callable(word):
        return ts(word.__name__)
    else:
        word = str(word)
        if word in translator:
            return translator[word]
        else:
            word = word.replace('_', ' ')
            return word


def avg(values):
    return sum(values) / float(len(values))


def perc_99th(values):
    return percentile(sorted(values), 0.99)


def perc_1th(values):
    return percentile(sorted(values), 0.01)


def perc_95th(values):
    return percentile(sorted(values), 0.95)


def median(values):
    return percentile(sorted(values), 0.50)


def thrpt_100(samples):
    """
    Return false if 3 or more samples of sched_thrpt are < 0.99, true otherwise
    """
    thrpt_samples = samples['sched_thrpt']
    return len([x for x in thrpt_samples if x < 0.99]) < 3


def max1(value):
    return min(value, 1)


scales = {'sched_latency_': 'log10L', 'sched_queue_': 'log10L', 'sched_drop_fract': 'log10L'}


def get_scale(y_label):
    """
    Return the first matching scale for y_label, or false
    """
    for label in scales:
        if y_label.startswith(label):
            return scales[label]
    return False


map_funcs = {'sched_thrpt': max1}


def caida_ts(params):
    trace_day = params['trace_day']
    year = int(trace_day[0:4])
    month = int(trace_day[4:6])
    day = int(trace_day[6:8])
    trace_time = params['trace_time']
    hour = int(trace_time[0:2])
    minute = int(trace_time[2:4])
    second = int(trace_time[4:6])
    dt = datetime.datetime(year, month, day, hour, minute, second)
    return time.mktime(dt.timetuple())


group_template = dict(
    y_sample={
        'sched_thrpt': min,
        'sched_latency_99th': max,
        'sched_queue_max_99th': max,
        'sched_queue_sum_99th': max,
    },
    filter_funcs={'sched_latency_99th': thrpt_100, 'sched_queue_util_peak': thrpt_100},
    x_param='N',
    z_param=('Q', 'W'),
    line_param='key',
    meta_samples={'cycle_util': [avg]})

group_template_dim = dict(
    y_sample={
        'sched_drop_fract': (perc_99th, median),
        'sched_latency_99th': max,
        'sched_queue_max_99th': max,
        'sched_queue_sum_99th': max,
    },
    x_param='N',
    z_param=('Q', 'W', 'quelen'),
    line_param='key',
    subdir_param=('quelen'),
    style='linespoints',
    meta_samples={'cycle_util': [avg]})

result_groups = [
    # 'hazard-wc-p-hash':
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key'),
    # 'hazard-wc-min-hash':
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key'),
    # "hazard-rmt-p-hash":
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key'),
    # "hazard-rmt-min-hash":
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key'),
    # "opp-wc":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param='Q', line_param='key'),
    # "opp-rmt-stress":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param='Q', line_param='key'),
    # "opp2-wc":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param=('Q', 'W'), line_param='key'),
    # "opp2-wc-stress_W":
    #    dict(y_sample='sched_thrpt', x_param='W', z_param=('N', 'Q'), line_param='key'),
    # "opp2-rmt-stress_N":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param=('Q', 'W'), line_param='key'),
    # "opp-b2b-mlen-stress-hazard":
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='mlen', style='lines'),
    # "opp-b2b-mlen-stress-thrpt":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param='Q', line_param='mlen'),
    # "opp-b2b-fb-flow-hazard":
    #     dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key'),
    # "opp-b2b-fb-flow-thrpt":
    #     dict(y_sample='sched_thrpt', x_param='N', z_param=('Q', 'W'), line_param='key')
    dict(sim_group='caida-chi15-opp', dest_dir='caida-chi15-opp', **group_template),
    dict(sim_group='caida-chi15-opp-dim', dest_dir='caida-chi15-opp-dim', **group_template_dim),
    dict(sim_group='mawi15-opp-dim', dest_dir='mawi15-opp-dim', **group_template_dim),
    # dict(
    #     sim_group='caida-chi15-opp',
    #     dest_dir='caida-chi15-opp-time-serie',
    #     y_sample={
    #         'sched_thrpt': (min)
    #     },
    #     x_param=caida_ts,
    #     z_param=('Q', 'W'),
    #     line_param='key',
    #     meta_samples={'cycle_util': [avg]}),
]

pickle_parsed_cache = dict()


def do_pickle_parse(conf):
    sim_group = conf['sim_group']
    all_samples = {}

    picklenames = glob.glob('results/%s/*.p' % sim_group)

    if len(picklenames) == 0:
        return all_samples

    bar = progressbar.ProgressBar()
    for filename in bar(picklenames):

        if filename in pickle_parsed_cache:
            results = pickle_parsed_cache[filename]
        else:
            with open(filename, "rb") as f:
                try:
                    results = pickle.load(f)
                    pickle_parsed_cache[filename] = results
                except EOFError:
                    print >> stderr, 'Error while reading', filename
                    continue

        this_sim_params = results['params']
        this_sim_samples = results['samples']

        line_name = this_sim_params[conf['line_param']]
        # this_sim_y_values = this_sim_samples[conf['y_sample']]

        if isinstance(conf['z_param'], (list, tuple)):
            z = tuple([this_sim_params[p] for p in conf['z_param']])
        else:
            z = this_sim_params[conf['z_param']]

        x_param = conf['x_param']
        if callable(x_param):
            x = float(x_param(this_sim_params))
        else:
            x = float(this_sim_params[conf['x_param']])

        if z not in all_samples:
            all_samples[z] = {}

        if x not in all_samples[z]:
            all_samples[z][x] = {}

        if line_name not in all_samples[z][x]:
            all_samples[z][x][line_name] = {}

        # if params['sched'] == OPPScheduler.__name__:
        # Prune results
        for sample_name, samples in this_sim_samples.items():
            if sample_name not in all_samples[z][x][line_name]:
                all_samples[z][x][line_name][sample_name] = []
            all_samples[z][x][line_name][sample_name].extend(samples)

    return all_samples


def parse_result_to_file(conf):
    sim_dest_dir = conf['dest_dir']
    sim_group = conf['sim_group']
    print "\n%s: parsing pickle files for sim group '%s'..." % (sim_dest_dir.upper(), sim_group)

    results = do_pickle_parse(conf)

    line_label = conf['line_param']
    x_label = conf['x_param']

    if 'meta_samples' in conf:
        meta_samples = conf['meta_samples']
    else:
        meta_samples = dict()

    subdir_param_name = None
    subdir_param_idx = None

    z_param = conf['z_param']
    if isinstance(z_param, (tuple, list)):
        z_label = '-'.join(z_param)
        try:
            subdir_param_name = conf['subdir_param']
            subdir_param_idx = z_param.index(conf['subdir_param'])
        except KeyError:
            pass
    else:
        z_label = conf['z_param']

    for z in results:

        if isinstance(z, (tuple, list)):
            z_str = '-'.join([str(i) for i in z])
        else:
            z_str = str(z)

        x_values = sorted(results[z].keys())

        line_names = set()
        for x in x_values:
            line_names.update(results[z][x].keys())
        # Sort line names per translation
        line_names = list(sorted(line_names, key=ts))

        for y_label, y_funcs in conf['y_sample'].items():

            if not isinstance(y_funcs, (tuple, list)):
                y_funcs = [y_funcs]

            for y_func in y_funcs:

                # First row with column names
                data = [map(ts, [x_label] + line_names)]

                # First line is comment
                data[0][0] = "# " + data[0][0]

                y_min = 1
                y_max = 0

                meta_values = {k: [] for k in meta_samples.keys()}

                if subdir_param_name:
                    file_dest_dir = sim_dest_dir + '/%s_%s' % (subdir_param_name, z[subdir_param_idx])
                else:
                    file_dest_dir = sim_dest_dir

                dat_fname = 'dat/' + file_dest_dir + "/%s_%s=%s.%s.dat" % (y_label, z_label, z_str, y_func.__name__)
                pic_fname = 'pdf/' + file_dest_dir + "/%s_%s=%s.%s.pdf" % (y_label, z_label, z_str, y_func.__name__)

                print "Generating %s..." % dat_fname

                skipped_points = 0

                def dummy_func(samples):
                    return True

                filter_func = dummy_func

                if 'filter_funcs' in conf:
                    filter_funcs = conf['filter_funcs']
                    if y_label in filter_funcs:
                        filter_func = filter_funcs[y_label]

                for x in x_values:
                    aggr_values = ['?'] * len(line_names)
                    for line in line_names:
                        if line in results[z][x]:
                            if not filter_func(results[z][x][line]):
                                skipped_points += 1
                                continue

                            this_sim_samples = results[z][x][line]

                            values = this_sim_samples[y_label]

                            if y_label in map_funcs:
                                values = map(map_funcs[y_label], values)

                            aggr_val = y_func(values)
                            aggr_values[line_names.index(line)] = aggr_val
                            y_min = min(y_min, aggr_val)
                            y_max = max(y_max, aggr_val)

                            for meta_sample_name in meta_samples.keys():
                                meta_values[meta_sample_name].extend(this_sim_samples[meta_sample_name])
                        else:
                            print "- warning: missing point %s:%s with %s=%s" % (x, line, z_label, z_str)

                    data.append(map(str, [x] + aggr_values))

                if skipped_points:
                    print "- warning: skipped %s points because of filter function %s" \
                          % (skipped_points, filter_func.__name__)

                if not os.path.exists("plot_data"):
                    os.makedirs("plot_data")

                if not os.path.exists("plot_data/dat/" + file_dest_dir):
                    os.makedirs("plot_data/dat/" + file_dest_dir)

                if not os.path.exists("plot_data/pdf/" + file_dest_dir):
                    os.makedirs("plot_data/pdf/" + file_dest_dir)

                if os.path.isfile("plot_data/" + pic_fname):
                    os.remove("plot_data/" + pic_fname)

                # Write gnuplot dat file
                with open("plot_data/" + dat_fname, "w") as f:

                    print >> f, "# %s" % ts(sim_dest_dir)
                    print >> f, "# %s=%s" % (ts(z_label), z_str)
                    print >> f, "# %s (%s)" % (ts(y_label), ts(y_func.__name__))

                    # Print nicely, aligned in columns
                    col_width = max(len(word) for row in data for word in row) + 2  # padding
                    for row in data:
                        print >> f, "".join(word.ljust(col_width) for word in row)

                title = "%s\\n%s=%s" % (ts(sim_dest_dir), ts(z_label), z)

                meta_pieces = []
                for meta_sample_name, meta_funcs in meta_samples.items():
                    for meta_func in meta_funcs:
                        meta_aggr_value = meta_func(meta_values[meta_sample_name])
                        meta_pieces.append(
                            "%s=%s (%s)" % (ts(meta_sample_name), hnum(meta_aggr_value), meta_func.__name__))

                if len(meta_pieces) > 0:
                    title += ", %s" % ', '.join(meta_pieces)

                # Write gnuplot script
                with open("plot_data/plot.gp", "a") as ps:

                    print >> ps, "\nset output '%s'" % pic_fname

                    print >> ps, "set key outside title '%s' box" % ts(line_label)
                    print >> ps, "set title  \"%s\"" % title
                    print >> ps, "set xlabel '%s'" % ts(x_label)
                    print >> ps, "set ylabel '%s (%s)'" % (ts(y_label), ts(y_func.__name__))

                    scale = get_scale(y_label)
                    if scale:
                        if scale == 'log10L':
                            print >> ps, "set logscale y"
                            print >> ps, 'set format y "10^{%L}"'
                        elif scale == 'log10g':
                            print >> ps, "set logscale y"
                            print >> ps, 'set format y "%g"'
                        else:
                            raise Exception("Unknown scale '%s' for y_label '%s'" % (scale, y_label))
                    else:
                        print >> ps, "unset logscale y"
                        print >> ps, 'set format y "%g"'

                    u_str = "u 1:%d t '%s'"
                    if 'style' in conf:
                        u_str += " w %s" % conf['style']

                    usings = [u_str % (i + 2, ts(line_names[i])) for i in range(len(line_names))]
                    using_str = ", \\\n\t'' ".join(usings)

                    print >> ps, "plot '%s' %s" % (dat_fname, using_str)


def main():
    if not os.path.exists("plot_data"):
        os.makedirs("plot_data")

    with open("plot_data/plot.gp", "w") as ps:
        print >> ps, "# gnuplot script"
        print >> ps, "set terminal pdf linewidth 2.5 size 3.4in,2in"
        print >> ps, "set grid"

    for group in result_groups:
        parse_result_to_file(group)


if __name__ == '__main__':
    main()

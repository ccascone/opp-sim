import glob
import pickle
from sys import stderr

import os

from misc import percentile, hnum

translator = dict(
    sched_quota_hazard="% concurrency hazards",
    sched_thrpt="Pipeline throughput",
    key_5tuple="5-tuple",
    key_ipsrc_ipdst="ipsrc,ipdst",
    key_ipsrc="ipsrc",
    key_proto_dport="proto,dport",
    key_proto_sport="proto,sport",
    key_const="* (constant)",
    pipe_wc="Worst case (100% util with minimum size packets)",
    pipe_rmt="RMT model (640Gb/s with 95% util and variable size packets)",
    cycle_util="util",
    key="Flow key",
    N="Pipeline depth (clock cycles)"
)


def ts(word):
    if isinstance(word, (list, tuple)):
        return '-'.join([ts(w) for w in word])
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


def perc_95th(values):
    return percentile(sorted(values), 0.95)


def median(values):
    return percentile(sorted(values), 0.50)


def thrpt_100(line_samples):
    thrpt_samples = line_samples['sched_thrpt']
    return len([x for x in thrpt_samples if x < 0.99]) < 3


def max1(value):
    return min(value, 1)


scales = {'sched_thrpt': 'lin', 'sched_latency_99th': 'log10', 'sched_queue_util_peak': 'log10'}
filter_funcs = {'sched_latency_99th': thrpt_100, 'sched_queue_util_peak': thrpt_100}
map_funcs = {'sched_thrpt': max1}

result_groups = {
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
    "caida-chi15-opp":
        dict(
            y_sample={
                'sched_thrpt': min,
                'sched_latency_99th': (avg, median, max, perc_95th),
                'sched_queue_util_peak': perc_99th
            },
            x_param='N',
            z_param=('Q', 'W'),
            line_param='key',
            meta_samples={'cycle_util': [avg]})
}


def do_pickle_parse(sim_group):
    conf = result_groups[sim_group]
    all_samples = {}

    for filename in glob.glob('results/%s/*.p' % sim_group):

        with open(filename, "rb") as f:
            try:
                results = pickle.load(f)
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


def parse_result_to_file(sim_group):
    results = do_pickle_parse(sim_group)
    conf = result_groups[sim_group]

    line_label = conf['line_param']
    x_label = conf['x_param']

    if 'meta_samples' in conf:
        meta_samples = conf['meta_samples']
    else:
        meta_samples = dict()

    z_param = conf['z_param']
    if isinstance(z_param, (tuple, list)):
        z_label = '-'.join(z_param)
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
                data = [map(ts, ["# " + x_label] + line_names)]

                y_min = 1
                y_max = 0

                meta_values = {k: [] for k in meta_samples.keys()}

                for x in x_values:
                    aggr_values = ['?'] * len(line_names)
                    for line in line_names:
                        if line in results[z][x]:
                            if y_label in filter_funcs:
                                filter_func = filter_funcs[y_label]
                                if not filter_func(results[z][x][line]):
                                    print >> stderr, \
                                        "Skipping point %s:%s in %s with %s=%s because filter func %s failed" \
                                        % (x, line, sim_group, z_label, z_str, filter_func.__name__)
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
                            print >> stderr, "Missing point %s:%s in %s with %s=%s" % (
                                x, line, sim_group, z_label, z_str)

                    data.append(map(str, [x] + aggr_values))

                dat_fname = sim_group + "_%s-%s_%s=%s.dat" % (y_label, y_func.__name__, z_label, z_str)
                pic_fname = sim_group + "_%s-%s_%s=%s.pdf" % (y_label, y_func.__name__, z_label, z_str)

                if not os.path.exists("plot_data"):
                    os.makedirs("plot_data")

                if os.path.isfile("plot_data/" + pic_fname):
                    os.remove("plot_data/" + pic_fname)

                # Write gnuplot dat file
                with open("plot_data/" + dat_fname, "w") as f:

                    print >> f, "# %s" % ts(sim_group)
                    print >> f, "# %s=%s" % (ts(z_label), z_str)
                    print >> f, "# %s" % ts(y_label)

                    # Print nicely, aligned in columns
                    col_width = max(len(word) for row in data for word in row) + 2  # padding
                    for row in data:
                        print >> f, "".join(word.ljust(col_width) for word in row)

                title = "%s\\n%s=%s" % (ts(sim_group), ts(z_label), z)

                meta_pieces = []
                for meta_sample_name, meta_funcs in meta_samples.items():
                    for meta_func in meta_funcs:
                        meta_aggr_value = meta_func(meta_values[meta_sample_name])
                        meta_pieces.append(
                            "%s=%s (%s)" % (ts(meta_sample_name), hnum(meta_aggr_value), meta_func.__name__))

                if len(meta_pieces) > 0:
                    title += ", %s" % ', '.join(meta_pieces)

                # Write gnuplot script
                with open("plot_data/plot.script", "a") as ps:

                    print >> ps, "\nset output '%s'" % pic_fname

                    print >> ps, "set key outside title '%s' box" % ts(line_label)
                    print >> ps, "set title  \"%s\"" % title
                    print >> ps, "set xlabel '%s'" % ts(x_label)
                    print >> ps, "set ylabel '%s (%s)'" % (ts(y_label), ts(y_func.__name__))

                    if y_label in scales and scales[y_label] != 'lin':
                        scale = scales[y_label]
                        if scale == 'log10':
                            print >> ps, "set logscale y"
                            print >> ps, 'set format y "10^{%L}"'
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

    with open("plot_data/plot.script", "w") as ps:
        print >> ps, "# gnuplot script"
        print >> ps, "set terminal pdf linewidth 2.5 size 3.4in,2in"
        print >> ps, "set grid"

    for group in result_groups:
        parse_result_to_file(group)


if __name__ == '__main__':
    main()

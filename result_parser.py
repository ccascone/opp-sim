import glob
import pickle
from sys import stderr

import datetime
import time
import os
import sys
import progressbar

from misc import percentile, hnum
from sim_params import keys_ccr

translator = dict(
    sched_quota_hazard="Fract data hazards",
    sched_thrpt="Pipeline throughput",
    key_5tuple="5tuple",
    key_ipsrc_ipdst="ipsrc,ipdst",
    key_ipsrc="ipsrc",
    key_ipsrc16="ipsrc16",
    key_ipdst="ipdst",
    key_ipdst16="ipdst16",
    key_proto_dport="proto,dport",
    key_proto_sport="proto,sport",
    key_const="*(global)",
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


p_filter = dict(
    param_filter=dict(
        key=['key_5tuple', 'key_ipdst', 'key_ipdst16', 'key_const']
    )
)

group_template_hazard = dict(
    y_sample={
        'sched_quota_hazard': perc_99th
    },
    x_param='N',
    z_param=('Q', 'W'),
    z_filter=(0, 0),
    line_param='key',
    meta_samples={'cycle_util': [avg]},
    **p_filter
)

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
    meta_samples={'cycle_util': [avg]},
    **p_filter)

group_template_dim = dict(
    y_sample={
        'sched_drop_fract': perc_99th,
        'sched_latency_99th': max,
        'sched_queue_max_99th': max,
        'sched_queue_sum_99th': max,
    },
    x_param='N',
    z_param=('quelen', 'Q', 'W'),
    line_param='key',
    subdir_param=('quelen'),
    style='linespoints',
    meta_samples={'cycle_util': [avg]},
    **p_filter)

result_confs = [
    dict(sim_group='caida-chi15-haz-1F', **group_template_hazard),
    dict(sim_group='caida-chi15-haz-MF', **group_template_hazard),

    dict(sim_group='caida-sj12-haz-1F', **group_template_hazard),
    dict(sim_group='caida-sj12-haz-MF', **group_template_hazard),

    dict(sim_group='mawi15-haz-1F', **group_template_hazard),
    dict(sim_group='mawi15-haz-MF', **group_template_hazard),

    dict(sim_group='fb-haz-1F', **group_template_hazard),

    dict(sim_group='caida-chi15-opp', **group_template),
    dict(sim_group='caida-chi15-opp-dim', trace_name='chi-15', **group_template_dim),

    dict(sim_group='caida-sj12-opp', **group_template),
    dict(sim_group='caida-sj12-opp-dim', trace_name='sj-12', **group_template_dim),

    dict(sim_group='mawi15-opp', **group_template),
    dict(sim_group='mawi15-opp-dim', trace_name='mawi-15', **group_template_dim),

    dict(sim_group='fb-opp', **group_template),
    dict(sim_group='fb-opp-dim', trace_name='fb-web', **group_template_dim),
]

pickle_parsed_cache = dict()


def do_pickle_parse(conf):
    sim_group = conf['sim_group']
    all_samples = {}

    picklenames = glob.glob('results/%s/*.p' % sim_group)

    if len(picklenames) == 0:
        return all_samples

    filtered_count = 0

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

        if 'param_filter' in conf:
            for param_key, param_values in conf['param_filter'].items():
                if param_key in this_sim_params and this_sim_params[param_key] not in param_values:
                    filtered_count += 1
                    continue

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
            x = float(this_sim_params[x_param])
            # FIXME remove me!
            if x_param == 'N' and x > 30:
                filtered_count += 1
                continue

        if z not in all_samples:
            all_samples[z] = {}

        if x not in all_samples[z]:
            all_samples[z][x] = {}

        if line_name not in all_samples[z][x]:
            all_samples[z][x][line_name] = {}

        for sample_name, samples in this_sim_samples.items():
            if sample_name not in all_samples[z][x][line_name]:
                all_samples[z][x][line_name][sample_name] = []
            all_samples[z][x][line_name][sample_name].extend(samples)

    print " - warn: filtered %s results" % filtered_count

    return all_samples


def parse_max_budget(confs, drop_tolerance=0.01, max_N=30):
    max_n_values = dict()
    sim_group_set = set()
    line_name_set = set()
    trace_names = dict()
    for conf in confs:
        sim_group = conf['sim_group']
        trace_names[sim_group] = conf['trace_name']
        sim_group_set.add(sim_group)
        print "Parsing %s..." % sim_group
        results = do_pickle_parse(conf)

        print "done"

        for z in results:
            if z not in max_n_values:
                max_n_values[z] = dict()
            if sim_group not in max_n_values[z]:
                max_n_values[z][sim_group] = dict()
            for x in results[z]:
                # is this the maximum X
                for line_name, line_samples in results[z][x].items():
                    if line_name not in [k.__name__ for k in keys_ccr]:
                        continue
                    line_name_set.add(line_name)
                    if line_name not in max_n_values[z][sim_group]:
                        max_n_values[z][sim_group][line_name] = {
                            'N': -1,
                            'sched_latency_99th': 0,
                            'sched_queue_max_99th': 0,
                            'sched_queue_sum_99th': 0}
                    drop_fract = max(line_samples['sched_drop_fract'])
                    current_record = max_n_values[z][sim_group][line_name]['N']
                    if drop_fract <= drop_tolerance and x > current_record and x <= 30:
                        max_n_values[z][sim_group][line_name] = {
                            'N': x,
                            'sched_latency_99th': max(line_samples['sched_latency_99th']),
                            'sched_queue_max_99th': max(line_samples['sched_queue_max_99th']),
                            'sched_queue_sum_99th': max(line_samples['sched_queue_sum_99th'])}

    sim_groups_sorted = sorted(sim_group_set)
    line_names_sorted = sorted(line_name_set)

    drop_dir = 'drop_%s' % drop_tolerance

    table_line_filter_out = []
    table_trace_filter_out = []
    table_z_str_filter_out = ['10-32-16', '100-32-16']

    table_col_names = ['']
    for sim_group in sim_groups_sorted:
        if trace_names[sim_group] in table_trace_filter_out:
            continue
        for line_name in line_names_sorted:
            if line_name in table_line_filter_out:
                continue
            table_col_names.append('%s-%s' % (trace_names[sim_group], ts(line_name)))

    table_rows = dict()
    for z in sorted(max_n_values.keys()):

        z_param = conf['z_param']
        if isinstance(z_param, (tuple, list)):
            z_label = '-'.join(z_param)
        else:
            z_label = conf['z_param']

        if isinstance(z, (tuple, list)):
            z_str = '-'.join([str(i) for i in z])
        else:
            z_str = str(z)

        table_col_names[0] = z_label

        for param in ['N', 'sched_latency_99th', 'sched_queue_max_99th', 'sched_queue_sum_99th']:

            if param not in table_rows:
                table_rows[param] = [table_col_names]

            if not os.path.isdir('plot_data/dat/max_N_per_drop/%s/%s=%s/' % (drop_dir, z_label, z_str)):
                os.makedirs('plot_data/dat/max_N_per_drop/%s/%s=%s/' % (drop_dir, z_label, z_str))

            dat_fname = "plot_data/dat/max_N_per_drop/%s/%s=%s/%s.dat" % (drop_dir, z_label, z_str, param)

            dat_lines = [[''] + map(ts, line_names_sorted)]

            table_row = [z_str]
            for sim_group in sim_groups_sorted:
                new_line = [trace_names[sim_group]]
                for line_name in line_names_sorted:
                    try:
                        val = int(max_n_values[z][sim_group][line_name][param])
                    except KeyError:
                        val = '?'
                    try:
                        latency_val = int(max_n_values[z][sim_group][line_name]['sched_latency_99th'])
                        latency_val = hnum(10 ** -9 * latency_val) + 's'
                    except KeyError:
                        latency_val = '?'
                    new_line.append(str(val))
                    if trace_names[sim_group] not in table_trace_filter_out \
                            and line_name not in table_line_filter_out:
                        table_row.append(str(val) + ' (%s)' % latency_val)
                for i in range(1, len(sim_groups_sorted)):
                    if new_line[i] != '?':
                        dat_lines.append(new_line)
                        break

            if z_str not in table_z_str_filter_out:
                table_rows[param].append(table_row)

            with open(dat_fname, 'w') as f:
                col_width = max(len(word) for line in dat_lines for word in line) + 2  # padding
                for line in dat_lines:
                    print >> f, "".join(word.ljust(col_width) for word in line)

    for param, rows in table_rows.items():
        if not os.path.isdir('plot_data/dat/max_N_per_drop/tables/%s' % drop_dir):
            os.makedirs('plot_data/dat/max_N_per_drop/tables/%s' % drop_dir)

        tex_name = "plot_data/dat/max_N_per_drop/tables/%s/%s.tex" % (drop_dir, param)

        with open(tex_name, 'w') as f:
            col_width = max(len(word) for row in rows for word in row) + 2  # padding
            for row in rows:
                print >> f, " & ".join(word.ljust(col_width) for word in row) + '\\\\ \\hline'


def parse_result_to_file(conf):
    sim_group = conf['sim_group']
    if 'dest_dir' in conf:
        sim_dest_dir = conf['dest_dir']
    else:
        sim_dest_dir = sim_group

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


def main(prefix):
    if not os.path.exists("plot_data"):
        os.makedirs("plot_data")

    with open("plot_data/plot.gp", "w") as ps:
        print >> ps, "# gnuplot script"
        print >> ps, "set terminal pdf linewidth 2.5 size 3.4in,2in"
        print >> ps, "set grid"

    drop_confs = []
    for conf in result_confs:
        if not prefix or conf['sim_group'].startswith(prefix):
            parse_result_to_file(conf)
            if conf['sim_group'].endswith('-dim'):
                drop_confs.append(conf)
    for drop_tolerance in [0, 0.01, 0.001, 0.0001, 0.00001]:
        parse_max_budget(drop_confs, drop_tolerance=drop_tolerance)


if __name__ == '__main__':
    prefix = sys.argv[1] if len(sys.argv) > 1 else None
    main(prefix)
    # parse_max_budget([result_confs[12]])

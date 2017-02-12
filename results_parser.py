import glob
import pickle
from sys import stderr

import os

import sim_params
from misc import hnum

MAX_VAL = 1
MAX_X = 50
Y_MULTIPLIER = 1
META_KEYS = []  # ['cycle_util']

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
            return word


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
    "opp-b2b-mlen-stress-hazard":
        dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='mlen', style='lines'),
    "opp-b2b-mlen-stress-thrpt":
        dict(y_sample='sched_thrpt', x_param='N', z_param='Q', line_param='mlen'),
}


def avg(values):
    return sum([min(v, MAX_VAL) for v in values]) / len(values)


def err(values):
    # TODO
    return 0


def do_pickle_parse(sim_group):
    conf = result_groups[sim_group]
    parsed_results = {}
    parsed_metadatas = {}

    for filename in glob.glob('results/%s/*.p' % sim_group):

        with open(filename, "rb") as f:
            try:
                results = pickle.load(f)
            except EOFError:
                print >> stderr, 'Error while reading', filename
                continue

        params = results['params']
        samples = results['samples']

        line_name = params[conf['line_param']]
        y_values = samples[conf['y_sample']]

        if isinstance(conf['z_param'], (list, tuple)):
            z = tuple([params[p] for p in conf['z_param']])
        else:
            z = params[conf['z_param']]

        x = float(params[conf['x_param']])

        if z not in parsed_results:
            parsed_results[z] = {}

        if x not in parsed_results[z]:
            parsed_results[z][x] = {}

        assert line_name not in parsed_results[z][x]

        parsed_results[z][x][line_name] = dict(avg=avg(y_values), err=err(y_values))

        parsed_metadatas[z] = {k: dict(avg=avg(samples[k]), err=err(samples[k])) for k in samples}

    return parsed_results, parsed_metadatas


def parse_result_to_file(sim_group):
    results, metadatas = do_pickle_parse(sim_group)
    conf = result_groups[sim_group]

    line_label = conf['line_param']
    x_label = conf['x_param']
    y_label = conf['y_sample']
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

        # First row with column names
        data = [map(ts, ["# " + x_label] + line_names)]

        y_min = 1
        y_max = 0

        for x in x_values:
            avg_values = ['?'] * len(line_names)
            err_values = ['?'] * len(line_names)
            for line in line_names:
                if line in results[z][x]:
                    avg_val = results[z][x][line]['avg'] * Y_MULTIPLIER
                    err_val = results[z][x][line]['err'] * Y_MULTIPLIER
                    avg_values[line_names.index(line)] = avg_val
                    err_values[line_names.index(line)] = err_val
                    y_min = min(y_min, avg_val)
                    y_max = max(y_max, avg_val)
                else:
                    print >> stderr, "Missing point %s:%s in %s with %s=%s" % (x, line, sim_group, z_label, z_str)

            data.append(map(str, [x] + avg_values))

        dat_fname = sim_group + "_%s=%s.dat" % (z_label, z_str)
        pic_fname = sim_group + "_%s=%s.pdf" % (z_label, z_str)

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

        try:
            pipe_conf = sim_params.sim_groups[sim_group]['pipe']
            pipe_name = "pipe_wc" if pipe_conf["read_chunk"] == 0 else "pipe_rmt"
        except:
            pipe_name = 'n/a'

        title = "%s\\n%s=%s" % (ts(pipe_name), ts(z_label), z)

        if len(META_KEYS) > 0:
            metas_str = ", ".join(["%s=%s" % (ts(k), hnum(metadatas[z][k]['avg'])) for k in META_KEYS])
            title += " (%s)" % metas_str

        # Write gnuplot script
        with open("plot_data/plot.script", "a") as ps:

            print >> ps, "\nset output '%s'" % pic_fname

            print >> ps, "set key outside title '%s' box" % ts(line_label)
            print >> ps, "set title  \"%s\"" % title
            print >> ps, "set xlabel '%s'" % ts(x_label)
            print >> ps, "set ylabel '%s'" % ts(y_label)

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

import glob
import subprocess

import os
from sys import stderr
import pickle

import sim_params

translator = dict(
    sched_quota_hazard="% concurrency hazard",
    key_5tuple="5tuple",
    key_ipsrc_ipdst="ipsrc,ipdst",
    key_ipsrc="ipsrc",
    key_proto_dport="proto,dport",
    key_proto_sport="proto,sport",
    key_const="* (constant)",
    pipe_wc="Worst case (100% util with minimum size packets)",
    pipe_rmt="RMT pipeline with 98% util"
)


def ts(word):
    word = str(word)
    if word in translator:
        return translator[word]
    else:
        return word


result_groups = {
    'hazard-wc-p-hash': dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key_func'),
    'hazard-wc-min-hash': dict(y_sample='sched_quota_hazard', x_param='N', z_param='Q', line_param='key_func'),
}


def avg(values):
    return sum(values) / len(values)


def err(values):
    return 0


def do_pickle_parse(sim_group):
    conf = result_groups[sim_group]
    parsed_results = {}
    for filename in glob.glob('results/%s/*.p' % sim_group):

        with open(filename, "rb") as f:
            try:
                results = pickle.load(f)
            except EOFError:
                print >> stderr, 'Error while reading', filename
                continue

        sim_params = results['params']
        sim_samples = results['samples']
        line_name = sim_params[conf['line_param']]
        y_values = sim_samples[conf['y_sample']]

        z = sim_params[conf['z_param']]
        x = float(sim_params[conf['x_param']])

        if z not in parsed_results:
            parsed_results[z] = {}

        if x not in parsed_results[z]:
            parsed_results[z][x] = {}

        assert line_name not in parsed_results[z][x]

        parsed_results[z][x][line_name] = dict()

        parsed_results[z][x][line_name]['avg'] = avg(y_values)
        parsed_results[z][x][line_name]['err'] = err(y_values)

    return parsed_results


def parse_result_to_file(sim_group):
    results = do_pickle_parse(sim_group)
    conf = result_groups[sim_group]

    line_label = conf['line_param']
    x_label = conf['x_param']
    y_label = conf['y_sample']
    z_label = conf['z_param']

    for z in results:
        output = ""
        output += "#%s=%s\n" % (z_label, z)
        lines = []
        x_values = sorted(results[z].keys())
        line_names = set()
        for x in x_values:
            line_names.update(results[z][x].keys())
        line_names = list(sorted(line_names, key=ts))
        data = [map(ts, ["# " + x_label] + line_names)]
        # output += "#%s\n" % "\t".join(map(str, [x_label] + line_names))
        for x in x_values:
            avg_values = [0] * len(line_names)
            err_values = [0] * len(line_names)
            for line in line_names:
                avg_val = "?"
                err_val = "?"
                if line in results[z][x]:
                    avg_val = results[z][x][line]['avg']
                    err_val = results[z][x][line]['err']
                else:
                    print >> stderr, "Missing point %s:%s" % (x, line)

                avg_values[line_names.index(line)] = avg_val

            data.append(map(str, [x] + avg_values))

        if not os.path.exists("plot_data"):
            os.makedirs("plot_data")

        dat_fname = sim_group + "_%s=%s.dat" % (z_label, z)
        pic_fname = sim_group + "_%s=%s.pdf" % (z_label, z)

        pipe = sim_params.sim_groups[sim_group]['pipe']
        pipe_type = "pipe_wc" if pipe["read_chunk"] == 0 else "pipe_rmt"

        with open("plot_data/" + dat_fname, "w") as f:
            print >> f, "# %s" % ts(sim_group)
            print >> f, "# %s=%s" % (ts(z_label), ts(z))
            print >> f, "# %s" % ts(y_label)
            col_width = max(len(word) for row in data for word in row) + 2  # padding
            for row in data:
                print >> f, "".join(word.ljust(col_width) for word in row)

        if os.path.isfile("plot_data/" + pic_fname):
            os.remove("plot_data/" + pic_fname)

        descr = "%s\\n%s=%s" % (ts(pipe_type), ts(z_label), z)

        with open("plot_data/plot.script", "a") as plot_script:
            print >> plot_script, "\nset output \"%s\"" % pic_fname
            print >> plot_script, "set title \"%s\"" % descr
            print >> plot_script, "set xlabel \"%s\"" % ts(x_label)
            print >> plot_script, "set ylabel \"%s\"" % ts(y_label)
            usings = ["u 1:%d t \"%s\"" % (i + 2, ts(line_names[i])) for i in range(len(line_names))]
            using_str = ", \\\n\t'' ".join(usings)
            print >> plot_script, "plot \"%s\" %s" % (dat_fname, using_str)


if __name__ == '__main__':

    if os.path.isfile("plot_data/plot.script"):
        os.remove("plot_data/plot.script")

    with open("plot_data/plot.script", "w") as plot_script:
        print >> plot_script, """ # gnuplot script
    set terminal pdf linewidth 3 size 4in,2.5in
    set key outside title "Flow key" box
    set autoscale
    set grid
    """

    for sim_group in result_groups:
        parse_result_to_file(sim_group)

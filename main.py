import sys
from multiprocessing import Pool, Value
from random import shuffle

import os

import sim_params
from simulator import Simulator

MAX_PROCESS = 2
AVG_SIM_DURATION = sim_params.max_samples + 10  # seconds


class hashabledict(dict):
    def __hash__(self):
        return hash(tuple(sorted(self.items())))


def print_eta(n):
    eta_minutes = ((n * AVG_SIM_DURATION) / MAX_PROCESS) / 60.0
    if eta_minutes < 60:
        print "ETA: %.0f minutes" % eta_minutes
    else:
        eta_hours = eta_minutes / 60
        if eta_hours < 24:
            print "ETA: %.1f hours" % eta_hours
        else:
            print "ETA: %.1f days" % (eta_hours / 24.0)


def worker(param_list):
    trace_params_dict = dict()
    for params in param_list:
        trace_key = hashabledict(params['trace'])
        if trace_key not in trace_params_dict:
            trace_params_dict[trace_key] = list()
        trace_params_dict[trace_key].append(params)

    for trace, param_list in trace_params_dict.items():
        s = Simulator(trace=trace)
        for params in param_list:
            del params['trace']
            s.provision(**params)
            success = s.run(threaded=True, debug=False)
            count.value += 1
            if not success:
                print "Detected error while running simulation, check simulator.log"
            print "Completed %d simulations..." % count.value
            sys.stdout.flush()


if __name__ == '__main__':
    count = Value('i', 0)
    pool = Pool(MAX_PROCESS)

    param_list = sim_params.generate_param_dicts()
    num_simulators = len(param_list)

    print "Will execute %d simulations (pid %d)..." % (num_simulators, os.getpgid(0))
    print_eta(num_simulators)

    shuffle(param_list)

    num_groups = MAX_PROCESS * 2
    param_groups = [list() for _ in range(num_groups)]
    for i in range(len(param_list)):
        g_idx = i % num_groups
        param_groups[g_idx].append(param_list[i])

    pool.map(worker, param_groups)

    print "All done!"

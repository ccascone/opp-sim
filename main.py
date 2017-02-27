import sys
import time
from multiprocessing import Pool, Value, cpu_count, Manager
from random import shuffle

import gc

import sim_params
from misc import hnum
from simulator import Simulator

MAX_PROCESS = 8


class HashableDict(dict):
    def __hash__(self):
        return hash(tuple(sorted(self.items())))


def eta(seconds):
    eta_minutes = seconds / 60.0
    if eta_minutes < 60:
        return "%.0f minutes" % eta_minutes
    else:
        eta_hours = eta_minutes / 60
        if eta_hours < 24:
            return "%.1f hours" % eta_hours
        else:
            return "%.1f days" % (eta_hours / 24.0)


def check_need_to_run(p_list):
    params = dict(**p_list)
    trace = params['trace']
    del params['trace']
    s = Simulator(trace=trace)
    s.provision(**params)
    if s.need_to_run():
        return p_list
    else:
        return None


def worker(ppp):
    p_list, tlist, num_sim = ppp
    trace_params_dict = dict()
    for params in p_list:
        trace_key = HashableDict(params['trace'])
        if trace_key not in trace_params_dict:
            trace_params_dict[trace_key] = list()
        trace_params_dict[trace_key].append(params)

    for trace, p_list in trace_params_dict.items():
        s = Simulator(trace=trace)
        for params in p_list:
            del params['trace']
            s.provision(**params)
            start_time = time.time()
            success = s.run(threaded=True, debug=False)
            delta_time = time.time() - start_time
            count.value += 1
            if not success:
                print "Detected error while running simulation, check simulator.log"
                tlist.append(None)
            else:
                tlist.append(delta_time)
                times = [t for t in tlist if t is not None]
                avg_time = sum(times) / len(times)
                rem_seconds = (num_sim - len(times)) * avg_time
                print "Completed %s/%s simulations [ETA %s / ~%s seconds per sim]..." \
                      % (len(tlist), num_sim, eta(rem_seconds), hnum(avg_time))
            sys.stdout.flush()
            gc.collect()


if __name__ == '__main__':
    count = Value('i', 0)
    pool = Pool(MAX_PROCESS)
    mngr = Manager()
    time_list = mngr.list()

    param_list = sim_params.generate_param_dicts()
    orig_num_simulators = len(param_list)

    print "Asked to execute %d simulations, checking if we can skip some..." % orig_num_simulators

    param_list = pool.map(check_need_to_run, param_list)
    param_list = filter(lambda x: x is not None, param_list)
    num_simulators = len(param_list)

    print "%s were already executed, starting %s simulations..." \
          % (orig_num_simulators - num_simulators, num_simulators)

    shuffle(param_list)

    num_groups = MAX_PROCESS * 2
    param_groups = [list() for _ in range(num_groups)]
    for i in range(len(param_list)):
        g_idx = i % num_groups
        param_groups[g_idx].append(param_list[i])

    worker_params = [(grp, time_list, num_simulators) for grp in param_groups]

    pool.map(worker, worker_params)

    print "All done!"

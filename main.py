import sys
import time
from multiprocessing import Pool, Value, cpu_count, Manager
from random import shuffle

import gc

import sim_params
from misc import hnum, get_trace_label
from simulator import Simulator

MAX_PROCESS = cpu_count()


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

    # trace_set = set(HashableDict(p['trace']) for p in p_list)
    # assert len(trace_set) == 1
    trace = p_list[0]['trace']

    trace_label = get_trace_label(trace) if trace is not None else "none"
    local_num_sim = len(p_list)

    print "Starting worker on trace file %s (%s simulations)..." % (trace_label, len(p_list))

    s = Simulator(trace=trace)

    shuffle(p_list)

    local_count = 0

    for sim_param_dict in p_list:
        del sim_param_dict['trace']
        s.provision(**sim_param_dict)
        start_time = time.time()
        success = s.run(threaded=True, debug=False)
        local_count += 1
        if local_count > 1:
            delta_time = time.time() - start_time
        else:
            # first time it takes a while to load the trace, use dummy value
            delta_time = 3
        if not success:
            print "Detected error while running simulation, check simulator.log"
            tlist.append(None)
        else:
            tlist.append(delta_time)
            times = [t for t in tlist if t is not None]
            avg_time = sum(times) / len(times)
            rem_seconds = ((num_sim - len(times)) * avg_time) / float(MAX_PROCESS)
            print "Completed %s/%s (ETA %s | ~%s sec/sim) [thread:%s %s/%s]..." \
                  % (len(tlist), num_sim, eta(rem_seconds), hnum(avg_time), trace_label, local_count, local_num_sim)
        sys.stdout.flush()
        gc.collect()


def main():
    pool = Pool(MAX_PROCESS)
    mngr = Manager()
    time_list = mngr.list()

    param_list = sim_params.generate_param_dicts()
    orig_num_simulators = len(param_list)

    print "Asked to execute %d simulations, checking if we can skip some..." % orig_num_simulators

    param_list = pool.map(check_need_to_run, param_list)
    param_list = filter(lambda x: x is not None, param_list)
    num_simulators = len(param_list)

    if num_simulators == 0:
        print "All simulations were already exectued, nothing to do here."
        return

    print "%s were already executed, starting %s simulations..." \
          % (orig_num_simulators - num_simulators, num_simulators)

    trace_params_dict = dict()
    for params in param_list:
        trace_key = HashableDict(params['trace']) if params['trace'] is not None else HashableDict({0: 0})
        if trace_key not in trace_params_dict:
            trace_params_dict[trace_key] = list()
        trace_params_dict[trace_key].append(params)

    # shuffle(param_list)

    # num_groups = MAX_PROCESS * 10
    # param_groups = [list() for _ in range(num_groups)]
    # for i in range(len(param_list)):
    #     g_idx = i % num_groups
    #     param_groups[g_idx].append(param_list[i])

    # max_group = max(len(g) for g in param_groups)
    # min_group = min(len(g) for g in param_groups)

    max_sim = max(len(x) for x in trace_params_dict.values())
    min_sim = min(len(x) for x in trace_params_dict.values())

    print "Created %s groups (1 per trace) of execution (%s-%s simulations per group)..." \
          % (len(trace_params_dict), max_sim, min_sim)

    grps = trace_params_dict.values()
    shuffle(grps)

    worker_params = [[grp, time_list, num_simulators] for grp in grps]

    pool.map(worker, worker_params)

    print "All done!"


if __name__ == '__main__':
    main()

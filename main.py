from multiprocessing import Pool, Value

import os

import sim_params
import params
from simulator import Simulator

MAX_PROCESS = 4
AVG_SIM_DURATION = sim_params.max_samples + 10  # seconds


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


def worker(params):
    s = Simulator(**params)
    s.run(threaded=True, debug=False)
    count.value += 1
    print "Completed %d simulations..." % count.value


if __name__ == '__main__':
    count = Value('i', 0)
    pool = Pool(MAX_PROCESS)

    param_list = sim_params.generate_param_dicts(True)
    num_simulators = len(param_list)

    print "Will execute %d simulations (pid %d)..." % (num_simulators, os.getpgid(0))
    print_eta(num_simulators)

    pool.map(worker, param_list)
    print "All done!"

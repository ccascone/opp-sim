import multiprocessing
from multiprocessing import Queue
from Queue import Empty

import progressbar

import params
from simulator import Simulator

if __name__ == '__main__':
    job_queue = Queue()
    running_jobs = Queue()
    running = True
    threads = []
    lock = multiprocessing.Lock()
    completed_jobs = 0


    def worker(waiting_jobs, running_jobs, bar):
        while running:
            try:
                simulator = waiting_jobs.get(block=True, timeout=1)
                running_jobs.put(simulator)
                simulator.run(threaded=True, debug=True)
                with lock:
                    bar.update(bar.value + 1)
            except Empty:
                pass


    for param_dict in params.gen_params():
        job_queue.put_nowait(Simulator(**param_dict))

    completed_jobs = job_queue.qsize()
    print "Will execute %d simulations" % completed_jobs
    widgets = [' [', progressbar.Timer(), '] ', progressbar.Bar(), ' (', progressbar.ETA(), ') ', ]
    bar = progressbar.ProgressBar(widgets=widgets, max_value=completed_jobs)
    bar.update(value=0, force=True)

    for i in range(10):
        t = multiprocessing.Process(target=worker, args=(job_queue, running_jobs, bar))
        t.start()
        threads.append(t)

    try:
        for t in threads:
            t.join()
    except KeyboardInterrupt:
        running = False
        while True:
            try:
                running_jobs.get_nowait().running = False
            except Empty:
                break

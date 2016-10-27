import pickle
import glob
import matplotlib.pyplot as plt
import numpy as np
import datetime


def build_date(yymmdd, hhmmss):
    return datetime.datetime(int(yymmdd[:4]), int(yymmdd[4:6]), int(yymmdd[6:8]), int(hhmmss[:2]), int(hhmmss[2:4]),
                             int(hhmmss[4:6]))


def plot_results():
    thrpt_values = {}  # { (date, Q, N, hash_func, key_func, clock_rate):[thrpt samples] }
    date_values = set([])
    Q_values = set([])
    N_values = set([])
    hash_func_values = set([])
    key_func_values = set([])
    clock_rate_values = set([])

    for filename in glob.glob('results/*.p'):
        with open(filename, "rb") as f:
            try:
                results = pickle.load(f)
            except EOFError:
                print 'Error while reading', filename
                continue
            p = results['params']
            date = build_date(p['trace_day'], str(p['trace_ts']))
            thrpt_values[date, p['Q'], p['N'], p['hash_func'], p['key_func'], p['clock_rate']] = results['samples']['thrpt']
        date_values.add(date)
        Q_values.add(p['Q'])
        N_values.add(p['N'])
        hash_func_values.add(p['hash_func'])
        key_func_values.add(p['key_func'])
        clock_rate_values.add(p['clock_rate'])

    for N in N_values:
        for hash_func in hash_func_values:
            for clock_rate in clock_rate_values:
                for date in sorted(date_values):
                    plt.figure()
                    plt.grid(True)
                    for key_func in key_func_values:
                        # standard deviation = np.std()
                        # standard deviation of the mean = standard error = np.std()/sqrt(len)
                        avg = [np.average(thrpt_values[date, Q, N, hash_func, key_func, clock_rate]) for Q in
                               sorted(Q_values) if
                               (date, Q, N, hash_func, key_func, clock_rate) in thrpt_values]
                        std = [np.std(thrpt_values[date, Q, N, hash_func, key_func, clock_rate]) for Q in sorted(Q_values)
                               if (date, Q, N, hash_func, key_func, clock_rate) in thrpt_values]
                        plt.errorbar(
                            x=[Q for Q in Q_values if (date, Q, N, hash_func, key_func, clock_rate) in thrpt_values], y=avg,
                            yerr=std,
                            label=key_func[4:], fmt='.-')
                    plt.title('%s\n%s, N=%d, clock_freq=%dGHz' % (date, hash_func, N, clock_rate))
                    plt.xlim(
                        [min(Q_values) - 0.1 * (max(Q_values) - min(Q_values)),
                         max(Q_values) + 0.1 * (max(Q_values) - min(Q_values))])
                    plt.xticks(range(min(Q_values), max(Q_values) + 1, 1))
                    plt.xlabel('Q')
                    plt.ylim([0, 1.05])
                    plt.ylabel('Throughput [%]')
                    plt.legend(loc='lower left')
                    plt.setp(plt.gca().get_legend().get_texts(), fontsize='small')
                    plt.show()

    raw_input('Press any key...')

if __name__ == '__main__':
    plot_results()

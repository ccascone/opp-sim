# clock_freq, N, Q, sched, hash, key, read_chunk, line_rate_util
from scheduler import HazardDetector, OPPScheduler
from params import *
from copy import copy

max_samples = 1

wc = dict(clock_freq=0, read_chunk=0, line_rate_util=1)
rmt = dict(clock_freq=10 ** 9, read_chunk=80, line_rate_util=1)

keys_all = [key_5tuple, key_ipsrc_ipdst, key_ipsrc, key_proto_dport, key_proto_sport, key_const]
keys_worst = [key_ipsrc, key_proto_dport, key_proto_sport, key_const]
defaults = dict(trace_day=conf.trace_day, trace_ts=130000, max_samples=max_samples)

sim_groups = {
    "hazard-wc-p-hash":
        dict(pipe=wc, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=0, hashf=hash_perfect),
    "hazard-wc-min-hash":
        dict(pipe=wc, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=[4, 8], hashf=hash_crc16),
    "hazard-rmt-p-hash":
        dict(pipe=rmt, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=0, hashf=hash_perfect),
    "hazard-rmt-min-hash":
        dict(pipe=rmt, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=[4, 8], hashf=hash_crc16),
    "opp-wc":
        dict(pipe=wc, sched=OPPScheduler, key=keys_worst, N=range(1, 17), Q=[1, 4, 8], hashf=hash_crc16),
    "opp-rmt":
        dict(pipe=wc, sched=OPPScheduler, key=keys_worst, N=16, Q=range(1, 9), hashf=hash_crc16),
}


def generate_param_dicts(unfolded=False):
    result = {}
    for sim_name in sim_groups:
        param_dicts = [dict(sim_group=sim_name, **defaults)]
        sim_group = sim_groups[sim_name]
        for param_name in ["sched", "pipe", "key", "N", "Q", "hashf"]:
            param_value = sim_group[param_name]
            if isinstance(param_value, (list, tuple)):
                new_param_dicts = []
                for val in param_value:
                    for param_dict in param_dicts:
                        d = copy(param_dict)
                        d[param_name] = val
                        new_param_dicts.append(d)
                param_dicts = new_param_dicts
            elif isinstance(param_value, (dict,)):
                for param_dict in param_dicts:
                    param_dict.update(param_value)
            else:
                for param_dict in param_dicts:
                    param_dict[param_name] = param_value
        result[sim_name] = param_dicts

    if unfolded:
        new_result = []
        for name in result:
            new_result.extend(result[name])
        return new_result

    return result


if __name__ == '__main__':

    r = generate_param_dicts(False)
    for sim_name in generate_param_dicts():
        print "##\n## %s \n##" % sim_name
        data = []
        for d in r[sim_name]:
            data.append(["%s=%s" % (n, v.__name__ if callable(v) else v) for n, v in d.items()])

        col_width = max(len(word) for row in data for word in row) + 2
        for row in data:
            print "".join(word.ljust(col_width) for word in row)

# clock_freq, N, Q, sched, hash, key, read_chunk, line_rate_util
from scheduler import HazardDetector, OPPScheduler
from params import *
from copy import copy

max_samples = 30

defaults = dict(max_samples=max_samples)

caida = dict(trace_provider='caida', trace_day=conf.trace_day, trace_ts=130000)
fb = dict(trace_provider='fb', trace_cluster='B', trace_rack='bace22a7')

# Pipelines
wc = dict(clock_freq=0, read_chunk=0, line_rate_util=1)
rmt_100 = dict(clock_freq=10 ** 9, read_chunk=80, line_rate_util=1)
rmt_b2b = dict(clock_freq=0, read_chunk=80, line_rate_util=1)

# Key sets
keys_all = [key_5tuple, key_ipsrc_ipdst, key_ipsrc, key_proto_dport, key_proto_sport, key_const]
keys_worst = [key_ipsrc, key_proto_dport, key_proto_sport, key_const]
keys_min = [key_proto_sport, key_5tuple, key_const]

qw_conf_1 = [
    dict(Q=1, W=[4, 8]),
    dict(Q=4, W=[4, 8]),
    dict(Q=8, W=[8, 16]),
    dict(Q=16, W=[16, 32])
]

qw_conf_2 = [
    dict(Q=1, W=[4, 8]),
    dict(Q=4, W=[4, 8]),
    dict(Q=8, W=[8, 16]),
]

sim_groups = {
    # "hazard-wc-p-hash":
    #     dict(pipe=wc, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=0, hashf=hash_perfect),
    # "hazard-wc-min-hash":
    #     dict(pipe=wc, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=[4, 8], hashf=hash_crc16),
    # "hazard-rmt-p-hash":
    #     dict(pipe=rmt, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=0, hashf=hash_perfect),
    # "hazard-rmt-min-hash":
    #     dict(pipe=rmt, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=[4, 8], hashf=hash_crc16),
    # "opp2-wc":
    #     dict(pipe=wc, sched=OPPScheduler, key=keys_all, N=range(1, 51), qw=qw_conf_1, hashf=hash_crc16),
    # "opp2-wc-stress_W":
    #     dict(pipe=wc, sched=OPPScheduler, key=keys_all, N=10, Q=1, W=[2 ** x for x in range(9)], hashf=hash_crc16),
    # "opp2-rmt-stress_N":
    #     dict(pipe=rmt_100, sched=OPPScheduler, key=keys_all, N=range(1, 51), qw=qw_conf_2, hashf=hash_crc16),
    # "opp2-rmt-b2b-stress_chunk":
    #     dict(sched=HazardDetector, key=key_const, N=10, Q=1, W=1, clock_freq=0, read_chunk=range(80, 1501, 142),
    #          line_rate_util=1, hashf=hash_crc16),
    # "opp-b2b-mlen-stress-hazard":
    #     dict(sched=HazardDetector, key=key_const, N=range(1, 21), Q=1, W=1, clock_freq=0,
    #          mlen=[x / 100.0 for x in range(0, 110, 10)], hashf=hash_crc16, read_chunk=80),
    # "opp-b2b-mlen-stress-thrpt":
    #     dict(sched=HazardDetector, key=key_const, N=range(1, 21), Q=1, W=1, clock_freq=0,
    #          mlen=[x / 100.0 for x in range(0, 110, 10)], hashf=hash_crc16, read_chunk=80),
    "opp-b2b-fb-flow-hazard":
        dict(trace=fb, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=1, W=1, clock_freq=0,
             hashf=hash_crc16, read_chunk=80),
    "opp-b2b-fb-flow-thrpt":
        dict(trace=fb, sched=OPPScheduler, key=keys_all, N=range(1, 51), qw=qw_conf_2, clock_freq=0,
             hashf=hash_crc16, read_chunk=80)
}


def explode_param_list(other_list, original_list, p_name=None):
    new_p_dicts = []
    for val in other_list:
        for p_dict in original_list:
            d = copy(p_dict)
            if isinstance(val, dict):
                d.update(val)
            else:
                assert p_name is not None
                d[p_name] = val
            new_p_dicts.append(d)
    return new_p_dicts


def explode_lines(sim_lines):
    new_sim_lines = []
    for sim_line in sim_lines:
        p_dicts = [{}]
        for p_name in sim_line:
            p_value = sim_line[p_name]
            if isinstance(p_value, (list, tuple)):
                p_dicts = explode_param_list(original_list=p_dicts, other_list=p_value, p_name=p_name)
                p_dicts = explode_lines(p_dicts)
            elif isinstance(p_value, (dict,)):
                other_sim_lines = explode_lines([p_value])
                p_dicts = explode_param_list(original_list=p_dicts, other_list=other_sim_lines)
            else:
                for p_dict in p_dicts:
                    p_dict[p_name] = p_value
        new_sim_lines.extend(p_dicts)
    return new_sim_lines


def generate_param_dicts():
    result = []
    for sim_name in sim_groups:
        sim_line = sim_groups[sim_name]
        sim_line['sim_group'] = sim_name
        # apply defaults
        sim_line.update(defaults)
        result.extend(explode_lines([sim_line]))
    return result


if __name__ == '__main__':

    param_dicts = generate_param_dicts()
    data = []
    for pd in param_dicts:
        data.append(["%s=%s" % (n, v.__name__ if callable(v) else v) for n, v in pd.items()])

    col_width = max(len(word) for row in data for word in row) + 2
    for row in data:
        print "".join(word.ljust(col_width) for word in row)

    print len(param_dicts)

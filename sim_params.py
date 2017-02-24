# clock_freq, N, Q, sched, hash, key, read_chunk, line_rate_util
from scheduler import HazardDetector, OPPScheduler
from params import *
from copy import copy

max_samples = 30

#defaults = dict(max_samples=max_samples)
defaults = dict()

caida_2015_chicago_dates = [('20150219', '125911'), ('20150219', '130000'), ('20150219', '130100'),
                            ('20150219', '130200'), ('20150219', '130300'), ('20150219', '130400'),
                            ('20150219', '130500'), ('20150219', '130600'), ('20150219', '130700'),
                            ('20150219', '130800'), ('20150219', '130900'), ('20150219', '131000'),
                            ('20150219', '131100'), ('20150219', '131200'), ('20150219', '131300'),
                            ('20150219', '131400'), ('20150219', '131500'), ('20150219', '131600'),
                            ('20150219', '131700'), ('20150219', '131800'), ('20150219', '131900'),
                            ('20150219', '132000'), ('20150219', '132100'), ('20150219', '132200'),
                            ('20150219', '132300'), ('20150219', '132400'), ('20150219', '132500'),
                            ('20150219', '132600'), ('20150219', '132700'), ('20150219', '132800'),
                            ('20150219', '132900'), ('20150219', '133000'), ('20150219', '133100'),
                            ('20150219', '133200'), ('20150219', '133300'), ('20150219', '133400'),
                            ('20150219', '133500'), ('20150219', '133600'), ('20150219', '133700'),
                            ('20150219', '133800'), ('20150219', '133900'), ('20150219', '134000'),
                            ('20150219', '134100'), ('20150219', '134200'), ('20150219', '134300'),
                            ('20150219', '134400'), ('20150219', '134500'), ('20150219', '134600'),
                            ('20150219', '134700'), ('20150219', '134800'), ('20150219', '134900'),
                            ('20150219', '135000'), ('20150219', '135100'), ('20150219', '135200'),
                            ('20150219', '135300'), ('20150219', '135400'), ('20150219', '135500'),
                            ('20150219', '135600'), ('20150219', '135700'), ('20150219', '135800'),
                            ('20150219', '135900'), ('20150219', '140000'), ('20150219', '140100'),
                            ('20150219', '140200')]

caida_chicago_template = dict(provider='caida', link='equinix-chicago', direction='X')

caida_test_trace = dict(day='20150219', time='125911', **caida_chicago_template)
caida_chicago_2015_traces = [dict(day=d, time=t, **caida_chicago_template) for d, t in caida_2015_chicago_dates]
fb_trace = dict(provider='fb', cluster='A', rack='0a2a1f0d')

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
    dict(Q=1, W=[1, 4, 8]),
    dict(Q=4, W=[4, 8]),
    dict(Q=8, W=[8, 16]),
]

qw_conf_3 = [
    dict(Q=1, W=[4, 8]),
    dict(Q=4, W=8),
    dict(Q=8, W=16),
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
    # "opp-b2b-fb-flow-hazard":
    #     dict(trace=fb_trace, sched=HazardDetector, key=keys_all, N=range(1, 51), Q=1, W=1, clock_freq=0,
    #          hashf=hash_crc16, read_chunk=80),
    # "opp-b2b-fb-flow-thrpt":
    #     dict(trace=fb_trace, sched=OPPScheduler, key=keys_all, N=range(1, 51), qw=qw_conf_2, clock_freq=0,
    #          hashf=hash_crc16, read_chunk=80)
    "caida-chi15-opp":
        dict(trace=caida_chicago_2015_traces, sched=OPPScheduler, key=keys_min, N=range(1, 40), qw=qw_conf_3,
             hashf=hash_crc16, read_chunk=80, clock_freq=0),
}

noexp = ['trace']

def explode_param_list(other_list, original_list, p_name=None):
    new_p_dicts = []
    for val in other_list:
        for p_dict in original_list:
            d = copy(p_dict)
            if p_name not in noexp and isinstance(val, dict):
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
                continue
            if p_name not in noexp and isinstance(p_value, (dict,)):
                other_sim_lines = explode_lines([p_value])
                p_dicts = explode_param_list(original_list=p_dicts, other_list=other_sim_lines)
                continue
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

    col_widths = [0] * max(len(row) for row in data)
    for i in range(len(col_widths)):
        col_widths[i] = max(len(row[i]) for row in data)
    for row in data:
        print "".join(row[i].ljust(col_widths[i] + 4) for i in range(len(row)))

    print len(param_dicts)

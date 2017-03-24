# clock_freq, N, Q, sched, hash, key, read_chunk, line_rate_util
from copy import copy

from misc import caida_list_all_trace_couples as caida_list_all_trace_couples
from hashkeys import *
from scheduler import OPPScheduler, HazardDetector

# defaults = dict(max_samples=max_samples)
defaults = dict()

caida_chi15_traces = caida_list_all_trace_couples('chicago-20150219')
caida_sj12_traces = caida_list_all_trace_couples('sanjose-20121115')
# mawi15_traces = [dict(provider='mawi', name='201507201400')]
mawi15_traces = [dict(provider='mawi', name='201507201400-0%s' % str(i)) for i in [1, 2, 3]]

# 10 most active racks from facebook
fb_traces = [dict(provider='fb', cluster='B', rack=r) for r in ['bace22a7', '791f21d2', '59b83d96', '079a31f6',
                                                                '2d1c28e6', 'e27318d3', '7d9c6925', 'aee15954',
                                                                'dde385e4', 'febcb8d0']]

# Key sets
keys_all = [key_5tuple, key_ipsrc_ipdst, key_ipsrc, key_proto_dport, key_proto_sport, key_const]
keys_worst = [key_ipsrc, key_proto_dport, key_proto_sport, key_const]
keys_min = [key_proto_sport, key_5tuple, key_ipdst, key_ipdst16, key_ipsrc, key_ipsrc16, key_const]
keys_dim = [key_proto_sport, key_5tuple]
keys_xx = [key_5tuple, key_ipsrc_ipdst, key_ipsrc, key_ipdst, key_ipsrc8, key_ipsrc16, key_ipsrc24, key_ipdst8,
           key_ipdst16, key_ipdst24, key_const]
keys_ccr = [key_const, key_5tuple, key_ipdst, key_ipdst16, key_ipsrc_ipdst]

# keys_ccr = [key_5tuple, key_ipdst, key_ipdst16, key_const]

hazard_template = dict(
    sched=HazardDetector, key=key_const, N=range(1, 31), Q=0, W=0, hashf=hash_crc16, read_chunk=80, clock_freq=0)
hazard_template_per_flow = dict(
    sched=HazardDetector, key=keys_ccr, N=range(1, 31), Q=0, W=0, hashf=hash_crc16, read_chunk=80, clock_freq=0)

thrpt_template = dict(
    sched=OPPScheduler, key=keys_ccr, N=range(1, 31), Q=[1, 4, 8, 16], W=[16], hashf=hash_crc16, read_chunk=80,
    clock_freq=0, thrpt_tolerance=0.8)

thrpt_template_1F = dict(
    sched=OPPScheduler, key=key_const, N=range(1, 11), Q=1, W=1, hashf=hash_crc16, read_chunk=80, clock_freq=0,
    thrpt_tolerance=0.8)

dim_template = dict(
    sched=OPPScheduler, key=keys_ccr, N=range(1, 31), Q=[1, 4, 8, 16], W=[16], quelen=[10, 100],
    hashf=hash_crc16, read_chunk=80, clock_freq=0, drop_tolerance=0.02)

dim_template_1F = dict(
    quelen=[10, 100], **thrpt_template_1F)

sim_groups = {
    # Hazard Detector

    "caida-chi15-haz-1F": dict(trace=caida_chi15_traces, **hazard_template),
    "caida-chi15-haz-MF": dict(trace=caida_chi15_traces, **hazard_template_per_flow),

    "caida-sj12-haz-1F": dict(trace=caida_sj12_traces, **hazard_template),
    "caida-sj12-haz-MF": dict(trace=caida_sj12_traces, **hazard_template_per_flow),

    "mawi15-haz-1F": dict(trace=mawi15_traces, **hazard_template),
    "mawi15-haz-MF": dict(trace=mawi15_traces, **hazard_template_per_flow),

    "fb-haz-1F": dict(trace=fb_traces, **hazard_template),

    # OPP

    "caida-chi15-opp": dict(trace=caida_chi15_traces, **thrpt_template),
    "caida-chi15-opp-dim": dict(trace=caida_chi15_traces, **dim_template),

    "caida-sj12-opp": dict(trace=caida_sj12_traces, **thrpt_template),
    "caida-sj12-opp-dim": dict(trace=caida_sj12_traces, **dim_template),

    "fb-opp": dict(trace=fb_traces, **thrpt_template_1F),
    "fb-opp-dim": dict(trace=fb_traces, **dim_template_1F),

    "mawi15-opp": dict(trace=mawi15_traces, **thrpt_template),
    "mawi15-opp-dim": dict(trace=mawi15_traces, **dim_template)
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
        col_widths[i] = max(len(row[i]) if len(row) > i else 0 for row in data)
    for row in data:
        print "".join(row[i].ljust(col_widths[i] + 4) for i in range(len(row)))

    print len(param_dicts)

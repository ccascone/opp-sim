# Simulator of stateful packet forwarding pipelines

This repository contains the code used in the paper:

C. Cascone, R. Bifulco, S. Pontarelli, A. Capone, *"Relaxing state-access constraints in stateful programmable data planes."*

*Documentation on how to use the simulator is still work in progress*

## Simulation results

Simulation results used in the paper are available under ./gp. Results are provided both in PDF and in TSV format (.dat) compatible with gnuplot. A gnuplot script to generate the PDF results is also provided (plot.gp)

To unserstand folder naming, consider the following:
* Results are provided for 4 different traffic traces: caida-chi15, caida-sj12, fb, mawi15, imc1 (uni1 in the paper), and imc2 (uni2 in the paper)
* "haz" represents the case of a non-blocking scheduler that can cause data hazards, for the case when no distinction is made between flows (1F), and when data hazards occur only between packets of the same flow (MF)
* "opp" represents the case of a pipeline that implements memory locking as described in the paper, with infinite queues
* "opp-dim" represents the previous case but when using fixed-size queues
* "max_N_per_drop" contains time budget results, i.s. the maximum number of cycles (and corresponding queueing latency) to support a given target throughput. Results are organized per levels of packet drop tolerance, for example results under drop_0.01 presents the maximum number of cycles to sustain a minimum throughput of 99%.

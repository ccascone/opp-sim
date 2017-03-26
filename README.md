# Simulator of stateful packet forwarding pipelines

This repository contains the code used in the paper:

C. Cascone, R. Bifulco, S. Pontarelli, A. Capone, *"Relaxing state-access constraints in stateful programmable data planes."* (https://arxiv.org/abs/1703.05442)

*Documentation on how to use the simulator is still work in progress*

## Simulation results

Simulation results used in the paper are available in ./gp. Results are provided both in PDF and in TSV format (.dat) compatible with gnuplot. A gnuplot script to generate the PDF results is also provided (plot.gp)

To unserstand folder naming, consider the following:
* Results are provided for 4 different traffic traces: caida-chi15, caida-sj12, fb, mawi15
* "haz" represents the case of a non-blocking scheduler that can cause data hazards, for the case when no distinction is made between flows (1F), and when data hazards occur only between packets of the same flow (MF)
* "opp" represents the case of a pipeline that implements memory locking as described in the paper, with infinite queues
* "opp-dim" represents the previous case but when using fixed-size queues
* "max_N_per_drop" contains result showed in Table 2 of the paper, organized per levels of packet drop tolerance

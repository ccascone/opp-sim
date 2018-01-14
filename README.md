# Simulator of stateful packet forwarding pipelines

This repository contains the code used in the paper:

C. Cascone, R. Bifulco, S. Pontarelli, A. Capone, *"Relaxing state-access constraints in stateful programmable data planes."*. ACM SIGCOMM CCR, 2018.

To execute the same simulations as in the paper:

```
python main.py
```

To reduce execution time, please consider using PyPy. The dependencies are listed in `requirements.txt`.

Before running the simulations, traffic traces need to be downloaded and pre-processed separately. URLs to download the traces are provided in the paper. Once you have downloaded the traces, these need to be unpacked and placed in the following directories:

* CHI15: `caida/chicago-20150219`
* SJ12: `caida/sanjose-20121115`
* MAWI: `mawi`
* FB: `fb/B` (for traces of the Facebook cluster B)
* UNI1 and UNI2: `imc`

Each one of these directories contains a python script to pre-process the trace files. The purpose of the pre-processing is to run simulations faster, by pre-parsing packets' headers. Please run the python script in each one of the trace directories, it will take a wile to complete (hours).

`scheduler.py` implements the classes that models the scheduler (and pipeline) as in the paper. `OPPScheduler` is the one that implements the locking scheme, `HazardDetector` is the one used to detect the fraction of data hazards for each trace.

`simulator.py` implements the simulator logic, while `main.py` is the script used to run all simulations, in parallel. The number and parameters for each simulation is defined in `sim_params.py` (look for the `sim_groups` dictionary). `result_parser.py` can be used to parse the results and generate the gnuplot script to produce the figures.

## Simulation results

Simulation results used in the paper are available under `./gp`. Results are provided both in PDF and in TSV format (.dat) compatible with gnuplot. A gnuplot script to generate the PDF results is also provided (plot.gp)

To unserstand folder naming, consider the following:
* Results are provided for 4 different traffic traces: caida-chi15, caida-sj12, fb, mawi15, imc1 (uni1 in the paper), and imc2 (uni2 in the paper)
* "haz" represents the case of a non-blocking scheduler that can cause data hazards, for the case when no distinction is made between flows (1F), and when data hazards occur only between packets of the same flow (MF)
* "opp" represents the case of a pipeline that implements memory locking as described in the paper, with infinite queues
* "opp-dim" represents the previous case but when using fixed-size queues
* "max_N_per_drop" contains time budget results, i.s. the maximum number of cycles (and corresponding queueing latency) to support a given target throughput. Results are organized per levels of packet drop tolerance, for example results under drop_0.01 presents the maximum number of cycles to sustain a minimum throughput of 99%.
* Differently from the paper, where W represents the number of bits used by the comparator, here W represents the maximum number of distinct flows, i.e. W_repo = 2^W_paper, e.g. W_repo = 16 corresponds to W_paper = 4.

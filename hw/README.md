# Hardware synthesis results

This folder contains the VHDL code and synthesis reports of the comparator used by the scheduler described in the paper.

There is one of such comparator for each queue served by the scheduler.
The purpose of the comparator is to tell if the same flow key at the head of the queue, is also traveling in the pipeline.
The flow key is of W bits. The pipeline is made of N stages. The comparator compares the W bits of the queue (x) with every stage of the pipeline (y1,y2...yN), producing a signal 1 if the flow key is found in the pipeline, 0 otherwise.

## Results

We have synthesized the comparator using Synopsys Design Compiler and a fairly old 45 nm library (NanGate 45nm Open Cell Library http://www.nangate.com/?page_id=2325).
Detailed area and timing reports are provided for W = 4 bits (as per simulation results in the paper) and N=8,16,32 (max N=30 in the paper).
We provide results when setting the clock frequency constraint to 1 GHz, to minimize area at the expense of critical-path delay (reports under 1ghz directory), and vice versa, by setting the clock frequency constraint to 4 GHz (reports under 4ghz), in order to get the minimum critical-path delay at the expense of area.

| N  | Area at 1 Ghz        | Min. delay |
|----|----------------------|------------|
| 8  | 196 um2 (71 cells)   | 240 ps     |
| 16 | 929 um2 (403 cells)  | 360 ps     |
| 32 | 1560 um2 (668 cells) | 400 ps     |

The proposed solution has a dependency on N, for which it might be hard to meet timing constraints for larger values of N. The use of a comparator is one of many possible solutions to implement the locking scheme proposed in the paper, alternative solutions can help solving timing constraints for larger values of N.

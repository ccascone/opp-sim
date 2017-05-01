# Hardware synthesis results

This folder contains the VHDL code and synthesis reports of the comparator used by the scheduler described in the paper.

There is one of such comparator for each queue served by the scheduler.
The purpose of the comparator is to tell if the same flow key at the head of the queue, is also traveling in the pipeline.
The flow key is of W bits. The pipeline is made of N stages. The comparator compares the W bits of the queue (x) with every stage of the pipeline (y1,y2...yN), producing a signal 1 if the flow key is found in the pipeline, 0 otherwise.

## Results

We have synthesized the comparator using Synopsys Design Compiler and the NanGate 45nm Open Cell Library (http://www.nangate.com/?page_id=2325).
Detailed area and timing reports are provided for W = 4 bits (as per simulation results in the paper) and N=8,16,32 (max N=30 in the paper).
In all cases the comparator meets timing constraints at 1 GHz. To summarize:

* N=8: area 340 um^2 (129 logic cells) timing 240 ps
* N=16: area 1194 um^2 (522 cells) timing 360 ps
* N=32: area 1988 um^2 (846 cells) timing 400 ps

Clearly, the proposed solution has a dependency on N, for which it might be hard to meet timing constraints for larger values of N.
The use of a comparator is one of many possible solutions to implement the locking scheme proposed in the paper, alternative solutions can help solving timing constraints for larger values of N.
# gnuplot script
set terminal pdf linewidth 1.5 size 3.4in,2in
set grid

set output 'pdf/caida-chi15-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/caida-chi15-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-haz-MF\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/caida-sj12-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-haz-MF\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/mawi15-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-haz-MF\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/imc1-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/imc1-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-haz-MF\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/imc1-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/imc2-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/imc2-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-haz-MF\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/imc2-haz-MF/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/fb-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "fb-haz-1F\nQ-W=(0, 0), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. data hazards [99^{th}%]'
unset logscale y
set format y "%g"
plot 'dat/fb-haz-1F/sched_quota_hazard_Q-W=0-0.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/caida-chi15-opp/sched_latency_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_latency_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_sum_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_sum_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_max_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_max_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_thrpt_Q-W=8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp/sched_thrpt_Q-W=8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_latency_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_latency_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_sum_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_sum_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_max_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_max_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_thrpt_Q-W=1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp/sched_thrpt_Q-W=1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_latency_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_latency_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_sum_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_sum_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_max_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_max_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_thrpt_Q-W=16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp/sched_thrpt_Q-W=16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_latency_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_latency_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_sum_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_sum_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_queue_max_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp/sched_queue_max_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp/sched_thrpt_Q-W=4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp/sched_thrpt_Q-W=4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-chi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-chi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_latency_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_latency_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_sum_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_sum_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_max_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_max_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_thrpt_Q-W=8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp/sched_thrpt_Q-W=8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_latency_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_latency_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_sum_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_sum_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_max_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_max_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_thrpt_Q-W=1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp/sched_thrpt_Q-W=1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_latency_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_latency_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_sum_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_sum_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_max_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_max_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_thrpt_Q-W=16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp/sched_thrpt_Q-W=16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_latency_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_latency_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_sum_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_sum_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_queue_max_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp/sched_queue_max_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp/sched_thrpt_Q-W=4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp/sched_thrpt_Q-W=4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "caida-sj12-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/caida-sj12-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_latency_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_latency_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_sum_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_sum_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_max_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_max_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_thrpt_Q-W=1-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp/sched_thrpt_Q-W=1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_latency_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_latency_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_sum_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_sum_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_max_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_max_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_thrpt_Q-W=8-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp/sched_thrpt_Q-W=8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_latency_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_latency_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_sum_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_sum_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_max_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_max_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_thrpt_Q-W=16-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp/sched_thrpt_Q-W=16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_latency_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_latency_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_sum_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_sum_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_queue_max_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp/sched_queue_max_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp/sched_thrpt_Q-W=4-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp/sched_thrpt_Q-W=4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/mawi15-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "mawi15-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/mawi15-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_latency_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_latency_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_sum_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_sum_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_max_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_max_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_thrpt_Q-W=1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp/sched_thrpt_Q-W=1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_latency_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_latency_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_sum_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_sum_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_max_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_max_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_thrpt_Q-W=8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp/sched_thrpt_Q-W=8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_latency_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_latency_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_sum_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_sum_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_max_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_max_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_thrpt_Q-W=16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp/sched_thrpt_Q-W=16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_latency_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_latency_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_sum_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_sum_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_queue_max_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp/sched_queue_max_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp/sched_thrpt_Q-W=4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp/sched_thrpt_Q-W=4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc1-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc1-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc1-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_latency_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_latency_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_sum_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_sum_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_max_99th_Q-W=1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_max_99th_Q-W=1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_thrpt_Q-W=1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp/sched_thrpt_Q-W=1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_latency_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_latency_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_sum_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_sum_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_max_99th_Q-W=8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_max_99th_Q-W=8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_thrpt_Q-W=8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp/sched_thrpt_Q-W=8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_latency_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_latency_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_sum_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_sum_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_max_99th_Q-W=16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_max_99th_Q-W=16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_thrpt_Q-W=16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp/sched_thrpt_Q-W=16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_latency_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_latency_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_sum_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_sum_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_queue_max_99th_Q-W=4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp/sched_queue_max_99th_Q-W=4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp/sched_thrpt_Q-W=4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp\nQ-W=(4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp/sched_thrpt_Q-W=4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-16-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-16-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 16, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-16-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-4-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-4-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 4, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-4-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-8-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-8-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(10, 8, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-8-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-16.perc_99th.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/imc2-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-16.max.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.pdf'
set key outside title 'Flow key' box
set title  "imc2-opp-dim\nquelen-Q-W=(100, 1, 16), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/imc2-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-16.min.dat' u 1:2 t '* (global)', \
	'' u 1:3 t '5-tuple', \
	'' u 1:4 t 'ipdst', \
	'' u 1:5 t 'ipdst/16', \
	'' u 1:6 t 'ipsrc,ipdst'

set output 'pdf/fb-opp/sched_latency_99th_Q-W=1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp\nQ-W=(1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp/sched_latency_99th_Q-W=1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp/sched_queue_sum_99th_Q-W=1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp\nQ-W=(1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp/sched_queue_sum_99th_Q-W=1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp/sched_queue_max_99th_Q-W=1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp\nQ-W=(1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp/sched_queue_max_99th_Q-W=1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp/sched_thrpt_Q-W=1-1.min.pdf'
set key outside title 'Flow key' box
set title  "fb-opp\nQ-W=(1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/fb-opp/sched_thrpt_Q-W=1-1.min.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(10, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_10/sched_latency_99th_quelen-Q-W=10-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-1.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(10, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_10/sched_drop_fract_quelen-Q-W=10-1-1.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(10, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_10/sched_queue_max_99th_quelen-Q-W=10-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(10, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_10/sched_queue_sum_99th_quelen-Q-W=10-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-1.min.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(10, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/fb-opp-dim/quelen_10/sched_thrpt_quelen-Q-W=10-1-1.min.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(100, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% latency (cycles) [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_100/sched_latency_99th_quelen-Q-W=100-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-1.perc_99th.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(100, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Fract. packets dropped [99^{th}%]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_100/sched_drop_fract_quelen-Q-W=100-1-1.perc_99th.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(100, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% max queue occupancy [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_100/sched_queue_max_99th_quelen-Q-W=100-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-1.max.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(100, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel '99^{th}\% queue occupancy sum [max]'
set logscale y
set format y "10^{%L}"
plot 'dat/fb-opp-dim/quelen_100/sched_queue_sum_99th_quelen-Q-W=100-1-1.max.dat' u 1:2 t '* (global)'

set output 'pdf/fb-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-1.min.pdf'
set key outside title 'Flow key' box
set title  "fb-opp-dim\nquelen-Q-W=(100, 1, 1), util=1 (avg)"
set xlabel 'Pipeline depth (clock cycles)'
set ylabel 'Throughput [min]'
unset logscale y
set format y "%g"
plot 'dat/fb-opp-dim/quelen_100/sched_thrpt_quelen-Q-W=100-1-1.min.dat' u 1:2 t '* (global)'

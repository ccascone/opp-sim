#!/usr/bin/env bash
set -e
source pypyenv/bin/activate
python result_parser.py $1
cd plot_data/
gnuplot < plot.gp
cd ..

#!/usr/bin/env bash
set -e
source pypyenv/bin/activate
python results_parser.py
cd plot_data/
gnuplot < plot.gp
cd ..

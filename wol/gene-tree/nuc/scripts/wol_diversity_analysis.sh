#! /usr/bin/env bash

for size in 1000 3000 9000; do paste <(sort -k2 error_after_prune/nuc//1/$size/apples2/results_results.csv) <(grep -wFf <(cut -f2 error_after_prune/nuc//1/$size/apples2/results_results.csv | sort) <(nw_prune -v <(nw_topology -bI trees/tree.nwk) `cat nuc/reps/1/$size/queries.txt nuc/reps/1/$size/refseqs.txt` | nw_distance -m p -s f -n -) | sort -k1) | cut -f1,3,4 | sed "s/$/\t$size/g"; done > error_after_prune/diversity_analysis_wol.csv

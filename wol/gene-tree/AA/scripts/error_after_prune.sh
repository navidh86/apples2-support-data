#!/bin/bash

for i in nuc prot; do
    for j in 1 2 3 4 5 6 7 8 9 10; do
        mkdir -p error_after_prune/$i/$j/
        cat $i/reps/$j/1000/refseqs.txt $i/reps/$j/1000/queries.txt > error_after_prune/$i/$j/1000_ref_and_qry.txt
        for k in 3000 9000; do
            mkdir -p error_after_prune/$i/$j/$k/
            nw_prune -v $i/reps/$j/$k/backbone.nwk `cat error_after_prune/$i/$j/1000_ref_and_qry.txt` > error_after_prune/$i/$j/$k/backbone.nwk
            for l in apples apples2; do
                mkdir -p error_after_prune/$i/$j/$k/$l
                nw_prune -v $i/reps/$j/$k/$l/results.newick `cat error_after_prune/$i/$j/1000_ref_and_qry.txt` > error_after_prune/$i/$j/$k/$l/results.nwk
                scripts/measure.sh error_after_prune/$i/$j/$k/$l error_after_prune/$i/$j/$k/$l/results.nwk trees/astral.lpp.nwk error_after_prune/$i/$j/$k/backbone.nwk
            done
        done
        for k in 1000; do
            for l in apples apples2; do
                mkdir -p error_after_prune/$i/$j/$k/$l
				cp $i/reps/$j/$k/$l/results_results.csv error_after_prune/$i/$j/$k/$l/
            done
        done
    done
done


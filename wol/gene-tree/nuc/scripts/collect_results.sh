#! /usr/bin/env bash

DIR=`pwd`

for m in epa-ng pplacer apples2-bme apples2 apples2-prot apples apples2-bme-prot ; do
	for c in nuc nuc3 prot ; do
                for i in `seq 1 10`; do
                        for j in 1000 3000 9000; do
                              cat $DIR/$c/reps/$i/$j/$m/results_results.csv | sed "s/$/\t$m\t$c\t$i\t$j/g"
                        done
                done
        done
done


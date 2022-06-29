#! /usr/bin/env bash

DIR=`pwd`

for m in epa-ng pplacer apples2 apples ; do
	for c in nuc ; do
                for i in `seq 1 10`; do
                        for j in 1000 3000 9000; do
                              cat $DIR/$c/reps/$i/$j/$m/time.txt | sed "s/$/,$j,$i,$m/g"
                        done
                done
        done
done


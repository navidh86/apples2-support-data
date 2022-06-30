#! /usr/bin/env bash

# run from parent directory

source activate tst

mkdir -p data

for GN in alignments/*; do
    gn=$(echo $GN | cut -c 12-16)
    echo $gn

    mkdir -p data/$gn
    echo $gn > data/$gn/select.txt

    TMP=`mktemp -t XXXXXXX.fa`
    
    while read sp; do echo alignments/$sp/aln_trimmed.fasta; done < data/$gn/select.txt | paste -s -d ' ' |  xargs scripts/catfasta2phyml.pl -f -c > $TMP

    python3 scripts/dedupe.py $TMP data/$gn/concat_dedup.fa data/$gn/dupmap.txt

    rm $TMP
done
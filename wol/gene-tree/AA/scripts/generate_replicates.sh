#! /usr/bin/env bash

for GN in alignments/*; do
    gn=$(echo $GN | cut -c 12-16)
    grep ">" data/$gn/concat_dedup.fa | sed "s/^.//g" > data/$gn/all.txt
    mkdir -p data/$gn/1000/
    (echo $gn; cat seed.txt) > data/$gn/theseed.txt
    sort -R --random-source=data/$gn/theseed.txt data/$gn/all.txt | head -n 1000 > data/$gn/1000/queries.txt
    sort -R --random-source=data/$gn/theseed.txt data/$gn/all.txt | tail -n 1000 > data/$gn/1000/refseqs.txt
done

f() {
    gn=$1
	bin/faSomeRecords data/$gn/concat_dedup.fa data/$gn/1000/queries.txt data/$gn/1000/query.fa
	bin/faSomeRecords data/$gn/concat_dedup.fa data/$gn/1000/refseqs.txt data/$gn/1000/ref.fa
    scripts/reestimate_backbone.sh data/$gn/1000/ trees/genes/$gn.nwk 1
}

export -f f

for GN in alignments/*; do
    gn=$(echo $GN | cut -c 12-16)
    printf "f $gn \n"		
done | xargs -n 1 -P 4 -t -I % bash -c "%"

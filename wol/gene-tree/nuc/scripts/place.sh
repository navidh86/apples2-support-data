#!/usr/bin/env bash
# place and measure placement error

source activate apples_support

apples_dir=$1 # path to apples-2-support code

# fast bootstrap
export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1

for GN in data/*; do
    gn=$(echo $GN | cut -c 6-10)
    prep=$GN/1000
    echo $prep
    mkdir -p $prep/fast_boot
    python3 $apples_dir/run_apples.py -s $prep/ref.fa -q $prep/query.fa -t $prep/backbone.nwk -X -o $prep/fast_boot/result.jplace -S -F
    gappa examine graft --allow-file-overwriting --out-dir=$prep/fast_boot --jplace-path=$prep/fast_boot/result.jplace
	bash scripts/measure.sh $prep/fast_boot/ $prep/fast_boot/result.newick trees/genes/$gn.nwk $prep/backbone.nwk
done

# pplacer
for GN in data/*; do
    gn=$(echo $GN | cut -c 6-10)
    prep=$GN/1000
    echo $prep
    mkdir -p $prep/pplacer
    pplacer -c $prep/taxtastic.refpkg -j 16 $prep/query.fa --timing --out-dir $prep/pplacer
    gappa examine graft --allow-file-overwriting --out-dir=$prep/pplacer --jplace-path=$prep/pplacer/query.jplace
	bash scripts/measure.sh $prep/pplacer/ $prep/pplacer/query.newick trees/genes/$gn.nwk $prep/backbone_ml.fasttree
done

# epa-ng
for GN in data/*; do
    gn=$(echo $GN | cut -c 6-10)
    prep=$GN/1000
    echo $prep
    mkdir -p $prep/epa-ng
    epa-ng -s $prep/ref.fa -q $prep/query.fa -t $prep/backbone_ml.fasttree -m GTR+G -w $prep/epa-ng/ --redo
    gappa examine graft --allow-file-overwriting --out-dir=$prep/epa-ng --jplace-path=$prep/epa-ng/epa_result.jplace
	bash scripts/measure.sh $prep/epa-ng/ $prep/epa-ng/epa_result.newick trees/genes/$gn.nwk $prep/backbone_ml.fasttree
done
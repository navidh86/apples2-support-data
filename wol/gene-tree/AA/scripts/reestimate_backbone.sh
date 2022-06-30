#!/usr/bin/env bash

DIR=$1
TREE=$2
PROT=$3 #1 if prot, 0 otherwise (nuc)

grep ">" $DIR/ref.fa | sed "s/^.//g" > $DIR/refseqs.txt
mapfile -t < $DIR/refseqs.txt
nw_prune -v <(nw_topology -bI $TREE) "${MAPFILE[@]}" > $DIR/topo_ref.tree

python3 scripts/resolve_polytomies.py $DIR/topo_ref.tree > $DIR/topo_ref_no_poly.tree

export OMP_NUM_THREADS=1

if [[ "$PROT" -eq "0"  ]]; then
	FastTreeMP -nt -nosupport  -nome  -noml -log $DIR/true_me.fasttree.log -intree $DIR/topo_ref_no_poly.tree < $DIR/ref.fa > $DIR/backbone.nwk
    FastTreeMP -nosupport -nt -gtr -nome -mllen -log ${DIR}/backbone_ml.log -intree ${DIR}/topo_ref_no_poly.tree < ${DIR}/ref.fa > ${DIR}/backbone_ml.fasttree
    # taxtastic package required by pplacer
    taxit create -l wol -P ${DIR}/taxtastic.refpkg --aln-fasta ${DIR}/ref.fa --tree-stats ${DIR}/backbone_ml.log --tree-file ${DIR}/backbone_ml.fasttree
else
	FastTreeMP -nosupport  -nome  -noml -log $DIR/true_me.fasttree.log -intree $DIR/topo_ref_no_poly.tree < $DIR/ref.fa > $DIR/backbone.nwk
    FastTreeMP -nosupport -lg -nome -mllen -log ${DIR}/backbone_ml.log -intree ${DIR}/topo_ref_no_poly.tree < ${DIR}/ref.fa > ${DIR}/backbone_ml.fasttree
    # taxtastic package required by pplacer
    taxit create -l wol -P ${DIR}/taxtastic.refpkg --aln-fasta ${DIR}/ref.fa --tree-stats ${DIR}/backbone_ml.log --tree-file ${DIR}/backbone_ml.fasttree
fi


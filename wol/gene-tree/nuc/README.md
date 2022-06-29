# Execute the commands below in the given order to reproduce the dataset:

1) First follow the instructions of the root README file: https://github.com/navidh86/apples2-support-data/blob/main/README.md
2) Download the alignments.zip from: https://drive.google.com/file/d/1OHer3WuqUOuWQeUurWHp1O-m6ha5rcZh/view?usp=sharing and unzip it in this direcotory so that the "alignments" folder resides here.
4) Run "scripts/create_single_gene_alignment.sh" from this directory. This will create 50 alignements corresponding to 50 genes in a new folder named "data".
5) Run "scripts/generate_replicates.sh" from this directory to generate the query and reference alignements, backbone trees and ohter necessary stuff.
6) Run "place.sh <path to apples-2-support>" from this directory to start placing queries using apples-2, pplacer and epa-ng.

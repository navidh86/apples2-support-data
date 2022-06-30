# Execute the commands below in the given order to reproduce the dataset:

1) First follow the instructions of the root README file: https://github.com/navidh86/apples2-support-data/blob/main/README.md
2) Download the alignments.zip from: https://drive.google.com/file/d/19ocVgqBoEvAKpiwHIiCtND3teFGHm9Ln/view?usp=sharing and unzip it in this direcotory so that the "alignments" folder resides here.
3) Activate "apples_support" environment, using "conda activate apples_support".
4) Run "scripts/create_single_gene_alignment.sh" from this directory. This will create 50 alignments corresponding to 50 genes in a new folder named "data".
5) Run "scripts/generate_replicates.sh" from this directory to generate the query and reference alignments, backbone trees and other necessary stuff.
6) Run "scripts/place.sh <path to apples-2-support>" from this directory to start placing queries using apples-2, pplacer and epa-ng.

cat first.fasta last.fasta > combined.fasta

python3 scaffold_major_chr_Arms.py combined.fasta order_orientation.txt Histone_locus.fasta

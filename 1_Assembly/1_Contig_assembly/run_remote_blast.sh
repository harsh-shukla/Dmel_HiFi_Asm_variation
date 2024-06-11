#!/bin/bash

## Specify the job name
#SBATCH --job-name=CONTAM_BLAST

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=1    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=batch.err
#SBATCH --output=batch.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Specify time limit
#SBATCH -t 3-00:00:00

REF=../iso1.asm.bp.p_ctg.fasta

while read p; do

  #echo "$p"

  samtools faidx $REF $p:0-25000 > curr.fasta
  echo -n $p- >> blast.1.out
  blastn -remote -db nr -outfmt "6 qseqid sseqid sscinames sskingdoms qcovs pident evalue" -max_target_seqs 1 -query curr.fasta | head -1 >> blast.1.out

done <contigs_to_blast.lst

#!/bin/bash

## Specify the job name
#SBATCH --job-name=Hifiasm

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=hifiasm.err
#SBATCH --output=hifiasm.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.


python3 find_longest.py ../histone_mapped_Reads.sizes 40 950000 > long_40X.lst
~/Softwares/seqtk/seqtk/seqtk subseq ../histone_mapped_Reads.fasta long_40X.lst > histone_long_40X.fasta
/data/homezvol1/hgshukla/Softwares/hifiasm/hifiasm-0.16.1/hifiasm -o histone.asm -t 32 -l 0  --hg-size 950k -D 10 histone_long_40X.fasta


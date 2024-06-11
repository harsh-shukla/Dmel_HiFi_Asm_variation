#!/bin/bash

## Specify the job name
#SBATCH --job-name=minimap2

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=minimap2.err
#SBATCH --output=minimap2.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

REF=/pub/hgshukla/JJ_Lab/Retrogenes_project/Data/drosphila_flybase_ann/dmel-all-chromosome-r6.36.fasta
ASM=../Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta


~/Softwares/minimap2/minimap2-2.24_x64-linux/minimap2 -t 32 -x asm10 $REF $ASM  > ISO1Scaf_to_ISO1rel6.paf

python3 dgeneis_index.py -i $REF -n ISO1_Rel6 -o iso1_rel.idx
python3 dgensis_index.py -i $ASM -n ISO1_HiFi -o iso1_hifi.idx

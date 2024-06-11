#!/bin/bash

## Specify the job name
#SBATCH --job-name=RepeatMasker

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=16    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=compleasm.err
#SBATCH --output=compleasm.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.


## LOAD MODULES or ENVIRONMENTS  ##
source ~/miniconda3/etc/profile.d/conda.sh
conda activate compleasm


ASM=../Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta
LIB=/pub/hgshukla/busco_lineage

compleasm run -a $ASM -o . -t 16 -l diptera_odb10 -L $LIB

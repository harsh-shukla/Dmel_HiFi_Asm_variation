#!/bin/bash

## Specify the job name
#SBATCH --job-name=RepeatMasker

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=rep.err
#SBATCH --output=rep.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.


## LOAD MODULES or ENVIRONMENTS  ##
source ~/miniconda3/etc/profile.d/conda.sh
conda activate base


SEQ=../../Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta
CUSTOM_LIB=RepeatMasker.MOD.lib

RepeatMasker -pa 8 -lib $CUSTOM_LIB -dir . $SEQ

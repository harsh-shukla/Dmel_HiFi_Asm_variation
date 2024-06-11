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

HIFI_DATA=/dfs3b/jje/hgshukla/HiFi_Subreads/ISO1/CCS_Gen_6_2/QV_0_99/ISO1_hifi_099.min8k.fasta.gz

/data/homezvol1/hgshukla/Softwares/hifiasm/hifiasm-0.16.1/hifiasm -o iso1.asm -t 32 -l 1 --hom-cov 96 $HIFI_DATA

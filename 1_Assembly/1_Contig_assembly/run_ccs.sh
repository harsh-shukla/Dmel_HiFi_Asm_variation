#!/bin/bash

## Specify the job name
#SBATCH --job-name=ISO1_CCS

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32   ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=ccs.err
#SBATCH --output=ccs.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Set run limit
#SBATCH -t 7-00:00:00

######## Load all modules needed ###############
source ~/miniconda3/etc/profile.d/conda.sh
conda activate PacbioTools
################################################

SUBREADBAM=/dfs3b/jje/hgshukla/HiFi_Subreads/ISO1/m54284U_200917_064543.subreads.bam

ccs --all --report-file CCSR1.report --num-threads 32 $SUBREADBAM ISO1_ccs_all.bam


######## Unload all modules ###################
################################################






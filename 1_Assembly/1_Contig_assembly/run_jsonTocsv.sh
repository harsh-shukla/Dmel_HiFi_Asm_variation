#!/bin/bash

## Specify the job name
#SBATCH --job-name=JSON_TO_CSV

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=6    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=jsontocsv.log.err
#SBATCH --output=jsontocsv.log.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Specify the total memory needed (default is 4.5 GB/core) 
#SBATCH --mem=26G

python json_to_TLV.py ISO1_ccs_all.zmw_metrics.json.gz ISO1_ccs_all.zmw_metrics.tsv

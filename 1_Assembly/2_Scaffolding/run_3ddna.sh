#!/bin/bash

## Specify the job name
#SBATCH --job-name=3DDNA

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=40    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=3ddna.err
#SBATCH --output=3ddna.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

#Sewt time
#SBATCH --time=4-00:00:00


DFT_ASM=/dfs7/jje/hgshukla/HiFi_Subreads/HiC/ISO1_161_Juicer/references/iso1.asm.bp.p_ctg.CntRem.mitproc.fasta
DEDUP=/dfs7/jje/hgshukla/HiFi_Subreads/HiC/ISO1_161_Juicer/aligned/merged_nodups.txt

run-asm-pipeline.sh -r 0 --input 50000 $DFT_ASM $DEDUP

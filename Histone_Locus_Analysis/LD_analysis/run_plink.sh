#!/bin/bash

## Specify the job name
#SBATCH --job-name=Plink

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=plink.err
#SBATCH --output=plink.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Set memory
#SBATCH --mem-per-cpu=3G

#Set time
#SBATCH --time=7-00:00:00



~/Softwares/plink/plink --vcf DGN_HisFlank.minGC10k.F.MOD2SNPs.vcf --recode --allow-extra-chr --vcf-half-call missing --set-missing-var-ids @:# --out DGN_T1

~/Softwares/plink/plink --file DGN_T1 --allow-extra-chr --r2 --matrix

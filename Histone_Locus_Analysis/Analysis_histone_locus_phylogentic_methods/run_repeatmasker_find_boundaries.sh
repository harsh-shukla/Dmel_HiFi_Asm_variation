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

#samtools faidx ../../histone.asm.bp.p_ctg.fasta ptg000003l > histone_locus_contig.fasta

SEQ=../../ptg000001l.RC.fasta
CUSTOM_LIB=boundary.lib

RepeatMasker -pa 8 -lib $CUSTOM_LIB -dir . $SEQ

python3 get_sequences.py ptg000001l.RC.fasta.out ptg000001l.RC.fasta ISO1_Histone_Units.fasta


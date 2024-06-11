#!/bin/bash

## Specify the job name
#SBATCH --job-name=Juicer

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=juicer.err
#SBATCH --output=juicer.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory
#SBATCH --chdir=.

#python ~/Softwares/JUICER/juicer-1.6/misc/generate_site_positions.py DpnII iso1.asm.bp.p_ctg.mitproc ../references/iso1.asm.bp.p_ctg.mitproc.fasta

JUICER_DIR=/dfs7/jje/hgshukla/HiFi_Subreads/HiC/ISO1_161_Juicer

$JUICER_DIR/scripts/juicer.sh -g iso1 -d $JUICER_DIR -s DpnII -p $JUICER_DIR/references/iso1.asm.bp.p_ctg.CntRem.mitproc.sizes -y $JUICER_DIR/restriction_sites/iso1.asm.bp.p_ctg.CntRem.mitproc_DpnII.txt -z $JUICER_DIR/references/iso1.asm.bp.p_ctg.CntRem.mitproc.fasta -D $JUICER_DIR -t 32

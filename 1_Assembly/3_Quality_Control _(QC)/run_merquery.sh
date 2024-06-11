#!/bin/bash

## Specify the job name
#SBATCH --job-name=Yak

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=16    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=meryl.err
#SBATCH --output=meryl.out

## Pass the current environment variables
#SBATCH --export=ALL

## Go to current working directory
#SBATCH --chdir=.


module load R/4.2.2
module load bedtools2/2.30.0

export MERQURY=/data/homezvol1/hgshukla/Softwares/merquery/merqury-1.3

ASM=../../Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta

#ILL_1=/dfs7/jje/hgshukla/HiFi_Subreads/novogene/ISO1/ISO1_CKDN230014388-1A_H75KWDSX7_L2_1.fq.gz
#ILL_2=/dfs7/jje/hgshukla/HiFi_Subreads/novogene/ISO1/ISO1_CKDN230014388-1A_H75KWDSX7_L2_2.fq.gz


meryl count k=21 memory=48 threads=16 *.fastq.gz output ISO1.meryl


$MERQURY/merqury.sh ISO1.meryl $ASM ISO1_Hifi

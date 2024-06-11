#!/bin/bash

## Specify the job name
#SBATCH --job-name=minimap2

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=minimap2.err
#SBATCH --output=minimap2.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.



HIFI_READS=/dfs7/jje/hgshukla/HiFi_Subreads/ISO1/CCS_Gen_6_2/QV_0_99/ISO1_hifi_099.min6k.fasta.gz
REF=/dfs7/jje/hgshukla/HiFi_Subreads/ISO1/CCS_Gen_6_2/Assembly/Hifiasm_16_1/Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta

minimap2 -ax map-hifi -t 32 $REF $HIFI_READS | samtools sort -@ 32 -O bam - > ISO1hifi.reads.mapped.bam
samtools index ISO1hifi.reads.mapped.bam

samtools depth -aa -r 2L:21550706-22150193 ISO1hifi.reads.mapped.bam > ISO1_targeted.depth   # For the histone locus  
samtools depth -aa -r X:24064288-27447821 ISO1hifi.reads.mapped.bam > X_extra.depth          # For the newly assmbled X locus

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


HIFI_READS=/dfs7/jje/hgshukla/HiFi_Subreads/A3/CCS_6_2/QV_gt_099/A3_hifi_099.min6k.fasta.gz

minimap2 -ax map-hifi -t 32 ../../a3.asm.bp.p_ctg.fasta $HIFI_READS | samtools sort -@ 32 -O bam - > A3hifi.reads.mapped.bam
samtools index A3hifi.reads.mapped.bam

samtools view ptg000005l:21258875-21866736 A3hifi.reads.mapped.bam  | awk -F"\t" '{print $1}' | sort | uniq > histone_mapped_reads.lst
~/Softwares/seqtk/seqtk/seqtk subseq $HIFI_READS histone_mapped_reads.lst > histone_mapped_Reads.fasta
/data/homezvol1/hgshukla/Softwares/hifiasm/hifiasm-0.16.1/hifiasm -o histone.asm -t 32 -r 3 -l 0 --hg-size 950k -D 10 histone_mapped_Reads.fasta

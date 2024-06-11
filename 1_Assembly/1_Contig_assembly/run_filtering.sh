#!/bin/bash

## Specify the job name
#SBATCH --job-name=FILTER

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=1    ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=filter.err
#SBATCH --output=filter.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Specify the total memory needed (default is 4.5 GB/core) 
#SBATCH --mem=9G


BAM_FILE=/dfs3b/jje/hgshukla/HiFi_Subreads/ISO1/CCS_Gen_6_2/ISO1_ccs_all.bam
READLIST=seq_qv_gt_099.txt

awk -F"\t" '{if($6>=0.99) print $1}' ISO1_ccs_all.zmw_metrics.tsv | sed '1d' > $READLIST

samtools view $BAM_FILE | fgrep -w -f $READLIST | samtools fasta - | gzip -c > ISO1_hifi_099.fasta.gz

~/Softwares/seqtk/seqtk/seqtk seq -L 6000 ISO1_hifi_099.fasta.gz  | gzip -c >  ISO1_hifi_099.min6k.fasta.gz


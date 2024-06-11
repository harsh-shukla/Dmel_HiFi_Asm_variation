#!/bin/bash

## Specify the job name
#SBATCH --job-name=Mapping

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=32   ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=mapping.err
#SBATCH --output=mapping.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.


REF=/dfs7/jje/hgshukla/HiFi_Subreads/HiC/ISO1_161_Juicer/references/iso1.asm.bp.p_ctg.CntRem.mitproc.fasta
FASTQ_R1=SRR6399448_1.fastq.gz
FASTQ_R2=SRR6399448_2.fastq.gz
CURR_SRA=SRR6399448
STRAIN=ISO1M
THREADS=32
NAME=ISO1male

R_STR="$(echo @RG\\tID:$CURR_SRA\\tSM:$STRAIN\\tLB:$CURR_SRA\\tPL:Illumina)" 

#bwa index $REF
bwa mem -R $R_STR -t $THREADS $REF $FASTQ_R1 $FASTQ_R2 | samtools sort -@ $THREADS -m 2G -O bam - > $NAME.sorted.bam
samtools index -@ $THREADS $NAME.sorted.bam
samtools flagstat -@ $THREADS  $NAME.sorted.bam > $NAME.flagstat.txt

samtools coverage -q 20 $NAME.sorted.bam > male.coverage
samtools coverage $NAME.sorted.bam > male.q0.coverage


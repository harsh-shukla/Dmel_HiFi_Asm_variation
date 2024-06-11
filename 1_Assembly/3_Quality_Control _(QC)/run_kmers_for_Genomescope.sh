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

~/Softwares/minimap2/minimap2-2.25_x64-linux/minimap2 -ax map-hifi -t 32 ../Scafolding/histone_replace/ISO1.Hifi.Scaf.fasta $HIFI_READS | samtools sort -@ 32 -O bam - > ISO1hifi.reads.mapped.bam

samtools index -@ 32 ISO1hifi.reads.mapped.bam
samtools view --region-file autosomes.lst --min-qlen 1000 -F SECONDARY,SUPPLEMENTARY ISO1hifi.reads.mapped.bam | awk -F"\t" '{print $1}' | sort | uniq > ISO1_autosomes.lst
seqtk subseq $HIFI_READS ISO1_autosomes.lst | seqtk seq -A |  pigz -p 16 -c > ISO1_hifi_autosomes.fasta.gz

/data/homezvol1/hgshukla/Softwares/jellyfish/jellyfish-linux count -C -m 21 -s 1G --bf-size 75G -t 32 <(zcat ISO1_hifi_autosomes.fasta.gz) -o iso1hifiauto.jf
/data/homezvol1/hgshukla/Softwares/jellyfish/jellyfish-linux histo -t 32 iso1hifiauto.jf > iso1hifiauto.histo


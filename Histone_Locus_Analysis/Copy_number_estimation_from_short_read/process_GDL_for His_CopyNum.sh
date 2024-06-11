#!/bin/bash

## Specify the job name
#SBATCH --job-name=Mapping

## account to charge
#SBATCH -A JJE_LAB

# Define nodes tasks and cpu_per_task
#SBATCH --nodes=1            ## (-N) number of nodes to use
#SBATCH --ntasks=1           ## (-n) number of tasks to launch
#SBATCH --cpus-per-task=1   ## number of cores the job needs

## Specify which queues you want to submit the jobs too
#SBATCH -p standard

# Specify where standard output and error are stored
#SBATCH --error=mapping.err
#SBATCH --output=mapping.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

#Set time
#SBATCH --time=7-00:00:00


## LOAD MODULES or ENVIRONMENTS  ##
#module load singularity/3.9.4

REF=/dfs7/jje/hgshukla/HiFi_Subreads/DSPR/histone_masked/ISO1.Hifi.Scaf.HisMask.fasta
THREADS=32

while read line; do

  IFS=','
  read -ra COLS <<< "$line"
  SRRID=${COLS[0]}
  STRAIN=${COLS[1]}

  mkdir $STRAIN
  cd $STRAIN

  FASTQ_R1=$(echo $SRRID\_1.fastq.gz)
  FASTQ_R2=$(echo $SRRID\_2.fastq.gz)
  CURR_SRA=$SRRID
  LIB=$STRAIN\_LIB1
  STRAIN=$STRAIN
  NAME=$STRAIN

 R_STR="$(echo @RG\\tID:$CURR_SRA\\tSM:$STRAIN\\tLB:$LIB\\tPL:Illumina)"  

 ~/Softwares/SRA_toolkit/sratoolkit.3.0.2-centos_linux64/bin/fasterq-dump --split-files $SRRID

 bwa index $REF 
 bwa mem -R $R_STR -t $THREADS $REF $FASTQ_R1 $FASTQ_R2 | samtools sort -@ $THREADS -m 2G -O bam - > $NAME.sorted.bam
 samtools index -@ $THREADS $NAME.sorted.bam
 samtools flagstat -@ $THREADS  $NAME.sorted.bam > $NAME.flagstat.txt
 samtools coverage -q 0 $NAME.sorted.bam > female.q0.coverage

 Dep_2L=`samtools depth -aa -J -s -r 2L $NAME.sorted.bam  | awk -F"\t" '{print $3}' | ~/Softwares/datamash/install/bin/datamash median 1`
 Dep_His=`samtools depth -aa -J -s -r Histone_Unit_17 $NAME.sorted.bam  | awk -F"\t" '{print $3}' | ~/Softwares/datamash/install/bin/datamash median 1`
 NUMCOP=`expr $Dep_His / $Dep_2L`
 echo -e $NAME "\t" $NUMCOP >> ../GDL_histone_CP.NEW.txt

 gzip *.fastq
 
 cd ..

done < $1

#Here $1 is sra_strain.txt

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
#SBATCH --error=mapping.var.err
#SBATCH --output=mapping.var.out

# Pass the current environment variables
#SBATCH --export=ALL

# Go to current working directory 
#SBATCH --chdir=.

# Set memory
#SBATCH --mem-per-cpu=6G

#Set time
#SBATCH --time=7-00:00:00


## LOAD MODULES or ENVIRONMENTS  ##
module load singularity/3.9.4
module load cutadapt/2.10

REF=/dfs7/jje/hgshukla/HiFi_Subreads/DSPR/histone_masked/ISO1.Hifi.Scaf.HisMask.fasta
THREADS=32

############### Mapping and calling variants for each strain ############################


while read line; do

  IFS=','
  read -ra COLS <<< "$line"
  SRRID=${COLS[1]}
  STRAIN=${COLS[0]}

  mkdir $STRAIN
  cd $STRAIN

  FASTQ_R1=$(echo $SRRID\_1.fastq)
  FASTQ_R2=$(echo $SRRID\_2.fastq)
  CURR_SRA=$SRRID
  LIB=$STRAIN\_LIB1
  NAME=$STRAIN

  R_STR="$(echo @RG\\tID:$CURR_SRA\\tSM:$STRAIN\\tLB:$LIB\\tPL:Illumina)"


  ~/Softwares/SRA_toolkit/sratoolkit.3.0.2-centos_linux64/bin/fasterq-dump --split-files $SRRID

  /data/homezvol1/hgshukla/Softwares/TrimGalore-0.6.10/trim_galore \
  --quality 20 --phred33 --stringency 3 --length 70 --trim-n --max_n 2 \
  --output_dir . --cores $THREADS --basename $SRRID \
  --paired \
  $FASTQ_R1 $FASTQ_R2

  FASTQ_R1_T=$SRRID\_val_1.fq
  FASTQ_R2_T=$SRRID\_val_2.fq

  #bwa index $REF
  bwa mem -R $R_STR -t $THREADS $REF $FASTQ_R1_T $FASTQ_R2_T | samtools sort -@ $THREADS -m 3G -O bam - > $NAME.sorted.bam
  samtools index -@ $THREADS $NAME.sorted.bam
  samtools flagstat -@ $THREADS  $NAME.sorted.bam > $NAME.flagstat.txt
  samtools coverage -q 0 $NAME.sorted.bam > female.q0.coverage

  pigz -p $THREADS $FASTQ_R1
  pigz -p $THREADS $FASTQ_R2
  pigz -p $THREADS $FASTQ_R1_T
  pigz -p $THREADS $FASTQ_R2_T

  singularity exec /data/homezvol1/hgshukla/Softwares/octopus/octopus.sif octopus --reference $REF --reads $NAME.sorted.bam -o $NAME.bcf --sequence-error-model PCR.HISEQ-2000 --min-mapping-quality 40 --threads 32 --regions 2L:20551068-23140193

  cd ..

done < $1


############### Joint genotyping ############################

find * | grep ".bam$" > list_bams.txt
find * | grep ".bcf$" > list_bcfs.txt

singularity exec /data/homezvol1/hgshukla/Softwares/octopus/octopus.sif octopus --reference $REF --reads-file list_bams.txt \
 --disable-denovo-variant-discovery --caller population --sequence-error-model PCR.HISEQ-2000 --source-candidates-file list_bcfs.txt \
 --min-source-candidate-quality 100 --min-mapping-quality 40 --max-genotype-combinations 10000 -o DGN_HisFlank.maxGC10k.F.vcf.gz --regions 2L:20551068-23140193 --threads 32    # here maxGC is maximun genotype combination
 
 
################ filtering ########################################
 
bcftools +setGT DGN_HisFlank.maxGC10k.F.vcf.gz -- -t q -n . -i'FT!="PASS"' | bcftools view -m2 -M2 /dev/stdin | bcftools +setGT /dev/stdin -- -t q -i'GT="0|1"' -n . | bcftools +setGT /dev/stdin -- -t q -i'GT="1|0"' -n . | bcftools +fill-tags /dev/stdin -- -t AC,AF,AN,MAF,NS,F_MISSING | bcftools filter -O z -i'INFO/F_MISSING<0.05 && INFO/MAF>0.05' /dev/stdin > DGN_HisFlank.maxGC10k.F.MOD2.vcf.gz 
 
 
 
 
 
## UNLOAD MODULES or ENVIRONMENTS  ##
module unload singularity/3.9.4
module unload cutadapt/2.10






























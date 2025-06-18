

# Genetic Variation in Recalcitrant Repetitive Regions of the *Drosophila melanogaster* Genome

This repository contains the code and supplementary files used for the analyses in the manuscript, "Genetic variation in recalcitrant repetitive regions of the *Drosophila melanogaster* genome." The scripts are organized into directories corresponding to the major steps of the methods section. Each main directory contains a `README` file with more specific details about its contents.

## Repository Structure

Below is a description of the main directories and the analyses they correspond to.

### 1_Assembly
This directory contains all scripts related to generating high-quality, chromosome-level genome assemblies from PacBio HiFi data.

* `1_Contig_assembly`: Scripts for *de novo* contig assembly using `hifiasm` and subsequent decontamination to remove microbial sequences.
* `2_Scaffolding`: Scripts for scaffolding contigs into chromosome-level assemblies using reference-assisted methods and Hi-C data.
* `3_Quality_Control_(QC)`: Scripts for assessing assembly completeness and accuracy using `BUSCO` and `Merqury`.
* `4_Heterozygosity`: Scripts for estimating autosomal heterozygosity using `GenomeScope`.
* `5_Identification_Y_contigs`: Scripts for identifying Y-linked contigs by comparing coverage from male and female Illumina read mapping.

### 2_Synteny_analysis
Contains scripts for generating and visualizing synteny dot plots between genome assemblies using `minimap2` and `D-Genies`.

### 3_Repeat_identification
Contains scripts for identifying repetitive elements using `RepeatMasker`. This directory also includes a FASTA file with the custom sequences (e.g., for Histone, Stellate, and rDNA) that were added to the default Dfam library for our study.

### 4_Depth_analysis
Contains scripts used to calculate per-base read depth. This analysis was used throughout the project to validate assembly structure, such as checking for collapsed or expanded regions in tandem arrays.

### Histone_Locus_Analysis
This directory is dedicated to the comprehensive analysis of the histone gene cluster.

* `Targeted_genome_Assembly`: Scripts for the targeted assembly of the histone locus from a subset of HiFi reads using `hifiasm` with repeat-sensitive parameters.
* `Copy_number_estimation_from_short_read`: Scripts for estimating histone gene copy number in the Global Diversity Lines (GDL) by mapping Illumina short-read data to a single reference histone unit.
* `LD_analysis`: Scripts for performing Linkage Disequilibrium (LD) analysis on variants flanking the histone locus in the Drosophila Genome Nexus (DGN) population data.
* `Analysis_histone_locus_phylogenetic_methods`: Scripts to extract individual histone repeat unit sequences from the assemblies. These sequences were subsequently used for phylogenetic analysis in `MEGA`.

### Scripts_for_plotting_Figures
This directory contains the R and/or Python scripts used to generate the figures presented in the manuscript. These scripts take the output files from the primary analysis pipelines to create the plots.


## Citation

If you use the code or data from this repository, please cite our paper:

> Shukla, H. G., Chakraborty, M., & Emerson, J. J. (2024). Genetic variation in recalcitrant repetitive regions of the Drosophila melanogaster genome. *bioRxiv*. [Link](https://www.biorxiv.org/content/10.1101/2024.06.11.598575v1)

## Author & Contact

* **Harsh G. Shukla**

For any questions or comments, please feel free to reach out via email: `harsh.g.shukla@gmail.com`

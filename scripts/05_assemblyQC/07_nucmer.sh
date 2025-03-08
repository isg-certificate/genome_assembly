#!/bin/bash
#SBATCH --job-name=nucmer
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=40G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err

hostname
date

module load MUMmer/4.0.2

# in/out dirs
OUTDIR=../../results/05_assemblyQC/nucmer
mkdir -p ${OUTDIR}

# Fdiaph genome
FDIAPH=../../results/04_assembly/scaffoldedAssemblies/hap1_scaffolds_final.fa

# download Fhet genome
wget -P ${OUTDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/125/445/GCF_011125445.2_MU-UCD_Fhet_4.1/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna.gz
gunzip ${OUTDIR}/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna.gz
FHET=${OUTDIR}/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run nucmer to generate the alignment
nucmer --delta="${OUTDIR}" -t 16 ${FDIAPH} ${FHET}

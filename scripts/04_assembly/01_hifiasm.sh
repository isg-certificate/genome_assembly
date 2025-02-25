#!/bin/bash 
#SBATCH --job-name=hifiasm
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 24
#SBATCH --mem=100G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load Hifiasm/0.24.0

INDIR=../../rawdata
OUTDIR=../../results/04_assembly/hifiasm
mkdir -p ${OUTDIR}

# Assemble with HiFi reads
# Also do Hi-C phasing with paired-end short reads in two FASTQ files
hifiasm \
    -t 24 \
    -o ${OUTDIR}/Fdiaphanus.asm \
    --h1 ${INDIR}/fFunDia1_Banded_Killifish_R1_001.fastq.gz \
    --h2 ${INDIR}/fFunDia1_Banded_Killifish_R2_001.fastq.gz \
    ${INDIR}/m64330e_221020_171856.bc1022--bc1022.hifi_reads.fastq.gz \
    ${INDIR}/m64334e_221030_084704.bc1022--bc1022.hifi_reads.fastq.gz

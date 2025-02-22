#!/bin/bash 
#SBATCH --job-name=nanoplotHIFI
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load NanoPlot/1.41.6

INDIR=../../rawdata
OUTDIR=../../results/02_qc/nanoplot
mkdir ${OUTDIR}

NanoPlot --fastq ${INDIR}/*hifi*fastq.gz -o ${OUTDIR} -p hifi -t 4 
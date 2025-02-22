#!/bin/bash 
#SBATCH --job-name=merylHistogramHiC
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load meryl/1.4.1

INDIR=../../results/03_genomeSize/merylCount/db_HiC
OUTDIR=../../results/03_genomeSize/merylHistogram/HiC
mkdir -p ${OUTDIR}


meryl histogram ${INDIR} | sed 's/\t/ /' >${OUTDIR}/hiC.histo
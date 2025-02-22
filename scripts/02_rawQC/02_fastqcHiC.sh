#!/bin/bash 
#SBATCH --job-name=fastqcHiC
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

module load fastqc/0.11.7


INDIR=../../rawdata/
OUTDIR=../../results/02_qc/fastqc
mkdir -p ${OUTDIR}

fastqc -t 4 -o ${OUTDIR} ${INDIR}/fFunDia1*.gz
#!/bin/bash 
#SBATCH --job-name=merylCountHiC
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=350G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load meryl/1.4.1

INDIR=../../rawdata
OUTDIR=../../results/03_genomeSize/merylCount
mkdir -p ${OUTDIR}

meryl count k=23 memory=350 threads=16 ${INDIR}/fFunDia1*fastq.gz output ${OUTDIR}/db_HiC
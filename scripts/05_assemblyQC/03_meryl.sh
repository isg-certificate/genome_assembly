#!/bin/bash 
#SBATCH --job-name=meryl
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 24
#SBATCH --mem=200G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# you must have tidyverse, argparse and scales installed in R in your home for whatever version of R you are using. 
# this script loads conda and activates an environment. you must create your own if going the conda route!
# you can also just install merqury via conda as well. 

source  ~/conda_xanadu.sh
conda activate r-4.3.3
module load merqury/1.3
module load meryl/1.4.1

INDIR=../../rawdata
OUTDIR=../../results/05_assemblyQC/meryl
mkdir -p ${OUTDIR}

# count k-mers for input HIFI reads
meryl count k=21 memory=200 threads=24 ${INDIR}/*hifi*fastq.gz output ${OUTDIR}/HIFI.meryl





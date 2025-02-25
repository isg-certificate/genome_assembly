#!/bin/bash 
#SBATCH --job-name=indexAssemblies
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=30G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-1]


hostname
date

module load bwa-mem2/2.1

# which haplotype to index
HAPS=(hap1 hap2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

# input/output dirs
INDIR=../../results/04_assembly/hifiasm_fastas/

OUTDIR=${INDIR}/${hap}_index
mkdir -p ${OUTDIR}

# index
bwa-mem2 index -p ${OUTDIR}/${hap} ${INDIR}/Fdiaphanus_${hap}.fa




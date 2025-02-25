#!/bin/bash 
#SBATCH --job-name=yahs
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=50G 
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-1]

hostname
date

module load YaHS/1.2.2

# input/output
HIC=../../results/04_assembly/HiC_align/
ASSEMBLIES=../../results/04_assembly/hifiasm_fastas
OUTDIR=../../results/04_assembly/scaffoldedAssemblies
mkdir -p ${OUTDIR}

# we're scaffolding both haplotypes separately
HAPS=(1 2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

# reference contig and 
FASTA=${ASSEMBLIES}/Fdiaphanus_hap${hap}.fa
BAM=${HIC}/hap${hap}.bam

# run yahs
yahs ${FASTA} ${BAM} -o ${OUTDIR}/hap${hap}
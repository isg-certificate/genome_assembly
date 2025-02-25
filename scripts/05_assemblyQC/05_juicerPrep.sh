#!/bin/bash 
#SBATCH --job-name=juicerPrep
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=60G 
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-1]

hostname
date

# generate Hi-C contact map per YaHS instructions

module load YaHS/1.2.2

INDIR=../../results/04_assembly/scaffoldedAssemblies/
CONTIGDIR=../../results/04_assembly/hifiasm_fastas/
OUTDIR=../../results/05_assemblyQC/contactMaps
mkdir -p ${OUTDIR}

HAPS=(1 2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

# convert bin file created by yahs
    # "juicer pre" is a script provided by yahs
BIN=${INDIR}/hap${hap}.bin
AGP=${INDIR}/hap${hap}_scaffolds_final.agp
FAI=${CONTIGDIR}/Fdiaphanus_hap${hap}.fa.fai

(juicer pre ${BIN} ${AGP} ${FAI} | 
    sort -k2,2d -k6,6d -T ./ --parallel=8 -S32G | 
    awk 'NF' > ${OUTDIR}/hap${hap}_alignments_sorted.txt.part) && 
(mv ${OUTDIR}/hap${hap}_alignments_sorted.txt.part ${OUTDIR}/hap${hap}_alignments_sorted.txt)


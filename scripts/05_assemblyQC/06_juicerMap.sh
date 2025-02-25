#!/bin/bash 
#SBATCH --job-name=juicerMap
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
module load juicer/1.22.01 # sets $JUICER variable
module load samtools/1.20

SCAFFOLDS=../../results/04_assembly/scaffoldedAssemblies/
OUTDIR=../../results/05_assemblyQC/contactMaps

HAPS=(1 2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

# generate "chrom.sizes" file
samtools faidx ${SCAFFOLDS}/hap${hap}_scaffolds_final.fa
FAI=${SCAFFOLDS}/hap${hap}_scaffolds_final.fa.fai
cut -f 1-2 ${FAI} >${OUTDIR}/hap${hap}_scaffolds_final.chrom.sizes

# run juicer to produce .hic file
(java -jar -Xmx32G ${JUICER} pre --threads 12 \
    ${OUTDIR}/hap${hap}_alignments_sorted.txt \
    ${OUTDIR}/hap${hap}_out.hic.part \
    ${OUTDIR}/hap${hap}_scaffolds_final.chrom.sizes) && 
(mv ${OUTDIR}/hap${hap}_out.hic.part ${OUTDIR}/hap${hap}_out.hic)


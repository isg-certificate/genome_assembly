#!/bin/bash 
#SBATCH --job-name=extractFASTAS
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

module load samtools/1.20

# get fasta files from hifiasm output:

INDIR=../../results/04_assembly/hifiasm/
OUTDIR=../../results/04_assembly/hifiasm_fastas/
mkdir -p ${OUTDIR}

# extract fastas
awk '/^S/{print ">"$2;print $3}' ${INDIR}/Fdiaphanus.asm.hic.hap1.p_ctg.gfa >${OUTDIR}/Fdiaphanus_hap1.fa
awk '/^S/{print ">"$2;print $3}' ${INDIR}/Fdiaphanus.asm.hic.hap2.p_ctg.gfa >${OUTDIR}/Fdiaphanus_hap2.fa
awk '/^S/{print ">"$2;print $3}' ${INDIR}/Fdiaphanus.asm.hic.p_ctg.gfa >${OUTDIR}/Fdiaphanus_primary_contigs.fa

samtools faidx ${OUTDIR}/Fdiaphanus_hap1.fa
samtools faidx ${OUTDIR}/Fdiaphanus_hap2.fa
samtools faidx ${OUTDIR}/Fdiaphanus_primary_contigs.fa
#!/bin/bash 
#SBATCH --job-name=downloadHIFI
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

# HIFI data for Fundulus diaphanus from here: https://www.genomeark.org/vgp-curated-assembly/Fundulus_diaphanus.html
    # HIFI reads, not subreads

OUTDIR=../../rawdata
mkdir -p ${OUTDIR}

wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Fundulus_diaphanus/fFunDia1/genomic_data/pacbio_hifi/m64330e_221020_171856.bc1022--bc1022.hifi_reads.fastq.gz
wget -P ${OUTDIR} https://genomeark.s3.amazonaws.com/species/Fundulus_diaphanus/fFunDia1/genomic_data/pacbio_hifi/m64334e_221030_084704.bc1022--bc1022.hifi_reads.fastq.gz
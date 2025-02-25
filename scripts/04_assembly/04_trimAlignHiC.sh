#!/bin/bash 
#SBATCH --job-name=trimAlignHiC
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=20G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-3]

hostname
date

module load bwa-mem2/2.1
module load samtools/1.20
module load arimaHiCmap/1.0

# haplotype, R1/R2 variables
HAPS=(hap1 hap1 hap2 hap2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

RNS=(R1 R2 R1 R2)
rn=${RNS[$SLURM_ARRAY_TASK_ID]}


#input/output

INDIR=../../rawdata
OUTDIR=../../results/04_assembly/HiC_align
mkdir -p ${OUTDIR}

# genome index
INDEX=../../results/04_assembly/hifiasm_fastas/${hap}_index/${hap}

# fastq to align
FQ=${INDIR}/fFunDia1_Banded_Killifish_${rn}_001.fastq.gz

# set read group variable
RG=$(echo \@RG\\tID:Fdiaphanus\\tSM:Fdiaphanus\\tLB:Fdiaphanus\\tPL:ILLUMINA\\tPU:none)

# get script location
FFE=$(which filter_five_end.pl)

# trim fastqs, align them, pass them to a filter script (from Arima)
zcat ${FQ} | 
    awk '{ if(NR%2==0) {print substr($1,6)} else {print} }' | 
    bwa-mem2 mem -R ${RG} -t 8 ${INDEX} - |
    samtools view -@ 4 -h - |
    perl ${FFE} |
    samtools view -Sb - >${OUTDIR}/${hap}_${rn}.bam

    
    
    



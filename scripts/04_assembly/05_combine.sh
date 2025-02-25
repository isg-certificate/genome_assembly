#!/bin/bash 
#SBATCH --job-name=combine
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=10G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --array=[0-1]


hostname
date

module load samtools/1.20
module load arimaHiCmap/1.0
module load samblaster/0.1.24

# which haplotype to combine
HAPS=(hap1 hap2)
hap=${HAPS[$SLURM_ARRAY_TASK_ID]}

#input/output
INDIR=../../results/04_assembly/HiC_align
FAIDX=../../results/04_assembly/hifiasm_fastas/Fdiaphanus_${hap}.fa.fai

# get locations
COMBINER=$(which two_read_bam_combiner.pl)
STATS=$(which get_stats.pl)
SAMTOOLS=$(which samtools)

# min mapQ
MAPQ_FILTER=10

# combine R1/R2 into a single bam, sort, mark duplicates
perl ${COMBINER} ${INDIR}/${hap}_R1.bam ${INDIR}/${hap}_R2.bam ${SAMTOOLS} ${MAPQ_FILTER} | 
    samtools view -Sh -t ${FAIDX} - | 
    samblaster | 
    samtools sort -T ${INDIR}/${hap}.tmp -@ 8 -o ${INDIR}/${hap}.bam -

# index bam file
samtools index ${INDIR}/${hap}.bam

# get statistics
perl ${STATS} ${INDIR}/${hap}.bam > ${INDIR}/${hap}.bam.stats
#!/bin/bash
#SBATCH --job-name=quast
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=20G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err

hostname
date

##########################################################
##              QUAST                                   ##      
##########################################################

module load quast/5.2.0

# loop over unscaffolded assemblies
ASSEMBLIES=../../results/04_assembly/hifiasm_fastas/
OUTDIR=../../results/05_assemblyQC/quast
    mkdir -p ${OUTDIR}

for file in $(find ${ASSEMBLIES} -name "*fa")
    do
    base=$(basename ${file} ".fa")
    echo ${base}

    mkdir -p ${OUTDIR}/${base}
    quast.py ${file} --threads 16 -o ${OUTDIR}/${base}

done

SCAFFOLDS=../../results/04_assembly/scaffoldedAssemblies/

# run on scaffolded haplotypes
for file in $(find ${SCAFFOLDS} -name "*fa")
    do
    base=$(basename ${file} ".fa")
    echo ${base}

    mkdir -p ${OUTDIR}/${base}
    quast.py ${file} --threads 16 -o ${OUTDIR}/${base}

done

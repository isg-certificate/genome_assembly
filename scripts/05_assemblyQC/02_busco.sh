#!/bin/bash 
#SBATCH --job-name=busco
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
#SBATCH --array=[0-2]

hostname
date

##########################################################
##              BUSCO                                   ##      
##########################################################

module load busco/5.4.5

OUTDIR="../../results/05_assemblyQC/busco"
    mkdir -p ${OUTDIR}


ASSEMBLYDIR=../../results/04_assembly/hifiasm_fastas/

ASSEMBLIES=($(find ${ASSEMBLYDIR} -name "*fa"))

GEN=${ASSEMBLIES[$SLURM_ARRAY_TASK_ID]}
BASE=$(basename ${GEN} ".fa")

DATABASE="/isg/shared/databases/BUSCO/odb10/lineages/actinopterygii_odb10"

busco \
    -i ${GEN} \
    -o ${OUTDIR}/${BASE} \
    -l ${DATABASE} \
    -m genome \
    -c 12 \
    -f
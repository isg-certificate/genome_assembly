#!/bin/bash 
#SBATCH --job-name=merqury
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
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

# you must have tidyverse, argparse and scales installed in R in your home for whatever version of R you are using. 
# note that merqury secretly does `module load R`, so you need to make sure these packages are installed 
# for whatever version of R that happens to load. 
# at the time of writing that version was R/4.2.2, but it may not be in the future. 

module load R/4.2.2
module load merqury/1.3
module load meryl/1.4.1

# input/output. prefix everything with $(pwd) so we can run merqury from the output directory
MERYLDIR=$(pwd)/../../results/05_assemblyQC/meryl/HIFI.meryl

# get an assembly file
ASSEMBLYDIR=$(pwd)/../../results/04_assembly/hifiasm_fastas/
ASSEMBLIES=($(find ${ASSEMBLYDIR} -name "*fa"))
GEN=${ASSEMBLIES[$SLURM_ARRAY_TASK_ID]}

# extract file name base to use as prefix
BASE=$(basename ${GEN} ".fa")

# run merqury from the output directory because it doesn't allow setting output location (!?!)
OUTDIR=../../results/05_assemblyQC/merqury/${BASE}
mkdir -p ${OUTDIR}
cd ${OUTDIR}

# run meryl
merqury.sh ${MERYLDIR} ${GEN} ${BASE}
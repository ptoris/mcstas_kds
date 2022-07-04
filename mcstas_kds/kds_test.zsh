#!/bin/bash

KDS="/Users/paul/KDSource" # KDSource path

##### Input #####

INPUT=kds_instrument   # McStas instrument name, without .instr
DIR_OUT="/Users/paul/Paul/Phelma/Stages/stage_2A/mcstas_kdsource/test" # Directory where execute simulation and store output files
N=1E6          # Number of particles to simulate

### End Input ###

# Output directory
rm -r $DIR_OUT
rm $INPUT.c $INPUT.out samples.mcpl.gz samples.ssv

# Execute McStas
export LD_LIBRARY_PATH=$KDS/lib
mcstas $INPUT.instr -I$KDS/mcstas/contrib -I$KDS/include
gcc $INPUT.c -o $INPUT.out -lkdsource -lmcpl -lm -I$KDS/include -L$KDS/lib
./$INPUT.out -n $N -d $DIR_OUT | tee test/bash.out 

mcplot test
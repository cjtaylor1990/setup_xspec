#!/bin/bash
#Currently built for the Department of Astronomy - University of Maryland
#Currently works for Mac (9/28/2020)

#Input from command line
relxillVersion=$1

#Making sure I have access to XSPEC
source "$HEADAS/headas-init.csh"

#Defining path to HEASoft directory based on the environmental HEADAS variable used
#in setting up XSPEC
heasoftPath=$HEADAS/..

currentPosition=$(pwd)

#Switching to HEASoft directory
cd ${heasoftPath}

#Making RELXILL directory and going there
relxillName="relxill_model_v${relxillVersion}"
mkdir ${relxillName}
cd ${relxillName}

#Downloading the model tarball
relxillFile="${relxillName}.tgz"
wget "https://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/${relxillFile}" --no-check-certificate

#Unpacking the model tarball
tar xfz ${relxillFile}
rm -f ${relxillFile}

#Downloading RELXILL tables
relxillTablesFile="relxill_tables.tgz"
wget "https://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/${relxillTablesFile}" --no-check-certificate

#Unpacking the table tarball
tar xfz ${relxillTablesFile}
rm -f ${relxillTablesFile}

#Compiling RELXILL
chmod u+x ./compile_relxill.sh
./compile_relxill.sh

cd ${currentPosition}

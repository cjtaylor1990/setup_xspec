#!/bin/bash
#Currently built for the Department of Astronomy - University of Maryland

#Input from command line
relxillVersion=$1

#Defining path to HEASoft directory based on the environmental HEADAS variable used
#in setting up XSPEC
heasoftPath=$HEADAS/..

currentPosition=$(pwd)

#Switching to HEASoft directory
cd ${heasoftPath}

#Downloading the model tarball
relxillName="relxill_model_v${relxillVersion}"
relxillFile="${relxillName}.tgz"
wget "https://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/${relxilLFile}"

#Unpacking the model tarball
tar -xvf ${relxillFile}
rm -f ${relxillFile}

#Moving inside of the new RELXILL directory
cd ${relxillName}

#Downloading RELXILL tables
relxillTablesFile="relxill_tables.tgz"
wget "https://www.sternwarte.uni-erlangen.de/~dauser/research/relxill/${relxillTablesFile}"

#Unpacking the table tarball
tar -xfz ${relxillTablesFile}
rm -f ${relxillTablesFile}

#Compiling RELXILL
chmod u+x ./compile_relxill.sh
./compile_relxill.sh

cd ${currentPosition}

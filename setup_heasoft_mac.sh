#!/bin/bash
#Currently built for Mac OSX - Catalina 10.15.6 on 07/19/2020

#Arguments from command line
heasoftVersion=$1 #Heasoft verison to set up
destinationDir=$2 #Relative (or absolute) path directory where to place the HEASoft directory
zshrcFile=$3 #Path to .cshrc file

#Setting compilers as environmental variables
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export FC=/usr/local/bin/gfortran-7

#System archetecture (current)
archName="x86_64-apple-darwin19.6.0"

#Finding absolute path to current location to return user after completed
originalLocation=$(pwd)

#HEASoft tar.gz (gzip tarball)
heasoftFile="heasoft-${heasoftVersion}src.tar.gz"

#URL for download for HEASoft with all moddern packages
heasoftUrl="https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${heasoftVersion}/${heasoftFile}"

#Going to directory
cd ${destinationDir}

#Finding absolute path of destination directory (useful for later)
absolutePathDestination=$(pwd)

#Downloading XSPEC tar.gz file
wget ${heasoftUrl}

#Unzipping tar.gz file
tar -xvf ${heasoftFile}
rm -f ${heasoftFile}

#Finding absolute path of destination directory (useful for later)
absolutePathDestination=$(pwd)

#Going to BUILD_DIR for installation
cd "heasoft-${heasoftVersion}"
cd BUILD_DIR

#Running configuration script
./configure

#Running makefile
make
make install

#Adding the necessary components to the .cshrc file
heaDir="${absolutePathDestination}/heasoft-${heasoftVersion}/${archName}"
echo "export HEADAS=${heaDir}" >> $zshrcFile
echo "alias heainit="source \$HEADAS/headas-init.sh"" >> $zshrcFile

#Returning user
cd ${originalLocation}
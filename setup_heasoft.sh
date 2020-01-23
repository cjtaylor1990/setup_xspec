#!/bin/bash
#Currently built for the Department of Astronomy - University of Maryland

#Arguments from command line
heasoftVersion=$1 #Heasoft verison to set up
destinationDir=$2 #Relative (or absolute) path directory where to place the HEASoft directory

#System archetecture (current)
systemArch="x86_64-pc-linux-gnu-libc2.17"

#Finding absolute path to current location to return user after completed
originalLocation=$(pwd)

#HEASoft tar.gz (gzip tarball)
heasoftFile="heasoft-6.26.1src.tar.gz"

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
echo "SETENV ${absolutePathDestination}/heasoft-${heasoftVersion}/${systemArch}" >> ~/.cshrc
echo "alias heainit "source $HEADAS/headas-init.csh"" >> ~/.cshrc

#Returning user
cd ${originalLocation}
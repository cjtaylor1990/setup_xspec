#Currently built for the Department of Astronomy - University of Maryland

#Arguments from command line
heasoftVersion=$1 #Heasoft verison to set up
destination=$2 #Relative (or absolute) path directory where to place the HEASoft directory

#Finding absolute path to current location to return user after completed
originalLocation=$(pwd)

#HEASoft tar.gz (gzip tarball)
heasoftFile="heasoft-6.26.1src.tar.gz"

#URL for download for HEASoft with all moddern packages
heasoftUrl="https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft${heasoftVersion}/${heasoftFile}"

#Downloading XSPEC tar.gz file
wget ${heasoftUrl}

#Unzipping tar.gz file
tar -xvf ${heasoftFile} -C ${destination}
rm -f ${xspe}

#Going to directory
cd ${destination}

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

#TODO Finish the pathin the SETENV command
#Adding the necessary components to the .cshrc file
echo "SETENV ${absolutePathDestination}/heasoft-${heasoftVersion}/" >> .cshrc
alias heainit "source $HEADAS/headas-init.csh"

#Returning user
cd ${originalLocation}
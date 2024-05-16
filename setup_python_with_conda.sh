#!/bin/bash

LibsForDev=(
    "numpy"
    "pandas"
    "ipython"
    "scipy"
    "matplotlib"
    "nilearn"
    "nibabel"
    "pyarrow"
    "pydicom"
)


mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh


# get which shell is in used,
# the input of $SHELLBASE should be zsh or bash
# and init the conda
SHELLBASE=$(basename "$SHELL")
~/miniconda3/bin/conda init $SHELLBASE 

# pick a python version
py_version=(
    "3.6"
    "3.7"
    "3.8"
    "3.9"
)

default_py_version_index=3
read -p "your conda env name?" condaEnvName
read -p "your python env version?m (default: ${py_version[$default_py_version_index]}) [${py_version[@]}): " PythonEnv

# export PATH=~/miniconda3/bin:$PATH
conda -n $condaEnvName python=$PythonEnv
conda activate $condaEnvName


# Install required libraries for development
for lib in "${LibsForDev[@]}"; do
    echo "Installing $lib..."
    conda install "$lib"
    echo "Installation of $lib completed."
done
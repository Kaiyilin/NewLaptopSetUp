#!/bin/bash

LibsForDev=(
    "numpy"
    "pandas"
    "ipython"
    "opencv-python"
    "scipy"
    "matplotlib"
    "nilearn"
    "apache-airflow"
    "nibabel"
    "pyarrow"
    "pydicom"
)


#!/bin/bash
# install pip and activate virtual env
pip3 install --upgrade pip
pip3 install virtualenv
python3 -m venv ./venv

echo "Starting activate virtual env..."
source ./venv/bin/activate
echo "Virtual env activated"

# Install required libraries for development
for lib in "${LibsForDev[@]}"; do
  pip3 install "$lib"
done
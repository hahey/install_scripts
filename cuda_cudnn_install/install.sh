#!/bin/bash

sudo apt-get -y update & sudo apt-get -y upgrade

wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

CUDA_REPO=$PWD/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
CUDA_PATCH=$PWD/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

# Assume cudnn is downloaded in Downloads folder
CUDNN_TARBALL=$HOME/Downloads/cudnn-8.0-linux-x64-v5.1.tgz

set -x

# Basic setup
sudo apt update && sudo apt upgrade && sudo apt install git python3 python3-venv


# Disable splash screen
sed -e 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT=""/' \
    /etc/default/grub > fixed_grub_config && \
    sudo mv fixed_grub_config /etc/default/grub
sudo update-grub2


# Install cuda
sudo dpkg -i $CUDA_REPO && sudo apt-get update && sudo apt-get install cuda
sudo dpkg -i $CUDA_PATCH && sudo apt-get update && sudo apt-get install cuda

# Install cudnn
sudo tar -xvf $CUDNN_TARBALL -C /usr/local/


# Set path
echo 'PATH=$PATH:/usr/local/cuda/bin' > cuda_env.sh
echo 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' >> cuda_env.sh
sudo mv cuda_env.sh /etc/profile.d/cuda_env.sh


# Test
python3 -m venv check_cuda_installation
source check_cuda_installation/bin/activate
pip install -U pip
pip install tensorflow-gpu
python -c 'import tensorflow as tf; tf.Session()'
if [ $? == 0 ];
then
    echo "Successfully configured cuda and cudnn"
    RETURN_CODE=0
else
    echo "Failed to configure cuda and cudnn"
    echo "Leaving everything in place for you to investigate"
    RETURN_CODE=1
fi
rm -r check_cuda_installation
exit RETURN_CODE

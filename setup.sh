#!/bin/bash -xe

function setup_instance {
  export DEBIAN_FRONTEND=noninteractive

  sudo apt-get -y update
  sudo apt-get -y upgrade

  sudo apt-get install -y software-properties-common # adds add-apt-repository
  sudo add-apt-repository contrib

  sudo apt-get -y install libgl1-mesa-glx wget locales-all
}

function setup_cuda {
  # update keys
  sudo apt-key del 7fa2af80
  keyring=cuda-keyring_1.0-1_all.deb
  if [ ! -f $keyring ]; then
    wget https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/$keyring
  fi
  sudo dpkg -i $keyring

  # download package
  deb_file=cuda-repo-debian10-11-1-local_11.1.0-455.23.05-1_amd64.deb
  if [ ! -f $deb_file ]; then
    wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/$deb_file
  fi
  sudo dpkg -i $deb_file
  
  # install
  sudo apt-get update
  sudo apt-get -y install cuda
  sudo apt-get -y install nvidia-cuda-toolkit
}

function setup_repo {
  rm -rf cloth-segmentation 2> /dev/null
  git clone https://github.com/levindabhi/cloth-segmentation.git
  cd cloth-segmentation
}

function setup_conda {
  wget https://repo.anaconda.com/miniconda/Miniconda3-py37_22.11.1-1-Linux-x86_64.sh -O miniconda-setup.sh
  # the script doesn't work with pure `sh`
  perl -i -pe 's/#!\/bin\/sh/#!\/bin\/bash/' miniconda-setup.sh
  chmod +x miniconda-setup.sh
  ./miniconda-setup.sh -bup ~/miniconda
  rm miniconda-setup.sh

  eval "$(~/miniconda/bin/conda shell.bash hook)"
  conda init bash
  conda install conda=23.1.0 --yes
  conda config --add channels conda-forge

  conda create --name cloth-segmentation python=3 --yes
  conda activate cloth-segmentation

  conda install --force-reinstall --yes numpy anaconda opencv pytorch torchvision cudatoolkit
}

function download_model {
  mkdir trained_checkpoint
  cd trained_checkpoint

  pip3 install gdown
  ~/.local/bin/gdown "1mhF3yqd7R-Uje092eypktNl-RoZNuiCJ"

  cd ..
}

function download_input {
  mkdir input_images
  cd input_images
  cat ../../input-images | head -4 | xargs wget
  cd ..
}

setup_instance
setup_cuda
setup_conda
setup_repo
download_model
download_input
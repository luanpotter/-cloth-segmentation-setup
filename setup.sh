#!/bin/bash -xe

function setup_instance {
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get -y update
  sudo apt-get -y upgrade

  sudo apt-get install -y software-properties-common # adds add-apt-repository
  sudo add-apt-repository contrib

  sudo apt-get -y install python3-pip libgl1-mesa-glx wget
  sudo apt-get -y upgrade python3
}

function setup_cuda {
  # update keys
  sudo apt-key del 7fa2af80
  wget https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/cuda-keyring_1.0-1_all.deb
  sudo dpkg -i cuda-keyring_1.0-1_all.deb

  # download package
  deb_file=cuda-repo-debian10-11-1-local_11.1.0-455.23.05-1_amd64.deb
  if [ ! -f $deb_file ]; then
    wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/$deb_file
    sudo dpkg -i $deb_file
  fi
  
  # install
  sudo apt-get update
  sudo apt-get -y install cuda
}

function setup_repo {
  rm -rf cloth-segmentation 2> /dev/null
  git clone https://github.com/levindabhi/cloth-segmentation.git

  cp requirements.txt cloth-segmentation/
  cd cloth-segmentation
  pip3 install -r requirements.txt
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
setup_repo
download_model
download_input


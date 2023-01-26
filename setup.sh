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
  deb_file=cuda-repo-debian11-11-7-local_11.7.1-515.65.01-1_amd64.deb
  if [ ! -f $deb_file ]; then
    wget https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/$deb_file
  fi
  sudo dpkg -i $deb_file

  sudo cp /var/cuda-repo-debian11-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
  sudo add-apt-repository contrib
  sudo apt-get update
  sudo apt-get -y install cuda
}

function setup_repo {
  rm -rf cloth-segmentation 2> /dev/null
  git clone https://github.com/levindabhi/cloth-segmentation.git
  cd cloth-segmentation
}

function setup_conda {
  if [ ! -d ~/miniconda ]; then
    wget https://repo.anaconda.com/miniconda/Miniconda3-py37_22.11.1-1-Linux-x86_64.sh -O miniconda-setup.sh
    # the script doesn't work with pure `sh`
    perl -i -pe 's/#!\/bin\/sh/#!\/bin\/bash/' miniconda-setup.sh
    chmod +x miniconda-setup.sh
    ./miniconda-setup.sh -bup ~/miniconda
    rm miniconda-setup.sh
  fi

  eval "$(~/miniconda/bin/conda shell.bash hook)"
  conda init bash
  # update conda
  conda install conda=23.1.0 --yes

  conda create --name cloth-segmentation python=3 --yes
  conda activate cloth-segmentation

  conda install --yes -c conda-forge opencv
  conda install --yes tqdm pillow
  conda install --force-reinstall --yes pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia
}

function download_model {
  mkdir trained_checkpoint
  cd trained_checkpoint

  pip3 install gdown
  gdown "1mhF3yqd7R-Uje092eypktNl-RoZNuiCJ"

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
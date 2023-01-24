#!/bin/bash -xe

function setup_repo {
  git clone https://github.com/levindabhi/cloth-segmentation.git

  cp requirements.txt cloth-segmentation/
  cd cloth-segmentation
  pip3 install -r requirements.txt
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

function run_model {
  python3 infer.py
}

rm -rf cloth-segmentation 2> /dev/null
setup_repo
download_model
download_input
run_model

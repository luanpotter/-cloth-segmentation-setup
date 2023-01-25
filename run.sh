#!/bin/bash -xe
#
function run_model {
  cd cloth-segmentation
  conda activate cloth-segmentation
  python3 infer.py
}

run_model

#!/bin/bash -xe
#
function run_model {
  cd cloth-segmentation
  python3 infer.py
}

run_model

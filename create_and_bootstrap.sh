#!/bin/bash

export IMAGE="graftM.img"

set -x

echo "Hello! starting $(date)"

sudo rm -rf $IMAGE
singularity create -s 3036 $IMAGE
sudo singularity bootstrap $IMAGE ubuntu.sh

echo "Goodbye! ending $(date)"

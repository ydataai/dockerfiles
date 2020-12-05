#!/bin/bash --login
set -e

echo "teste"
conda activate h2o4gpuenv
exec "$@"

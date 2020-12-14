#!/bin/bash --login
set -e

conda activate h2o4gpuenv
exec "$@"

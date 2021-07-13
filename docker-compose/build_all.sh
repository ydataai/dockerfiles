#!/bin/bash
set -e

echo "==> Start building images..."; echo "";
for filename in *.yaml; do
    echo "===> Start building: $filename"; echo "";
    docker-compose -f $filename build
    echo ""; echo "===> Finish building: $filename"; echo "";
done
echo "==> Finish building images..."; echo "";


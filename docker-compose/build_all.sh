#!/bin/bash
set -e

## CPU
echo "==> Start building cpu images..."; echo ""
for filename in cpu-* ; do
    echo "===> Start building: $filename"; echo ""
    docker-compose -f $filename build >/dev/null
    echo ""; echo "===> Finishing building: $filename"; echo ""
done
echo "==> Finish building cpu images..."; echo ""; echo ""; echo ""

## GPU
echo "==> Start building gpu images..."; echo "";
for filename in gpu-* ; do
    echo "===> Start building: $filename"; echo ""
    docker-compose -f $filename build >/dev/null
    echo ""; echo "===> Finishing building: $filename"; echo ""
done
echo "==> Finish building gpu images..."; echo ""

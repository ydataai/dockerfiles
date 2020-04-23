#! /bin/bash

OLDPWD=$PWD

cd $1

build_args=$(for i in `cat build.args`; do out+="--build-arg $i " ; done; echo $out;out="")
echo $build_args

docker build --rm $build_args -t $2 .
docker push $2

cd $OLDPWD

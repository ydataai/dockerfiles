#! /bin/bash

OLDPWD=$PWD

cd $1

if [ -f "build.args" ]; then
    build_args=$(for i in `cat build.args`; do out+="--build-arg $i " ; done; echo $out;out="")
    echo "Running with argumens: $build_args"
fi


docker build --rm $build_args -t $2 .
# docker push $2

cd $OLDPWD

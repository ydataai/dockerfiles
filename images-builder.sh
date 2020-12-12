cuda_images=(nvidia-cuda)
cuda_versions=(10.0 10.1)

laboratories_images=(data-science/laboratories-base data-science/jupyterlab-1.2.15 \
data-science/jupyterlab-1.2.15_tensorflow-1.15 data-science/jupyterlab-1.2.15_tensorflow-2.3 \
data-science/jupyterlab-1.2.15_pytorch-1.7 data-science/h2oflow-3.32.0.2)
laboratories_images_types=(cpu gpu)

for image in "${cuda_images[@]}"
do
  for version in "${cuda_versions[@]}"
  do
    make build IMAGE="$image" VERSION="$version"
    make push IMAGE="$image" VERSION="$version"
  done
done

for image in "${laboratories_images[@]}"
do
  for type in "${laboratories_images_types[@]}"
  do
    make build IMAGE="$image" TYPE="$type" TAG="$1"
    make push IMAGE="$image" TYPE="$type" TAG="$1"
  done
done

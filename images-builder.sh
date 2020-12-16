laboratories_images=(data-science/laboratories-base data-science/jupyterlab-2.2.9 \
data-science/jupyterlab-2.2.9_tensorflow-1.15 data-science/jupyterlab-2.2.9_tensorflow-2.3 \
data-science/jupyterlab-2.2.9_pytorch-1.7 data-science/h2oflow-3.32.0.2 data-science/ydata)
laboratories_images_types=(cpu gpu)

for image in "${laboratories_images[@]}"
do
  for type in "${laboratories_images_types[@]}"
  do
      make build IMAGE="$image" TYPE="$type" TAG="$1"
      make push IMAGE="$image" TYPE="$type" TAG="$1"
  done
done

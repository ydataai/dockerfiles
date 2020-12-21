laboratories_images_types=(cpu gpu)

case $1 in
  base)
      for type in "${laboratories_images_types[@]}"
      do
          make build IMAGE="data-science/laboratories-base" TYPE="$type" TAG="$2"
          make push IMAGE="data-science/laboratories-base" TYPE="$type" TAG="$2"
      done
    ;;

  jupyterlab)
      for image in data-science/jupyterlab-1.2.15 data-science/jupyterlab-1.2.15_tensorflow-1.15 data-science/jupyterlab-1.2.15_tensorflow-2.3 data-science/jupyterlab-1.2.15_pytorch-1.7
      do
        for type in "${laboratories_images_types[@]}"
        do
            make build IMAGE="$image" TYPE="$type" TAG="$2"
            make push IMAGE="$image" TYPE="$type" TAG="$2"
        done
      done
    ;;

  h2o)
      for type in "${laboratories_images_types[@]}"
      do
          make build IMAGE="data-science/h2oflow-3.32.0.2" TYPE="$type" TAG="$2"
          make push IMAGE="data-science/h2oflow-3.32.0.2" TYPE="$type" TAG="$2"
      done
    ;;

  ydata)
      make build IMAGE="data-science/ydata" TAG="$2"
      make push IMAGE="data-science/ydata" TAG="$2"
    ;;
esac

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
      for image in data-science/jupyterlab data-science/jupyterlab_tensorflow-1.15 data-science/jupyterlab_tensorflow-2.3 data-science/jupyterlab_pytorch-1.7
      do
        for type in "${laboratories_images_types[@]}"
        do
            make build IMAGE="$image" TYPE="$type" TAG="$2"
            make push IMAGE="$image" TYPE="$type" TAG="$2"
        done
      done
    ;;

  rstudio)
      for image in data-science/rstudio
      do
        for type in "${laboratories_images_types[@]}"
        do
            make build IMAGE="$image" TYPE="$type" TAG="$2"
            make push IMAGE="$image" TYPE="$type" TAG="$2"
        done
      done
    ;;

  rstudio_bundles)
      for image in data-science/rstudio_tensorflow data-science/rstudio_torch-1.7
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
          make build IMAGE="data-science/h2oflow" TYPE="$type" TAG="$2"
          make push IMAGE="data-science/h2oflow" TYPE="$type" TAG="$2"
      done
    ;;

  ydata)
      make build IMAGE="data-science/ydata" TAG="$2"
      make push IMAGE="data-science/ydata" TAG="$2"
    ;;
esac

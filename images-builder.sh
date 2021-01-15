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
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/jupyterlab" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/jupyterlab" TYPE="$type" TAG="$2"
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

  jupyterlab_python_bundles)
    for image in data-science/jupyterlab_python_tensorflow-1.15 data-science/jupyterlab_python_tensorflow-2.3 data-science/jupyterlab_python_torch-1.7
    do
      for type in "${laboratories_images_types[@]}"
      do
        make build IMAGE="$image" TYPE="$type" TAG="$2"
        make push IMAGE="$image" TYPE="$type" TAG="$2"
      done
    done
  ;;

  jupyterlab_r_bundles)
    for image in data-science/jupyterlab_r_tensorflow-1.15 data-science/jupyterlab_r_tensorflow-2.3 data-science/jupyterlab_r_torch-1.7
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
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/ydata" TAG="$2"
      make push IMAGE="data-science/ydata" TAG="$2"
    done
  ;;
esac

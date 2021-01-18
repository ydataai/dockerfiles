laboratories_images_types=(cpu gpu)

case $1 in
  base_python)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/laboratories-base" LANGUAGE="python" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/laboratories-base" LANGUAGE="python" TYPE="$type" TAG="$2"
    done
  ;;

  base_r)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/laboratories-base" LANGUAGE="r" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/laboratories-base" LANGUAGE="r" TYPE="$type" TAG="$2"
    done
  ;;

  jupyterlab_python)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/jupyterlab_python" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/jupyterlab_python" TYPE="$type" TAG="$2"
    done
  ;;

  jupyterlab_r)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/jupyterlab_r" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/jupyterlab_r" TYPE="$type" TAG="$2"
    done
  ;;

  rstudio)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/rstudio" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/rstudio" TYPE="$type" TAG="$2"
    done
  ;;

  rstudio_tensorflow)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/rstudio_tensorflow" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/rstudio_tensorflow" TYPE="$type" TAG="$2"
    done
  ;;

  rstudio_torch)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/rstudio_torch-1.7" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/rstudio_torch-1.7" TYPE="$type" TAG="$2"
    done
  ;;

  jupyterlab_python_tensorflow)
    for image in data-science/jupyterlab_python_tensorflow-1.15 data-science/jupyterlab_python_tensorflow-2.3
    do
      for type in "${laboratories_images_types[@]}"
      do
        make build IMAGE="$image" TYPE="$type" TAG="$2"
        make push IMAGE="$image" TYPE="$type" TAG="$2"
      done
    done
  ;;

  jupyterlab_r_tensorflow)
    for image in data-science/jupyterlab_r_tensorflow-1.15 data-science/jupyterlab_r_tensorflow-2.3
    do
      for type in "${laboratories_images_types[@]}"
      do
        make build IMAGE="$image" TYPE="$type" TAG="$2"
        make push IMAGE="$image" TYPE="$type" TAG="$2"
      done
    done
  ;;

  jupyterlab_python_torch)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$type" TAG="$2"
    done
  ;;

  jupyterlab_r_torch)
    for type in "${laboratories_images_types[@]}"
    do
      make build IMAGE="data-science/jupyterlab_r_torch-1.7" TYPE="$type" TAG="$2"
      make push IMAGE="data-science/jupyterlab_r_torch-1.7" TYPE="$type" TAG="$2"
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

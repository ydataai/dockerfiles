
case $1 in
  base_python)
    make build IMAGE="data-science/laboratories-base" LANGUAGE="python" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/laboratories-base" LANGUAGE="python" TYPE="$2" TAG="$3"
  ;;

  base_r)
    make build IMAGE="data-science/laboratories-base" LANGUAGE="r" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/laboratories-base" LANGUAGE="r" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_python)
    make build IMAGE="data-science/jupyterlab_python" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_python" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_r)
    make build IMAGE="data-science/jupyterlab_r" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_r" TYPE="$2" TAG="$3"
  ;;

  rstudio)
    make build IMAGE="data-science/rstudio" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/rstudio" TYPE="$2" TAG="$3"
  ;;

  rstudio_tensorflow)
    make build IMAGE="data-science/rstudio_tensorflow" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/rstudio_tensorflow" TYPE="$2" TAG="$3"
  ;;

  rstudio_torch)
    make build IMAGE="data-science/rstudio_torch-1.7" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/rstudio_torch-1.7" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_python_tensorflow)
    for image in data-science/jupyterlab_python_tensorflow-1.15 data-science/jupyterlab_python_tensorflow-2.3
    do
      make build IMAGE="$image" TYPE="$2" TAG="$3"
      make push IMAGE="$image" TYPE="$2" TAG="$3"
    done
  ;;

  jupyterlab_r_tensorflow)
    for image in data-science/jupyterlab_r_tensorflow-1.15 data-science/jupyterlab_r_tensorflow-2.3
    do
      make build IMAGE="$image" TYPE="$2" TAG="$3"
      make push IMAGE="$image" TYPE="$2" TAG="$3"
    done
  ;;

  jupyterlab_python_torch)
    make build IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_r_torch)
    make build IMAGE="data-science/jupyterlab_r_torch-1.7" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_r_torch-1.7" TYPE="$2" TAG="$3"
  ;;

  h2o)
    make build IMAGE="data-science/h2oflow" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/h2oflow" TYPE="$2" TAG="$3"
  ;;

  ydata)
    make build IMAGE="data-science/ydata" TAG="$2"
    make push IMAGE="data-science/ydata" TAG="$2"
  ;;
esac

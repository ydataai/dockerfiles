
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

  visualcode)
    make build IMAGE="data-science/visualcode" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/visualcode" TYPE="$2" TAG="$3"
  ;;

  visualcode_tensorflow-1.15)
    make build IMAGE="data-science/visualcode_tensorflow-1.15" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/visualcode_tensorflow-1.15" TYPE="$2" TAG="$3"
  ;;

  visualcode_tensorflow-2.3)
    make build IMAGE="data-science/visualcode_tensorflow-2.3" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/visualcode_tensorflow-2.3" TYPE="$2" TAG="$3"
  ;;

  visualcode_torch)
    make build IMAGE="data-science/visualcode_torch-1.7" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/visualcode_torch-1.7" TYPE="$2" TAG="$3"
  ;;

  rstudio_tensorflow)
    make build IMAGE="data-science/rstudio_tensorflow" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/rstudio_tensorflow" TYPE="$2" TAG="$3"
  ;;

  rstudio_torch)
    make build IMAGE="data-science/rstudio_torch" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/rstudio_torch" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_python_tensorflow-1.15)
    make build IMAGE="data-science/jupyterlab_python_tensorflow-1.15" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_python_tensorflow-1.15" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_python_tensorflow-2.3)
    make build IMAGE="data-science/jupyterlab_python_tensorflow-2.3" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_python_tensorflow-2.3" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_r_tensorflow-1.15)
    make build IMAGE="data-science/jupyterlab_r_tensorflow-1.15" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_r_tensorflow-1.15" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_r_tensorflow-2.3)
    make build IMAGE="data-science/jupyterlab_r_tensorflow-2.3" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_r_tensorflow-2.3" TYPE="$2" TAG="$3"
  ;;


  jupyterlab_python_torch)
    make build IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_python_torch-1.7" TYPE="$2" TAG="$3"
  ;;

  jupyterlab_r_torch)
    make build IMAGE="data-science/jupyterlab_r_torch" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/jupyterlab_r_torch" TYPE="$2" TAG="$3"
  ;;

  h2o)
    make build IMAGE="data-science/h2oflow" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/h2oflow" TYPE="$2" TAG="$3"
  ;;

  visualcode_ydata)
    make build IMAGE="data-science/visualcode_ydata" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/visualcode_ydata" TYPE="$2" TAG="$3"
  ;;

  ydata)
    make build IMAGE="data-science/ydata" TYPE="$2" TAG="$3"
    make push IMAGE="data-science/ydata" TYPE="$2" TAG="$3"
  ;;

  dask-worker)
    make build IMAGE="dask/worker" VERSION="2020.12.0" TAG="$3"
    make push IMAGE="dask/worker" VERSION="2020.12.0" TAG="$3"
  ;;

esac

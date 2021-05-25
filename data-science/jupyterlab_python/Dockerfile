ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

COPY --chown=ydata:users dask_config.yaml /etc/dask/distributed.yaml

USER ${UID}

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --dev-build=False --minimize=False

# Integrate NBDIME with git
RUN nbdime config-git --enable --global

# Configure elyra runtime-images
RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_tensorflow_115-cpu" \
--display_name="YData Tensorflow 1.15 CPU" \
--image_name="docker.io/ydata/jupyterlab_python_tensorflow-1.15:0.17.0-cpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_tensorflow_23-cpu" \
--display_name="YData Tensorflow 2.3 CPU" \
--image_name="docker.io/ydata/jupyterlab_python_tensorflow-2.3:0.17.0-cpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_torch_17-cpu" \
--display_name="YData Torch 1.7 CPU" \
--image_name="docker.io/ydata/jupyterlab_python_torch-1.7:0.17.0-cpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata-cpu" \
--display_name="YData CPU" \
--image_name="ghcr.io/ydataai/ydata:0.17.0-cpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_tensorflow_115-gpu" \
--display_name="YData Tensorflow 1.15 GPU" \
--image_name="docker.io/ydata/jupyterlab_python_tensorflow-1.15:0.17.0-gpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_tensorflow_23-gpu" \
--display_name="YData Tensorflow 2.3 GPU" \
--image_name="docker.io/ydata/jupyterlab_python_tensorflow-2.3:0.17.0-gpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata_torch_17-gpu" \
--display_name="YData Torch 1.7 GPU" \
--image_name="docker.io/ydata/jupyterlab_python_torch-1.7:0.17.0-gpu"

RUN elyra-metadata install runtime-images --schema_name=runtime-image \
--name="ydata-gpu" \
--display_name="YData GPU" \
--image_name="ghcr.io/ydataai/ydata:0.17.0-gpu"

# Configure container startup
ENV URL_BASE_PATH /
EXPOSE 8888
ENTRYPOINT [ "/etc/entrypoint.sh" ]
CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${URL_BASE_PATH}" ]

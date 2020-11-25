FROM ydata/laboratories-base:0.1.0

COPY --chown=ydata:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install --use-feature=2020-resolver -r /tmp/requirements.txt

# Enable kale extension
RUN jupyter labextension install kubeflow-kale-labextension

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}" ]

CUDA_IMAGES=nvidia-cuda
LABS_IMAGES=data-science/jupyterlab data-science/laboratories-base data-science/jupyterlab_r_torch-1.7 \
data-science/jupyterlab_r_tensorflow-1.15 data-science/jupyterlab_r_tensorflow-2.3 \
data-science/rstudio data-science/rstudio_tensorflow data-science/rstudio_torch-1.7 \
data-science/jupyterlab_python_tensorflow-1.15 data-science/jupyterlab_python_tensorflow-2.3 \
data-science/jupyterlab_python_torch-1.7 data-science/h2oflow data-science/ydata
IMAGES=$(CUDA_IMAGES) $(LABS_IMAGES)
TAG=latest
TYPES=cpu gpu
CUDA_VERSIONS=10.0 10.1

.PHONY: help list-images build push build-and-push-all

define DOCKER_BUILD
	$(MAKE) -C $1 build
endef

define DOCKER_PUSH
	$(MAKE) -C $1 push
endef

help:	# The following lines will print the available commands when entering just 'make'
ifeq ($(UNAME), Linux)
	@grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
else
	@awk -F ':.*###' '$$0 ~ FS {printf "%15s%s\n", $$1 ":", $$2}' \
		$(MAKEFILE_LIST) | grep -v '@awk' | sort
endif

list-images: ### Lists all the images available to be built and/or pushed to Docker image registry
	@echo "The images that you can use this tool to build are:"; echo ""
	@echo $(foreach image, $(IMAGES), "\t • ${image}"; echo "")

build:	### Builds the image given, its name, its type and, optionally, its tag. I.e.: `make build IMAGE=h2oflow-3.32.0.2 TYPE=gpu TAG=0.1.0 (optional)`
ifndef IMAGE
	$(error Missing IMAGE variable. Usage: make build IMAGE= TYPE= TAG= (optional))
endif
ifeq ($(IMAGE),nvidia-cuda)
ifndef VERSION
	$(error Missing VERSION variable. Usage: make build IMAGE= VERSION=)
endif
else
ifneq ($(IMAGE),data-science/ydata)
ifndef TYPE
	$(error Missing TYPE variable. Usage: make build IMAGE= TYPE= TAG= (optional))
endif
endif
endif
ifeq ($(filter $(IMAGE),$(IMAGES)),)
	$(error Invalid image selected. Call `make list-images` to check the images you can build)
endif
ifeq ($(IMAGE),nvidia-cuda)
ifeq ($(filter $(VERSION),$(CUDA_VERSIONS)),)
	$(error Invalid VERSION selected. Only 10.0 or 10.1 are supported)
endif
else
ifneq ($(IMAGE),data-science/ydata)
ifeq ($(filter $(TYPE),$(TYPES)),)
	$(error Invalid type selected. Only cpu or gpu are supported)
endif
endif
endif

ifeq ($(IMAGE),nvidia-cuda)
	$(call DOCKER_BUILD,${IMAGE},${VERSION})
else
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG})
endif

push:	### Pushes the image to Docker image registry, given its name and its tag. I.e.: `make push IMAGE=h2oflow-3.32.0.2 TAG=0.1.0 (optional)`
ifndef IMAGE
	$(error Missing IMAGE variable. Usage: make push IMAGE= TAG= (optional))
endif
ifeq ($(IMAGE),nvidia-cuda)
ifndef VERSION
	$(error Missing VERSION variable. Usage: make build IMAGE= VERSION=)
endif
else
ifneq ($(IMAGE),data-science/ydata)
ifndef TYPE
	$(error Missing TYPE variable. Usage: make build IMAGE= TYPE= TAG= (optional))
endif
endif
endif
ifeq ($(filter $(IMAGE),$(IMAGES)),)
	$(error Invalid image selected. Call `make list-images` to check the images you can build)
endif
ifeq ($(IMAGE),nvidia-cuda)
ifeq ($(filter $(VERSION),$(CUDA_VERSIONS)),)
	$(error Invalid VERSION selected. Only 10.0 or 10.1 are supported)
endif
else
ifneq ($(IMAGE),data-science/ydata)
ifeq ($(filter $(TYPE),$(TYPES)),)
	$(error Invalid type selected. Only cpu or gpu are supported)
endif
endif
endif

ifeq ($(IMAGE),nvidia-cuda)
	$(call DOCKER_PUSH,${IMAGE},${VERSION})
else
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})
endif

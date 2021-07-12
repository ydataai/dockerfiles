TAG=latest
DOCKER_REGISTRY=docker.io

.PHONY: build push

define DOCKER_BUILD
	$(eval ARGS_FILE := ./$2/build.args)

	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg PACKAGES_FILE=$4" && cat $(ARGS_FILE) | awk '{print "--build-arg",$$1}' && cat ./build.args | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$(subst data-science/,,$1)_$(subst _packages.txt,,$4):$3-$2 .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := ydata/$(subst data-science/,,$1)_$(subst _packages.txt,,$4):$3-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}
endef

build:
ifeq (${TYPE},gpu)
ifndef CUDA
	$(error Missing CUDA variable. Usage: make build IMAGE= TYPE=gpu CUDA=(10.0, 10.1, 11.0) TAG= (optional))
endif
	$(call DOCKER_BUILD,${IMAGE},gpu-cuda${CUDA},${TAG},${LANGUAGE}_packages.txt)
else
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG},${LANGUAGE}_packages.txt)
endif

push:
ifeq (${TYPE},gpu)
ifndef CUDA
	$(error Missing CUDA variable. Usage: make build IMAGE= TYPE=gpu CUDA=(10.0, 10.1, 11.0) TAG= (optional))
endif
	$(call DOCKER_PUSH,${IMAGE},gpu-cuda${CUDA},${TAG},${LANGUAGE})
else
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG},${LANGUAGE})
endif




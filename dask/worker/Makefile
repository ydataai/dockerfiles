DOCKER_REGISTRY=docker.io

.PHONY: build

define DOCKER_BUILD
	$(eval ARGS_FILE := ./$1/build.args)

	@echo ""; echo "==> Building dask-worker image, version $1"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS := $(shell cat ./$1/build.args | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/dask-worker:$1-$2 .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := ydata/dask-worker:$1-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}
endef

build:
	$(call DOCKER_BUILD,${VERSION},${TAG})

push:
	$(call DOCKER_PUSH,${VERSION},${TAG})

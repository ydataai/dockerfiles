TAG=latest
DOCKER_REGISTRY=ghcr.io
PACKAGE=ydataai/dockerfiles

.PHONY: build

define DOCKER_BUILD
	$(eval ARGS_FILE := ./build.args)

	@echo ""; echo "==> Building $(subst data-science/,,$1) image, with tag $2"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS += $(shell cat ./build.args | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@echo docker build --rm $($@_BUILD_ARGS) -t $(subst data-science/,,$1):$2-gpu .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := $(subst data-science/,,$1):$2-gpu)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@echo docker push ${DOCKER_REGISTRY}/${PACKAGE}/${IMAGE_NAME}
endef

build:
	$(call DOCKER_BUILD,${IMAGE},${TAG})

push:
	$(call DOCKER_PUSH,${IMAGE},${TAG})

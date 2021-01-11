TAG=latest
DOCKER_REGISTRY=docker.io

.PHONY: build push

define DOCKER_BUILD
	$(eval ARGS_FILE := ./build.args)

	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg TYPE=$2 --build-arg TYPE=$(subst -cuda10.1,,$2)" && cat $(ARGS_FILE) | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$(subst data-science/,,$1):$3-$(subst -cuda10.1,,$2) -f Dockerfile.$2 .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := ydata/$(subst data-science/,,$1):$3-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}
endef

build:
ifeq ($(TYPE),gpu)
	$(call DOCKER_BUILD,${IMAGE},${TYPE}-cuda10.1,${TAG})
else
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG})
endif

push:
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})

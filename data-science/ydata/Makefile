TAG=latest
DOCKER_REGISTRY=ghcr.io
OWNER=ydataai

.PHONY: build push

define DOCKER_BUILD
	@echo ""; echo "==> Building $(subst data-science/,,$1) image, with tag $2"; echo ""

	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg TAG=$2-gpu-cuda10.1" ))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ${DOCKER_REGISTRY}/${OWNER}/$(subst data-science/,,$1):$(subst -cuda10.1,,$2)-gpu .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := $(subst data-science/,,$1):$2-gpu)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${OWNER}/${IMAGE_NAME}
endef

build:
ifeq ($(TYPE),gpu)
	$(call DOCKER_BUILD,${IMAGE},${TAG})
else
	$(call DOCKER_BUILD,${IMAGE},${TAG})
endif

push:
	$(call DOCKER_PUSH,${IMAGE},${TAG})

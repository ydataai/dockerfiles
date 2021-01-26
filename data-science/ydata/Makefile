TAG=latest
DOCKER_REGISTRY=ghcr.io
OWNER=ydataai

.PHONY: build push

define DOCKER_BUILD
	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg TAG=$3-$2" ))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ${DOCKER_REGISTRY}/${OWNER}/$(subst data-science/,,$1):$3-$(subst -cuda10.1,,$2) .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := $(subst data-science/,,$1):$3-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${OWNER}/${IMAGE_NAME}
endef

build:
ifeq ($(TYPE),gpu)
	$(call DOCKER_BUILD,${IMAGE},gpu-cuda10.1,${TAG})
else
	$(call DOCKER_BUILD,${IMAGE},cpu,${TAG})
endif

push:
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})

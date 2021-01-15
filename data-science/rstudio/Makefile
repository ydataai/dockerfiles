TAG=latest
DOCKER_REGISTRY=docker.io
CUDA_VERSIONS=10.0 10.1

.PHONY: build push

define DOCKER_BUILD
	$()
	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg TYPE=$(subst -cuda10.1,,$2) --build-arg TAG=$3-$2"))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$(subst data-science/,,$1):$3-$2 -f Dockerfile.$(firstword $(subst -, ,$2)) .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := ydata/$(subst data-science/,,$1):$3-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}
endef

build:
ifeq (${TYPE},gpu)
	$(foreach version,$(CUDA_VERSIONS),$(call DOCKER_BUILD,${IMAGE},gpu-cuda${version},${TAG}))
else
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG})
endif

push:
ifeq (${TYPE},gpu)
	$(foreach version,$(CUDA_VERSIONS),$(call DOCKER_PUSH,${IMAGE},gpu-cuda${version},${TAG}))
else
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})
endif

test:
	echo $(firstword $(subst -, ,gpu-cuda10.0))

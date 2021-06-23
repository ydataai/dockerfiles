TAG=latest
DOCKER_REGISTRY=docker.io
TENSORFLOW_VERSIONS=1.15 2.3

.PHONY: build push

define DOCKER_BUILD
	$()
	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS := $(shell echo "--build-arg TYPE=$(subst -cuda10.1,,$2) --build-arg VERSION=$4 --build-arg TAG=$3-$2"))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$(subst data-science/,,$1-$4):$3-$(subst -cuda10.1,,$2) .
endef

define DOCKER_PUSH
	$(eval IMAGE_NAME := ydata/$(subst data-science/,,$1-$4):$3-$2)
	@echo ""; echo "==> Pushing ${IMAGE_NAME} to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}
endef

build:
ifeq ($(TYPE),gpu)
	$(foreach VERSION,${TENSORFLOW_VERSIONS},$(call DOCKER_BUILD,${IMAGE},${TYPE}-cuda10.0,${TAG},${VERSION}))
else
	$(foreach VERSION,${TENSORFLOW_VERSIONS},$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG},${VERSION}))
endif

push:
	$(foreach VERSION,${TENSORFLOW_VERSIONS},$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG},${VERSION}))

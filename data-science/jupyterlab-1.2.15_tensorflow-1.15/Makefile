TAG=latest
DOCKER_REGISTRY=docker.io/ydata

.PHONY: build

define DOCKER_BUILD
	$(eval ARGS_FILE := ./$2/build.args)

	@echo ""; echo "==> Building $(subst data-science/,,$1) image, $2-bound with tag $3"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS += $(shell echo "--build-arg TYPE=$2" && cat ./$2/build.args | awk '{print "--build-arg",$$1}' && cat ./build.args | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$(subst data-science/,,$1):$3-$2 .
endef

define DOCKER_PUSH
	@echo ""; echo "==> Pushing ydata/$1-$2:$3 to Docker image registry..."
	@docker push ${DOCKER_REGISTRY}/$(subst data-science/,,$1):$3-$2
endef

build:
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG})

push:
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})

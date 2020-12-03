IMAGES_PATH=data-science
$(eval $_IMAGES := $(shell ls -ld ${IMAGES_PATH}/*/ | sort -r | head -1 | awk '{sub(/${IMAGES_PATH}\//, "", $$9); sub(/\//, "", $$9); print $$9}'))
$(eval $_IMAGES += $(shell ls -ld ${IMAGES_PATH}/*/ | sort | head -n $$(( $$(ls -ld ${IMAGES_PATH}/*/ | wc -l | awk '{print $$1}') - 1 )) | awk '{sub(/${IMAGES_PATH}\//, "", $$9); sub(/\//, "", $$9); print $$9}'))
TAG=latest
TYPES=cpu
DOCKER_HUB=docker.io/ydata

.PHONY: help list-images build push build-and-push-all

define DOCKER_BUILD
	$(eval ARGS_FILE := $(PWD)/data-science/$1/$2/build.args)

	@echo ""; echo "==> Building $1 image, $2-bound with tag $3"; echo ""

	@echo ""; echo "==> Reading args from $(ARGS_FILE)"
	$(eval $@_BUILD_ARGS := $(shell cat $(PWD)/data-science/$1/$2/build.args | awk '{print "--build-arg",$$1}'))

	@echo ""; echo "\t==> Using the following variables:"; echo ""
	@echo "\t\t$($@_BUILD_ARGS)"; echo ""; echo ""

	@echo ""; echo "==> Commencing build"
	@docker build --rm $($@_BUILD_ARGS) -t ydata/$1:$3-$2 data-science/$1/$2
endef

define DOCKER_PUSH
	@echo ""; echo "==> Pushing ydata/$1:$3-$2 to DockerHub..."
	@docker push ${DOCKER_HUB}/$1:$3-$2
endef

define DOCKER_BUILD_AND_PUSH
	$(call DOCKER_BUILD,$1,$2,$3)
	$(call DOCKER_PUSH,$1,$2,$3)
endef

help:	# The following lines will print the available commands when entering just 'make'
ifeq ($(UNAME), Linux)
	@grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
else
	@awk -F ':.*###' '$$0 ~ FS {printf "%15s%s\n", $$1 ":", $$2}' \
		$(MAKEFILE_LIST) | grep -v '@awk' | sort
endif

list-images: ### Lists all the images available to be built and/or pushed to DockerHub
	@echo "The images that you can use this tool to build are:"; echo ""
	@echo $(foreach image, $($_IMAGES), "\t • ${image}"; echo "")

build:	### Builds the image given, its name, its type and, optionally, its tag. I.e.: `make build IMAGE=h2oflow-3.32.0.2 TYPE=gpu TAG=0.1.0 (optional)`
ifndef IMAGE
	$(error Missing IMAGE variable. Usage: make build IMAGE= TYPE= TAG= (optional))
endif
ifndef TYPE
	$(error Missing TYPE variable. Usage: make build IMAGE= TYPE= TAG= (optional))
endif
ifeq ($(filter $(IMAGE),$($_IMAGES)),)
	$(error Invalid image selected. Call `make list-images` to check the images you can build)
endif
ifeq ($(filter $(TYPE),$(TYPES)),)
	$(error Invalid type selected. Only cpu or gpu are supported)
endif
	$(call DOCKER_BUILD,${IMAGE},${TYPE},${TAG})

push:	### Pushes the image to DockerHub, given its name and its tag. I.e.: `make push IMAGE=h2oflow-3.32.0.2 TAG=0.1.0 (optional)`
ifndef IMAGE
	$(error Missing IMAGE variable. Usage: make push IMAGE= TAG= (optional))
endif
	$(call DOCKER_PUSH,${IMAGE},${TYPE},${TAG})

build-and-push-all:	### Builds and pushes all the currently available images, both CPU and GPU bound, to DockerHub, with the given tag. I.e.: `make build-and-push-all TAG=0.1.0 (optional)`
	$(foreach type, $(TYPES), $(foreach image, $($_IMAGES), $(call DOCKER_BUILD_AND_PUSH,${image},${type},${TAG})))

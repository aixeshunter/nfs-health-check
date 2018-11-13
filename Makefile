GO ?= go
FIRST_GOPATH := $(firstword $(subst :, ,$(shell $(GO) env GOPATH)))

PREFIX ?= _outputs

DOCKERFILE      ?= Dockerfile
DOCKER_REPO ?= aixeshunter
DOCKER_IMAGE_NAME ?= nfs-health-check
DOCKER_IMAGE_TAG ?= v1.1


.PHONY: build
build:
        @echo ">> building binaries"
        $(GO) build nfs-check.go

.PHONY: docker
docker: build
        @echo ">> building docker image from $(DOCKERFILE)"
        @docker build -t "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" .
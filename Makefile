# basic parameters
NAME     := porker-front
VERSION  := v0.0.0
REVISION := $(shell git rev-parse --short HEAD)

# build parameters
BACKEND_URI ?= http://localhost:8080
DOCKER_USER ?= fake_suer
DOCKER_PASS ?= fake_pass
DOCKER_REGISTRY = core.harbor.swallowarc.work/porker/porker-front

.PHONY: build/release build/flutter-builder generate test docker-login
build/release:
	flutter pub get
	flutter build web --release --dart-define=BACKEND_URI=$(BACKEND_URI)

docker/build:
	docker build -t $(DOCKER_REGISTRY) .

docker/push: docker-login
	docker push $(DOCKER_REGISTRY)

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

test:
	flutter test

docker-login:
	docker login core.harbor.swallowarc.work -u $(DOCKER_USER) -p $(DOCKER_PASS)

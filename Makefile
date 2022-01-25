# basic parameters
NAME     := porker-front
VERSION  := v0.0.0
REVISION := $(shell git rev-parse --short HEAD)

# build parameters
BACKEND_URI ?= http://localhost:8080
DOCKER_USER ?= fake_suer
DOCKER_PASS ?= fake_pass
DOCKER_REGISTRY = swallowarc/porker-front

.PHONY: build/release build/flutter-builder generate test docker-login
build/release:
	flutter pub get
	#flutter build web --release --dart-define=BACKEND_URI=$(BACKEND_URI)
	flutter build web --release

docker/build:
	docker build -t $(DOCKER_REGISTRY) .

docker/push:
	docker push $(DOCKER_REGISTRY)

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

test:
	flutter test

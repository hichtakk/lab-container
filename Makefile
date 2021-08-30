.DEFAULT_GOAL := help

build:  ## build docker image
	docker build --no-cache -t hichtakk/testing-tools:v0.0.2 .

push:  ## push container image to docker hub
	docker push hichtakk/testing-tools:v0.0.2

clean: ## delete container and image
	docker ps -a | grep hichtakk/testing-tools | awk '{print $$1}' | xargs docker rm
	docker images | grep hichtakk/testing-tools | awk '{print $$3}' | xargs docker rmi
	docker builder prune --all

help:
	@grep -E '^[a-zA-Z_\-\/\.]+:.*?## .*$$' $(MAKEFILE_LIST) | sort

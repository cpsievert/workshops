.PHONY: all

all: build.done

# build and push to https://hub.docker.com/r/cpsievert
build.done: Dockerfile
	docker build -t workshops-20171118 .
	touch build.done
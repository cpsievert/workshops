.PHONY: all

all: build.done

# build and push to https://hub.docker.com/r/cpsievert
build.done: Dockerfile
	docker build -t workshops-20171018 .
	touch build.done

aws: build.done
	docker tag workshops-20171018:latest 471140226550.dkr.ecr.us-east-2.amazonaws.com/workshops-20171018:latest
	docker push 471140226550.dkr.ecr.us-east-2.amazonaws.com/workshops-20171018:latest
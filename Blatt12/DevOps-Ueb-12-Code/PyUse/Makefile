NEXUS=devopsXXYY:8088

help:
	cat Makefile

build:
	docker build -t pyuse .

push:
	docker login ${NEXUS}
	docker tag pyuse ${NEXUS}/pyuse
	docker push  ${NEXUS}/pyuse

run:
	docker run --rm -it -p6000:6000 pyuse

service:
	docker service create --name pyuse --with-registry-auth -p6000:6000 --replicas 5 ${NEXUS}/pyuse

sh:
	docker run --rm -it -p6000:6000 pyuse sh

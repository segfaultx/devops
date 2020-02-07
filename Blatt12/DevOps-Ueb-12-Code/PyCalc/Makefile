
NEXUS=devops0308:8088

help:
	echo ${NEXUS}
	cat Makefile

build:
	docker build -t pycalc .

push:
	docker login ${NEXUS}
	docker tag pycalc ${NEXUS}/pycalc
	docker push ${NEXUS}/pycalc

run:
	docker run --rm -it -p5000:5000 pycalc

service:
	docker service create --name pycalc --with-registry-auth -p5000:5000 --replicas 5 ${NEXUS}/pycalc

sh:
	docker run --rm -it -p5000:5000 pycalc sh

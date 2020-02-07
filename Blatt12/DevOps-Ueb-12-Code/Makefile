help:
	cat Makefile

deploy:
	docker stack deploy --with-registry-auth -c pyapp-compose.yml pyapp

update:
	docker service update --force pyapp_pycalc
	docker service update --force pyapp_pyuse

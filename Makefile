#change for justfile

run:
	docker-compose up mangosd

init-db:
	docker-compose up initdb

build:
	docker-compose up build

create-builders:
	docker-compose build build runtime

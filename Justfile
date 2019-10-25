#change for justfile

run:
	docker-compose up mangosd

init-db:
	docker-compose up initdb

extract-maps path:
	cp ./data/builder/data/run/bin/tools/* {{ path }}
	files=`ls ./data/builder/data/run/bin/tools/`
	cd {{ path }}
	chmod 755 ./ExtractResources.sh
	./ExtractResources.sh
	rm $files

build:
	docker run -v ` realpath ./data/builder/etc`:/runtime/etc -v ` realpath ./data/builder/data`:/runtime/data tek_mangos_builder build.sh

create-builder:
    docker build -f ./services/builder/Dockerfile -t tek_mangos_builder .

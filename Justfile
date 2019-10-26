#change for justfile

create-builder:
    docker build -f ./services/builder/Dockerfile -t tek_mangos_builder .

build:
	docker run -v ` realpath ./data/builder/etc`:/runtime/etc -v ` realpath ./data/builder/data`:/runtime/data tek_mangos_builder build.sh

extract-maps path:
	cp ./data/builder/data/run/bin/tools/* {{ path }}
	files=`ls ./data/builder/data/run/bin/tools/` && cd {{ path }} && chmod 755 ./ExtractResources.sh && ./ExtractResources.sh ; rm $files
	mv {{ path }}/maps/ ./data/mangosd/data/ || true
	mv {{ path }}/vmaps/ ./data/mangosd/data/ || true
	mv {{ path }}/mmaps/ ./data/mangosd/data/ || true
	mv {{ path }}/dbc/ ./data/mangosd/data/ || true

init-db:
	docker-compose up initdb

run:
	docker-compose up mangosd

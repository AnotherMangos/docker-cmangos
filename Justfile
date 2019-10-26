

# Create the docker container used to build realmd and mangosd and used to initialize the db
create-builder:
    docker build -f ./services/builder/Dockerfile -t tek_mangos_builder .

# Build the current version of realmd and mangosd
build-servers:
	docker run -v ` realpath ./data/builder/etc`:/runtime/etc -v ` realpath ./data/builder/data`:/runtime/data tek_mangos_builder build.sh

# Extracts the maps from the WOW client directory and put them in the mounted volume of the game server
extract-maps path:
	cp ./data/builder/data/run/bin/tools/* {{ path }}
	files=`ls ./data/builder/data/run/bin/tools/` && cd {{ path }} && chmod 755 ./ExtractResources.sh && ./ExtractResources.sh ; rm $files
	mv {{ path }}/maps/ ./data/mangosd/data/ || true
	mv {{ path }}/vmaps/ ./data/mangosd/data/ || true
	mv {{ path }}/mmaps/ ./data/mangosd/data/ || true
	mv {{ path }}/dbc/ ./data/mangosd/data/ || true

# Initialize the db with the builder
init-db:
	docker-compose up initdb
	docker-compose up -d mangosd
	sleep 2
	just exec account delete ADMINISTRATOR
	just exec account delete GAMEMASTER
	just exec account delete MODERATOR
	just exec account delete PLAYER
	docker-compose down

# reset the db
reset-db:
	docker-compose down
	rm -rf ./data/mysql/*

# Start the auth and game server
run:
	docker-compose up mysql realmd mangosd

# start a terminal on the game server
terminal:
	docker-compose exec mangosd ./terminal.sh

# execute a new command on the game server
exec +cmd:
	docker-compose exec mangosd ./exec.sh {{ cmd }}
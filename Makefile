# Build and run the application by default
default: build run

#
# OS
#

# run runs the built binary with dependencies in Docker containers
run:
	./run.sh

# build builds the application
build:
	./build.sh

# stop stops dependencies in Docker containers
stop: docker-stop

#
# Docker
#

DOCKER_COMPOSE=docker-compose -f docker-compose.yaml

# docker-start start all Docker containers
docker-start:
	${DOCKER_COMPOSE} up -d

# docker-stop stops all Docker containers
docker-stop:
	${DOCKER_COMPOSE} stop

# docker-stop-force stops Docker containers and removes newtowrks, images and etc.
docker-stop-force:
	${DOCKER_COMPOSE} down --remove-orphans -v

#
# Tests
#

# test runs unit tests
test: test-unit

# test-unit runs unit tests
test-unit:
	go test -v ./...

#
# Other
#

gensol:
	abigen --sol=internal/contracts/Flattened.sol --pkg=contracts --out internal/contracts/flattened.go

check: build test


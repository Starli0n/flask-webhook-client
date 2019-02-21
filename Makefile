-include .env
export $(shell sed 's/=.*//' .env)

export PYTHON_HTTP_URL=http://${PYTHON_HOSTNAME}:${HTTP_PORT}

.PHONY: env_var
env_var: # Print environnement variables
	@cat .env
	@echo
	@echo PYTHON_HTTP_URL=${PYTHON_HTTP_URL}

.PHONY: env
env: # Create .env and tweak it before initialize
	cp .env.default .env

.PHONY: app
app: initialize pull build mount

.PHONY: initialize
initialize:
	chmod +x app/scripts/{install,upgrade,run}.sh

.PHONY: pull
pull: # Pull the docker image
	docker pull python:${PYTHON_TAG}

.PHONY: build
build:
	docker build -t python-venv:${PYTHON_TAG} \
		--build-arg no_proxy=${no_proxy} \
		--build-arg NO_PROXY=${NO_PROXY} \
		--build-arg http_proxy=${http_proxy} \
		--build-arg HTTP_PROXY=${HTTP_PROXY} \
		--build-arg https_proxy=${https_proxy} \
		--build-arg HTTPS_PROXY=${HTTPS_PROXY} \
		--no-cache .

.PHONY: upgrade
upgrade:
	docker-compose run --rm --name python-install ${PYTHON_CONTAINER} /bin/bash -c ./scripts/upgrade.sh

.PHONY: init
init: # Install dependencies
	docker-compose run --rm --name python-install ${PYTHON_CONTAINER} /bin/bash -c ./scripts/install.sh

.PHONY: init-shell
init-shell: # Open a shell on a fresh container
	docker-compose run --rm --name python-shell ${PYTHON_CONTAINER} /bin/bash

.PHONY: erase
erase:
	rm -rf app/{__pycache__,venv}

.PHONY: config
config: # Show docker-compose configuration
	docker-compose -f docker-compose.yml config

.PHONY: up
up: # Start containers and services
	docker-compose -f docker-compose.yml up -d

.PHONY: down
down: # Stop containers and services
	docker-compose -f docker-compose.yml down

.PHONY: start
start: # Start containers
	docker-compose -f docker-compose.yml start

.PHONY: stop
stop: # Stop containers
	docker-compose -f docker-compose.yml stop

.PHONY: restart
restart: # Restart container
	docker-compose -f docker-compose.yml restart

.PHONY: delete
delete: down erase

.PHONY: mount
mount: init up

.PHONY: reset
reset: down up

.PHONY: hard-reset
hard-reset: delete mount

.PHONY: logs
logs:
	docker-compose logs -f

.PHONY: shell
shell: # Open a shell on a started container
	docker exec -it ${PYTHON_CONTAINER} /bin/bash

.PHONY: curl
curl:
	@curl ${PYTHON_HTTP_URL}

.PHONY: url
url:
	@echo ${PYTHON_HTTP_URL}

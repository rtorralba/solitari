
#!/bin/bash

DOCKER_CONTAINER = app
OS := $(shell uname)

ifeq ($(OS),Darwin)
    UID = $(shell id -u)
else ifeq ($(OS),Linux)
	UID = $(shell id -u)
else
	UID = 1000
endif

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

up: ## Start the containers
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml up -d

compile: ## Compile program
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml exec --user ${UID} app fpc PRINCIPA.PAS

run: ## Run program
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml exec --user ${UID} app ./PRINCIPA

stop: ## Stop the containers
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml stop

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) -f .docker/docker-compose.yml run

build: ## Rebuilds all the containers
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml build

bash: ## ssh's into the be container
	U_ID=${UID} docker-compose -f .docker/docker-compose.yml exec --user ${UID} ${DOCKER_CONTAINER} /bin/bash
.DEFAULT_GOAL := help

include .env
export  $(shell sed 's/=.*//' .env)

# ---------------------------------------------------------- #
# LOCAL
# ---------------------------------------------------------- #

up: ## Start Service ~ Mode Local
	docker-compose up --no-build

# ---------------------------------------------------------- #
# Deploy
# ---------------------------------------------------------- #

start: ## Start Service ~ Mode Deploy
	docker-compose --file docker-compose.deploy.yml up -d

# ---------------------------------------------------------- #
# GENERAL
# ---------------------------------------------------------- #

bash: ## Run Container ~ Mode General
	docker run -it --rm -v ${PWD}:/app -w /app denoland/deno:latest bash

dependencies: ## Install Dependencies ~ Mode General
	docker run -it --rm  -v ${PWD}:/app -w /app denoland/deno:latest npm i

restart: ## Restart Principal Service ~ Mode General
	docker-compose restart server

restart-all: ## Restart All Services ~ Mode General
	docker-compose restart

stop: ## Stop All Services ~ Mode General
	docker-compose stop

down: ## Down All Services ~ Mode General
	docker-compose down

logs: ## Show Logs Principal Service ~ Mode General
	docker-compose logs --tail="all" --follow server

logs-all: ## Show Logs All Services ~ Mode General
	docker-compose logs --tail="all" --follow

git-pull: ## Run Update Code ~ Mode General
	git pull origin ${BRANCH}

compile: ## Build Proyect ~ Mode General
	docker run -it --rm -v ${PWD}:/app -w /app denoland/deno:latest sh scripts/deploy.sh

deploy: git-pull compile restart ## Run Full Deploy ~ Mode General

help: ## Info Makefile Tags ~ Mode General
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'

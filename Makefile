include .env

ARGS = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

%:
	@:

help:	## Show this help
	@echo "Welcome to \033[0;32mReact Dockerized template project\033[0m."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m ENV=<value>\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)


build:	## Build dockers from docker compose
	@START=$$(date +%s); \
	if [ ! -d "${PROJECT_NAME}" ]; then mkdir ${PROJECT_NAME}; fi; \
	docker compose \
	build \
	--build-arg REACT_PROJECT_NAME=${REACT_PROJECT_NAME} \
	--build-arg NODE_ENV=${NODE_ENV} \
	--pull \
	--no-cache; \
	STOP=$$(date +%s); \
	echo "\033[0;32mBuild took $$((STOP-START)) seconds\033[0m"

build-cached:	## Build dockers from docker compose with cache
	@START=$$(date +%s); \
	if [ ! -d "${PROJECT_NAME}" ]; then mkdir ${PROJECT_NAME}; fi; \
	docker compose \
	build \
	--build-arg REACT_PROJECT_NAME=${REACT_PROJECT_NAME} \
	--build-arg NODE_ENV=${NODE_ENV}; \
	STOP=$$(date +%s); \
	echo "\033[0;32mBuild took $$((STOP-START)) seconds\033[1;37m"

init-next:	## Initialize a new React App with Next.js (App Router)
	@make build
	@docker run -it -d -v ./:/app --name ${IMAGE_NAME} ${IMAGE_NAME} sh
	@docker exec -it ${IMAGE_NAME} sh -c "npx create-next-app@latest ${REACT_PROJECT_NAME}"
	@docker rm -f ${IMAGE_NAME}
	@make build-cached

init-react:	## Initialize a new React App with React Router (v7)
	@make build
	@docker run -it -d -v ./:/app --name ${IMAGE_NAME} ${IMAGE_NAME} sh
	@docker exec -it ${IMAGE_NAME} sh -c "npx create-react-router@latest ${REACT_PROJECT_NAME}"
	@docker rm -f ${IMAGE_NAME}
	@make build-cached

init-expo:	## Initialize a new React App with Expo (for native apps)
	@make build
	@docker run -it -d -v ./:/app --name ${IMAGE_NAME} ${IMAGE_NAME} sh
	@docker exec -it ${IMAGE_NAME} sh -c "npx create-expo-app@latest ${REACT_PROJECT_NAME}"
	@docker rm -f ${IMAGE_NAME}
	@make build-cached

up:	## Start dockers from docker composer
	@docker compose up -d --remove-orphans

down:	## Stop dockers from docker composer
	@docker compose down

start:	## Start dockers from docker composer
	@docker compose start

stop:	## Stop dockers from docker composer
	@docker compose stop

clean:	## Clean up all stopped containers and unused images
	@make down
	@docker rmi ${IMAGE_NAME}

npm:	## Run npm command in the React project
	@docker exec -it ${IMAGE_NAME} sh -c "npm $(ARGS)"

shell:	## Go to shell in the React project
	@docker exec -it ${IMAGE_NAME} sh

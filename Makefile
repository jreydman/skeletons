# VARS
Prefix := project
APP_name := node-app

PORT_locale := 3000
PORT_docker := 3000
NAME_container := ${Prefix}_${APP_name}
DOCKER_ENV := dev

dev:
	npx run dev

test:
	npm run test

build: 
	rimraf ./build && npx tsc

start: build
	npm start	

docker-image:
	docker images | grep ${Prefix}/${APP_name}

docker-scan:
	docker ps -a --filter name=${NAME_container}

docker-build: test
	docker build -f ./Dockerfile.${DOCKER_ENV} -t ${Prefix}/${APP_name} .

docker-run: docker-build
	docker run --name ${NAME_container} -d -p ${PORT_locale}:${PORT_docker} ${Prefix}/${APP_name}
	
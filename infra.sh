#!/bin/bash

# !!!Run only if own Docker build is required!!!

# Error handling
set -o errexit          # Exit on most errors
set -o errtrace         # Make sure any error trap is inherited
set -o pipefail         # Use last non-zero exit code in a pipeline

declare RED='\033[0;31m'
declare BLUE='\033[0;34m'
declare NC='\033[0m'

printf "STARTED\n"

# Docker .env filename:
declare env=".env"
# folder where the current script is located:
declare CURDIR="$(cd "$(dirname "$0")"; pwd -P)"

# copying a template _env to .env:
if [ -f $env ]; then
   printf "***the file ${BLUE}${env}${NC} already exists!\n"
else
   cp "_env" $env
   printf "***the file ${RED}${env}${NC} created!\n"
fi

## reading Docker .env parameters:
if [ ! -r $env ]; then
  printf "Missing environment file ${RED}$env${NC} in the folder ${RED}$PWD${NC}. Make sure to fix it and try again.\n"
  exit 1
else
  source $env
fi
printf "Current folder    = ${RED}${CURDIR}${NC}\n"

git clone --depth 1 https://github.com/kiwitcms/Kiwi.git src

# Portainer:
# Only for LINUX!!! Mac-users can use standard Docker client: install and start Portainer on port 9000 (http://localhost:9000)
declare portainer="portainer"
declare portainer_port="9000"
if [ ! "$(docker ps -q -f name=$portainer)" ]; then
   if [ "$(docker ps -aq -f status=exited -f name=$portainer)" ]; then
      # cleanup if an exited container blocks
      docker rm $portainer
   fi
   docker volume create portainer_data
   docker run -d -p ${portainer_port}:9000 --name $portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /etc/${portainer}:/data portainer/portainer-ce:latest
   printf "***spinned ${portainer} on the port ${BLUE}${portainer_port}${NC}\n"
fi

printf "FINISHED\n"
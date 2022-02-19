#!/bin/bash

# Error handling
set -o errexit          # Exit on most errors
set -o errtrace         # Make sure any error trap is inherited
set -o pipefail         # Use last non-zero exit code in a pipeline

declare RED='\033[0;31m'
declare BLUE='\033[0;34m'
declare NC='\033[0m'

# folder where the current script is located:
declare CURDIR="$(cd "$(dirname "$0")"; pwd -P)"
declare pg_secret="postgres.secret"
declare pga_secret="pgadmin.secret"
# Docker .env filename:
declare env=".env"

printf "STARTED\n"
printf "   Current folder    = ${BLUE}${CURDIR}${NC}\n"

# creating a secret for postgre database:
if [ ! -r ${pg_secret} ]; then
  printf "   Creating a secret file ${RED}${pg_secret}${NC} in the folder ${RED}${PWD}${NC}. \n"
  openssl rand -base64 14 > ${pg_secret}
fi

# copying a template _env to .env:
if [ -f $env ]; then
   printf "   ***the file ${BLUE}${env}${NC} already exists!\n"
else
   cp "_env" $env
   printf "   ***the file ${RED}${env}${NC} created! edit it if required, otherwise the default settings will take place.\n"
fi

printf "FINISHED\n"
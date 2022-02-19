#!/bin/bash

#adjust your settings as you need:
envfile=".env"
project="kiwi"

case "${1}" in
        --up | -u ) 
            docker-compose --env-file ${envfile} --project-name ${project} up -d pgadmin
            ;;
        --down | -d ) 
            docker-compose --env-file ${envfile} --project-name ${project} down
            ;;
        --pull | -p ) 
            docker-compose --env-file ${envfile} --project-name ${project} pull pgadmin
            ;;
        --restart | -r ) 
            docker-compose --env-file ${envfile} --project-name ${project} down
            docker-compose --env-file ${envfile} --project-name ${project} up -d pgadmin
            ;;
        --migrate | -m ) 
            docker-compose --env-file ${envfile} --project-name ${project} down
            docker-compose --env-file ${envfile} --project-name ${project} pull pgadmin
            docker-compose --env-file ${envfile} --project-name ${project} up -d pgadmin
            docker exec -it kiwi_web /Kiwi/manage.py migrate
            ;;
        * ) 
            printf "usage: ${0} [arg]\n   --up,-u\t\t Start the stack\n   --down,-d\t\t Stop the stack\n   --pull,-p\t\t Pull the changes\n   --restart,-r\t\t Cold-restart the stack\n   --migrate,-m\t\t Migrate the system (careful!)\n"
            ;;
esac
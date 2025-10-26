echo -e "USER_ID=$UID\nGROUP_ID=$UID" > .env
docker-compose build

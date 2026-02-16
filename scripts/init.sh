echo -e "USER_ID=$UID\nGROUP_ID=$UID" > .env
docker-compose build
if [ ! -e data/config.json ]; then
  cp data/config.sample.json data/config.json
fi

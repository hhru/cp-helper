#!/bin/bash
export CONFLUENT_VERSION=5.4.1
docker-compose down
if [ "$1" == "--dev" ]; then
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build
elif [ "$1" == "" ]; then
  docker-compose up --build
else
  echo Wrong argument.
fi

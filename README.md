# CP-helper
Commercial proposal helper
Школьный проект 2020 - сервис рекомендательных услуг для формирования коммерческого предложения работодателям hh.

## Build
`mvn clean install`

## Run
`mvn exec:java`

## Database
`run.sh`

Запускает Docker container с базой данных cp_helper .
Скрипт для запуска команд в базе после инициализации - init.sql .

## Create and run docker image
`./build.sh`

##Docker-compose
Запуск контейнеров с базой данных, backend-сервисом и frontend react приложением
`./run.sh`

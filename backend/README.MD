## Build
`mvn clean install`

## Run
`mvn exec:java`

MS SQL database:
При запуске основного docker-compose поднимает базу и исполняет скрипты из scripts/crm_analytics_db
Адрес localhost:1433
Логин: sa
Пароль: cp_helper3A!

Основные таблицы:
CRMData750.dbo.Account - информация о работодателе
ActivationAnalysisData.dbo.orders_all_cleansed - активация услуг работодателя
ActivationAnalysisData.dbo.spending - размещения вакансий работодателем
VacancyDataMart.dbo.vw_VacancyResponses - тут лежат отклики

! VacancyDataMart.dbo.vw_VacancyResponses это view, а не table. Она агрегирует данные из VacancyDataMart.mart.VacancyResponses 
Чтобы данные там появились, их надо Insert VacancyDataMart.mart.VacancyResponses

Коды компаний из апи:
3911579 авито
1870 работа ру
1455 Хэдхантер


## Build
`mvn clean install`

## Run
`mvn exec:java`

## Api
GET /report/services/
По списку работадателей (employerId) возвращает список самых эффективных услуг. 
Поля: Код работодателя, код услуги, имя услуги, количество заказанных услуг, количество откликов на вакансии по услуге, дата заказа услуги работодателем.
employerId, serviceId, serviceName, serviceQuantity, responseQuantity, orderDate:

GET /report/services?employerId=1&employerId=1455

Пример
/report/services/?employerId=1455
Возвращает 
[{"employerId":1455,"serviceId":3,"serviceName":"Access to the resume database","serviceQuantity":22,"responseQuantity":555,"orderDate":{"year":2020,"month":"APRIL","dayOfWeek":"SUNDAY","dayOfYear":110,"era":"CE","monthValue":4,"dayOfMonth":19,"chronology":{"calendarType":"iso8601","id":"ISO"},"leapYear":true}}]

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


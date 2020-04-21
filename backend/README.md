## Build
`mvn clean install`

## Run
`mvn exec:java`

## Api
GET /report/services
По списку работадателей (employerId) и датам с () по () возвращает список услуг. 
Поля: Код работодателя, код услуги, имя услуги, количество заказанных услуг, количество откликов на вакансии по услуге, дата заказа услуги работодателем, код специализации.
employerId, serviceId, serviceName, serviceCount, responseQuantity, orderDate, specialization:

GET /report/services?employerId=1455&startDate=2020-01-31&endDate=2020-12-01

Возвращает 
(```[{"employerId":1455,"serviceId":3,"serviceName":"Access to the resume database","serviceCount":22,"responseQuantity":555,"orderDate":"2020-04-21","specialization":1.3950}]```)

Подробности: если не ввести начальную дату, то она по умолчанию 2000-01-01. Конечная по умолчанию 3000-01-01.
Коды специализаций можно посмотреть тут: https://api.hh.ru/specializations 

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


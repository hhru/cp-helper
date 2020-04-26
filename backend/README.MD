## Build
`mvn clean install`

## Run
`mvn exec:java`

**MS SQL database:**    
При запуске основного docker-compose поднимает базу и исполняет скрипты из scripts/crm_analytics_db  
Адрес localhost:1433  
Логин: sa  
Пароль: cp_helper3A!  

**Основные таблицы:**    
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

Если вы используете Docker for Mac <= 1.11 или Docker Toolbox for Windows(docker machine IP: 192.168.99.100),  
то для того чтобы получить доступ к kafka снаружи, перед запуском выполните:  
`export DOCKER_HOST_IP=192.168.99.100`  

## Api
GET /report/services
По списку работадателей (employerId) и датам с (startDate) по (endDate) возвращает список услуг. Формат дат: yyyy-mm-dd
Поля: Код работодателя, код услуги, имя услуги, количество заказанных услуг, количество откликов на вакансии по услуге, дата заказа услуги работодателем, код специализации, количество откликов на единицу услуги.
employerId, serviceId, serviceName, serviceCount, responseQuantity, orderDate, specialization, responsePerService:

GET /report/services?employerId=1455&employerId=1870&startDate=2020-01-31&endDate=2020-12-01

Возвращает 
```{"service":[{"employerId":1455,"serviceId":3,"serviceName":"Access to the resume database","serviceCount":22,"responseQuantity":555,"orderDate":"2020-04-24","specialization":"1.395","responsePerService":"25.227"},{"employerId":1870,"serviceId":6,"serviceName":"Highlight the resume","serviceCount":11,"responseQuantity":1000,"orderDate":"2020-04-24","specialization":"20","responsePerService":"90.909"}]}```

Обратите внимание на верхнию ключ "service".

Подробности: если не ввести начальную дату, то она по умолчанию 2000-01-01. Конечная по умолчанию 3000-01-01.
Если количество заказанных услуг (serviceCount) по какой-то причине = 0, то responsePerService будет равно количеству откликов.
Коды специализаций можно посмотреть тут: https://api.hh.ru/specializations 

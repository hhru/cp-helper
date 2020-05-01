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

## API
1. Конкуренты

    1.1 Получение списка конкурентов:
    
    GET `/employer/{companyId}/competitors?areaId={id}`
        
    По умолчанию используется регион Россия.
    
    ОТВЕТ:
    
    Список id конкурентов в JSON формате:
    
    { "competitorsIds": [id1,id2,id3,...] }
    
    1.2 Добавление конкурента в список
    
    POST `/employer/{companyId}/competitors`
    
    В теле запроса указываются id конкурента и id региона 
    
    `{
    "competitorId" : 123,
    "areaId" : 234
    }`
    
    ОТВЕТ:
    
    Возвращает 200OK в случае успешного добавления
    
    1.3 Удаление конкурента из списка
    
    DELETE `/employer/{companyId}/competitors`
    
    В теле запроса указываются id конкурента и id региона 
    
    `{
    "competitorId" : 123,
    "areaId" : 234
    }`

2. Отчеты
    
    2.1 Получение списка услуг
    
    GET /report/services?employerId={id1}&employerId={id2}&...&startDate={startDate}&endDate={endDate}
    
    где employerId - список идентификаторов конкурентов,
    
    startDate - начальная дата для поиска (по умолчанию 2000-01-01),
    
    endDate - конечная дата для поиска (по умолчанию 3000-01-01).
    
    Формат даты - yyyy-mm-dd
    
    ОТВЕТ:
    Список услуг в JSON формате:
    
        `{"service":[
          {"employerId":1455,
           "serviceId":3,         
           "serviceName":"Access to the resume database",
           "serviceCount":22,
           "responseQuantity":555,
           "orderDate":"2020-04-24",
           "specialization":"1.395",
           "responsePerService":"25.227"
          },
          {"employerId":1870,
           "serviceId":6,
           "serviceName":"Highlight the resume",
           "serviceCount":11,
           "responseQuantity":1000,
           "orderDate":"2020-04-24",
           "specialization":"20",
           "responsePerService":"90.909"
           }
         ]}`
     
    где 
    
    employerId - код работодателя,
    
    serviceId - код услуги, 
    
    serviceName - имя услуги, 
    
    serviceCount - количество заказанных услуг, 
    
    responseQuantity - количество откликов на вакансии по услуге, 
    
    orderDate - дата заказа услуги работодателем,
    
    specialization - код специализации (https://api.hh.ru/specializations),
    
    responsePerService -  количество откликов на единицу услуги.
    
    Если количество заказанных услуг (serviceCount) по какой-то причине = 0, то responsePerService будет равно количеству откликов.
    
    

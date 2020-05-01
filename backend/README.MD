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
2605703 Зарплата ру  

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
    
    endDate - конечная дата для поиска (по умолчанию текущая дата).
    
    startDate - начальная дата для поиска (по умолчанию endDate минус 7 дней),
    
    Формат даты - yyyy-mm-dd
    
    ОТВЕТ:
    Список услуг в JSON формате сгруппирован по employerId. Внутри суммированы отклики(responseCount) и траты(spendingCount) по услугам за выбранный период и отсортирован по responsePerService начиная с наибольшего:

        `{
           "services_by_employer": {
              "1870":[
                 {
                  "employerId":1870,
                  "serviceCode":27,
                  "serviceName":"Left block advert",
                  "serviceAreaId":70,
                  "serviceProfArea":1,
                  "spendingCount":2,
                  "responseCount":10,
                  "responsePerService":5
                 },
                 {
                  "employerId":1870,
                  "serviceCode":25,
                  "serviceName":"Footer advert",
                  "serviceAreaId":70,
                  "serviceProfArea":20,
                  "spendingCount":17,
                  "responseCount":10,
                  "responsePerService":0.588
                  }
               ],
              "1455":[
                 {
                  "employerId":1455,
                  "serviceCode":22,
                  "serviceName":"Access to the resume database",
                  "serviceAreaId":70,
                  "serviceProfArea":20,
                  "spendingCount":101,
                  "responseCount":40,
                  "responsePerService":0.396
                 }
               ]
            }
         }`
   
    где 
    
    employerId - код работодателя, 
    
    serviceCode - код услуги, 
    
    serviceName - имя услуги, 
    
    serviceAreaId - код региона,
    
    serviceProfArea - код специализации (https://api.hh.ru/specializations),
    
    spendingCount - количество потраченных услуг, 
    
    responseCount - количество откликов на вакансии по услуге, 
    
    responsePerService -  количество откликов на единицу услуги.
    
    Если количество заказанных услуг (serviceCount) по какой-то причине = 0, то responsePerService будет равно количеству откликов.
    
    Если startDate больше endDate, то возвращается ошибка 400.  

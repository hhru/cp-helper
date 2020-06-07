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
    
    GET `/employer/{companyId}/competitors?areaId={id}&competitorsNumber={n}`
        
    По умолчанию используется регион Россия.

    n - Максимальное количество конкурентов
    
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
    
    GET /report/services?employerId={id1}&employerId={id2}&...&startDate={startDate}&endDate={endDate}&areaId={id}&profAreaId={id})
    
    где employerId - список идентификаторов конкурентов,
    
    endDate - конечная дата для поиска (по умолчанию текущая дата),
    
    startDate - начальная дата для поиска (по умолчанию endDate минус 7 дней),

    areaId - идентификатор региона для фильтра услуг,

    profAreaId - идентификатор специализации для фильтра услуг.
    
    Формат даты - yyyy-mm-dd

    areaId - фильтр по ID географической области вакансии (по умолчанию поиск по всем областям),
    
    profAreaId - фильтр по ID специализации вакансии (по умолчанию поиск по всем специализациям).

    Коды специализации (https://api.hh.ru/specializations).

    ОТВЕТ:
    Список услуг в JSON формате сгруппирован по employerId. Внутри суммированы отклики(responseCount) и траты(spendingCount) по услугам за выбранный период и отсортирован по responsesPerSpending начиная с наибольшего:

        `{
           "services_by_employer": {
              "1870":[
                 {
                  "serviceCode":"VP",
                  "responsesCount":100
                  "spendingCount":1
                  "responsesPerSpending":100
                  "responsesPerDay":100
                  "costPerResponse":30
                 }
               ],
              "1455":[
                 {
                  "serviceCode":"VPPREM",
                  "responsesCount":94,
                  "spendingCount":1,
                  "responsesPerSpending":94,
                  "responsesPerDay":47,
                  "costPerResponse":21.277
                 },
                 {
                  "serviceCode":"VP",
                  "responsesCount":37,
                  "spendingCount":1,
                  "responsesPerSpending":37,
                  "responsesPerDay":12.333,
                  "costPerResponse":27.027
                 },
               ]
            }
         }`
   
    где 
    
    serviceCode - код услуги, 
    
    responseCount - количество откликов на вакансии по услуге,
    
    spendingCount - количество потраченных услуг, 
    
    responsePerSpending -  количество откликов на единицу траты, 
    
    responsePerDay -  количество откликов в день, 
    
    costPerResponse -  средняя цена отклика.
    
    Если делитель по какой-то причине = 0, то при продсчёте метрик будет = 1.
    
    Если startDate больше endDate, то возвращается ошибка 400.

3. Поиск новых конкурентов

	GET `/findCompetitors?spendingCountWeight={w1}&vacancyAreaWeight={w2}&vacancyMaskWeight={w3}&staffNumberWeight={w4}&profAreaWeight={w5}`

	где w1...w5 - веса соответствующих параметров.
	
	Все параметры опциональные, по умолчанию стоит 1.
	
	Ответ: 200 The competitors have been successfully updated


  

-- Documentation: https://docs.microsoft.com/ru-ru/sql/linux/sql-server-linux-run-sql-server-agent-job?view=sql-server-ver15

--
-- I.
--

-- 1. Create table
USE CRMData750
GO

CREATE TABLE dbo.CompetitorReport(
    [report_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [report_date] [date] NOT NULL,
    [employer_id] [int] NOT NULL,
	[service_code] [nvarchar](50) NOT NULL,
    [responses_count] [int] NOT NULL,
    [spending_id] [int] NOT NULL,
    [spending_date] [datetime] NOT NULL,
    [report_spending_same_day] [bit] NOT NULL,
    [vacancy_id] [int] NOT NULL,
    [vacancy_area_id] [int] NOT NULL,
    [cost] [float] NULL
    ) ON [PRIMARY]
GO

CREATE TABLE dbo.CompetitorProfArea(
     [report_id] [int] NOT NULL,
     [profarea_id] [int] NOT NULL
) ON [PRIMARY]
GO

-- 2. Create Procedure
USE CRMData750
GO
INSERT INTO dbo.CompetitorReport(report_date, employer_id, service_code, responses_count, spending_id, spending_date,
                                 report_spending_same_day, vacancy_id, vacancy_area_id, cost)
VALUES ('2020-04-01', 1455, 'VP', 10, 1, '2020-03-28 14:23:19.234', false, 100, 113, 1000)
GO


USE CRMData750;
GO

CREATE OR ALTER PROCEDURE dbo.GenerateCompetitorReport
    @start_date datetime,
    @end_date datetime,
    @client_code_1 int,
    @client_code_2 int,
    @client_code_3 int,
    @client_code_4 int,
    @client_code_5 int,
    @client_code_6 int,
    @client_code_7 int
AS
    SET NOCOUNT ON;
    INSERT INTO [CRMData750].[dbo].[CompetitorReport]
    SELECT		CAST(@start_date as date) as [report_date], t.employer_id as [employer_id], t.code as [service_code],
                t.resp_cnt as [responses_count], t.ID as [spending_id], t.date as [spending_date],
                CASE WHEN (CAST(@start_date as date) = CAST(t.date as date)) THEN 1 ELSE 0 END as [report_spending_same_day],
                t.object_id as [vacancy_id], t.RegionID as [vacancy_area_id], t.unit_price as [cost]
    FROM		(
                    SELECT		s.ID, s.date, s.employer_id, s.employer_service_id, s.code, s.object_id, s.unit_price,
                                sum(ISNULL(r.responses, 0)) as resp_cnt, s.RegionID
                    FROM		(
                                    SELECT			s.ID, s.date,
                                                      -- здесь leaddate - когда услуга перестала действовать. нужно для фильтра откликов
                                                      CASE	WHEN s.code = 'VPREM' AND COALESCE(s.leaddate, ArhivationDate, DATEADD(day, 1, @end_date)) > s.[vacancy_life] THEN s.[vacancy_life]
                                                              ELSE COALESCE(s.leaddate, ArhivationDate, DATEADD(day, 1, @end_date)) END as leaddate,
                                                      s.employer_id, s.employer_service_id, s.code, s.qtty, s.t, s.object_id, o.cost, o.cnt, s.qtty*CAST(o.cost as float)/o.cnt as unit_price, s.RegionID
                                    FROM			(
                                                        SELECT			s.ID, s.date,
                                                                          -- leaddate - дата следующей траты на вакансию
                                                                          LEAD(date) over (partition by object_id order by date) as leaddate,
                                                                          -- ArchivationDate - datetime когда вакансия была удалена
                                                                          vl.ArhivationDate as ArhivationDate,
                                                                          CASE	WHEN code = 'VPREM' THEN DATEADD(day, 7, date)
                                                                                  ELSE DATEADD(month, 1, date) END as [vacancy_life],
                                                                          s.employer_id, s.employer_service_id, s.code, CAST(s.qtty as int) as qtty, s.t, s.object_id, vl.RegionID
                                                        FROM			[ActivationAnalysisData].[dbo].[spending] s
                                                                            LEFT JOIN [VacancySnapshot].[dbo].[VacancySnapshotLast] vl ON s.object_id = vl.VacancyID
                                                        WHERE			-- после того как услугу потратили, её срок действия - 1 месяц
                                                                DATEADD(month, 1, date) > @start_date
                                                          AND s.code IN ('VP', 'RENEWAL_VP', 'VPREM', 'AP', 'ADN')
                                                          AND s.t IN (1, 2)
                                                    ) as s
                                                        LEFT JOIN	(

                                        SELECT		o1.[employer_id], o1.[employer_service_id], o1.[activation_time],
                                                      CASE WHEN o1.code LIKE 'FA%' THEN o2.code ELSE o1.code END as [code],
                                                      CASE WHEN o1.code LIKE 'FA%' THEN o2.cnt ELSE o1.original_cnt END as cnt,
                                                      CASE WHEN o1.code LIKE 'FA%' THEN o1.adjusted_cost*0.4 ELSE o1.adjusted_cost END as cost
                                        FROM		[ActivationAnalysisData].[dbo].[orders_all_cleansed] o1
                                                        LEFT JOIN [ActivationAnalysisData].[dbo].[orders_all_uncleansed] o2 ON	o1.employer_service_id = o2.employer_service_id
                                            AND o2.code IN ('VP', 'RENEWAL_VP', 'VPREM', 'ADN', 'AP')
                                            AND o1.adjusted_cost > 0
                                        WHERE		(o1.code IN ('VP', 'VPREM', 'RENEWAL_VP', 'ADN', 'AP') OR o1.code LIKE 'FA+VPP%')
                                          -- если услуга FA+VPP, то ее можно активировать до определенного момента; иначе - в течение года
                                          AND (
                                                (o1.code LIKE 'FA%' AND o1.expiration_time > @start_date)
                                                OR
                                                (o1.code NOT LIKE 'FA%' AND DATEADD(year, 1, o1.activation_time) > @start_date)
                                            )
                                    ) as o ON s.employer_service_id = o.employer_service_id AND s.code = o.code
                                ) as s
                                    LEFT JOIN
                                (
                                    SELECT		EmployerID, VacancyID, ResponseCreationDate, count(ID) as responses
                                    FROM		[VacancyDataMart].[mart].[VacancyResponses]
                                    WHERE		CAST(ResponseCreationDate as date) BETWEEN @start_date AND @end_date
                                    GROUP BY	EmployerID, VacancyID, ResponseCreationDate
                                ) as r ON r.VacancyID = s.object_id AND r.EmployerID = s.employer_id AND (r.ResponseCreationDate > s.date AND r.ResponseCreationDate < s.leaddate)
                                -- проверяем, что услуга действует в день отчета
                    WHERE		s.leaddate > @start_date
                    GROUP BY	s.ID, s.date, s.leaddate,
                                s.employer_id, s.employer_service_id, s.code, s.object_id, s.qtty, s.unit_price, s.cost, s.cnt, s.RegionID
                ) as t
    WHERE       employer_id	IN	(@client_code_1, @client_code_2, @client_code_3, @client_code_4, @client_code_5, @client_code_6, @client_code_7);

    INSERT INTO [CRMData750].[dbo].[CompetitorProfArea]
    SELECT cr.report_id, pa.ProfAreaID as profarea_id
    FROM (
             -- выбрать 3 последних profarea для вакансии
             SELECT p.ProfAreaID, p.VacancyID
             FROM(
                     SELECT *, ROW_NUMBER() OVER (PARTITION BY VacancyID ORDER BY SnapshotDate DESC) AS RowNum
                     FROM [VacancySnapshot].[dbo].[VacancySnapshotProfAreaLast]
                 ) as p
             WHERE RowNum <= 3) as pa
             JOIN(
        SELECT c.report_id, c.vacancy_id
        FROM [CRMData750].[dbo].[CompetitorReport] c
        WHERE c.report_date = CAST(@start_date as date)
    ) as cr ON pa.VacancyID = cr.vacancy_id;

GO
EXECUTE dbo.GenerateCompetitorReport
        @start_date = '2020-05-03 00:00:00.000',
        @end_date = '2020-05-03 23:59:59.999',
        @client_code_1 = 1455,
        @client_code_2 = 1870,
        @client_code_3 = 84585,
        @client_code_4 = 2096237,
        @client_code_5 = 2605703,
        @client_code_6 = 2624107,
        @client_code_7 = 1269556
/*
CREATE OR ALTER PROCEDURE dbo.GenerateCompetitorReport
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @report_creation_date as date = (select report_creation_date from (select TOP 1 * FROM CRMData750.dbo.CompetitorReport ORDER BY id DESC) as s)
    SET @report_creation_date = DATEADD(day, 1, @report_creation_date)
    INSERT INTO dbo.CompetitorReport(employer_id, service_code, service_name, service_area_id, service_profarea_id, spending_count, responses_count, report_creation_date)
    VALUES (1455, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40  as int), @report_creation_date),
           (1455, 'RENEWAL_VP', 'RENEVAL_VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1455, 'VPREM', 'VPREM service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1455, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1455, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (1870, 'VP', 'VP service name', 2, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1870, 'RENEWAL_VP', 'RENEVAL_VP service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1870, 'VPREM', 'VPREM service name', 1, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1870, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1870, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (84585, 'VP', 'VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (84585, 'RENEWAL_VP', 'RENEVAL_VP service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (84585, 'VPREM', 'VPREM service name', 1, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (84585, 'AP', 'AP service name', 4, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (84585, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (2096237, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2096237, 'RENEWAL_VP', 'RENEVAL_VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2096237, 'VPREM', 'VPREM service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2096237, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2096237, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (2605703, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2605703, 'RENEWAL_VP', 'RENEVAL_VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2605703, 'VPREM', 'VPREM service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2605703, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2605703, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (2624107, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2624107, 'RENEWAL_VP', 'RENEVAL_VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2624107, 'VPREM', 'VPREM service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2624107, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (2624107, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),

           (1269556, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1269556, 'RENEWAL_VP', 'RENEVAL_VP service name', 2, 2, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1269556, 'VPREM', 'VPREM service name', 3, 3, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1269556, 'AP', 'AP service name', 4, 4, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date),
           (1269556, 'ADN', 'ADN service name', 66, 6, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), @report_creation_date)
END

GO

--
-- II. Create and run SQL Server Agent job
--

-- 1. Adds a new job executed by the SQLServerAgent service
EXEC msdb.dbo.sp_add_job
    @job_name = N'Competitor reporting' ;
GO

-- 2. Adds a step (operation) to the job
EXEC msdb.dbo.sp_add_jobstep
   @job_name = N'Competitor reporting',
   @step_name = N'Generate competitor report',
   @subsystem = N'TSQL',
   @command = N'CRMData750.dbo.GenerateCompetitorReport;',
   @retry_attempts = 5,
   @retry_interval = 5 ;
GO

--3. Creates a schedule called 'Every 10 seconds'
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'Every 10 seconds',
    @enabled=1,
    @freq_type=4,
    @freq_interval=1,
    @freq_subday_type=2,
    @freq_subday_interval=10,
    @freq_relative_interval=0,
    @freq_recurrence_factor=0,
    @active_start_date=20070211,
    @active_end_date=99991231,
    @active_start_time=0,
    @active_end_time=235959;
GO

-- 4. Sets the 'Every 10 seconds' schedule to the 'Competitor reporting' Job
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Competitor reporting',
   @schedule_name = N'Every 10 seconds';
GO

--5. Add job server
EXEC msdb.dbo.sp_add_jobserver
   @job_name = N'Competitor reporting',
   @server_name = N'(LOCAL)';
GO

-- 6. Start job
--EXEC msdb.dbo.sp_start_job N'Competitor reporting' ;
GO


--
-- III. Checking
--
-- docker-compose up mssql
-- docker exec -it cp-helper_mssql_1 bash -c "/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ""cp_helper3A\!"""
-- select * from CRMData750.dbo.CompetitorReport;
-- GO
 */
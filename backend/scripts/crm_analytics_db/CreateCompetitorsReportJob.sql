-- Documentation: https://docs.microsoft.com/ru-ru/sql/linux/sql-server-linux-run-sql-server-agent-job?view=sql-server-ver15

--
-- I.
--

-- 1. Create table
USE CRMData750
GO

CREATE TABLE dbo.CompetitorReport(
    [report_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [report_date] [date] NULL,
    [employer_id] [int] NULL,
    [service_code] [nvarchar](50) NULL,
    [responses_count] [int] NULL,
    [spending_id] [int] NULL,
    [spending_date] [datetime] NULL,
    [report_spending_same_day] [bit] NULL,
    [vacancy_id] [int] NULL,
    [vacancy_area_id] [int] NULL,
    [cost] [float] NULL
) ON [PRIMARY]
GO

CREATE TABLE dbo.VacancyProfArea(
     [vacancy_profarea_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
     [vacancy_id] [int] NOT NULL,
     [profarea_id] [int] NOT NULL,
     [snapshot_date] [datetime] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE dbo.TrackedEmployers(
    [employer_id] INT NOT NULL PRIMARY KEY
) ON [PRIMARY]
GO

INSERT INTO [CRMData750].[dbo].[TrackedEmployers]
(employer_id)
VALUES
(1455), (1870), (84585), (2096237), (2605703), (2624107), (1269556)
GO

-- 2. Create Procedure

USE CRMData750;
GO

CREATE OR ALTER PROCEDURE dbo.GenerateCompetitorReport
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @report_date as date
    DECLARE @start_date as datetime
    DECLARE @end_date as datetime
    SET @report_date = (SELECT report_date FROM [TestShapshotData].[dbo].[tmp_cache])
    UPDATE [TestShapshotData].[dbo].[tmp_cache] SET report_date = DATEADD(day, 1, @report_date)
    SET @start_date = CAST(@report_date as DATETIME)
    SET @end_date = CONVERT(DATETIME, CONVERT(varchar(11),@report_date, 23) + ' 23:59:59.998', 121)

    INSERT INTO [CRMData750].[dbo].[CompetitorReport]
    SELECT CAST(@start_date as date) as [report_date], t.employer_id as [employer_id], t.code as [service_code],
           t.resp_cnt as [responses_count], t.ID as [spending_id], t.date as [spending_date],
           CASE WHEN (CAST(@start_date as date) = CAST(t.date as date)) THEN 1 ELSE 0 END as [report_spending_same_day],
           t.object_id as [vacancy_id], t.RegionID as [vacancy_area_id], t.unit_price as [cost]
    FROM (
        SELECT s.ID, s.date, s.employer_id, s.employer_service_id, s.code, s.object_id, s.unit_price,
               sum(ISNULL(r.responses, 0)) as resp_cnt, s.RegionID
        FROM (
            SELECT s.ID, s.date,
            -- здесь leaddate - когда услуга перестала действовать. нужно для фильтра откликов
                CASE WHEN s.code = 'VPREM' AND COALESCE(s.leaddate, ArhivationDate, DATEADD(day, 1, @end_date)) > s.[vacancy_life] THEN s.[vacancy_life]
                ELSE COALESCE(s.leaddate, ArhivationDate, DATEADD(day, 1, @end_date)) END as leaddate,
                s.employer_id, s.employer_service_id, s.code, s.qtty, s.t, s.object_id, o.cost, o.cnt, s.qtty*CAST(o.cost as float)/o.cnt as unit_price, s.RegionID
            FROM (
                SELECT s.ID, s.date,
                    -- leaddate - дата следующей траты на вакансию
                    LEAD(date) over (partition by object_id order by date) as leaddate,
                    -- ArchivationDate - datetime когда вакансия была удалена
                    vl.ArhivationDate as ArhivationDate,
                    CASE WHEN code = 'VPREM' THEN DATEADD(day, 7, date)
                    ELSE DATEADD(month, 1, date) END as [vacancy_life],
                    s.employer_id, s.employer_service_id, s.code, CAST(s.qtty as int) as qtty, s.t, s.object_id, vl.RegionID
                FROM [ActivationAnalysisData].[dbo].[spending] s
                LEFT JOIN [VacancySnapshot].[dbo].[VacancySnapshotLast] vl ON s.object_id = vl.VacancyID
                WHERE -- после того как услугу потратили, её срок действия - 1 месяц
                DATEADD(month, 1, date) > @start_date AND date < @end_date
                AND s.code IN ('VP', 'RENEWAL_VP', 'VPREM', 'AP', 'ADN')
                AND s.t IN (1, 2)
            ) as s
            LEFT JOIN (
                SELECT o1.[employer_id], o1.[employer_service_id], o1.[activation_time],
                    CASE WHEN o1.code LIKE 'FA%' THEN o2.code ELSE o1.code END as [code],
                    CASE WHEN o1.code LIKE 'FA%' THEN o2.cnt ELSE o1.original_cnt END as cnt,
                    CASE WHEN o1.code LIKE 'FA%' THEN o1.adjusted_cost*0.4 ELSE o1.adjusted_cost END as cost
                FROM [ActivationAnalysisData].[dbo].[orders_all_cleansed] o1
                LEFT JOIN [ActivationAnalysisData].[dbo].[orders_all_uncleansed] o2 ON	o1.employer_service_id = o2.employer_service_id
                AND o2.code IN ('VP', 'RENEWAL_VP', 'VPREM', 'ADN', 'AP')
                AND o1.adjusted_cost > 0
                WHERE (o1.code IN ('VP', 'VPREM', 'RENEWAL_VP', 'ADN', 'AP') OR o1.code LIKE 'FA+VPP%')
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
            SELECT EmployerID, VacancyID, ResponseCreationDate, count(ID) as responses
            FROM [VacancyDataMart].[mart].[VacancyResponses]
            WHERE ResponseCreationDate BETWEEN @start_date AND @end_date
            GROUP BY EmployerID, VacancyID, ResponseCreationDate
        ) as r ON r.VacancyID = s.object_id AND r.EmployerID = s.employer_id AND (r.ResponseCreationDate >= s.date AND r.ResponseCreationDate <= s.leaddate)
        -- проверяем, что услуга действует в день отчета
        WHERE s.leaddate > @start_date AND s.RegionID IS NOT NULL AND s.cost IS NOT NULL
        GROUP BY s.ID, s.date, s.leaddate,
        s.employer_id, s.employer_service_id, s.code, s.object_id, s.qtty, s.unit_price, s.cost, s.cnt, s.RegionID
    ) as t WHERE t.employer_id IN (SELECT employer_id FROM CRMData750.dbo.TrackedEmployers)

    INSERT INTO [CRMData750].[dbo].[VacancyProfArea] (vacancy_id, profarea_id, snapshot_date)
    SELECT pa.VacancyID, pa.ProfAreaID, pa.SnapshotDate
    FROM(
        SELECT p.VacancyID, p.ProfAreaID, p.SnapshotDate
        FROM(
            SELECT *,
            RANK() OVER (PARTITION BY VacancyID ORDER BY SnapshotDate DESC) as rankByDate
            FROM [VacancySnapshot].[dbo].[VacancySnapshotProfAreaLast] p) as p
        WHERE p.rankByDate = 1) as pa
    JOIN(
    SELECT DISTINCT(c.vacancy_id)
    FROM [CRMData750].[dbo].[CompetitorReport] c) as cr
    ON pa.VacancyID = cr.vacancy_id
    WHERE NOT EXISTS (SELECT vacancy_id, profarea_id FROM [CRMData750].[dbo].[VacancyProfArea] WHERE vacancy_id = pa.VacancyID AND profarea_id = pa.ProfAreaID)
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

--3. Creates a schedule called 'Every 15 seconds'
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'Every 15 seconds',
    @enabled=1,
    @freq_type=4,
    @freq_interval=1,
    @freq_subday_type=2,
    @freq_subday_interval=15,
    @freq_relative_interval=0,
    @freq_recurrence_factor=0,
    @active_start_date=20070211,
    @active_end_date=99991231,
    @active_start_time=0,
    @active_end_time=235959;
GO

-- 4. Sets the 'Every 15 seconds' schedule to the 'Competitor reporting' Job
EXEC msdb.dbo.sp_attach_schedule
   @job_name = N'Competitor reporting',
   @schedule_name = N'Every 15 seconds';
GO

--5. Add job server
EXEC msdb.dbo.sp_add_jobserver
   @job_name = N'Competitor reporting',
   @server_name = N'(LOCAL)';
GO

-- 6. Start job
EXEC msdb.dbo.sp_start_job N'Competitor reporting' ;
GO


--
-- III. Checking
--
-- docker-compose up mssql
-- docker exec -it cp-helper_mssql_1 bash -c "/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ""cp_helper3A\!"""
-- select * from CRMData750.dbo.CompetitorReport;
-- GO

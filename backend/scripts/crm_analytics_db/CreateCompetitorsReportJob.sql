-- Documentation: https://docs.microsoft.com/ru-ru/sql/linux/sql-server-linux-run-sql-server-agent-job?view=sql-server-ver15

--
-- I.
--

-- 1. Create table
USE CRMData750
GO

CREATE TABLE dbo.CompetitorReport(
    [id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [employer_id] [int] NULL,
	[service_code] [varchar](50) NULL,
	[service_name] [nvarchar](220) NULL,
    [service_area_id] [int] NULL,
	[service_profarea_id] [int] NULL,
	spending_count [int] NULL,
	responses_count [int] NULL,
	[report_creation_date] [date] NULL
    ) ON [PRIMARY]
GO

-- 2. Create Procedure
USE CRMData750
GO
INSERT INTO dbo.CompetitorReport(employer_id, service_code, service_name, service_area_id, service_profarea_id, spending_count, responses_count, report_creation_date)
VALUES (1455, 'VP', 'VP service name', 1, 1, CAST(RAND() * 20 as int), CAST(RAND() * 40 as int), '2020-04-01')
GO

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
EXEC msdb.dbo.sp_start_job N'Competitor reporting' ;
GO


--
-- III. Checking
--
-- docker-compose up mssql
-- docker exec -it cp-helper_mssql_1 bash -c "/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ""cp_helper3A\!"""
-- select * from CRMData750.dbo.CompetitorReport;
-- GO
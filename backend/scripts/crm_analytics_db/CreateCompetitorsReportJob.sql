-- Documentation: https://docs.microsoft.com/ru-ru/sql/linux/sql-server-linux-run-sql-server-agent-job?view=sql-server-ver15

--
-- I.
--

-- 1. Create table
USE CRMData750
GO

CREATE TABLE dbo.CompetitorReport(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ServiceName] [nvarchar](220) NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[CompetitorId] [int] NULL,
	[ProfessionalArea] [nvarchar](100) NULL
) ON [PRIMARY]
GO

-- 2. Create Procedure
USE CRMData750
GO

CREATE OR ALTER PROCEDURE dbo.GenerateCompetitorReport
    @CompetitorId INTEGER = NULL,
    @ServiceName NVARCHAR(220) = NULL,
    @ProfessionalArea NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO CRMData750.dbo.CompetitorReport
    (
        CompetitorId,
        ServiceName,
        ProfessionalArea,
        ModifiedOn
    )
    VALUES
    (
        @CompetitorId,
        @ServiceName,
        @ProfessionalArea,
        SYSDATETIME()
    )
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
   @command = N'CRMData750.dbo.GenerateCompetitorReport 1455, ''Access to the resume database'', ''Hiring'';',
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
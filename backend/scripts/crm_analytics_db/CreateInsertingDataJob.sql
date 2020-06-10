-- Documentation: https://docs.microsoft.com/ru-ru/sql/linux/sql-server-linux-run-sql-server-agent-job?view=sql-server-ver15

--
-- I.
--

USE CRMData750
GO

INSERT INTO [TestShapshotData].[dbo].[tmp_cache] (
  report_date, insert_date
) VALUES (
 '2020-04-01', '2020-04-01'
)
GO

CREATE OR ALTER PROCEDURE dbo.LoadTestData
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @insert_date as date
    SET @insert_date = (SELECT insert_date FROM [TestShapshotData].[dbo].[tmp_cache])
    UPDATE [TestShapshotData].[dbo].[tmp_cache] SET insert_date = DATEADD(day, 1, @insert_date)

    INSERT INTO [ActivationAnalysisData].[dbo].[orders_all_cleansed]
    ([employer_id], [account_id], [employer_service_id], [activation_time], [code], [original_cnt], [adjusted_cost])
    SELECT [employer_id], [account_id], [employer_service_id], [activation_time], [code], [original_cnt], [adjusted_cost]
    FROM [TestShapshotData].[dbo].[orders_all_cleansed_test]
    WHERE [TestShapshotData].[dbo].[orders_all_cleansed_test].[activation_time] = @insert_date

    INSERT INTO [ActivationAnalysisData].[dbo].[orders_all_uncleansed]
    ([employer_service_id], [activation_time], [employer_id], [account_id], [code], [cnt])
    SELECT [employer_service_id], [activation_time], [employer_id], [account_id], [code], [cnt]
    FROM [TestShapshotData].[dbo].[orders_all_uncleansed_test]
    WHERE [TestShapshotData].[dbo].[orders_all_uncleansed_test].[activation_time] = @insert_date

    INSERT INTO [ActivationAnalysisData].[dbo].[spending]
    ([ID], [date], [employer_id], [account_id], [employer_service_id], [code], [qtty], [t], [object_id])
    SELECT [ID], [date], [employer_id], [account_id], [employer_service_id], [code], [qtty], [t], [object_id]
    FROM [TestShapshotData].[dbo].[spending_test]
    WHERE [TestShapshotData].[dbo].[spending_test].[date] = @insert_date

    INSERT INTO [VacancyDataMart].[mart].[VacancyResponses]
    ([VacancyID], [EmployerID], [ResponseCreationDate], [ID])
    SELECT [VacancyID], [EmployerID], [ResponseCreationDate], [ID]
    FROM [TestShapshotData].[dbo].[VacancyResponses_test]
    WHERE [TestShapshotData].[dbo].[VacancyResponses_test].[ResponseCreationDate] = @insert_date

    INSERT INTO [VacancySnapshot].[dbo].[VacancySnapshotProfAreaLast]
    (ProfAreaID, VacancyID, SnapshotDate)
    SELECT ProfAreaID, VacancyID, SnapshotDate
    FROM [TestShapshotData].[dbo].[VacancySnapshotProfAreaLast_test]
    WHERE [TestShapshotData].[dbo].[VacancySnapshotProfAreaLast_test].[SnapshotDate] = @insert_date

    INSERT INTO [VacancySnapshot].[dbo].[VacancySnapshotLast]
    (RegionID, VacancyID, SnapshotDate, ArhivationDate)
    SELECT RegionID, VacancyID, SnapshotDate, ArhivationDate
    FROM [TestShapshotData].[dbo].[VacancySnapshotLast_test]
    WHERE [TestShapshotData].[dbo].[VacancySnapshotLast_test].[SnapshotDate] = @insert_date

    INSERT INTO [VacancySnapshot].[dbo].[VacancyTitle]
    (VacancyId, LastTitle)
    SELECT vacancy_id, vacancy_name
    FROM [TestShapshotData].[dbo].[VacancyTitle_test]
    WHERE [TestShapshotData].[dbo].[VacancyTitle_test].[creation_date] = @insert_date
END
GO

--
-- II. Create and run SQL Server Agent job
--

-- 1. Adds a new job executed by the SQLServerAgent service
EXEC msdb.dbo.sp_add_job
    @job_name = N'Insert data' ;
GO

-- 2. Adds a step (operation) to the job
EXEC msdb.dbo.sp_add_jobstep
   @job_name = N'Insert data',
   @step_name = N'Inserting test data',
   @subsystem = N'TSQL',
   @command = N'CRMData750.dbo.LoadTestData;',
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
   @job_name = N'Insert data',
   @schedule_name = N'Every 10 seconds';
GO

--5. Add job server
EXEC msdb.dbo.sp_add_jobserver
   @job_name = N'Insert data',
   @server_name = N'(LOCAL)';
GO

-- 6. Start job
EXEC msdb.dbo.sp_start_job N'Insert data' ;
GO

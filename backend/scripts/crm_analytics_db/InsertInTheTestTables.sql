USE [TestShapshotData]
GO

CREATE OR ALTER PROCEDURE dbo.InsertCleansed
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @Employers TABLE (employer_id int)
  INSERT INTO @Employers (employer_id) VALUES (1455), (1870), (84585), (2096237), (2605703), (2624107), (1269556)

  DECLARE @Codes TABLE (code varchar(50))
  INSERT INTO @Codes (code) VALUES ('VP'), ('RENEWAL_VP'), ('VPREM'), ('AD'), ('ADN'), ('FA+'), ('FA+VPP')

  DECLARE @employer_id as int
  DECLARE @employer_service_id as int
  DECLARE @activation_time as date
  SET @activation_time = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @code as VARCHAR(50)
  DECLARE @original_cnt as int
  DECLARE @adjusted_cost as int
  DECLARE @cl_cnt as int = 0

  WHILE @cl_cnt < 1000
  BEGIN
    SET @employer_id = (SELECT TOP 1 employer_id FROM @Employers ORDER BY NEWID())
    SET @employer_service_id = CAST(RAND() * 5000 as int)
    IF @cl_cnt >= 20 AND @cl_cnt % 20 = 0 SET @activation_time = DATEADD(day, 1, @activation_time)
    SET @code = (SELECT TOP 1 code FROM @Codes ORDER BY NEWID())
    SET @original_cnt = CAST(RAND() * 500 as int)
    SET @adjusted_cost = CAST(RAND() * 10000 as int)

    INSERT INTO [TestShapshotData].[dbo].[orders_all_cleansed_test] (
      [employer_id], [employer_service_id], [activation_time], [code], [original_cnt], [adjusted_cost]
    ) VALUES (
      @employer_id, @employer_service_id, @activation_time, @code, @original_cnt, @adjusted_cost
    )

    SET @cl_cnt = @cl_cnt + 1
  END
END
GO

EXEC dbo.InsertCleansed
GO

CREATE OR ALTER PROCEDURE dbo.InsertUncleansed
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @Employers TABLE (employer_id int)
  INSERT INTO @Employers (employer_id) VALUES (1455), (1870), (84585), (2096237), (2605703), (2624107), (1269556)

  DECLARE @Codes TABLE (code varchar(50))
  INSERT INTO @Codes (code) VALUES ('VP'), ('RENEWAL_VP'), ('VPREM'), ('AD'), ('ADN'), ('FA+'), ('FA+VPP')

  DECLARE @employer_service_id as int
  DECLARE @activation_time as date
  SET @activation_time = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @employer_id as int
  DECLARE @code as VARCHAR(50)
  DECLARE @cnt as int
  DECLARE @uncl_cnt as int = 0

  WHILE @uncl_cnt < 1000
  BEGIN
    SET @employer_service_id = CAST(RAND() * 5000 as int)
    IF @uncl_cnt >= 20 AND @uncl_cnt % 20 = 0 SET @activation_time = DATEADD(day, 1, @activation_time)
    SET @employer_id = (SELECT TOP 1 employer_id FROM @Employers ORDER BY NEWID())
    SET @code = (SELECT TOP 1 code FROM @Codes ORDER BY NEWID())
    SET @cnt = CAST(RAND() * 500 as int)
    INSERT INTO [TestShapshotData].[dbo].[orders_all_uncleansed_test] (
      [employer_service_id], [activation_time], [employer_id], [code], [cnt]
    ) VALUES (
      @employer_service_id, @activation_time, @employer_id, @code, @cnt
    )

    SET @uncl_cnt = @uncl_cnt + 1
  END
END
GO

EXEC dbo.InsertUncleansed
GO

CREATE OR ALTER PROCEDURE dbo.InsertSpending
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @ProfArea TABLE (id int, name varchar(100))
  INSERT INTO @ProfArea (id, name) VALUES (1, 'Информационные технологии, интернет, телеком'),
                                    (2, 'Бухгалтерия, управленческий учет, финансы предприятия'),
                                    (3, 'Маркетинг, реклама, PR')

  DECLARE @Regions TABLE (id int, name varchar(100))
  INSERT INTO @Regions (id, name) VALUES (113, 'Россия'), (1, 'Москва'), (2, 'Санкт-Петербург'), (3, 'Екатеринбург')

  DECLARE @id as int = 1
  DECLARE @date as date
  SET @date = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @employer_id as int
  DECLARE @employer_service_id as int
  DECLARE @code as VARCHAR(50)
  DECLARE @qtty as int
  DECLARE @t as int
  DECLARE @object_id as int

  WHILE @id < 1000
  BEGIN
    IF @id >= 20 AND @id % 20 = 0 SET @date = DATEADD(day, 1, @date)
    SET @employer_id = (SELECT TOP 1 employer_id FROM dbo.orders_all_cleansed_test WHERE activation_time <= @date ORDER BY NEWID())
    SET @employer_service_id = (SELECT TOP 1 employer_service_id FROM  dbo.orders_all_cleansed_test WHERE activation_time <= @date AND employer_id = @employer_id ORDER BY NEWID())
    SET @code = (SELECT TOP 1 code from dbo.orders_all_cleansed_test WHERE activation_time <= @date AND employer_id = @employer_id AND employer_service_id = @employer_service_id ORDER BY NEWID())
    SET @t = FLOOR(RAND() * (2-1) + 1)
    IF @t = 1 SET @qtty = 1 ELSE SET @qtty = -1
    SET @object_id = CAST(RAND() * 5000 as int)
    INSERT INTO [TestShapshotData].[dbo].[spending_test](
      [ID], [date], [employer_id], [employer_service_id], [code], [qtty], [t], [object_id]
    ) VALUES (
      @id, @date, @employer_id, @employer_service_id, @code, @qtty, @t, @object_id
    )
    INSERT INTO [TestShapshotData].[dbo].[VacancySnapshotProfAreaLast_test] (
      ProfAreaID, VacancyID, SnapshotDate
    ) VALUES (
      (SELECT TOP 1 id FROM @ProfArea ORDER BY NEWID()), @object_id, @date
    )
    INSERT INTO [TestShapshotData].[dbo].[VacancySnapshotLast_test] (
      RegionID, VacancyID, SnapshotDate, ArhivationDate
    ) VALUES (
      (SELECT TOP 1 id FROM @Regions ORDER BY NEWID()), @object_id, @date, (SELECT DATEFROMPARTS(9999, 12, 31))
    )
    INSERT INTO [TestShapshotData].[dbo].[VacancyResponses_test] (
      [VacancyID], [EmployerID], [ResponseCreationDate], [ID]
    ) VALUES (
      @object_id, @employer_id, @date, @id
    )
    SET @id = @id + 1
  END
END
GO

EXEC dbo.InsertSpending
GO

CREATE OR ALTER PROCEDURE dbo.InsertResponses
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @vacancy_id as int
  DECLARE @employer_id as int
  DECLARE @response_date as date
  SET @response_date = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @resp_cnt as int = 0

  WHILE @resp_cnt < 1000
  BEGIN
    IF @resp_cnt >= 20 AND @resp_cnt % 20 = 0 SET @response_date = DATEADD(day, 1, @response_date)
    SET @vacancy_id = (SELECT TOP 1 object_id FROM dbo.spending_test WHERE date <= @response_date ORDER BY NEWID())
    SET @employer_id = (SELECT TOP 1 employer_id FROM dbo.spending_test WHERE object_id = @vacancy_id ORDER BY NEWID())
    INSERT INTO [TestShapshotData].[dbo].[VacancyResponses_test] (
      [VacancyID], [EmployerID], [ResponseCreationDate], [ID]
    ) VALUES (
      @vacancy_id, @employer_id, @response_date, @resp_cnt + 1001
    )
    SET @resp_cnt = @resp_cnt + 1
  END
END
GO

EXEC dbo.InsertResponses
GO

CREATE OR ALTER PROCEDURE dbo.InsertProfArea
AS
BEGIN
  DECLARE @ProfArea TABLE (id int, name varchar(100))
  INSERT INTO @ProfArea (id, name) VALUES (1, 'Информационные технологии, интернет, телеком'),
                                    (2, 'Бухгалтерия, управленческий учет, финансы предприятия'),
                                    (3, 'Маркетинг, реклама, PR')

  DECLARE @profarea_id as int
  DECLARE @vacancy_id as int
  DECLARE @snapshot_date as date
  SET @snapshot_date = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @area_cnt as int = 0

  WHILE @area_cnt < 1000
  BEGIN
    IF @area_cnt >= 20 AND @area_cnt % 20 = 0 SET @snapshot_date = DATEADD(day, 1, @snapshot_date)
    SET @vacancy_id = (SELECT TOP 1 object_id FROM dbo.spending_test WHERE date <= @snapshot_date ORDER BY NEWID())
    SET @profarea_id = (SELECT TOP 1 id FROM @ProfArea ORDER BY NEWID())
    INSERT INTO [TestShapshotData].[dbo].[VacancySnapshotProfAreaLast_test] (
      ProfAreaID, VacancyID, SnapshotDate
    ) VALUES (
      @profarea_id, @vacancy_id, @snapshot_date
    )
    SET @area_cnt = @cnt + 1
  END
END
GO

EXEC dbo.InsertProfArea
GO

CREATE OR ALTER PROCEDURE dbo.InsertSnapshot
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @Regions TABLE (id int, name varchar(100))
  INSERT INTO @Regions (id, name) VALUES (113, 'Россия'), (1, 'Москва'), (2, 'Санкт-Петербург'), (3, 'Екатеринбург')

  DECLARE @region_id as int
  DECLARE @vacancy_id as int
  DECLARE @snapshot_date as date
  SET @snapshot_date = (SELECT DATEFROMPARTS(2020, 4, 1))
  DECLARE @arhivation_date as date
  SET @arhivation_date = (SELECT DATEFROMPARTS(9999, 12, 31))
  DECLARE @snap_cnt as int = 1

  WHILE @snap_cnt < 1000
  BEGIN
    IF @snap_cnt >= 20 AND @snap_cnt % 20 = 0 SET @snapshot_date = DATEADD(day, 1, @snapshot_date)
    SET @vacancy_id = (SELECT TOP 1 object_id FROM dbo.spending_test WHERE date <= @snapshot_date ORDER BY NEWID())
    SET @region_id = (SELECT TOP 1 id FROM @Regions ORDER BY NEWID())
    INSERT INTO [TestShapshotData].[dbo].[VacancySnapshotLast_test] (
      RegionID, VacancyID, SnapshotDate, ArhivationDate
    ) VALUES (
      @region_id, @vacancy_id, @snapshot_date, @arhivation_date
    )
    SET @snap_cnt = @snap_cnt + 1
  END
END
GO

EXEC dbo.InsertSnapshot
GO

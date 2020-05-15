USE [VacancySnapshot]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancySnapshotLast](
    RegionID int not null,
	VacancyID int not null,
	ArhivationDate datetime NULL,
	SnapshotDate datetime not null
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancySnapshotProfAreaLast] (
    ProfAreaID int not null,
	VacancyID int not null,
	SnapshotDate datetime not null
) ON [PRIMARY]
GO

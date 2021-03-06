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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create table Vacancy
(
	ID int not null,
	CreationDate datetime not null,
	SiteID int,
	EmployerID int not null,
	Title nvarchar(500),
	JobSite nvarchar(50),
	accept_handicapped nvarchar(3),
	UserID int
)
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create table VacancyTitle
(
	VacancyId int,
	LastTitle nvarchar(256)
)
go

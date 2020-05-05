USE [VacancySnapshot]
GO
CREATE TABLE [dbo].[VacancySnapshotLast](
    [VacancyID] [int] NOT NULL,
    [SnapshotDate] [datetime] NULL,
    [RegionID] [int] NOT NULL,
    [MetallicID] [int] NULL,
    [VacancyTypeID] [int] NULL,
    [VacancyStateID] [int] NULL,
    [PublicationDate] [datetime] NULL,
    [ArhivationDate] [datetime] NULL,
    [CompensationFrom] [float] NULL,
    [CompensationTo] [float] NULL,
    [CompensationCurrency] [nvarchar](10) NULL,
    [EmploymentTypeID] [int] NULL
) ON [PRIMARY]
GO
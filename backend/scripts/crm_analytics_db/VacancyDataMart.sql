USE [VacancyDataMart]
GO
/****** Object:  Schema [mart]    Script Date: 29.03.2020 11:07:42 ******/
CREATE SCHEMA [mart]
GO
/****** Object:  Table [mart].[VacancyResponses]    Script Date: 29.03.2020 11:07:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mart].[VacancyResponses](
	[RegionID] [int] NULL,
	[VacancyID] [int] NULL,
	[PublicationDate] [date] NULL,
	[VacancyStateID] [int] NULL,
	[ResumeID] [int] NULL,
	[UserID] [int] NULL,
	[EmployerID] [int] NULL,
	[UserTypeID] [int] NULL,
	[SiteID] [int] NULL,
	[ResumeCreationDate] [date] NULL,
	[UserCreationDate] [date] NULL,
	[EmployerType] [int] NULL,
	[ResponseCreationDate] [datetime] NULL,
	[ResumeRegionID] [int] NULL,
	[ResponseAppType] [varchar](30) NULL,
	[ResponsePlatform] [varchar](30) NULL,
	[VacancyCreationDate] [date] NULL,
	[ResumeColorTypeID] [int] NULL,
	[ID] [bigint] NULL,
	[VacancyCollarTypeId] [int] NULL,
	[MetallicId] [int] NULL,
	[VacancyTypeID] [int] NULL,
	[ResumeProfAreaId] [int] NULL
) ON [PRIMARY]
GO

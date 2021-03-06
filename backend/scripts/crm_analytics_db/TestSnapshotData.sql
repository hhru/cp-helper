USE [TestShapshotData]
GO

CREATE TABLE [dbo].[tmp_cache]
(
 report_date DATE NULL,
 insert_date DATE NULL
)
GO


/****** Object:  Table [dbo].[orders_all_cleansed_test] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_test](
	[seller_account_id] [smallint] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[order_id] [int] NULL,
	[service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[code] [nvarchar](50) NULL,
	[original_cnt] [int] NULL,
	[adjusted_cnt] [int] NULL,
	[original_cost] [real] NULL,
	[adjusted_cost] [real] NULL,
	[order_cost] [real] NULL,
	[region_path] [nvarchar](max) NULL,
	[profarea_path] [nvarchar](max) NULL,
	[activated_by_user_id] [int] NULL,
	[activated_by_user_name] [nvarchar](4000) NULL,
	[activated_by_user_type_id] [int] NULL,
	[given_discount_rate] [nvarchar](250) NULL,
	[service_name] [nvarchar](3000) NULL,
	[special_offer_id] [nvarchar](50) NULL,
	[is_barter] [nvarchar](50) NULL,
	[line_count] [int] NULL,
	[adjustment_info] [varchar](250) NULL,
	[unit] [nvarchar](50) NULL,
	[prolongates] [int] NULL,
	[has_cart] [bit] NULL,
	[withdraw_type] [nvarchar](10) NULL,
	[adjusted_cost_extVAT] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[spending_test]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[spending_test](
	[ID] [int] NULL,
	[date] [datetime] NULL,
	[order_id] [int] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[code] [varchar](50) NULL,
	[qtty] [int] NULL,
	[t] [int] NULL,
	[seller_account_id] [int] NULL,
	[object_id] [int] NULL,
	[employer_manager_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_uncleansed_test] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_uncleansed_test](
	[order_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[cnt] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[price1] [nvarchar](50) NULL,
	[cost] [real] NULL,
	[order_cost] [real] NULL,
	[seller_account_id] [smallint] NULL,
	[buyed_by_manager_id] [int] NULL,
	[given_discount_rate] [nvarchar](250) NULL,
	[service_name] [nvarchar](3000) NULL,
	[SpecialOfferID] [nvarchar](50) NULL,
	[Splitted] [nvarchar](50) NULL,
	[IsBarter] [nvarchar](50) NULL,
	[prolongates] [int] NULL,
	[has_cart] [bit] NULL,
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [mart].[VacancyResponses_test]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancyResponses_test](
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create table [dbo].[VacancySnapshotLast_test] (
	RegionID int not null,
	VacancyID int not null,
	ArhivationDate datetime null,
	SnapshotDate datetime not null
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create table [dbo].[VacancySnapshotProfAreaLast_test] (
	ProfAreaID int not null,
	VacancyID int not null,
	SnapshotDate datetime not null
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancyTitle_test]
(
    vacancy_id int NOT NULL,
    vacancy_name nvarchar(256) NOT NULL,
    creation_date datetime NOT NULL
) ON [PRIMARY]
GO


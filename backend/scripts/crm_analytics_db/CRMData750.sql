USE [CRMData750]
GO
/****** Object:  Schema [mart]    Script Date: 29.03.2020 11:11:40 ******/
CREATE SCHEMA [mart]
GO
/****** Object:  Table [dbo].[EventStatus]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventStatus](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventType]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventType](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventTSC]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventTSC](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[TypeId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Goal] [nvarchar](250) NULL,
	[TerritoryId] [uniqueidentifier] NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[ActualResponse] [nvarchar](250) NULL,
	[PrimaryBudgetedCost] [numeric](18, 2) NULL,
	[PrimaryExpectedRevenue] [numeric](18, 2) NULL,
	[PrimaryActualCost] [numeric](18, 2) NULL,
	[PrimaryActualRevenue] [numeric](18, 2) NULL,
	[Notes] [nvarchar](max) NULL,
	[LastActualizeDate] [datetime2](7) NULL,
	[RecipientCount] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountIndustry]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountIndustry](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[event]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[event]
AS
-- event
SELECT e.Id AS guid,
       e.CreatedOn AS created_on,
       e.CreatedById AS created_by_guid,
       e.ModifiedOn AS modified_on,
       e.ModifiedById as modified_by_guid,
       e.ProcessListeners AS process_listeners,
       e.Name AS name,
       e.TypeId AS type_guid,
       et.Name AS type_name,
       e.OwnerId AS owner_guid,
       e.StatusId AS status_guid,
       es.Name AS status_name,
       e.StartDate AS start_date,
       e.EndDate AS end_date,
       e.Goal AS goal,
       e.TerritoryId AS territory_guid,
       e.IndustryId AS industry_guid,
       i.Code AS industry_id,
       e.ActualResponse AS actual_response,
       e.PrimaryBudgetedCost AS primary_budgeted_cost,
       e.PrimaryExpectedRevenue AS primary_expected_revenue,
       e.PrimaryActualCost AS primary_actual_cost,
       e.PrimaryActualRevenue AS primary_actual_revenue,
       e.Notes AS notes,
       e.LastActualizeDate AS last_actualize_date,
       e.RecipientCount AS recipient_count
FROM dbo.EventTSC AS e
LEFT OUTER JOIN dbo.EventStatus AS es ON es.Id = e.StatusId
LEFT OUTER JOIN dbo.EventType AS et ON et.Id = e.TypeId
LEFT OUTER JOIN dbo.AccountIndustry AS i ON i.Id = e.IndustryId

GO
/****** Object:  Table [dbo].[Account]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationStateId] [uniqueidentifier] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[EmployeesNumberId] [uniqueidentifier] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[RegionId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[RegistrationPlatformId] [uniqueidentifier] NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[PrimaryContactId] [uniqueidentifier] NULL,
	[SellerAccountID] [int] NULL,
	[RegionHHId] [uniqueidentifier] NULL,
	[ClientCategoryId] [uniqueidentifier] NULL,
	[LastInvoicePaymentDate] [date] NULL,
	[RecorderId] [uniqueidentifier] NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[Phone] [nvarchar](250) NULL,
	[Web] [nvarchar](250) NULL,
	[DisqualificationReasonId] [uniqueidentifier] NULL,
	[MlmScore] [numeric](18, 2) NULL,
	[IsVirtualRegistration] [bit] NULL,
	[IsHidden] [bit] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[PreLoggerDate] [datetime2](7) NULL,
	[PrimaryPersonalAccount] [numeric](18, 2) NULL,
	[RepeatRegistration] [bit] NULL,
	[InformationSourceId] [uniqueidentifier] NULL,
	[OwnershipId] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Description] [nvarchar](250) NULL,
	[ParentId] [uniqueidentifier] NULL,
	[Code] [nvarchar](250) NULL,
	[AdditionalPhone] [nvarchar](250) NULL,
	[Fax] [nvarchar](250) NULL,
	[AddressTypeId] [uniqueidentifier] NULL,
	[CityId] [uniqueidentifier] NULL,
	[Zip] [nvarchar](50) NULL,
	[AccountCategoryId] [uniqueidentifier] NULL,
	[AnnualRevenueId] [uniqueidentifier] NULL,
	[AlternativeName] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[GPSN] [nvarchar](50) NULL,
	[GPSE] [nvarchar](50) NULL,
	[PriceListId] [uniqueidentifier] NULL,
	[UsrAccountBillboardId] [uniqueidentifier] NULL,
	[UsrAccountTelevisionId] [uniqueidentifier] NULL,
	[UsrAccountRadioId] [uniqueidentifier] NULL,
	[UsrAccountInternetAdvertId] [uniqueidentifier] NULL,
	[UsrAccountMediaId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidServKAId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidSiteId] [uniqueidentifier] NULL,
	[UsrAccountUseRunningLineId] [uniqueidentifier] NULL,
	[UsrAccountModulesMediaId] [uniqueidentifier] NULL,
	[UsrAccountAdvertAgency] [bit] NULL,
	[UsrAccountDistributor] [bit] NULL,
	[UsrAccountVendor] [bit] NULL,
	[UsrAccountIntegrator] [bit] NULL,
	[MarketingBudgetAvailabilityId] [uniqueidentifier] NULL,
	[RelationsLevelId] [uniqueidentifier] NULL,
	[ClientClassId] [uniqueidentifier] NULL,
	[ExistingAccountId] [uniqueidentifier] NULL,
	[BudgetOnStaffAvailabilityId] [uniqueidentifier] NULL,
	[MonthId] [uniqueidentifier] NULL,
	[BudgetingTypeId] [uniqueidentifier] NULL,
	[HRQuantityId] [uniqueidentifier] NULL,
	[UseEDId] [uniqueidentifier] NULL,
	[ManagerVacanciesNumber] [int] NULL,
	[LastSynchronizationDate] [datetime2](7) NULL,
	[ActivityContactId] [uniqueidentifier] NULL,
	[LastActivityDate] [datetime2](7) NULL,
	[LastInformationUpdateDate] [datetime2](7) NULL,
	[AccountAddToBlackList] [bit] NULL,
	[CBRating] [numeric](18, 2) NULL,
	[BadRegistrComment] [nvarchar](500) NULL,
	[URLHHru] [nvarchar](250) NULL,
	[URLHHua] [nvarchar](250) NULL,
	[URLHHby] [nvarchar](250) NULL,
	[PaymentAmountByYear] [numeric](18, 2) NULL,
	[PaymentAmountByHalfYear] [numeric](18, 2) NULL,
	[PaymentAmountByPreviousYear] [numeric](18, 2) NULL,
	[LastTaskDate] [datetime2](7) NULL,
	[LastTaskOwnerDate] [datetime2](7) NULL,
	[BaseDepthDate] [datetime2](7) NULL,
	[LastTaskTypeId] [uniqueidentifier] NULL,
	[LastTaskOwnerId] [uniqueidentifier] NULL,
	[PersonalAccountCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountLockCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountLock] [numeric](18, 2) NULL,
	[QuestionaryAccountId] [uniqueidentifier] NULL,
	[RecruitingStuffCount] [int] NULL,
	[PersonalAccountCurrencyRate] [numeric](18, 2) NULL,
	[PersonalAccountLockCurRate] [numeric](18, 2) NULL,
	[PrimaryPersonalAccountLock] [numeric](18, 2) NULL,
	[PreLoggerId] [uniqueidentifier] NULL,
	[PreLoggerStatusId] [uniqueidentifier] NULL,
	[TsSpecialFeatureId] [uniqueidentifier] NULL,
	[PersonalAccountAd] [numeric](18, 2) NULL,
	[PrimaryPersonalAccountAd] [numeric](18, 2) NULL,
	[PersonalAccountAdCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountAdCurrencyRate] [numeric](18, 2) NULL,
	[TsRegistrationSeparationDate] [date] NULL,
	[Completeness] [int] NULL,
	[AccountLogoId] [uniqueidentifier] NULL,
	[NrbLastSparkRequestDate] [datetime2](7) NULL,
	[NrbInn] [nvarchar](50) NULL,
	[NrbOgrn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegionHH]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegionHH](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL,
	[RegionTypeId] [uniqueidentifier] NULL,
	[ParentId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountRegion]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AccountRegion]
AS
SELECT        a.Id, a.ClientSiteCode, reg.Name AS Region, frr.AreaName, frr.FilialArea, frr.CountryName AS Country, frr.DistrictName
FROM            dbo.Account AS a LEFT OUTER JOIN
                         dbo.RegionHH AS reg ON reg.Id = a.RegionHHId LEFT OUTER JOIN
                         CommonData.dbo.FlatRegion_Russia AS frr ON reg.Code = frr.ID LEFT OUTER JOIN
                         dbo.Country AS cu ON cu.Id = a.CountryId
GO
/****** Object:  Table [dbo].[ProductSales]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales](
	[InvoiceDate] [date] NULL,
	[InvoiceNumber] [nvarchar](250) NULL,
	[EmployerIDName] [nvarchar](303) NULL,
	[EmployerID] [int] NULL,
	[PaymentDate] [date] NULL,
	[ManagerHHID] [int] NULL,
	[ProductCode] [nvarchar](300) NULL,
	[ProductName] [nvarchar](250) NULL,
	[Amount] [numeric](33, 6) NULL,
	[AmountExVAT] [float] NULL,
	[PaymaentSource] [varchar](3) NOT NULL,
	[SotrCode] [nvarchar](10) NULL,
	[SID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ProductSales_manager]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ProductSales_manager]
AS
SELECT        p.InvoiceDate, p.InvoiceNumber, p.EmployerIDName, p.EmployerID, p.PaymentDate, p.ManagerHHID, o.SotrName, p.ProductCode, p.ProductName, p.Amount, p.AmountExVAT, p.PaymaentSource, p.SotrCode, p.SID
FROM            dbo.ProductSales AS p LEFT OUTER JOIN
                             (SELECT DISTINCT SotrName, CodeForSite
                               FROM            SalesPlanFact_30.dbo.OrganizationEmployees) AS o ON o.CodeForSite = p.ManagerHHID
GO
/****** Object:  View [dbo].[vw_DEV_Account]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_DEV_Account]
AS
SELECT        TOP (10) ClientSiteCode, Name
FROM            dbo.Account
GO
/****** Object:  Table [dbo].[HRQuantity]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HRQuantity](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[InformationSource]    Script Date: 29.03.2020 11:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformationSource](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[Code] [int] NOT NULL,
 CONSTRAINT [PKUQVSm3iGTVBTuaJ8t90AGTbBBhU] PRIMARY KEY NONCLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientCategory]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientCategory](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountCategory]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountCategory](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[ID] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationState]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationState](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountEmployeesNumber]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountEmployeesNumber](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Position] [int] NULL,
	[Code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadDisqualifyReason]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadDisqualifyReason](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Code] [int] NULL,
	[RepeatRegistration] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[account_detail]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create VIEW [dbo].[account_detail]
AS-- 2. account_on_competitors
SELECT a.Id AS guid,
       a.ClientSiteCode AS employer_id,
       a.ModifiedOn AS modified_on,
       a.RegistrationDate AS registration_date,
       rs.Name AS registration_state,
       ins.Name AS information_source,
       a.IsVirtualRegistration AS is_virtual_registration,
       a.PreLoggerDate AS pre_registration_date,
       cl.Name AS market_segment ,
       ac.Name AS category ,
       at.Name AS account_type ,
       aen.Name AS employees_number ,
       a.ManagerVacanciesNumber as manager_vacancies_number,
       hrq.Name AS hr_quantity ,
       dr.Name AS disqualification_reason

FROM dbo.Account AS a
       LEFT JOIN dbo.AccountType AS at ON at.ID = a.TypeID
       LEFT JOIN dbo.RegistrationState AS rs ON a.RegistrationStateId = rs.Id
       LEFT JOIN dbo.InformationSource AS ins ON a.InformationSourceId = ins.Id
       LEFT JOIN dbo.AccountEmployeesNumber AS aen ON aen.Id = a.EmployeesNumberID
       LEFT JOIN dbo.LeadDisqualifyReason AS dr ON dr.Id = a.DisqualificationReasonId
       LEFT JOIN dbo.HRQuantity AS hrq ON hrq.id = a.HRQuantityId
       LEFT JOIN dbo.ClientCategory AS cl ON cl.id = a.ClientCategoryId
       LEFT JOIN dbo.AccountCategory AS ac ON ac.Id = a.AccountCategoryId



GO
/****** Object:  Table [dbo].[Contact]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ModifiedOn] [datetime2](3) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[Name] [nvarchar](250) NULL,
	[Phone] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[CodeForSite] [int] NULL,
	[IsDelete] [bit] NULL,
	[SKS] [bit] NULL,
	[ID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[GenderID] [uniqueidentifier] NULL,
	[JobTitle] [nvarchar](250) NULL,
	[MainPhone] [nvarchar](250) NULL,
	[UserID] [int] NULL,
	[HHID] [int] NULL,
	[DepartmentID] [uniqueidentifier] NULL,
	[gkl] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactChanges]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactChanges](
	[ID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[ChangeDt] [date] NULL,
	[SID] [int] IDENTITY(1,1) NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  View [dbo].[vw_ManagerSCD]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ManagerSCD]
AS
SELECT cc.SID,
       cc.ID,
       cc.ContactDepartmentID,
       CASE
           WHEN  cc.ChangeDt = '2019-02-11'
           THEN '2019-02-01'
           ELSE cc.ChangeDt
       END AS
	   	    DateFrom,
       case
	   when
	   COALESCE(DATEADD(dd, -1, LEAD(cc.ChangeDt) OVER(PARTITION BY cc.ID   ORDER BY cc.ChangeDt)), '9999-12-31') = '2019-02-10'
	   then '2019-01-31'
	   else COALESCE(DATEADD(dd, -1, LEAD(cc.ChangeDt) OVER(PARTITION BY cc.ID   ORDER BY cc.ChangeDt)), '9999-12-31')
	   end



	   AS DateTo,
       c.ModifiedOn,
       c.CreatedOn,
       c.Name,
       c.Phone,
       c.Email,
       c.CodeForSite,
       c.IsDelete,
       c.SKS,
       c.OwnerID,
       c.AccountID,
       c.GenderID,
       c.JobTitle,
       c.MainPhone,
       c.UserID,
       c.HHID,
       c.DepartmentID
FROM ContactChanges cc
     LEFT JOIN Contact c ON cc.ID = c.ID

GO
/****** Object:  View [dbo].[Managers1C_CRM]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Managers1C_CRM]
AS
SELECT DISTINCT c.ID, eo.SotrName, eo.SotrCode, eo.CodeForSite
FROM            SalesPlanFact_30.dbo.OrganizationEmployees AS eo LEFT OUTER JOIN
                         dbo.Contact AS c ON eo.CodeForSite = c.CodeForSite AND eo.CodeForSite <> ''
GO
/****** Object:  Table [dbo].[ContactDepartment]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactDepartment](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[CodeForSite] [nvarchar](250) NULL,
	[DepartmentId] [uniqueidentifier] NULL,
	[CallEquivalentTypeId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SellerAccount]    Script Date: 29.03.2020 11:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SellerAccount](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountDetail]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AccountDetail]
AS
SELECT a.Id,
       a.ClientSiteCode,
       a.RegistrationDate,
       a.Name AS AccountName,
       concat(a.ClientSiteCode, ' - ', a.Name) AccountNameID,
       rs.ID AS RegistrationStateID,
       rs.Name AS RegistrationState,
       c.ID AS ManagerID,
       c.Name AS Manager,
       cd.Name AS Department,
       at.Name AS AccountType,
       aen.Name AS EmployeesNumber,
       reg.Name AS Region,
       frr.AreaName,
       frr.FilialArea,
       sa.Name AS SellerAccount,
       a.PrimaryContactID,
       a.RegionID,
       a.RegionHHid,
       a.PersonalAccount,
       a.RegistrationPlatformID,
       a.DisqualificationReasonId,
       a.Phone,
       a.Web,
       reg.Code AS RegionCode,
       CASE a.IsVirtualRegistration
           WHEN 1
           THEN 'Виртуальная регистрация'
           ELSE 'Не виртуальная регистрация'
       END AS VirtualRegistration,
       CASE
           WHEN a.PreLoggerDate IS NULL
           THEN 'Не предрегистрация'
           ELSE 'Предрегистрация'
       END AS PredRegistration,
       dr.Name AS DisqualificationReason,
       a.MlmScore,
       a.[AccountDateChangeTypeRegistr],
       reg.Code AS reg_Code,
       a.RegistrationSiteId,
       c.CodeForSite AS ManagerCodeForSite,
       frr.CountryName AS Country,
       a.RecorderId,
       a.[ModifiedOn],
       cl.Name AS market_segment,
       ac.Name AS AccountCategory,
       a.ManagerVacanciesNumber,
       hrq.Name AS HrQuantity
	   ,frr.DistrictName

/*, */

FROM dbo.Account AS a
     LEFT JOIN dbo.Contact AS c ON a.OwnerID = c.ID
     LEFT JOIN dbo.AccountType AS at ON at.ID = a.TypeID
     LEFT JOIN dbo.RegistrationState AS rs ON a.RegistrationStateId = rs.Id
     LEFT JOIN dbo.SellerAccount AS sa ON sa.ID = a.SellerAccountID
     LEFT JOIN dbo.AccountEmployeesNumber AS aen ON aen.Id = a.EmployeesNumberID
     LEFT JOIN dbo.RegionHH AS reg ON reg.Id = a.RegionHHid
     LEFT JOIN CommonData.dbo.FlatRegion_Russia AS frr ON reg.Code = frr.ID
     LEFT JOIN dbo.ContactDepartment AS cd ON cd.Id = c.ContactDepartmentID
     LEFT JOIN [dbo].[LeadDisqualifyReason] AS dr ON dr.Id = a.DisqualificationReasonId
     LEFT JOIN [dbo].[Country] AS cu ON cu.Id = a.CountryId
     LEFT JOIN CRMData750.dbo.HRQuantity AS hrq ON hrq.id = a.HRQuantityId
     LEFT JOIN CRMData750.dbo.ClientCategory AS cl ON cl.id = a.[ClientCategoryId]
     LEFT JOIN [CRMData750].[dbo].[AccountCategory] AS ac ON ac.Id = a.AccountCategoryId
UNION ALL
SELECT NEWID(),
       13796255,
       '2016-01-01',
       'Неавторизованный пользователь',
       concat(3796255, ' - ', 'Неавторизованный пользователь'),
       'D31A4845-3258-42EC-9B30-6ECD5DCDA648',
       'Подтвержденная регистрация',
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
	   null
GO
/****** Object:  Table [dbo].[EventTarget]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventTarget](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[EventId] [uniqueidentifier] NULL,
	[EventResponseId] [uniqueidentifier] NULL,
	[Note] [nvarchar](500) NULL,
	[IsFromGroup] [bit] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[TargetItem] [nvarchar](50) NULL,
	[AccountId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OLAP-1854]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-1854]
AS
SELECT        t.ClientSiteCode, t.AccountName, ad.ManagerCodeForSite, ad.Department, o_1.cnt, MAX(t.activation_time) AS activation_time, MAX(t.employer_service_id) AS employer_service_id, SUM(t.qtty) AS qtty
FROM            (SELECT DISTINCT a.ID, a.ClientSiteCode, a.AccountName, a.ManagerID, o.employer_service_id, o.activation_time, o.cnt, COALESCE (s.qtty, 0) AS qtty
                          FROM            dbo.EventTarget AS e LEFT OUTER JOIN
                                                    dbo.AccountDetail AS a ON e.AccountId = a.ID LEFT OUTER JOIN
                                                    ActivationAnalysisData.dbo.orders_all_uncleansed AS o ON o.employer_id = a.ClientSiteCode LEFT OUTER JOIN
                                                    ActivationAnalysisData.dbo.orders_all_uncleansed AS o2 ON o.employer_service_id = o2.employer_service_id LEFT OUTER JOIN
                                                        (SELECT        employer_service_id, code, SUM(CAST(qtty AS int)) AS qtty
                                                          FROM            ActivationAnalysisData.dbo.spending
                                                          WHERE        (t IN (1, 2))
                                                          GROUP BY employer_service_id, code) AS s ON s.employer_service_id = o.employer_service_id LEFT OUTER JOIN
                                                    ResumeSnapshots.dbo.UserSnapshotLast AS usl ON o.buyed_by_manager_id = usl.ID LEFT OUTER JOIN
                                                    dbo.EventTSC AS etsc ON e.EventId = etsc.Id
                          WHERE        (o.activation_time > DATEADD(day, 1, eomonth(DATEADD(month, - 1, GETDATE())))) AND (o.code = 'VP') AND (o2.code = 'VPPL') AND
                                                    (etsc.Name IN ('Спец кампания по привлечению вакансий от федеральных/локальных клиентов', 'Привлечение вакансий. Федорченко 2017',
                                                    'Акция ОКП-Москва «Привлечение региональных вакансий»'))) AS t LEFT OUTER JOIN
                         dbo.AccountDetail AS ad ON t.ClientSiteCode = ad.ClientSiteCode LEFT OUTER JOIN
                             (SELECT        employer_service_id, cnt
                               FROM            ActivationAnalysisData.dbo.orders_all_uncleansed
                               WHERE        (code = 'VP')) AS o_1 ON o_1.employer_service_id = t.employer_service_id
GROUP BY t.ClientSiteCode, t.AccountName, ad.ManagerCodeForSite, ad.Department, o_1.cnt
HAVING        (ad.Department LIKE '%ОКП%') AND (SUM(t.qtty) = 0) AND (MAX(t.activation_time) = DATEADD(day, - 7, GETDATE()))
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[Id] [uniqueidentifier] NULL,
	[Title] [nvarchar](500) NULL,
	[StartDate] [datetime2](7) NULL,
	[DueDate] [datetime2](7) NULL,
	[PriorityId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[DocumentId] [uniqueidentifier] NULL,
	[InvoiceId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[ResultId] [uniqueidentifier] NULL,
	[DetailedResult] [nvarchar](max) NULL,
	[ShowInScheduler] [bit] NULL,
	[RemindToAuthor] [bit] NULL,
	[RemindToOwner] [bit] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ActualStartDate] [datetime2](7) NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ActivityEquivalentCalls] [int] NULL,
	[HHID] [int] NULL,
	[HHCreationTime] [datetime2](7) NULL,
	[ActivityCategoryId] [uniqueidentifier] NULL,
	[ActualEndDate] [datetime2](7) NULL,
	[IsFromExcel] [bit] NULL,
	[ExcelDetails] [nvarchar](500) NULL,
	[AuthorId] [uniqueidentifier] NULL,
	[EscalationLevel] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[OLAP-2036]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-2036]
AS
SELECT        t.employer_id, ad.ManagerCodeForSite, t.last_expiration_time, GETDATE() AS DateStart, DATEADD(day, 7, GETDATE()) AS DateEnd
FROM            (SELECT        employer_id, MAX(expiration_time) AS last_expiration_time
                          FROM            ActivationAnalysisData.dbo.orders_all_cleansed
                          WHERE        (code LIKE 'FA%') AND (original_cnt IN (183, 365))
                          GROUP BY employer_id) AS t LEFT OUTER JOIN
                         dbo.AccountDetail AS ad ON ad.ClientSiteCode = t.employer_id
WHERE        (DATEDIFF(day, t.last_expiration_time, GETDATE()) = 1) AND (t.employer_id NOT IN
                             (SELECT        a.ClientSiteCode
                               FROM            dbo.Activity AS ac LEFT OUTER JOIN
                                                         dbo.Account AS a ON ac.AccountId = a.Id
                               WHERE        (DATEDIFF(day, ac.ActualStartDate, GETDATE()) <= 30) AND (ac.ActivityCategoryId = 'B6C1655F-EB4D-462B-B5C2-4EC84891E32B') AND (a.ClientSiteCode IN
                                                             (SELECT        employer_id
                                                               FROM            (SELECT        employer_id, MAX(expiration_time) AS last_expiration_time
                                                                                         FROM            ActivationAnalysisData.dbo.orders_all_cleansed AS orders_all_cleansed_1
                                                                                         WHERE        (code LIKE 'FA%') AND (original_cnt IN (183, 365))
                                                                                         GROUP BY employer_id) AS t_1
                                                               WHERE        (DATEDIFF(day, last_expiration_time, GETDATE()) = 1)))))
GO
/****** Object:  View [dbo].[Contact_Department]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Contact_Department]
AS
SELECT        c.ID, c.Name AS Manager, cd.Name AS Department, c.IsDelete, c.SKS, c.OwnerID, c.ContactDepartmentID, c.AccountID, c.UserID, c.CodeForSite, c.HHID, c.JobTitle
FROM            dbo.Contact AS c LEFT OUTER JOIN
                         dbo.ContactDepartment AS cd ON cd.Id = c.ContactDepartmentID
GO
/****** Object:  Table [dbo].[Case]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Case](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Number] [nvarchar](50) NOT NULL,
	[RegisteredOn] [datetime2](7) NULL,
	[Subject] [nvarchar](500) NOT NULL,
	[Symptoms] [nvarchar](max) NOT NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[ResponseDate] [datetime2](7) NULL,
	[SolutionDate] [datetime2](7) NULL,
	[StatusId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[PriorityId] [uniqueidentifier] NULL,
	[OriginId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[RespondedOn] [datetime2](7) NULL,
	[SolutionProvidedOn] [datetime2](7) NULL,
	[ClosureDate] [datetime2](7) NULL,
	[ClosureCodeId] [uniqueidentifier] NULL,
	[Solution] [nvarchar](max) NOT NULL,
	[SatisfactionLevelId] [uniqueidentifier] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[ResponseOverdue] [bit] NOT NULL,
	[SolutionOverdue] [bit] NOT NULL,
	[SatisfactionLevelComment] [nvarchar](max) NOT NULL,
	[SolutionRemains] [decimal](18, 1) NOT NULL,
	[ServiceItemId] [uniqueidentifier] NULL,
	[PersonTypeId] [uniqueidentifier] NULL,
	[HHID] [int] NOT NULL,
	[PlatformTypeId] [uniqueidentifier] NULL,
	[SiteModuleId] [uniqueidentifier] NULL,
	[ShowOnPortal] [bit] NOT NULL,
	[UrgencyTypeId] [uniqueidentifier] NULL,
	[ImpactDegreeId] [uniqueidentifier] NULL,
	[HashCode] [nvarchar](250) NOT NULL,
	[ProblemTypeId] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NOT NULL,
	[HHRespondedOn] [datetime2](7) NULL,
	[SolvedOnLevelId] [uniqueidentifier] NULL,
	[DetailedSolution] [nvarchar](max) NOT NULL,
	[CaseSolutionId] [uniqueidentifier] NULL,
	[SiteCreatedOn] [datetime2](7) NULL,
	[CaseTypeId] [uniqueidentifier] NULL,
	[EscalationLevel] [int] NOT NULL,
	[BrowserId] [uniqueidentifier] NULL,
	[SupportLevelId] [uniqueidentifier] NULL,
	[JiraRequest] [nvarchar](250) NOT NULL,
	[OutlookCreatedOn] [datetime2](7) NULL,
	[RemindToAuthor] [bit] NOT NULL,
	[RemindToOwner] [bit] NOT NULL,
	[RemindToAuthorDate] [datetime2](7) NULL,
	[RemindToOwnerDate] [datetime2](7) NULL,
	[FIO] [nvarchar](250) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[JiraRequest2] [nvarchar](250) NOT NULL,
	[ShowOnPortalIsManual] [bit] NOT NULL,
	[IsOvervalue] [bit] NOT NULL,
	[BrowserVersion] [nvarchar](250) NOT NULL,
	[IsAttachmentExists] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_OLAP2640]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_OLAP2640]
as
with managers as
(
SELECT ID, [CodeForSite], Name, SUBSTRING(email, 1, CHARINDEX('@', email)-1) as [login]
FROM [CRMData750].[dbo].[Contact]
where Name in ('Ахантьева Екатерина',
		  'Байе Александра',
		  'Березнёв Александр',
		  'Борисова Виктория',
		  'Ваго Елена',
		  'Ветрова Анна',
		  'Волина Татьяна',
		  'Гладкова Татьяна',
		  'Жаврук Любовь',
		  'Жукова Алёна',
		  'Ильин Алексей',
		  'Козырева Светлана',
		  'Красновская Татьяна',
		  'Петухова Екатерина',
		  'Соколова Алена',
		  'Тедеева Инга',
		  'Шевчук Анна',
		  'Юнак Марина',
		  'Юрова Оксана')
and ContactDepartmentId is not null
)
---------------
/*ЗАДАЧИ jIRA*/
---------------

-- задачи jira спп
SELECT 'jira.hh.ru/browse/'+ORIGINALKEY+'-'+cast(ji.issuenum as nvarchar(10)) IssueLink
      ,m.CodeForSite as ManagerId
	 ,m.Name as ManagerName
      ,[CREATED] as CreatedOn
	 ,'СПП' IssueType
FROM [JIRAREP].[dbo].[jiraissue] ji
join managers m on m.[login]=ji.CREATOR
where ORIGINALKEY='SSS'

union all

-- задачи jira продукты
SELECT 'jira.hh.ru/browse/'+ORIGINALKEY+'-'+cast(ji.issuenum as nvarchar(10))
      ,m.CodeForSite
	 ,m.Name
      ,[CREATED]
	 ,'Продукты'
FROM [JIRAREP].[dbo].[jiraissue] ji
join managers m on m.[login]=ji.CREATOR
where ORIGINALKEY like 'ADV%'

union all
---------------
/*АКТИВНОСТИ В CRM*/
---------------
--активности спп в CRM
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/ActivityPageV2/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'СПП'
from CRMData750.dbo.[Activity] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='F3DD77EE-C4EA-4262-BD00-515BE28B5D26'

union all
--активности техпод в CRM
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/ActivityPageV2/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'Техпод'
from CRMData750.dbo.[Activity] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='4F9192BC-7A25-4D06-91C9-3CF83992ECAC'

union all
--активности продукты в CRM
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/ActivityPageV2/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'Продукты'
from CRMData750.dbo.[Activity] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='14F4BD27-00C9-45EA-8ADF-0870DF22681A'

---------------
/*ОБРАЩЕНИЯ В CRM*/
---------------
union all
-- обращения в спп
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/CasePage/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'СПП'
from CRMData750.dbo.[Case] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='F3DD77EE-C4EA-4262-BD00-515BE28B5D26'

union all
--обращения в техпод
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/CasePage/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'Техпод'
from CRMData750.dbo.[Case] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='4F9192BC-7A25-4D06-91C9-3CF83992ECAC'

union all
--обращения в продукты
select 'https://crm.hh.ru/0/Nui/ViewModule.aspx#CardModuleV2/CasePage/edit/'+cast(a.ID as nvarchar(36))
	  ,m.CodeForSite
	  ,m.Name
	  ,a.CreatedOn
	  ,'Продукты'
from CRMData750.dbo.[Case] a
join CRMData750.dbo.Contact_Department cd on a.OwnerId=cd.ID
join managers m on a.CreatedById=m.ID
where cd.ContactDepartmentId='14F4BD27-00C9-45EA-8ADF-0870DF22681A'
GO
/****** Object:  Table [dbo].[AccountBranch]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountBranch](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[SphereId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[Active] [bit] NULL,
	[IndustryId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sphere]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sphere](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL,
	[AccountIndustryId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountToIndustry]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AccountToIndustry]
AS
SELECT DISTINCT ab.AccountId, ai.Id AS AccountIndustryId, ai.Name AS AccountIndustry, s.Id AS SphereID, s.Name AS Sphere
FROM            dbo.AccountBranch AS ab LEFT OUTER JOIN
                         dbo.Sphere AS s ON ab.SphereId = s.Id LEFT OUTER JOIN
                         dbo.AccountIndustry AS ai ON ai.Id = s.AccountIndustryId
WHERE        (ab.Active = 1)

GO
/****** Object:  View [dbo].[AccountIndustryGrouped]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AccountIndustryGrouped]
AS
  SELECT    distinct  [AccountId] ,
            STUFF((    SELECT '| ' + [AccountIndustry] AS [text()]

                        FROM (SELECT distinct [AccountId]
            ,[AccountIndustry]
        FROM [CRMData750].[dbo].[AccountToIndustry])
						ai2
                        WHERE
                        ai1.[AccountId] = ai2.[AccountId]
                        FOR XML PATH('')
                        ), 1, 1, '' )

            AS [AccountIndustry]
FROM [CRMData750].[dbo].[AccountToIndustry] ai1
GO
/****** Object:  View [dbo].[OLAP_2782_Contact]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Contact]
AS
SELECT        Name, Phone, Email, CodeForSite, IsDelete, SKS, ID, OwnerID, ContactDepartmentID, AccountID, GenderID, JobTitle, MainPhone, UserID, HHID, DepartmentID, gkl
FROM            dbo.Contact
WHERE        (SKS = 0) AND (Email LIKE '%@hh.ru')
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Number] [nvarchar](250) NULL,
	[StartDate] [datetime2](7) NULL,
	[PrimaryAmount] [numeric](18, 2) NULL,
	[PrimaryPaymentAmount] [numeric](18, 2) NULL,
	[PaymentStatusId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[SupplierBillingInfoId] [uniqueidentifier] NULL,
	[RemindToOwner] [bit] NULL,
	[RemindToOwnerDate] [datetime2](7) NULL,
	[CustomerBillingInfoId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CurrencyRate] [numeric](18, 2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DueDate] [datetime] NULL,
	[PaymentAmount] [numeric](18, 2) NULL,
	[Notes] [nvarchar](max) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[SupplierId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[OrderId] [uniqueidentifier] NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[PlanPaymentDate] [datetime] NULL,
	[InvoiceFirstPayment] [bit] NULL,
	[InvoiceMotiveFirstPaymentId] [uniqueidentifier] NULL,
	[IsProcessedByShortSalesClose] [bit] NULL,
	[IsProcessedByShortSalesControl] [bit] NULL,
	[InvoiceSecondManagerId] [uniqueidentifier] NULL,
	[InvoicePercentSecondManager] [int] NULL,
	[InvoiceReasonSplitId] [uniqueidentifier] NULL,
	[InvoiceMethodPaymentId] [uniqueidentifier] NULL,
	[InvoiceTypeId] [uniqueidentifier] NULL,
	[InvoiceTypeOfBilling] [nvarchar](250) NULL,
	[InvoiceDateOfDeposit] [datetime2](7) NULL,
	[InvoiceNetting] [bit] NULL,
	[InvoiceVATRate] [numeric](18, 2) NULL,
	[AmountWithoutVAT] [numeric](18, 2) NULL,
	[PrimaryAmountWithoutVAT] [numeric](18, 2) NULL,
	[PaymentAmountWithoutVAT] [numeric](18, 2) NULL,
	[InvoiceLastSynchroDate] [datetime2](7) NULL,
	[CodeForSite] [int] NULL,
	[ID1C] [uniqueidentifier] NULL,
	[InvoiceCommentFirstPayment] [nvarchar](max) NULL,
	[EventId] [uniqueidentifier] NULL,
	[SplitActivityIdId] [uniqueidentifier] NULL,
	[SplitDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[OLAP_2782_Invoices]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Invoices]
AS
SELECT        a.Id, a.Number, a.AccountId, CAST(a.StartDate AS date) AS StartDate, a.DueDate, a.PaymentStatusId, a.OwnerId, a.ManagerName, a.CodeForSite, oe.ID AS s_id, a.InvoicePercentSecondManager,
                         a.PrimaryAmountWithoutVAT
FROM            (SELECT        i.Id, i.Number, i.AccountId, i.StartDate, i.DueDate, i.PaymentStatusId, i.OwnerId, c.Name AS ManagerName, c.CodeForSite, i.InvoicePercentSecondManager, i.PrimaryAmountWithoutVAT
                          FROM            (SELECT        Id, Number, AccountId, StartDate, DueDate, PaymentStatusId, OwnerId, InvoicePercentSecondManager, (100 - InvoicePercentSecondManager)
                                                                              / 100 * PrimaryAmountWithoutVAT AS PrimaryAmountWithoutVAT
                                                    FROM            dbo.Invoice
                                                    UNION ALL
                                                    SELECT        Id, Number, AccountId, StartDate, DueDate, PaymentStatusId, InvoiceSecondManagerId AS OwnerId, InvoicePercentSecondManager,
                                                                             InvoicePercentSecondManager / 100 * PrimaryAmountWithoutVAT AS Expr1
                                                    FROM            dbo.Invoice AS Invoice_1
                                                    WHERE        (InvoiceSecondManagerId IS NOT NULL)) AS i INNER JOIN
                                                    dbo.OLAP_2782_Contact AS c ON c.ID = i.OwnerId) AS a INNER JOIN
                         SalesPlanFact_30.dbo.OrganizationEmployeesForCube AS oe ON a.CodeForSite = oe.CodeForSite AND a.StartDate BETWEEN oe.StartDate AND oe.EndDate
GO
/****** Object:  View [dbo].[Contact_isSKS]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Contact_isSKS]
AS
SELECT        ID, Name, OwnerID, ContactDepartmentID, CodeForSite, SKS
FROM            dbo.Contact
WHERE        (SKS = 1)
GO
/****** Object:  View [dbo].[OLAP_2782_Invoice_not_pay_60]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Invoice_not_pay_60]
AS
SELECT        a.Id, a.Number, a.AccountId, a.StartDate, oe.ID AS s_id, a.DueDate, a.PaymentStatusId, a.OwnerId, a.ManagerName, a.CodeForSite, a.InvoicePercentSecondManager, a.PrimaryAmountWithoutVAT
FROM            (SELECT        Id, Number, AccountId, StartDate, DueDate, PaymentStatusId, OwnerId, ManagerName, CodeForSite, InvoicePercentSecondManager, PrimaryAmountWithoutVAT
                          FROM            dbo.OLAP_2782_Invoices
                          WHERE        (DueDate IS NULL) AND (StartDate >= DATEADD(day, - 60, GETDATE()))) AS a INNER JOIN
                         SalesPlanFact_30.dbo.OrganizationEmployeesForCube AS oe ON a.CodeForSite = oe.CodeForSite AND a.StartDate BETWEEN oe.StartDate AND oe.EndDate
GO
/****** Object:  View [dbo].[OLAP_2782_Activity_not_finish]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Activity_not_finish]
AS
SELECT        a_1.Id, a_1.OwnerId, a_1.AccountId, a_1.CodeForSite, oe.ID AS s_id, oe.SotrName, a_1.ManagerName, a_1.StatusId, a_1.ResultId, a_1.ActivityCategoryId, a_1.ActualStartDate, a_1.ActualEndDate, CAST(a_1.CreatedOn AS date)
                         AS CreatedOn
FROM            (SELECT        a.Id, a.OwnerId, a.AccountId, c.CodeForSite, c.Name AS ManagerName, a.StatusId, a.ResultId, a.ActivityCategoryId, a.ActualStartDate, a.ActualEndDate, a.StartDate, a.DueDate, a.CreatedOn
                          FROM            dbo.Activity AS a INNER JOIN
                                                    dbo.OLAP_2782_Contact AS c ON c.ID = a.OwnerId
                          WHERE        (a.StartDate > '2018-04-01') AND (a.ActualEndDate IS NULL) AND (c.CodeForSite <> 0)) AS a_1 INNER JOIN
                         SalesPlanFact_30.dbo.OrganizationEmployeesForCube AS oe ON a_1.CodeForSite = oe.CodeForSite AND a_1.CreatedOn BETWEEN oe.StartDate AND oe.EndDate
GO
/****** Object:  Table [dbo].[Calls_v2]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calls_v2](
	[user] [nvarchar](100) NULL,
	[MonthDate] [date] NULL,
	[direction] [nvarchar](9) NULL,
	[bils] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  View [dbo].[vw_Calls]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Calls]
AS
SELECT        c.[user], oe.ID, u.CodeForSite, c.MonthDate, c.direction, c.bils
FROM            dbo.Calls_v2 AS c INNER JOIN
                             (SELECT        Name, Phone, Email, CodeForSite
                               FROM            dbo.Contact
                               WHERE        (Email LIKE '%@hh.ru') AND (AccountID = 'D2EB29A1-EB80-471D-AA3F-A61358CD4268') AND (IsDelete = 0)) AS u ON REPLACE(u.Email, '@hh.ru', '') = c.[user] INNER JOIN
                         SalesPlanFact_30.dbo.OrganizationEmployeesForCube AS oe ON oe.CodeForSite = u.CodeForSite AND c.MonthDate BETWEEN oe.StartDate AND oe.EndDate
GO
/****** Object:  View [dbo].[vw_LG]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_LG]
as
select RANK() OVER(ORDER BY i.ID) ID,
i.Number,
cast(i.StartDate as date) StartDate,
cast(i.DueDate as date) DueDate,
case when i.DueDate is null then null else i.AmountwithoutVAT end AmountwithoutVAT,
RANK() OVER(ORDER BY cte.ID) as ActivityID,
cast(cte.ActualEndDate as date) as ActivityDuedate,
cte.Title as ActivityTitle,
cte.OwnerID,
cte.ClientSiteCode as ActivityAccountID,
case when i.DueDate is not null then 'Да' when i.DueDate is null and i.ID is not null then 'Нет' else null end InvoiceIsPaid,
case when i.Number like '%-Б/%' then 'Да' else 'Нет' end InvoiceIsBonus
from CRMData750.dbo.Invoice i
right join
--активности типа транзакционное обслуживание + поле NextActivityDate - дата активности следующей за текущей (или дата текущей +30 дней, если в течение 30 дней не было активности)
(
select a.ID,
cast(ActualEndDate as date) ActualEndDate,
Title,
AccountID,
ac.ClientSiteCode, a.OwnerID,
cast(case when LEAD(ActualEndDate) OVER (PARTITION BY AccountID ORDER BY ActualEndDate)<DATEADD(dd,30,ActualEndDate)
then LEAD(ActualEndDate) OVER (PARTITION BY AccountID ORDER BY ActualEndDate)
else DATEADD(dd,30,ActualEndDate) end as date) as NextActivityDate
from CRMData750.dbo.Activity a
left join CRMData750.dbo.Account ac on a.AccountId=ac.ID
where a.ActivityCategoryID='95C42028-EAD2-4B01-8D36-853D2FEAD2D9' and ActualEndDate is not null
) cte
on i.AccountId=cte.AccountId and i.StartDate >= cte.ActualEndDate and i.StartDate < cte.NextActivityDate
GO
/****** Object:  Table [dbo].[InvoiceBillLabel]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceBillLabel](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[InvoiceId] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Amount] [numeric](18, 2) NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CodeForSite] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ProductSales]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ProductSales]
AS
SELECT NULL [InvoiceDate],
       [InvoiceNumber],
       concat(EmployerID, ' - ', a.Name) EmployerIDName,
       EmployerID,
       [PaymentDate],
       CASE
           WHEN s.CodeForSite = 0
           THEN NULL
           ELSE s.CodeForSite
       END ManagerHHID,
       NULL [ProductCode],
       CASE
           WHEN [InvoiceNumber] LIKE 'КМ/%'
           THEN 'ClickMe'
           ELSE COALESCE(o.[product], 'Реклама (1С)')
       END [ProductName],
       NULL Amount,
       (CASE
            WHEN o.[ProductCount] = 1
            THEN [PINSumWoVAT]
            WHEN o.[ProductCount] > 1
                 AND ABS(p.[SumWoVATPayment] - o.[SumWoVATOrder]) < 10
            THEN o.[SumWoVAT]

        /*/o.[ProductCount]*/

            WHEN o.[ProductCount] > 1
                 AND ABS(p.[SumWoVATPayment] - o.[SumWoVATOrder]) > 10
            THEN [PINSumWoVAT] * (o.[SumWoVAT] / o.[SumWoVATOrder])
            WHEN o.[SumWoVATOrder] IS NULL
            THEN [PINSumWoVAT]
        END) * COALESCE((om.Percentage / 100), 1) AmountExVAT,
       '1C' PaymaentSource,
       s.SotrCode [SotrCode]
FROM [AdvertisementBillingData].[dbo].[PaymentInvoiceOrder] p
     LEFT JOIN [AdvertisementBillingData].[dbo].[OrderProductSum] o ON p.[ADVOrderID] = o.[ADVOrderID]
     LEFT JOIN [CRMData750].dbo.Account a ON a.ClientSiteCode = o.EmployerID
     LEFT JOIN [AdvertisementBillingData].[dbo].[ADVOrderManager] om ON om.ADVOrderID = p.[ADVOrderID]
     LEFT JOIN
(
    SELECT DISTINCT
           [SotrCode],
           [CodeForSite]
    FROM [SalesPlanFact_30].[dbo].[OrganizationEmployees]
) AS s ON s.SotrCode = om.ManagerID
WHERE InvoiceNumber IS NOT NULL
UNION ALL
SELECT

/*	i.ID				InvoiceID,*/

i.InvoiceDate,
i.InvoiceNumber,
CAST(a.ClientSiteCode AS VARCHAR(50)) + ' - ' + a.Name EmployerIDName,

/*	i.CustomerID,*/

a.ClientSiteCode EmployerID,
CAST(i.PaymentOrderDate AS DATE) PaymentDate,

/*i.OwnerID									ManagerID,*/

c.CodeForSite ManagerHHID,

/*	c.Name										ManagerName,*/

CAST(i.ProductCode AS NVARCHAR) ProductCode,
i.ProductName,
i.Amount,
i.AmountExVAT,
'CRM' PaymaentSource,
NULL
FROM
(
    SELECT DISTINCT
           [InvoiceTypeOfBilling] billing_type,
           Invoice.ID,
           [StartDate] InvoiceDate,
           Number InvoiceNumber,
           [AccountId] CustomerID,
           [PaymentStatusId] BillStatusID,
           Invoice.CurrencyID,
           InvoiceTypeID,
           DueDate PaymentOrderDate,
           OwnerID,
           il.[CodeForSite] ProductCode,
           il.Name ProductName,
           il.Amount * (100 - COALESCE([InvoicePercentSecondManager], 0)) / 100 Amount,
           il.Amount * (100 - COALESCE([InvoicePercentSecondManager], 0)) / 100 / CASE
                                                                                      WHEN [InvoiceVATRate] = 0
                                                                                      THEN 1.18
                                                                                      ELSE [InvoiceVATRate]/100 +1
                                                                                  END AmountExVAT,
           invoice.CreatedByID

    /*		AmountWOVAT*(1 - coalesce(SecondManagerPercent/100,0)) AmountExVAT*/

    FROM CRMData750.dbo.Invoice
         RIGHT JOIN CRMData750.dbo.InvoiceBillLabel il ON Invoice.ID = il.InvoiceID
    UNION

    /* ALL*/

    SELECT [InvoiceTypeOfBilling] billing_type,
           Invoice.ID,
           [StartDate] InvoiceDate,
           Number InvoiceNumber,
           [AccountId] CustomerID,
           [PaymentStatusId] BillStatusID,
           Invoice.CurrencyID,
           InvoiceTypeID,
           DueDate PaymentOrderDate,
           [InvoiceSecondManagerId] OwnerID,
           il.CodeForSite ProductCode,
           il.Name ProductName,
           il.Amount * COALESCE([InvoicePercentSecondManager], 0) / 100 Amount,
           il.Amount * COALESCE([InvoicePercentSecondManager], 0) / 100 / CASE
                                                                              WHEN [InvoiceVATRate] = 0
                                                                              THEN 1.18
                                                                              ELSE [InvoiceVATRate]/100 +1
                                                                          END AmountExVAT,
           invoice.CreatedByID

    /*		AmountWOVAT*coalesce(SecondManagerPercent/100,0) AmountExVAT*/

    FROM CRMData750.dbo.Invoice
         RIGHT JOIN CRMData750.dbo.InvoiceBillLabel il ON Invoice.ID = il.InvoiceID
    WHERE [InvoiceSecondManagerId] IS NOT NULL
) i
LEFT JOIN CRMData750.dbo.Contact c ON c.ID = i.OwnerID
LEFT JOIN CRMData750.dbo.Account a ON a.ID = i.CustomerID
LEFT JOIN CRMData750.dbo.ContactDepartment cd ON cd.ID = c.ContactDepartmentID
WHERE i.billing_type = ''

      /*is null									--Берем только счета загруженные в CRM из биллинга сайта*/

      AND i.CurrencyID = '5FB76920-53E6-DF11-971B-001D60E938C6'

      /*Берем только счета в рублях*/

      AND i.BillStatusID = '698D39FD-52E6-DF11-971B-001D60E938C6'

      /*Берем только счета со статусом "Оплачен" (он включает статусы биллинга "Оплачен" и "Оплачен картой")*/

      AND i.PaymentOrderDate <> '1899-12-30'

      /*Не берем счета, в которых несмотря на статус "Оплачен" стоит пустая дата оплаты, это реально не оплаченные счета*/

      AND i.InvoiceTypeID NOT IN('A1842931-DD32-4454-94AA-F6FB23938E43', '53E5C0C9-C08D-4325-94B3-9984D773830D')

    /*Не берем бонусные и бартерные счета*/

    AND i.InvoiceDate >= '2007-03-01'

    /*Не берем сомнительные счета, выставленные в процессе запуска биллинга сайта в начале 2007 г*/

    AND a.ClientSiteCode NOT IN(958982, 242942, 709998)

/*Не берем тестовые регистрации*/

AND i.PaymentOrderDate >= '2015-01-01';
GO
/****** Object:  Table [dbo].[TsRelationship]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TsRelationship](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[RelationTypeId] [uniqueidentifier] NULL,
	[ReverseRelationTypeId] [uniqueidentifier] NULL,
	[Active] [bit] NULL,
	[Description] [nvarchar](250) NULL,
	[AccountAId] [uniqueidentifier] NULL,
	[ContactAId] [uniqueidentifier] NULL,
	[AccountBId] [uniqueidentifier] NULL,
	[ContactBId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TsRelationType]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TsRelationType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[ForContactContact] [bit] NULL,
	[ForAccountContact] [bit] NULL,
	[ForContactAccount] [bit] NULL,
	[ForAccountAccount] [bit] NULL,
	[ReverseRelationTypeId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_TsRelationship]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_TsRelationship]
AS
SELECT        MIN(CreatedOn) AS CreatedOn, AccountIdSource, AccountIdDest, 'Выделенная регистрация' AS regtype, Active
FROM            (SELECT        MIN(CreatedOn) AS CreatedOn, AccountIdSource, AccountIdDest, 'Выделенная регистрация' AS regtype, Active
                          FROM            (SELECT DISTINCT
                                                                              r.CreatedOn, 'Исходная регистрация' AS regtype,
                                                                              CASE WHEN t1.Name = 'Исходная регистрация' THEN [AccountAId] WHEN t2.Name = 'Исходная регистрация' THEN [AccountBId] END AS AccountIdSource,
                                                                              CASE WHEN t1.Name = 'Исходная регистрация' THEN [AccountBId] WHEN t2.Name = 'Исходная регистрация' THEN [AccountAId] END AS AccountIdDest, r.Active
                                                    FROM            dbo.TsRelationship AS r LEFT OUTER JOIN
                                                                              dbo.TsRelationType AS t1 ON r.RelationTypeId = t1.Id LEFT OUTER JOIN
                                                                              dbo.TsRelationType AS t2 ON r.ReverseRelationTypeId = t2.Id
                                                    WHERE        (t1.Name = 'Исходная регистрация') OR
                                                                              (t2.Name = 'Исходная регистрация')
                                                    UNION
                                                    SELECT DISTINCT
                                                                             r.CreatedOn, 'Выделенная регистрация' AS regtype,
                                                                             CASE WHEN t1.Name = 'Выделенная регистрация' THEN [AccountBId] WHEN t2.Name = 'Выделенная регистрация' THEN [AccountAId] END AS AccountIdSource,
                                                                             CASE WHEN t1.Name = 'Выделенная регистрация' THEN [AccountAId] WHEN t2.Name = 'Выделенная регистрация' THEN [AccountBId] END AS AccountIdDest, r.Active
                                                    FROM            dbo.TsRelationship AS r LEFT OUTER JOIN
                                                                             dbo.TsRelationType AS t1 ON r.RelationTypeId = t1.Id LEFT OUTER JOIN
                                                                             dbo.TsRelationType AS t2 ON r.ReverseRelationTypeId = t2.Id
                                                    WHERE        (t1.Name = 'Выделенная регистрация') OR
                                                                             (t2.Name = 'Выделенная регистрация')) AS t
                          GROUP BY AccountIdDest, AccountIdSource, Active
                          UNION
                          SELECT DISTINCT
                                                   r.CreatedOn, CASE WHEN t1.Name = 'Исходная регистрация' THEN [AccountAId] WHEN t2.Name = 'Исходная регистрация' THEN [AccountBId] END AS AccountIdSource,
                                                   CASE WHEN t1.Name = 'Исходная регистрация' THEN [AccountAId] WHEN t2.Name = 'Исходная регистрация' THEN [AccountBId] END AS AccountIdDest, 'Исходная регистрация' AS regtype,
                                                   r.Active
                          FROM            dbo.TsRelationship AS r LEFT OUTER JOIN
                                                   dbo.TsRelationType AS t1 ON r.RelationTypeId = t1.Id LEFT OUTER JOIN
                                                   dbo.TsRelationType AS t2 ON r.ReverseRelationTypeId = t2.Id
                          WHERE        (t1.Name = 'Исходная регистрация') OR
                                                   (t2.Name = 'Исходная регистрация')) AS t2_1
GROUP BY AccountIdSource, AccountIdDest, regtype, Active
GO
/****** Object:  View [dbo].[OLAP-2271]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-2271]
AS
SELECT        TOP (100) PERCENT a.AccountName AS 'Название клиента', a.ClientSiteCode AS 'Код клиента на сайте',
                             (SELECT        SUM(PaymentAmountWithoutVAT) AS Expr1
                               FROM            dbo.Invoice AS i
                               WHERE        (PaymentStatusId IN ('698D39FD-52E6-DF11-971B-001D60E938C6', '03794BF5-52E6-DF11-971B-001D60E938C6', 'C225EB9F-3897-4B66-B381-78847A840E4F')) AND (YEAR(DueDate) = 2017) AND
                                                         (AccountId = a.ID)) AS 'Объем платежей за 2017 без НДС',
                             (SELECT        SUM(PaymentAmountWithoutVAT) AS Expr1
                               FROM            dbo.Invoice AS i
                               WHERE        (PaymentStatusId IN ('698D39FD-52E6-DF11-971B-001D60E938C6', '03794BF5-52E6-DF11-971B-001D60E938C6', 'C225EB9F-3897-4B66-B381-78847A840E4F')) AND (YEAR(DueDate) = 2017) AND
                                                         (AccountId = a.ID)) * 1.51 AS 'Цель 2018', CAST(e.CreatedOn AS date) AS 'Дата простановки мероприятия', inv.DueDate AS 'Дата оплаты счета ПОСЛЕ даты простановки меропритяия в CRM',
                         inv.PaymentAmountWithoutVAT AS 'Сумма оплаченного счета без НДС ПОСЛЕ даты простановки меропритяия в CRM', DATEDIFF(dd, CAST(e.CreatedOn AS date), GETDATE())
                         AS 'Количество полных дней, прошедших с даты простановки воздействия'
FROM            dbo.AccountDetail AS a INNER JOIN
                         dbo.EventTarget AS e ON a.ID = e.AccountId AND e.EventId = '66C3D0A4-8ED5-4F30-9970-1ACEC48CFBE4' LEFT OUTER JOIN
                         dbo.Invoice AS inv ON inv.AccountId = a.ID AND inv.DueDate > e.CreatedOn AND inv.PaymentStatusId IN ('698D39FD-52E6-DF11-971B-001D60E938C6', '03794BF5-52E6-DF11-971B-001D60E938C6',
                         'C225EB9F-3897-4B66-B381-78847A840E4F')
ORDER BY 'Код клиента на сайте', 'Дата оплаты счета ПОСЛЕ даты простановки меропритяия в CRM'
GO
/****** Object:  Table [dbo].[ActivityStatus]    Script Date: 29.03.2020 11:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityStatus](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Finish] [bit] NULL,
	[Code] [nvarchar](50) NULL,
	[ProcessListeners] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_LG_withCancel]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_LG_withCancel]
AS
SELECT        RANK() OVER (ORDER BY i.ID) ID, i.Number, cast(i.StartDate AS date) StartDate, cast(i.DueDate AS date) DueDate, CASE WHEN i.DueDate IS NULL THEN NULL ELSE i.AmountwithoutVAT END AmountwithoutVAT,
RANK() OVER (ORDER BY cte.ID) AS ActivityID, cast(cte.ActualEndDate AS date) AS ActivityDuedate, cte.Title AS ActivityTitle, cte.OwnerID, cte.ClientSiteCode AS ActivityAccountID, CASE WHEN i.DueDate IS NOT NULL
THEN 'Да' WHEN i.DueDate IS NULL AND i.ID IS NOT NULL THEN 'Нет' ELSE NULL END InvoiceIsPaid, CASE WHEN i.Number LIKE '%-Б/%' THEN 'Да' ELSE 'Нет' END InvoiceIsBonus, ActivityStatus
,Lag(cte.ActualEndDate) over (partition by cte.AccountID order by cte.ActualEndDate) lastActivityEndData
,Lag(ActivityStatus) over (partition by cte.AccountID order by cte.ActualEndDate) lastActivityStatus
FROM            CRMData750.dbo.Invoice i RIGHT JOIN
                             /*активности типа транзакционное обслуживание + поле NextActivityDate - дата активности следующей за текущей (или дата текущей +30 дней, если в течение 30 дней не было активности)*/ (SELECT        a.ID,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         cast(ActualEndDate
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         date)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ActualEndDate,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Title,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AccountID,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ac.ClientSiteCode,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         a.OwnerID,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         cast(CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         WHEN
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         LEAD(ActualEndDate)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         OVER
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         (PARTITION
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         BY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AccountID
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ORDER
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        BY
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ActualEndDate)
                          < DATEADD(dd, 30, ActualEndDate) THEN LEAD(ActualEndDate) OVER (PARTITION BY AccountID
ORDER BY ActualEndDate) ELSE DATEADD(dd, 30, ActualEndDate) END AS date) AS NextActivityDate, ast.Name ActivityStatus
FROM            (SELECT        ID, AccountId, Title, COALESCE (ActualEndDate, startdate) ActualEndDate, StatusId, OwnerID
                          FROM            CRMData750.dbo.Activity a
                          WHERE        a.ActivityCategoryID = '95C42028-EAD2-4B01-8D36-853D2FEAD2D9') a LEFT JOIN
                         CRMData750.dbo.Account ac ON a.AccountId = ac.ID LEFT JOIN
                         [dbo].[ActivityStatus] ast ON ast.Id = a.StatusId) cte ON i.AccountId = cte.AccountId AND i.StartDate >= cte.ActualEndDate AND i.StartDate < cte.NextActivityDate
--where ActivityStatus='Отменена'
GO
/****** Object:  Table [dbo].[TsQuestionaryChangeHistory]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TsQuestionaryChangeHistory](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[QuestionaryId] [uniqueidentifier] NULL,
	[ProcessingStatusId] [uniqueidentifier] NULL,
	[PostponedReasonId] [uniqueidentifier] NULL,
	[StatusChangeDate] [datetime2](7) NULL,
	[PostponeDate] [datetime2](7) NULL,
	[RecorderId] [uniqueidentifier] NULL,
	[Comment] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Questionary]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questionary](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[OwnershipId] [uniqueidentifier] NULL,
	[PrimaryContactId] [uniqueidentifier] NULL,
	[ParentId] [uniqueidentifier] NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[Code] [nvarchar](250) NULL,
	[TypeId] [uniqueidentifier] NULL,
	[Phone] [nvarchar](250) NULL,
	[AdditionalPhone] [nvarchar](250) NULL,
	[Fax] [nvarchar](250) NULL,
	[Web] [nvarchar](250) NULL,
	[AddressTypeId] [uniqueidentifier] NULL,
	[Address] [nvarchar](max) NULL,
	[CityId] [uniqueidentifier] NULL,
	[RegionId] [uniqueidentifier] NULL,
	[Zip] [nvarchar](50) NULL,
	[CountryId] [uniqueidentifier] NULL,
	[AccountCategoryId] [uniqueidentifier] NULL,
	[EmployeesNumberId] [uniqueidentifier] NULL,
	[AnnualRevenueId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NULL,
	[Logo] [varbinary](max) NULL,
	[AlternativeName] [nvarchar](250) NULL,
	[GPSN] [nvarchar](50) NULL,
	[GPSE] [nvarchar](50) NULL,
	[PriceListId] [uniqueidentifier] NULL,
	[UsrAccountBillboardId] [uniqueidentifier] NULL,
	[UsrAccountTelevisionId] [uniqueidentifier] NULL,
	[UsrAccountRadioId] [uniqueidentifier] NULL,
	[UsrAccountInternetAdvertId] [uniqueidentifier] NULL,
	[UsrAccountMediaId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidServKAId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidSiteId] [uniqueidentifier] NULL,
	[UsrAccountUseRunningLineId] [uniqueidentifier] NULL,
	[UsrAccountModulesMediaId] [uniqueidentifier] NULL,
	[UsrAccountAdvertAgency] [bit] NULL,
	[UsrAccountDistributor] [bit] NULL,
	[UsrAccountVendor] [bit] NULL,
	[UsrAccountIntegrator] [bit] NULL,
	[MarketingBudgetAvailabilityId] [uniqueidentifier] NULL,
	[RegistrationPlatformId] [uniqueidentifier] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[RecorderId] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RelationsLevelId] [uniqueidentifier] NULL,
	[ClientClassId] [uniqueidentifier] NULL,
	[RegistrationStateId] [uniqueidentifier] NULL,
	[RepeatRegistration] [bit] NULL,
	[ExistingAccountId] [uniqueidentifier] NULL,
	[InformationSourceId] [uniqueidentifier] NULL,
	[BudgetOnStaffAvailabilityId] [uniqueidentifier] NULL,
	[MonthId] [uniqueidentifier] NULL,
	[BudgetingTypeId] [uniqueidentifier] NULL,
	[ClientCategoryId] [uniqueidentifier] NULL,
	[HRQuantityId] [uniqueidentifier] NULL,
	[DisqualificationReasonId] [uniqueidentifier] NULL,
	[UseEDId] [uniqueidentifier] NULL,
	[ManagerVacanciesNumber] [int] NULL,
	[LastSynchronizationDate] [datetime2](7) NULL,
	[CommentED] [nvarchar](max) NULL,
	[ActivityContactId] [uniqueidentifier] NULL,
	[LastActivityDate] [datetime2](7) NULL,
	[LastInformationUpdateDate] [datetime2](7) NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[RegionHHId] [uniqueidentifier] NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[AccountAddToBlackList] [bit] NULL,
	[CBRating] [numeric](18, 2) NULL,
	[BadRegistrComment] [nvarchar](500) NULL,
	[URLHHru] [nvarchar](250) NULL,
	[URLHHua] [nvarchar](250) NULL,
	[URLHHby] [nvarchar](250) NULL,
	[PaymentAmountByYear] [numeric](18, 2) NULL,
	[PaymentAmountByHalfYear] [numeric](18, 2) NULL,
	[PaymentAmountByPreviousYear] [numeric](18, 2) NULL,
	[LastTaskDate] [datetime2](7) NULL,
	[LastTaskOwnerDate] [datetime2](7) NULL,
	[BaseDepthDate] [datetime2](7) NULL,
	[IsVirtualRegistration] [bit] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[SellerAccountID] [int] NULL,
	[LastTaskTypeId] [uniqueidentifier] NULL,
	[LastTaskOwnerId] [uniqueidentifier] NULL,
	[LastInvoicePaymentDate] [date] NULL,
	[PersonalAccountCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[PersonalAccountLockCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountLock] [numeric](18, 2) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ProcessingStatusId] [uniqueidentifier] NULL,
	[IsCorporateContact] [bit] NULL,
	[CorporateContact] [nvarchar](500) NULL,
	[IsEmail] [bit] NULL,
	[Email] [nvarchar](50) NULL,
	[IsPhone] [bit] NULL,
	[IsWeb] [bit] NULL,
	[INN] [nvarchar](50) NULL,
	[ApplicantJobId] [uniqueidentifier] NULL,
	[OpenVacancies] [nvarchar](250) NULL,
	[Comment] [nvarchar](max) NULL,
	[QuestionaryAccountId] [uniqueidentifier] NULL,
	[RecruitingStuffCount] [int] NULL,
	[PersonalAccountCurrencyRate] [numeric](18, 2) NULL,
	[PrimaryPersonalAccount] [numeric](18, 2) NULL,
	[PersonalAccountLockCurRate] [numeric](18, 2) NULL,
	[PrimaryPersonalAccountLock] [numeric](18, 2) NULL,
	[PreLoggerId] [uniqueidentifier] NULL,
	[PreLoggerDate] [datetime2](7) NULL,
	[PreLoggerStatusId] [uniqueidentifier] NULL,
	[ApplicantName] [nvarchar](250) NULL,
	[MlmScore] [numeric](18, 2) NULL,
	[IsHidden] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountReactionTime]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[AccountReactionTime]
AS
SELECT        t.Id, t.ClientSiteCode, t.CreationTime, t.StatusChangeDate, t.ReactionType, t.ReactionTime, t.RegistrationStateId, o.OwnerId
FROM            (SELECT        a.Id, a.ClientSiteCode, e.CreationTime, MIN(fr.StatusChangeDate) AS StatusChangeDate, CASE WHEN MIN(fr.StatusChangeDate) IS NULL THEN 'нет реакции' ELSE 'реакция' END AS ReactionType,
                                                    DATEDIFF(minute, e.CreationTime, MIN(fr.StatusChangeDate)) AS ReactionTime, a.RegistrationStateId
                          FROM            dbo.Account AS a LEFT OUTER JOIN
                                                        (SELECT        q.AccountId, DATEADD(minute, 180, qh.StatusChangeDate) AS StatusChangeDate
                                                          FROM            dbo.Questionary AS q LEFT OUTER JOIN
                                                                                    dbo.TsQuestionaryChangeHistory AS qh ON qh.QuestionaryId = q.Id
                                                          WHERE        (qh.StatusChangeDate IS NOT NULL)
                                                          UNION
                                                          SELECT        AccountId, DATEADD(minute, 180, StartDate) AS Expr1
                                                          FROM            dbo.Activity
                                                          UNION
                                                          SELECT        Id, DATEADD(minute, 180, AccountDateChangeTypeRegistr) AS Expr1
                                                          FROM            dbo.Account) AS fr ON a.Id = fr.AccountId LEFT OUTER JOIN
                                                    VacancySnapshot.dbo.Employer AS e ON a.ClientSiteCode = e.ID
                          GROUP BY a.Id, a.ClientSiteCode, e.CreationTime, a.RegistrationStateId) AS t LEFT OUTER JOIN
                             (SELECT        q.AccountId, qh.StatusChangeDate, qh.RecorderId AS OwnerId
                               FROM            dbo.Questionary AS q LEFT OUTER JOIN
                                                         dbo.TsQuestionaryChangeHistory AS qh ON qh.QuestionaryId = q.Id
                               WHERE        (qh.StatusChangeDate IS NOT NULL)
                               UNION
                               SELECT        AccountId, DATEADD(minute, 180, StartDate) AS Expr1, OwnerId
                               FROM            dbo.Activity AS Activity_1
                               UNION
                               SELECT        Id, DATEADD(minute, 180, AccountDateChangeTypeRegistr) AS Expr1, OwnerId
                               FROM            dbo.Account AS Account_1) AS o ON o.AccountId = t.Id AND t.StatusChangeDate = o.StatusChangeDate
GO
/****** Object:  View [dbo].[TopParentCountry]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopParentCountry] as

WITH RCTE AS
(
    SELECT  ParentId, Id, 1 AS Lvl FROM CRMData750.dbo.RegionHH

    UNION ALL

    SELECT rh.ParentId, rc.Id, Lvl+1 AS Lvl
    FROM CRMData750.dbo.RegionHH  rh
    INNER JOIN RCTE rc ON rh.Id = rc.ParentId
)
,CTE_RN AS
(
    SELECT *, ROW_NUMBER() OVER (PARTITION BY r.ID ORDER BY r.Lvl DESC) RN
    FROM RCTE r

)
SELECT r.Id, pc.Name AS ChildName, r.ParentId as TopParentId, pp.Name AS ParentName, RN
FROM CTE_RN r
INNER JOIN CRMData750.dbo.RegionHH  pp ON pp.id = r.ParentId
INNER JOIN CRMData750.dbo.RegionHH  pc ON pc.id = r.Id
WHERE RN =2
GO
/****** Object:  Table [dbo].[OpportunityInStage]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityInStage](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[StageId] [uniqueidentifier] NULL,
	[StartDate] [date] NULL,
	[DueDate] [date] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[Comments] [nvarchar](500) NULL,
	[ProcessListeners] [int] NULL,
	[Historical] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[LeadType]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[ImageId] [uniqueidentifier] NULL,
	[RecordInactive] [bit] NULL,
	[ActivityProductLookupId] [uniqueidentifier] NULL,
	[Hidden] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[OpportunityStage]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityStage](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[End] [bit] NULL,
	[Successful] [bit] NULL,
	[Number] [int] NULL,
	[ProcessListeners] [int] NULL,
	[MaxProbability] [int] NULL,
	[NextStepTerm] [int] NULL,
	[IsSelectAvailable] [bit] NULL,
	[ShowInFunnel] [bit] NULL,
	[Color] [nvarchar](50) NULL,
	[ShowInProgressBar] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[Id] [uniqueidentifier] NULL,
	[Title] [nvarchar](500) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[StageId] [uniqueidentifier] NULL,
	[DueDate] [datetime2](7) NULL,
	[CloseReasonId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[MoodId] [uniqueidentifier] NULL,
	[IsPrimary] [bit] NULL,
	[PartnerId] [uniqueidentifier] NULL,
	[Budget] [numeric](18, 2) NULL,
	[Probability] [int] NULL,
	[Amount] [numeric](18, 2) NULL,
	[SourceId] [uniqueidentifier] NULL,
	[ResponsibleDepartmentId] [uniqueidentifier] NULL,
	[Weaknesses] [nvarchar](500) NULL,
	[Strength] [nvarchar](500) NULL,
	[Tactic] [nvarchar](500) NULL,
	[CheckDate] [date] NULL,
	[ProcessId] [uniqueidentifier] NULL,
	[WinnerId] [uniqueidentifier] NULL,
	[LeadTypeId] [uniqueidentifier] NULL,
	[HHID] [int] NULL,
	[Number] [nvarchar](250) NULL,
	[OpportunityTypeOfSaleId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[AmountWithoutVAT] [numeric](18, 2) NULL,
	[RateVAT] [numeric](18, 2) NULL,
	[PrimaryBudget] [numeric](18, 2) NULL,
	[PrimaryAmount] [numeric](18, 2) NULL,
	[PrimaryAmountWithoutVAT] [numeric](18, 2) NULL,
	[NeedTypeId] [uniqueidentifier] NULL,
	[DiscountPercent] [int] NULL,
	[DiscountReasonId] [uniqueidentifier] NULL,
	[StartedDate] [date] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[Completeness] [int] NULL,
	[ByProcess] [bit] NULL,
	[Description] [nvarchar](max) NULL,
	[EventCode] [int] NULL,
	[NrbAmountByProbability] [numeric](18, 2) NULL
) ON [CRMData750_new] TEXTIMAGE_ON [CRMData750_new]
GO
/****** Object:  View [dbo].[olap-2534]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[olap-2534]
AS
SELECT
      ot.[CreatedOn]
	 ,ot.Name [LeadType]
	 ,s.Name Stage
  FROM [dbo].[OpportunityInStage] os
  left join (
    SELECT
	   o.Id
	   ,[Title]
	   ,o.[CreatedOn]
	   ,lt.Name
  FROM [dbo].[Opportunity] o
  left join [dbo].[LeadType] lt
  on o.LeadTypeId=lt.Id) ot
  on os.OpportunityId=ot.Id
  left join dbo.OpportunityStage s
  on s.Id=os.StageId
  where
  ot.Name like '%бренд%'
  union

select
[CREATED]
	 ,[LeadType]
	 , Stage
from

(
SELECT
[CREATED]
	 ,it.pname [LeadType]
	 ,'Задача в jira' Stage
	 ,ji.ID
	 ,
	 case
      when
			SUBSTRING([STRINGVALUE],CHARINDEX ('=',[STRINGVALUE])+1, len([STRINGVALUE])) like '%[0-9]%'
	  and	SUBSTRING([STRINGVALUE],CHARINDEX ('=',[STRINGVALUE])+1, len([STRINGVALUE])) not like '%[a-z]%'
	  and	SUBSTRING([STRINGVALUE],CHARINDEX ('=',[STRINGVALUE])+1, len([STRINGVALUE])) not like '%-%'
	  and	SUBSTRING([STRINGVALUE],CHARINDEX ('=',[STRINGVALUE])+1, len([STRINGVALUE])) not like '%,%'

			then SUBSTRING([STRINGVALUE],CHARINDEX ('=',[STRINGVALUE])+1, len([STRINGVALUE]))
	  when
			SUBSTRING([STRINGVALUE],CHARINDEX ('/employer/',[STRINGVALUE])+10, len([STRINGVALUE]))  like '%[0-9]%'
		and SUBSTRING([STRINGVALUE],CHARINDEX ('/employer/',[STRINGVALUE])+10, len([STRINGVALUE])) not like '%[a-z]%'
	    and SUBSTRING([STRINGVALUE],CHARINDEX ('/employer/',[STRINGVALUE])+10, len([STRINGVALUE])) not like '%-%'
		and SUBSTRING([STRINGVALUE],CHARINDEX ('/employer/',[STRINGVALUE])+10, len([STRINGVALUE])) not like '%,%'
			then    SUBSTRING([STRINGVALUE],CHARINDEX ('/employer/',[STRINGVALUE])+10, len([STRINGVALUE]))
	  end
	     as employer_id


  FROM [JIRAREP].[dbo].[jiraissue] ji
  left join JIRAREP.dbo.issuetype it
  on ji.issuetype=it.ID
  left join (SELECT [ISSUE]
      ,[STRINGVALUE]
  FROM [JIRAREP].[dbo].[customfieldvalue]
   where
  CUSTOMFIELD=11079) as cf
  on cf.[ISSUE]=ji.ID
  where ORIGINALKEY='ADVTEST'
  and it.pname  in  ('Брендированные письма, Брендированные страницы, Брендированные шаблоны вакансий'
,'Бренд.шаблоны вакансий'
,'Оптимал'
,'Простая'
,'Профессионал'
,'Эксклюзив')

) as t
inner join (   SELECT
	   a.ClientSiteCode
	   ,o.[CreatedOn]
  FROM [dbo].[Opportunity] o
  left join [dbo].[LeadType] lt
  on o.LeadTypeId=lt.Id
  left join dbo.Account a
  on a.Id=o.AccountId
  where
  lt.Name like '%бренд%'
  ) op
  on t.employer_id=cast(op.ClientSiteCode as nvarchar)
    and t.CREATED between op.CreatedOn and dateadd(day,30,op.CreatedOn)
  union

  SELECT
      [activation_time]
       ,p.Name
	  ,'Активация'

  FROM [ActivationAnalysisData].[dbo].[orders_all_cleansed]  o
  left join CommonData.dbo.Product_Flat p
  on o.code=p.ID
  inner join (   SELECT
	   a.ClientSiteCode
	   ,o.[CreatedOn]
  FROM [dbo].[Opportunity] o
  left join [dbo].[LeadType] lt
  on o.LeadTypeId=lt.Id
  left join dbo.Account a
  on a.Id=o.AccountId
  where
  lt.Name like '%бренд%'
  ) op
  on o.employer_id=op.ClientSiteCode
  and o.activation_time between op.CreatedOn and dateadd(day,30,op.CreatedOn)


  where p.Level3='WS_HH_BRANDED_PAGES'
  and p.Name !='Конструктор страниц работодателя'
GO
/****** Object:  Table [dbo].[AccountSnapshot]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountSnapshot](
	[SnapshotDate] [datetime] NULL,
	[ID] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationStateID] [uniqueidentifier] NULL,
	[AccountTypeID] [uniqueidentifier] NULL,
	[EmployeesNumberID] [uniqueidentifier] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[RegionID] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[RegionHHId] [uniqueidentifier] NULL
) ON [MonthPartitionScheme]([SnapshotDate])
GO
/****** Object:  View [dbo].[vw_AccountSnapshot_ChangeManager]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_AccountSnapshot_ChangeManager]
AS
SELECT SnapshotDate as ChangeDate, ID, OwnerID
from
(
	SELECT      SnapshotDate, ID, OwnerID, LAG(OwnerID) OVER(PARTITION BY ID ORDER BY SnapshotDate) PrevOwnerID
	FROM        dbo.AccountSnapshot
) t
where OwnerID!=PrevOwnerID
GO
/****** Object:  Table [dbo].[LeadCampaigns]    Script Date: 29.03.2020 11:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadCampaigns](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[LeadId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[SiteTypeId] [uniqueidentifier] NULL,
	[WebPage] [nvarchar](250) NOT NULL,
	[VacancyCompetitorQuantity] [int] NOT NULL,
	[VacancyQuantity] [int] NOT NULL,
	[VacancyQuantityUpdatedOn] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SiteType]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CodeForSite] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[account_on_competitors]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[account_on_competitors]
AS-- 2. account_on_competitors
SELECT lc.Id AS guid,
       lc.AccountId AS account_guid,
       a.ClientSiteCode AS employer_id,
       lc.ModifiedOn AS modified_on,
       st.Name AS competitor_name,
       lc.WebPage AS competitor_webpage
FROM dbo.LeadCampaigns AS lc
LEFT OUTER JOIN dbo.Account AS a ON a.Id = lc.AccountId
LEFT OUTER JOIN dbo.SiteType AS st ON lc.SiteTypeId = st.Id



GO
/****** Object:  Table [dbo].[EventResponse]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventResponse](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[event_participation]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[event_participation]
AS
-- 1. event_participation
SELECT e.Id AS guid,
       e.CreatedOn AS created_on,
       e.CreatedById AS created_by_guid,
       e.ModifiedOn AS modified_on,
       e.ModifiedById as modified_by_guid,
       e.ProcessListeners AS process_listeners,
       e.EventId AS event_guid,
       er.Name AS event_response,
       e.Note as note,
       e.IsFromGroup as is_from_group,
       e.ContactId AS contact_guid,
       e.TargetItem AS target_item,
       e.AccountId as account_guid,
       a.ClientSiteCode AS employer_id
FROM dbo.EventTarget AS e
       LEFT OUTER JOIN dbo.Account AS a ON e.AccountId = a.Id
       LEFT OUTER JOIN dbo.EventResponse AS er ON e.EventResponseId = er.Id


GO
/****** Object:  View [dbo].[vw_OLAP-2625]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_OLAP-2625]
AS
SELECT        opp.DueDateMonth, opp.Department, opp.Department AS Expr1, opp.Amount, opp.Weighted_sum, pay.FactSum, pay.[Plan], pay.DEV
FROM            (SELECT        eomonth(o.DueDate) AS DueDateMonth, c.Name AS Manager, cd.Name AS Department, c.CodeForSite, SUM(o.Amount) AS Amount, SUM(o.Amount * CAST(o.Probability AS float) / 100) AS Weighted_sum
                          FROM            dbo.Opportunity AS o LEFT OUTER JOIN
                                                    dbo.Contact AS c ON o.OwnerId = c.ID LEFT OUTER JOIN
                                                    dbo.ContactDepartment AS cd ON c.ContactDepartmentID = cd.Id
                          GROUP BY eomonth(o.DueDate), c.Name, cd.Name, c.CodeForSite) AS opp LEFT OUTER JOIN
                             (SELECT        m.PeriodMonth, m.ObjectCode, oe.CodeForSite, m.FactSum, k.Size AS [Plan], m.FactSum / k.Size AS DEV
                               FROM            (SELECT        eomonth(Period) AS PeriodMonth, ObjectCode, SUM(Sum) AS FactSum
                                                         FROM            SalesPlanFact_30.dbo.ManagerSale_Bonus_20
                                                         GROUP BY eomonth(Period), ObjectCode) AS m LEFT OUTER JOIN
                                                             (SELECT        eomonth(Period) AS PeriodMonthK, IDSotr, Size
                                                               FROM            SalesPlanFact_30.dbo.Kvota_20
                                                               WHERE        (IDSotr IS NOT NULL) AND (Type = 'Месяц') AND (_Description IS NULL)) AS k ON k.IDSotr = m.ObjectCode AND k.PeriodMonthK = m.PeriodMonth LEFT OUTER JOIN
                                                             (SELECT DISTINCT SotrCode, CodeForSite
                                                               FROM            SalesPlanFact_30.dbo.OrganizationEmployees
                                                               WHERE        (CodeForSite <> '')) AS oe ON oe.SotrCode = m.ObjectCode) AS pay ON pay.PeriodMonth = opp.DueDateMonth AND pay.CodeForSite = opp.CodeForSite
GO
/****** Object:  View [dbo].[OLAP_2782_OpportunityPredict]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[OLAP_2782_OpportunityPredict]
AS
SELECT        o.AccountId, CAST(o.DueDate AS DATE) AS DueDate, o.Probability, o.Amount, o.Probability * o.PrimaryAmountWithoutVAT / 100 AS AmountProb, DiscountPercent,
                         o.Probability * o.PrimaryAmountWithoutVAT / 100 * DiscountPercent / 100 AS Discount, c.CodeForSite, oe.ID AS s_id, os.[End]
FROM            dbo.Opportunity AS o LEFT OUTER JOIN
                         dbo.Account AS a ON o.AccountId = a.Id LEFT OUTER JOIN
                         dbo.Contact AS c ON c.ID = a.OwnerId LEFT OUTER JOIN
                         SalesPlanFact_30.dbo.OrganizationEmployeesForCube AS oe ON oe.CodeForSite = c.CodeForSite AND GETDATE() >= oe.StartDate AND GETDATE() < oe.EndDate LEFT OUTER JOIN
                         dbo.OpportunityStage AS os ON os.Id = o.StageId
WHERE        (o.DueDate <=
                             (SELECT        MAX(PK_Date) AS Expr1
                               FROM            CommonData.dbo.Time)) OR
                         (o.DueDate IS NULL)
GO
/****** Object:  Table [dbo].[ActivityCategory]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityCategory](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[ActivityTypeId] [uniqueidentifier] NULL,
	[HHID] [int] NULL,
	[IsOwnerByAccount] [bit] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[IsBaseDepth] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OLAP_2782_Activity_by_type]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Activity_by_type]
AS
SELECT        a.Id, CAST(a.StartDate AS date) AS StartDate, a.DueDate, a.AccountId, ac.Name AS ActivityCategory, oe.ID AS s_id
FROM            dbo.Activity AS a LEFT OUTER JOIN
                         dbo.ActivityCategory AS ac ON ac.Id = a.ActivityCategoryId LEFT OUTER JOIN
                         dbo.Contact AS c ON c.ID = a.OwnerId LEFT OUTER JOIN
                             (SELECT        ID, Organization, SotrName, SotrCode, DivisionCode, ParentDivision, Post, RecruitmentEvent, StartDate, EndDate, CodeForSite
                               FROM            SalesPlanFact_30.dbo.OrganizationEmployeesForCube
                               WHERE        (CodeForSite <> 0)) AS oe ON oe.CodeForSite = c.CodeForSite AND a.StartDate BETWEEN oe.StartDate AND DATEADD(day, - 1, oe.EndDate)
WHERE        (CAST(a.StartDate AS date) <= '2020-01-01') AND (CAST(a.StartDate AS date) >= '2000-01-01')
GO
/****** Object:  View [dbo].[OLAP_2782_Account_without_opportunity]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Account_without_opportunity]
AS

SELECT a.[Id]
      ,oe.ID as s_id
  FROM [CRMData750].[dbo].[Account] a
  left join (
  (SELECT [AccountId]
FROM [CRMData750].[dbo].[Opportunity]
  where
  getdate() between [StartedDate] and coalesce(DueDate, getdate()+1)
  or
  getdate() < [StartedDate] )) as o
  on o.AccountId=a.Id
 left join CRMData750.dbo.Contact c
 on a.OwnerId = c.ID
 left join (SELECT  [ID]
      ,[Organization]
      ,[SotrName]
      ,[SotrCode]
      ,[DivisionCode]
      ,[ParentDivision]
      ,[Post]
      ,[RecruitmentEvent]
      ,[StartDate]
      ,[EndDate]
      ,[CodeForSite]
  FROM [SalesPlanFact_30].[dbo].[OrganizationEmployeesForCube]
  where [CodeForSite]!=0) oe
  on oe.CodeForSite=c.CodeForSite
  and getdate() between oe.StartDate and oe.EndDate

 where
  RegistrationStateId not in ('C4766DB3-FC74-427B-B51A-066F3E05F530','E9C7E0FC-5E0A-4B79-86D0-43C25A7B04D7')
 and o.AccountId is null


GO
/****** Object:  View [dbo].[OLAP_2782_Calls]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Calls]
AS
SELECT        cal.uuid, cal.[user], CAST(cal.stti AS date) AS stti, cal.calltype, oe.ID AS s_id
FROM            CDR.dbo.vw_Calls AS cal LEFT OUTER JOIN
                             (SELECT        REPLACE(Email, '@hh.ru', '') AS ulogin, CodeForSite
                               FROM            dbo.Contact
                               WHERE        (Email LIKE '%@hh.ru') AND (CodeForSite <> 0) AND (Phone <> '')) AS c ON cal.[user] = c.ulogin LEFT OUTER JOIN
                             (SELECT        ID, Organization, SotrName, SotrCode, DivisionCode, ParentDivision, Post, RecruitmentEvent, StartDate, EndDate, CodeForSite
                               FROM            SalesPlanFact_30.dbo.OrganizationEmployeesForCube
                               WHERE        (CodeForSite <> 0)) AS oe ON oe.CodeForSite = c.CodeForSite AND cal.stti BETWEEN oe.StartDate AND DATEADD(day, - 1, oe.EndDate)
GO
/****** Object:  View [dbo].[OLAP_2782_Churn]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP_2782_Churn]
AS
SELECT        o.employer_id, oe.ID AS s_id, CASE WHEN GETDATE() BETWEEN o.activation_time AND o.expiration_time OR
                         GETDATE() <= o.activation_time THEN 'не отток' ELSE 'отток' END AS Churn
FROM            ActivationAnalysisData.dbo.orders_all_cleansed AS o INNER JOIN
                             (SELECT        employer_id, MAX(employer_service_id) AS es_max
                               FROM            ActivationAnalysisData.dbo.orders_all_cleansed
                               WHERE        (code LIKE 'FA%') AND (original_cnt >= '30') AND (seller_account_id = 1)
                               GROUP BY employer_id) AS m ON m.es_max = o.employer_service_id LEFT OUTER JOIN
                         dbo.Account AS a ON a.ClientSiteCode = o.employer_id LEFT OUTER JOIN
                         dbo.Contact AS c ON c.ID = a.OwnerId LEFT OUTER JOIN
                             (SELECT        ID, Organization, SotrName, SotrCode, DivisionCode, ParentDivision, Post, RecruitmentEvent, StartDate, EndDate, CodeForSite
                               FROM            SalesPlanFact_30.dbo.OrganizationEmployeesForCube
                               WHERE        (CodeForSite <> 0)) AS oe ON oe.CodeForSite = c.CodeForSite AND GETDATE() BETWEEN oe.StartDate AND oe.EndDate
GO
/****** Object:  Table [dbo].[_DatePairs]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_DatePairs](
	[FirstDate] [date] NULL,
	[SecondDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_EmployerChanges]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_EmployerChanges](
	[Date1] [date] NULL,
	[Date2] [date] NULL,
	[ID] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[RegistrationDate] [date] NULL,
	[AccountState1] [uniqueidentifier] NULL,
	[AccountState2] [uniqueidentifier] NULL,
	[AccountType1] [uniqueidentifier] NULL,
	[AccountType2] [uniqueidentifier] NULL,
	[EmployeesNumber1] [uniqueidentifier] NULL,
	[EmployeesNumber2] [uniqueidentifier] NULL,
	[Field1] [int] NULL,
	[Field2] [int] NULL,
	[State1] [uniqueidentifier] NULL,
	[State2] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[_EmployerChangesTwoWay]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_EmployerChangesTwoWay](
	[CurrDate] [date] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[RegistrationDate] [date] NULL,
	[AccountStateID] [uniqueidentifier] NULL,
	[AccountStateIDCorr] [uniqueidentifier] NULL,
	[AccountTypeID] [uniqueidentifier] NULL,
	[AccountTypeIDCorr] [uniqueidentifier] NULL,
	[EmployeesNumberID] [uniqueidentifier] NULL,
	[EmployeesNumberIDCorr] [uniqueidentifier] NULL,
	[FieldID] [int] NULL,
	[FieldIDCorr] [int] NULL,
	[StateID] [uniqueidentifier] NULL,
	[StateIDCorr] [uniqueidentifier] NULL,
	[Flow] [int] NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[_EmployerCountGroup]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_EmployerCountGroup](
	[Name] [nvarchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[BigGroupName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account_NewRegistaration]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_NewRegistaration](
	[ID] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationDate] [date] NULL,
	[region_group] [varchar](250) NULL,
	[pay] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[account_pays]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_pays](
	[client_site_code] [int] NULL,
	[sum_last_year] [numeric](38, 2) NULL,
	[sum365] [numeric](38, 2) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Account_today]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_today](
	[Id] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationStateId] [uniqueidentifier] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[EmployeesNumberId] [uniqueidentifier] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[RegionId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[RegistrationPlatformId] [uniqueidentifier] NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[RegistrationDate] [date] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[PrimaryContactId] [uniqueidentifier] NULL,
	[SellerAccountID] [int] NULL,
	[RegionHHId] [uniqueidentifier] NULL,
	[ClientCategoryId] [uniqueidentifier] NULL,
	[LastInvoicePaymentDate] [date] NULL,
	[RecorderId] [uniqueidentifier] NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[Phone] [nvarchar](250) NULL,
	[Web] [nvarchar](250) NULL,
	[DisqualificationReasonId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountBillingInfo]    Script Date: 29.03.2020 11:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountBillingInfo](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[BillingInfo] [nvarchar](max) NULL,
	[ProcessListeners] [int] NULL,
	[AccountManagerId] [uniqueidentifier] NULL,
	[ChiefAccountantId] [uniqueidentifier] NULL,
	[LegalAddress] [nvarchar](500) NULL,
	[Bank] [nvarchar](250) NULL,
	[AccountNumber] [nvarchar](250) NULL,
	[BankAccountNumber] [nvarchar](250) NULL,
	[CorAccountNumber] [nvarchar](250) NULL,
	[INN] [nvarchar](250) NULL,
	[KPP] [nvarchar](250) NULL,
	[InBank] [nvarchar](250) NULL,
	[OKPO] [nvarchar](250) NULL,
	[PersonalAccount] [nvarchar](250) NULL,
	[PersonFirstName] [nvarchar](250) NULL,
	[PersonLastName] [nvarchar](250) NULL,
	[PersonMiddleName] [nvarchar](250) NULL,
	[PassportNumber] [nvarchar](250) NULL,
	[PassportSerial] [nvarchar](250) NULL,
	[Giver] [nvarchar](500) NULL,
	[OGRN] [nvarchar](250) NULL,
	[WhenGiven] [date] NULL,
	[OGRNSerial] [nvarchar](250) NULL,
	[OGRNNumber] [nvarchar](250) NULL,
	[OGRNGiver] [nvarchar](250) NULL,
	[OGRNWhenGiven] [date] NULL,
	[PayerTypeId] [uniqueidentifier] NULL,
	[Code] [int] NULL,
	[IsDisabled] [bit] NULL,
	[SettlementAccountNumber] [nvarchar](250) NULL,
	[LegalUnit] [nvarchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountDetail_prob_mlm]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountDetail_prob_mlm](
	[ClientSiteCode] [int] NULL,
	[RegistrationDate] [date] NULL,
	[AccountName] [nvarchar](250) NULL,
	[RegistrationState] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[AccountType] [nvarchar](250) NULL,
	[EmployeesNumber] [nvarchar](250) NULL,
	[Region] [nvarchar](250) NULL,
	[SellerAccount] [nvarchar](50) NULL,
	[PrimaryContactID] [uniqueidentifier] NULL,
	[JobTitle] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[c_Phone] [nvarchar](250) NULL,
	[a_Phone] [nvarchar](250) NULL,
	[Web] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountInTag]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountInTag](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[TagId] [uniqueidentifier] NULL,
	[EntityId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountOwnerHistory]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountOwnerHistory](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[OldOwnerId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountOwnership]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountOwnership](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[CountryId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Code] [nvarchar](250) NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountSnapshot_ChangeManager]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountSnapshot_ChangeManager](
	[ChangeDate] [date] NULL,
	[ID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountSnapshot_MonthDistinct]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountSnapshot_MonthDistinct](
	[SnapshotDateMonth] [datetime] NULL,
	[ID] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RegistrationStateID] [uniqueidentifier] NULL,
	[AccountTypeID] [uniqueidentifier] NULL,
	[EmployeesNumberID] [uniqueidentifier] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[RegionID] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL
) ON [MonthPartitionScheme]([SnapshotDateMonth])
GO
/****** Object:  Table [dbo].[AccountSnapshot_MonthDistinct_group]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountSnapshot_MonthDistinct_group](
	[SnapshotDateMonth] [datetime] NULL,
	[Department] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NULL,
	[AccountCnt] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[AccountTag]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTag](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ActivityInTag]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityInTag](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[TagId] [uniqueidentifier] NULL,
	[EntityId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ActivityPirates]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityPirates](
	[Id] [uniqueidentifier] NULL,
	[Title] [nvarchar](500) NULL,
	[StartDate] [datetime2](7) NULL,
	[DueDate] [datetime2](7) NULL,
	[PriorityId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[DocumentId] [uniqueidentifier] NULL,
	[InvoiceId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[ResultId] [uniqueidentifier] NULL,
	[DetailedResult] [nvarchar](max) NULL,
	[ShowInScheduler] [bit] NULL,
	[RemindToAuthor] [bit] NULL,
	[RemindToOwner] [bit] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ActualStartDate] [datetime2](7) NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ActivityEquivalentCalls] [int] NULL,
	[HHID] [int] NULL,
	[HHCreationTime] [datetime2](7) NULL,
	[ActivityCategoryId] [uniqueidentifier] NULL,
	[ActualEndDate] [datetime2](7) NULL,
	[IsFromExcel] [bit] NULL,
	[ExcelDetails] [nvarchar](500) NULL,
	[AuthorId] [uniqueidentifier] NULL,
	[EscalationLevel] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityProduct]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityProduct](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[ActivityId] [uniqueidentifier] NULL,
	[IsIncluded] [bit] NULL,
	[ProductId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityProductGroup]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityProductGroup](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityProductLookup]    Script Date: 29.03.2020 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityProductLookup](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[ProductGroupId] [uniqueidentifier] NULL,
	[IsDefault] [bit] NULL,
	[Position] [int] NULL,
	[StateId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityProductLookupState]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityProductLookupState](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityResult]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityResult](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[BusinessProcessOnly] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityTag]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityTag](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[TypeId] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ActivityType]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Code] [nvarchar](50) NULL,
	[ProcessListeners] [int] NULL,
	[TypeImage] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALL_Calls_from_sql6msk]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALL_Calls_from_sql6msk](
	[Тип звонка] [int] NULL,
	[Год звонка] [int] NULL,
	[Месяц звонка] [int] NULL,
	[День звонка] [int] NULL,
	[Час звонка] [int] NULL,
	[Минута звонка] [int] NULL,
	[Телефон менеджера] [nvarchar](4000) NULL,
	[Телефон клиента] [nvarchar](4000) NULL,
	[Длительность часы] [int] NULL,
	[Длительность минуты] [int] NULL,
	[Длительность секунды] [int] NULL,
	[Дата звонка] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlockedEmployerByRobot]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockedEmployerByRobot](
	[EmloyerId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calendar]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calendar](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[TimeZoneId] [uniqueidentifier] NULL,
	[Depth] [int] NOT NULL,
	[ContactId] [uniqueidentifier] NULL,
	[AroundClock] [bit] NULL,
	[WithoutDayOff] [bit] NULL,
	[UserId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[CalendarForPeriod]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CalendarForPeriod](
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
	[WeekDay] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Call]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Call](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[StartDate] [datetime2](3) NULL,
	[EndDate] [datetime2](3) NULL,
	[Duration] [int] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ResultId] [uniqueidentifier] NULL,
	[LinkToFile] [nvarchar](250) NULL,
	[ownerid] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ClientSubscription_Aggregated]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_Aggregated](
	[ReportingDate] [date] NULL,
	[Department] [varchar](100) NULL,
	[Manager] [varchar](100) NULL,
	[Cnt] [int] NULL,
	[Code] [varchar](50) NULL,
	[RegionGroup] [varchar](150) NULL,
	[ServiceDescription] [varchar](2000) NULL,
	[EmployerCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSubscription_Detailed]    Script Date: 29.03.2020 11:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_Detailed](
	[ReportingDate] [datetime] NOT NULL,
	[EmployerID] [int] NULL,
	[EmployerName] [nvarchar](263) NOT NULL,
	[Department] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL,
	[ServiceID] [float] NULL,
	[ServiceName] [nvarchar](2000) NULL,
	[ServiceDescription] [nvarchar](max) NULL,
	[Cnt] [float] NOT NULL,
	[Code] [varchar](50) NULL,
	[RegionGroup] [varchar](39) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSubscription_Employers]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_Employers](
	[ReportingDate] [datetime] NOT NULL,
	[EmployerID] [int] NULL,
	[EmployerName] [nvarchar](263) NOT NULL,
	[Department] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSubscription_ReportingDates]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_ReportingDates](
	[ReportingDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSubscription_Service]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_Service](
	[employer_id] [float] NULL,
	[employer_service_id] [float] NULL,
	[service_id] [float] NULL,
	[service_name] [nvarchar](2000) NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[code] [varchar](50) NULL,
	[cnt] [float] NULL,
	[service_description] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSubscription_ServiceRaw]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSubscription_ServiceRaw](
	[employer_id] [float] NULL,
	[employer_service_id] [float] NULL,
	[service_id] [float] NULL,
	[service_name] [nvarchar](2000) NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[code] [varchar](50) NULL,
	[cnt] [float] NULL,
	[region_id] [nvarchar](50) NULL,
	[region_name] [nvarchar](255) NULL,
	[profarea_id] [nvarchar](50) NULL,
	[profarea_name] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Communication]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Communication](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Code] [nvarchar](50) NULL,
	[ProcessListeners] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommunicationType]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommunicationType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [varbinary](max) NULL,
	[HyperlinkTemplate] [nvarchar](250) NULL,
	[UseforAccounts] [bit] NULL,
	[UseforContacts] [bit] NULL,
	[ProcessListeners] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact_today]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact_today](
	[ModifiedOn] [datetime2](3) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[Name] [nvarchar](250) NULL,
	[Phone] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[CodeForSite] [int] NULL,
	[IsDelete] [bit] NULL,
	[SKS] [bit] NULL,
	[MainPhone] [nvarchar](250) NULL,
	[USERID] [int] NULL,
	[Id] [uniqueidentifier] NULL,
	[Description] [nvarchar](250) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[Dear] [nvarchar](250) NULL,
	[SalutationTypeId] [uniqueidentifier] NULL,
	[GenderId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[DecisionRoleId] [uniqueidentifier] NULL,
	[JobId] [uniqueidentifier] NULL,
	[JobTitle] [nvarchar](250) NULL,
	[DepartmentId] [uniqueidentifier] NULL,
	[BirthDate] [date] NULL,
	[MobilePhone] [nvarchar](250) NULL,
	[HomePhone] [nvarchar](250) NULL,
	[Skype] [nvarchar](250) NULL,
	[Address] [nvarchar](max) NULL,
	[CityId] [uniqueidentifier] NULL,
	[RegionId] [uniqueidentifier] NULL,
	[Zip] [nvarchar](50) NULL,
	[CountryId] [uniqueidentifier] NULL,
	[DoNotUseEmail] [bit] NULL,
	[DoNotUseCall] [bit] NULL,
	[DoNotUseFax] [bit] NULL,
	[DoNotUseSms] [bit] NULL,
	[DoNotUseMail] [bit] NULL,
	[Notes] [nvarchar](max) NULL,
	[TypeId] [uniqueidentifier] NULL,
	[AddressTypeId] [uniqueidentifier] NULL,
	[Facebook] [nvarchar](250) NULL,
	[LinkedIn] [nvarchar](250) NULL,
	[Twitter] [nvarchar](250) NULL,
	[FacebookId] [nvarchar](250) NULL,
	[LinkedInId] [nvarchar](250) NULL,
	[TwitterId] [nvarchar](250) NULL,
	[ContactPhoto] [varbinary](max) NULL,
	[TwitterAFDAId] [uniqueidentifier] NULL,
	[FacebookAFDAId] [uniqueidentifier] NULL,
	[LinkedInAFDAId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[PhotoId] [uniqueidentifier] NULL,
	[GPSN] [nvarchar](50) NULL,
	[GPSE] [nvarchar](50) NULL,
	[Surname] [nvarchar](250) NULL,
	[GivenName] [nvarchar](250) NULL,
	[MiddleName] [nvarchar](250) NULL,
	[Confirmed] [bit] NULL,
	[CallEquivalentTypeId] [uniqueidentifier] NULL,
	[ContactDepartmentId] [uniqueidentifier] NULL,
	[GKL] [bit] NULL,
	[SalesCountryId] [uniqueidentifier] NULL,
	[AreaId] [uniqueidentifier] NULL,
	[LastSynchroDate] [datetime2](7) NULL,
	[HHID] [int] NULL,
	[UsrLivetexLogin] [nvarchar](250) NULL,
	[DoNotUseAutoCall] [bit] NULL,
	[NrbIsOnline] [bit] NULL,
	[Completeness] [int] NULL,
	[LanguageId] [uniqueidentifier] NULL,
	[LastSiteActivityDate] [date] NULL,
	[AgreeForRecord] [bit] NULL,
	[EmployeeId] [uniqueidentifier] NULL
) ON [CRMData750_new] TEXTIMAGE_ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Contact_today_del]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact_today_del](
	[ModifiedOn] [datetime2](3) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[Name] [nvarchar](250) NULL,
	[Phone] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[CodeForSite] [int] NULL,
	[IsDelete] [bit] NULL,
	[SKS] [bit] NULL,
	[ID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[GenderID] [uniqueidentifier] NULL,
	[MainPhone] [nvarchar](250) NULL,
	[UserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactChanges2]    Script Date: 29.03.2020 11:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactChanges2](
	[ID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[ChangeDt] [datetime] NULL,
	[SID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ContactChanges] PRIMARY KEY CLUSTERED
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactCommunication]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactCommunication](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[CommunicationTypeId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[Position] [int] NULL,
	[SocialMediaId] [nvarchar](250) NULL,
	[SearchNumber] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Number] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactEventLog]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactEventLog](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[Code] [int] NOT NULL,
	[Date] [datetime2](7) NULL,
	[EventTypeId] [uniqueidentifier] NULL,
	[IsSystem] [bit] NOT NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[Quantity] [int] NOT NULL,
	[EventNotificationTime] [datetime2](7) NULL,
	[EventEndTime] [datetime2](7) NULL,
	[LinkedEventId] [int] NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ContactLeaders]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactLeaders](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[ContactId] [uniqueidentifier] NULL,
	[LeaderId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactTest]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTest](
	[ModifiedOn] [datetime2](3) NULL,
	[CreatedOn] [datetime2](3) NULL,
	[Name] [nvarchar](250) NULL,
	[Phone] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[CodeForSite] [int] NULL,
	[IsDelete] [bit] NULL,
	[SKS] [bit] NULL,
	[ID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[GenderID] [uniqueidentifier] NULL,
	[JobTitle] [nvarchar](250) NULL,
	[MainPhone] [nvarchar](250) NULL,
	[UserID] [int] NULL,
	[HHID] [int] NULL,
	[DepartmentID] [uniqueidentifier] NULL,
	[gkl] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[Code] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contract]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contract](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Number] [nvarchar](250) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[StateId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[SupplierBillingInfoId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[CustomerBillingInfoId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NULL,
	[ParentId] [uniqueidentifier] NULL,
	[OurCompanyId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CurrencyRate] [numeric](18, 2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[PrimaryAmount] [numeric](18, 2) NULL,
	[OrderId] [uniqueidentifier] NULL,
	[UsrContractName] [nvarchar](500) NULL,
	[UsrSiteCode] [int] NULL,
	[UsrNote] [nvarchar](500) NULL,
	[UsrClientSiteCode] [int] NULL,
	[UsrContractLimitationId] [uniqueidentifier] NULL,
	[UsrOriginalExistance] [bit] NULL,
	[UsrInterStandings] [bit] NULL,
	[UsrOwnerChainKnown] [bit] NULL,
	[UsrComplexContract] [bit] NULL,
	[UsrContractKindId] [uniqueidentifier] NULL,
	[UsrLanguageId] [uniqueidentifier] NULL,
	[UsrUtensilsId] [uniqueidentifier] NULL,
	[UsrSignatoryId] [uniqueidentifier] NULL,
	[UsrWarmthId] [uniqueidentifier] NULL,
	[UsrActPayments] [int] NULL,
	[UsrFrequencyId] [uniqueidentifier] NULL,
	[UsrPaymentDate] [date] NULL,
	[UsrFileLink] [nvarchar](250) NULL,
	[UsrWrongWay] [bit] NULL,
	[UsrSendFileToClient] [bit] NULL,
	[UsrFileIsNeedToUpdate] [bit] NULL,
	[UsrRecordType] [int] NULL,
	[ID1C] [uniqueidentifier] NULL,
	[IntegerNumber] [int] NULL,
	[ContactSubscriberId] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContractState]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContractState](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Position] [int] NOT NULL,
	[CodeForSite] [int] NOT NULL,
	[SendChangesToSite] [bit] NOT NULL,
	[Start] [bit] NOT NULL,
	[Finish] [bit] NOT NULL,
	[NotActual] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContractType]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContractType](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[IsSlave] [bit] NULL,
	[CodeForSite] [int] NULL,
	[Litera] [nvarchar](50) NULL,
	[NotActive] [bit] NULL,
	[Position] [int] NULL,
	[IsContactSubscriberRequired] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContractVisa]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContractVisa](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Objective] [nvarchar](max) NOT NULL,
	[VisaOwnerId] [uniqueidentifier] NULL,
	[IsAllowedToDelegate] [bit] NOT NULL,
	[DelegatedFromId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[SetById] [uniqueidentifier] NULL,
	[SetDate] [datetime2](7) NULL,
	[IsCanceled] [bit] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[ContractId] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ShortName] [nvarchar](50) NULL,
	[Symbol] [nvarchar](50) NULL,
	[RecalcDirection] [int] NULL,
	[Division] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[ProcessListeners] [int] NULL,
	[CurrecySymbolPosition] [int] NULL,
	[CodeMDS] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DayInCalendar]    Script Date: 29.03.2020 11:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DayInCalendar](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[DayOfWeekId] [uniqueidentifier] NULL,
	[DayTypeId] [uniqueidentifier] NULL,
	[Date] [date] NULL,
	[CalendarId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[DayOfWeek]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DayOfWeek](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[Number] [int] NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[DaysOffVisaDurationReport]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaysOffVisaDurationReport](
	[Date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DayType]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DayType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[Color] [nvarchar](250) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
	[NonWorking] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[DEL_Account_all_col]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Account_all_col](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[OwnershipId] [uniqueidentifier] NULL,
	[PrimaryContactId] [uniqueidentifier] NULL,
	[ParentId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[Code] [nvarchar](250) NULL,
	[TypeId] [uniqueidentifier] NULL,
	[Phone] [nvarchar](250) NULL,
	[AdditionalPhone] [nvarchar](250) NULL,
	[Fax] [nvarchar](250) NULL,
	[Web] [nvarchar](250) NULL,
	[AddressTypeId] [uniqueidentifier] NULL,
	[Address] [nvarchar](max) NULL,
	[CityId] [uniqueidentifier] NULL,
	[RegionId] [uniqueidentifier] NULL,
	[Zip] [nvarchar](50) NULL,
	[CountryId] [uniqueidentifier] NULL,
	[AccountCategoryId] [uniqueidentifier] NULL,
	[EmployeesNumberId] [uniqueidentifier] NULL,
	[AnnualRevenueId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NULL,
	[Logo] [varbinary](max) NULL,
	[AlternativeName] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[GPSN] [nvarchar](50) NULL,
	[GPSE] [nvarchar](50) NULL,
	[PriceListId] [uniqueidentifier] NULL,
	[UsrAccountBillboardId] [uniqueidentifier] NULL,
	[UsrAccountTelevisionId] [uniqueidentifier] NULL,
	[UsrAccountRadioId] [uniqueidentifier] NULL,
	[UsrAccountInternetAdvertId] [uniqueidentifier] NULL,
	[UsrAccountMediaId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidServKAId] [uniqueidentifier] NULL,
	[UsrAccountUsePaidSiteId] [uniqueidentifier] NULL,
	[UsrAccountUseRunningLineId] [uniqueidentifier] NULL,
	[UsrAccountModulesMediaId] [uniqueidentifier] NULL,
	[UsrAccountAdvertAgency] [bit] NULL,
	[UsrAccountDistributor] [bit] NULL,
	[UsrAccountVendor] [bit] NULL,
	[UsrAccountIntegrator] [bit] NULL,
	[MarketingBudgetAvailabilityId] [uniqueidentifier] NULL,
	[RegistrationPlatformId] [uniqueidentifier] NULL,
	[RegistrationSiteId] [uniqueidentifier] NULL,
	[RecorderId] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[RelationsLevelId] [uniqueidentifier] NULL,
	[ClientClassId] [uniqueidentifier] NULL,
	[RegistrationStateId] [uniqueidentifier] NULL,
	[RepeatRegistration] [bit] NULL,
	[ExistingAccountId] [uniqueidentifier] NULL,
	[InformationSourceId] [uniqueidentifier] NULL,
	[BudgetOnStaffAvailabilityId] [uniqueidentifier] NULL,
	[MonthId] [uniqueidentifier] NULL,
	[BudgetingTypeId] [uniqueidentifier] NULL,
	[ClientCategoryId] [uniqueidentifier] NULL,
	[HRQuantityId] [uniqueidentifier] NULL,
	[DisqualificationReasonId] [uniqueidentifier] NULL,
	[UseEDId] [uniqueidentifier] NULL,
	[ManagerVacanciesNumber] [int] NULL,
	[LastSynchronizationDate] [datetime2](7) NULL,
	[CommentED] [nvarchar](max) NULL,
	[ActivityContactId] [uniqueidentifier] NULL,
	[LastActivityDate] [datetime2](7) NULL,
	[LastInformationUpdateDate] [datetime2](7) NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[RegionHHId] [uniqueidentifier] NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[AccountAddToBlackList] [bit] NULL,
	[CBRating] [numeric](18, 2) NULL,
	[BadRegistrComment] [nvarchar](500) NULL,
	[URLHHru] [nvarchar](250) NULL,
	[URLHHua] [nvarchar](250) NULL,
	[URLHHby] [nvarchar](250) NULL,
	[PaymentAmountByYear] [numeric](18, 2) NULL,
	[PaymentAmountByHalfYear] [numeric](18, 2) NULL,
	[PaymentAmountByPreviousYear] [numeric](18, 2) NULL,
	[LastTaskDate] [datetime2](7) NULL,
	[LastTaskOwnerDate] [datetime2](7) NULL,
	[BaseDepthDate] [datetime2](7) NULL,
	[IsVirtualRegistration] [bit] NULL,
	[FederalAreaId] [uniqueidentifier] NULL,
	[SellerAccountID] [int] NULL,
	[LastTaskTypeId] [uniqueidentifier] NULL,
	[LastTaskOwnerId] [uniqueidentifier] NULL,
	[LastInvoicePaymentDate] [date] NULL,
	[PersonalAccountCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[PersonalAccountLockCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountLock] [numeric](18, 2) NULL,
	[QuestionaryAccountId] [uniqueidentifier] NULL,
	[RecruitingStuffCount] [int] NULL,
	[PersonalAccountCurrencyRate] [numeric](18, 2) NULL,
	[PrimaryPersonalAccount] [numeric](18, 2) NULL,
	[PersonalAccountLockCurRate] [numeric](18, 2) NULL,
	[PrimaryPersonalAccountLock] [numeric](18, 2) NULL,
	[PreLoggerId] [uniqueidentifier] NULL,
	[PreLoggerDate] [datetime2](7) NULL,
	[PreLoggerStatusId] [uniqueidentifier] NULL,
	[MlmScore] [numeric](18, 2) NULL,
	[IsHidden] [bit] NULL,
	[TsSpecialFeatureId] [uniqueidentifier] NULL,
	[PersonalAccountAd] [numeric](18, 2) NULL,
	[PrimaryPersonalAccountAd] [numeric](18, 2) NULL,
	[PersonalAccountAdCurrencyId] [uniqueidentifier] NULL,
	[PersonalAccountAdCurrencyRate] [numeric](18, 2) NULL,
	[TsRegistrationSeparationDate] [date] NULL,
	[Completeness] [int] NULL,
	[AccountLogoId] [uniqueidentifier] NULL
) ON [CRMData750_new] TEXTIMAGE_ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[DEL_AccountSnapshot_ChangeManager_old]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_AccountSnapshot_ChangeManager_old](
	[ChangeDate] [date] NULL,
	[ID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_Activity_tmp]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Activity_tmp](
	[Id] [uniqueidentifier] NULL,
	[Title] [nvarchar](500) NULL,
	[StartDate] [datetime2](7) NULL,
	[DueDate] [datetime2](7) NULL,
	[PriorityId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[DocumentId] [uniqueidentifier] NULL,
	[InvoiceId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[TypeId] [uniqueidentifier] NULL,
	[ResultId] [uniqueidentifier] NULL,
	[DetailedResult] [nvarchar](max) NULL,
	[ShowInScheduler] [bit] NULL,
	[RemindToAuthor] [bit] NULL,
	[RemindToOwner] [bit] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ActualStartDate] [datetime2](7) NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ActivityEquivalentCalls] [int] NULL,
	[HHID] [int] NULL,
	[HHCreationTime] [datetime2](7) NULL,
	[ActivityCategoryId] [uniqueidentifier] NULL,
	[ActualEndDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_ProductSales_tableau]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_ProductSales_tableau](
	[InvoiceDate] [date] NULL,
	[InvoiceNumber] [nvarchar](250) NULL,
	[EmployerIDName] [nvarchar](303) NULL,
	[EmployerID] [int] NULL,
	[PaymentDate] [date] NULL,
	[ManagerHHID] [int] NULL,
	[ProductCode] [nvarchar](300) NULL,
	[ProductName] [nvarchar](250) NULL,
	[ProductID] [int] NULL,
	[ProductNameReport] [nvarchar](100) NULL,
	[ProductCategory] [nvarchar](250) NULL,
	[ProductLine] [nvarchar](250) NULL,
	[Amount] [numeric](33, 6) NULL,
	[AmountExVAT] [float] NULL,
	[DepartmentName] [nvarchar](250) NOT NULL,
	[ReportDepartmentName] [nvarchar](250) NULL,
	[ManagerName] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[ProcessListeners] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EffectiveTaskTypes]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EffectiveTaskTypes](
	[Name] [nvarchar](255) NULL,
	[TaskTypeID] [uniqueidentifier] NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employer_AllSignals_Queue_Scoring]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employer_AllSignals_Queue_Scoring](
	[PredictionTime] [varchar](23) NULL,
	[ContactDepartmentName] [nvarchar](500) NULL,
	[ManagerName] [nvarchar](500) NULL,
	[AccountID] [uniqueidentifier] NULL,
	[Theme] [nvarchar](max) NULL,
	[ClientSiteCode] [int] NULL,
	[Score] [int] NULL,
	[K_Score] [float] NULL,
	[ContactDepartmentId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerForBlockMLM]    Script Date: 29.03.2020 11:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerForBlockMLM](
	[EmpoyerID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerForBlockMLM_History]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerForBlockMLM_History](
	[EmpoyerID] [int] NULL,
	[Date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerFunnel]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerFunnel](
	[SellerAccount] [varchar](20) NULL,
	[EmployerRegistrationDate] [date] NULL,
	[EmployerType] [varchar](30) NULL,
	[EmployerRegistrationSite] [varchar](30) NULL,
	[EmployerRegion] [varchar](100) NULL,
	[EmployerRegionGroup] [varchar](30) NULL,
	[EmployerHeacount] [varchar](20) NULL,
	[HasRegistered] [int] NULL,
	[HasCreatedInvoice] [int] NULL,
	[HasPaidInvoice] [int] NULL,
	[CreatedInvoicesCount] [int] NULL,
	[PaidInvoicesCount] [int] NULL,
	[CreatedInvoicesSumTotalExVAT] [float] NULL,
	[PaidInvoicesSumTotalExVAT] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerFunnel_Invoices]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerFunnel_Invoices](
	[InvoiceGroup] [varchar](20) NULL,
	[ID] [uniqueidentifier] NULL,
	[CustomerID] [uniqueidentifier] NULL,
	[Date] [date] NULL,
	[BasicAmountWOVAT] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventTypeOnSite]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventTypeOnSite](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[f13]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[f13](
	[CreatedOn] [datetime2](7) NULL,
	[Контрагент] [nvarchar](250) NULL,
	[Код клиента на сайте] [int] NULL,
	[Отдел] [nvarchar](500) NULL,
	[Ответсвенный] [nvarchar](500) NULL,
	[Значение класификатора] [nvarchar](250) NULL,
	[комментарий] [nvarchar](500) NULL,
	[результат подробно] [nvarchar](max) NULL,
	[Факт. дата/время завершения активности] [datetime2](7) NULL
) ON [CRMData750_new] TEXTIMAGE_ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[f13_maxdate]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[f13_maxdate](
	[CreatedOn] [datetime2](7) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[FederalDistrict]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FederalDistrict](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[HHID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HH_TaskEscalation]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HH_TaskEscalation](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ActivityId] [uniqueidentifier] NOT NULL,
	[SignalDate] [datetime] NOT NULL,
	[EscalationLevel] [int] NULL,
	[EmailRecipients] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_tmp]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_tmp](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Number] [nvarchar](250) NULL,
	[StartDate] [date] NULL,
	[PrimaryAmount] [numeric](18, 2) NULL,
	[PrimaryPaymentAmount] [numeric](18, 2) NULL,
	[PaymentStatusId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[SupplierBillingInfoId] [uniqueidentifier] NULL,
	[RemindToOwner] [bit] NULL,
	[RemindToOwnerDate] [datetime2](7) NULL,
	[CustomerBillingInfoId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CurrencyRate] [numeric](18, 2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DueDate] [date] NULL,
	[PaymentAmount] [numeric](18, 2) NULL,
	[Notes] [nvarchar](max) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[SupplierId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[OrderId] [uniqueidentifier] NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[PlanPaymentDate] [date] NULL,
	[InvoiceFirstPayment] [bit] NULL,
	[InvoiceMotiveFirstPaymentId] [uniqueidentifier] NULL,
	[IsProcessedByShortSalesClose] [bit] NULL,
	[IsProcessedByShortSalesControl] [bit] NULL,
	[InvoiceSecondManagerId] [uniqueidentifier] NULL,
	[InvoicePercentSecondManager] [int] NULL,
	[InvoiceReasonSplitId] [uniqueidentifier] NULL,
	[InvoiceMethodPaymentId] [uniqueidentifier] NULL,
	[InvoiceTypeId] [uniqueidentifier] NULL,
	[InvoiceTypeOfBilling] [nvarchar](250) NULL,
	[InvoiceDateOfDeposit] [datetime2](7) NULL,
	[InvoiceNetting] [bit] NULL,
	[InvoiceVATRate] [numeric](18, 2) NULL,
	[AmountWithoutVAT] [numeric](18, 2) NULL,
	[PrimaryAmountWithoutVAT] [numeric](18, 2) NULL,
	[PaymentAmountWithoutVAT] [numeric](18, 2) NULL,
	[InvoiceLastSynchroDate] [datetime2](7) NULL,
	[CodeForSite] [int] NULL,
	[ID1C] [uniqueidentifier] NULL,
	[InvoiceCommentFirstPayment] [nvarchar](max) NULL,
	[EventId] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_today]    Script Date: 29.03.2020 11:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_today](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Number] [nvarchar](250) NULL,
	[StartDate] [date] NULL,
	[PrimaryAmount] [numeric](18, 2) NULL,
	[PrimaryPaymentAmount] [numeric](18, 2) NULL,
	[PaymentStatusId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[SupplierBillingInfoId] [uniqueidentifier] NULL,
	[RemindToOwner] [bit] NULL,
	[RemindToOwnerDate] [datetime2](7) NULL,
	[CustomerBillingInfoId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CurrencyRate] [numeric](18, 2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DueDate] [date] NULL,
	[PaymentAmount] [numeric](18, 2) NULL,
	[Notes] [nvarchar](max) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[SupplierId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[OpportunityId] [uniqueidentifier] NULL,
	[OrderId] [uniqueidentifier] NULL,
	[ProjectId] [uniqueidentifier] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[PlanPaymentDate] [date] NULL,
	[InvoiceFirstPayment] [bit] NULL,
	[InvoiceMotiveFirstPaymentId] [uniqueidentifier] NULL,
	[IsProcessedByShortSalesClose] [bit] NULL,
	[IsProcessedByShortSalesControl] [bit] NULL,
	[InvoiceSecondManagerId] [uniqueidentifier] NULL,
	[InvoicePercentSecondManager] [int] NULL,
	[InvoiceReasonSplitId] [uniqueidentifier] NULL,
	[InvoiceMethodPaymentId] [uniqueidentifier] NULL,
	[InvoiceTypeId] [uniqueidentifier] NULL,
	[InvoiceTypeOfBilling] [nvarchar](250) NULL,
	[InvoiceDateOfDeposit] [datetime2](7) NULL,
	[InvoiceNetting] [bit] NULL,
	[InvoiceVATRate] [numeric](18, 2) NULL,
	[AmountWithoutVAT] [numeric](18, 2) NULL,
	[PrimaryAmountWithoutVAT] [numeric](18, 2) NULL,
	[PaymentAmountWithoutVAT] [numeric](18, 2) NULL,
	[InvoiceLastSynchroDate] [datetime2](7) NULL,
	[CodeForSite] [int] NULL,
	[ID1C] [uniqueidentifier] NULL,
	[InvoiceCommentFirstPayment] [nvarchar](max) NULL,
	[EventId] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceMethodPayment]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceMethodPayment](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[CodeForSite] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoicePaymentStatus]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoicePaymentStatus](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[FinalStatus] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceReasonSplit]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceReasonSplit](
	[Id] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LastSnapshotDate]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LastSnapshotDate](
	[LastSnapshotDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerDepartmentLog]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerDepartmentLog](
	[SnapshotDate] [date] NULL,
	[ID] [uniqueidentifier] NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL,
	[AreaID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerMistakes]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerMistakes](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[StartDate] [datetime] NULL,
	[ConfirmationDate] [datetime] NULL,
	[Link] [nvarchar](255) NULL,
	[Mistake] [nvarchar](255) NULL,
	[MistakeType] [nvarchar](255) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[minutesForOLAP2796]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[minutesForOLAP2796](
	[date] [datetime] NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbActivityOnSiteUrl]    Script Date: 29.03.2020 11:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbActivityOnSiteUrl](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Code] [nvarchar](50) NULL,
	[ProcessListeners] [int] NULL,
	[NrbAddress] [nvarchar](500) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbActivityOpportunity]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbActivityOpportunity](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[NrbActivityId] [uniqueidentifier] NULL,
	[NrbOpportunityId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbCommunicationResult]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbCommunicationResult](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[NrbCommunicationResultLevel1Id] [uniqueidentifier] NULL,
	[NrbCommunicationResultLevel2Id] [uniqueidentifier] NULL,
	[NrbCommunicationResultLevel3Id] [uniqueidentifier] NULL,
	[NrbComment] [nvarchar](500) NULL,
	[NrbActivityId] [uniqueidentifier] NULL,
	[NrbQuestionaryId] [uniqueidentifier] NULL,
	[NrbCaseId] [uniqueidentifier] NULL,
	[NrbOrderId] [uniqueidentifier] NULL,
	[NrbOpportunityId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbCommunicationResultLevel1]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbCommunicationResultLevel1](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbCommunicationResultLevel2]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbCommunicationResultLevel2](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[NrbCommunicationResultLevel1Id] [uniqueidentifier] NULL,
	[NrbOwnerId] [uniqueidentifier] NULL,
	[NrbCaseCategoryId] [uniqueidentifier] NULL,
	[NrbShowOnCaseCreationProcess] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[NrbCommunicationResultLevel3]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NrbCommunicationResultLevel3](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[NrbCommunicationResultLevel2Id] [uniqueidentifier] NULL,
	[NrbRequiredComment] [bit] NULL,
	[NrbShowOnCaseCreationProcess] [bit] NULL,
	[NrbCaseCategoryId] [uniqueidentifier] NULL,
	[NrbRequiredShortOpportunity] [bit] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[OLAP_1926_Invoice]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_1926_Invoice](
	[Number] [nvarchar](250) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[StartDate] [date] NULL,
	[DueDate] [date] NULL,
	[DueDate_Prev] [date] NULL,
	[PaymentAmount] [numeric](18, 2) NULL,
	[InvoiceFirstPayment] [bit] NULL,
	[InvoicePercentSecondManager] [int] NULL,
	[InvoiceReasonSplit] [nvarchar](250) NULL,
	[InvoiceMethodPayment] [nvarchar](250) NULL,
	[PrimaryAmountWithoutVAT] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[olap_2270_Invoice]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[olap_2270_Invoice](
	[Number] [nvarchar](250) NULL,
	[ClientSiteCode] [int] NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[DueDate] [date] NULL,
	[PrevDueDate] [date] NULL,
	[PaymentAmountWithoutVAT] [numeric](18, 2) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[olap_2270_Invoice_ExpDate]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[olap_2270_Invoice_ExpDate](
	[Number] [nvarchar](250) NULL,
	[ClientSiteCode] [int] NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[DueDate] [date] NULL,
	[PrevDueDate] [date] NULL,
	[DayFromPrevPayment] [int] NULL,
	[last_expiration_time] [datetime] NULL,
	[PaymentAmountWithoutVAT] [numeric](18, 2) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[OLE DB Destination]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLE DB Destination](
	[client_site_code] [int] NULL,
	[sum_last_year] [numeric](38, 2) NULL,
	[sum365] [numeric](38, 2) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[OpportunityType]    Script Date: 29.03.2020 11:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[problemsForOLAP2796]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[problemsForOLAP2796](
	[date] [datetime] NOT NULL,
	[isSyncProblem] [int] NOT NULL,
	[isReplProblem] [int] NOT NULL,
	[isErr] [int] NOT NULL,
	[isELC] [int] NOT NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[ProblemType]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[OwnerId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessingStatus]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessingStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[BOOLEAN] [bit] NULL,
	[Hidden] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[UnitId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[TaxId] [uniqueidentifier] NULL,
	[Active] [bit] NOT NULL,
	[URL] [nvarchar](250) NOT NULL,
	[TypeId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[OwnerId] [uniqueidentifier] NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ProductSourceId] [uniqueidentifier] NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[PictureId] [uniqueidentifier] NULL,
	[IsArchive] [bit] NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[TradeMarkId] [uniqueidentifier] NULL,
	[AdsPeriodId] [uniqueidentifier] NULL,
	[LocationTypeId] [uniqueidentifier] NULL,
	[LocationPageId] [uniqueidentifier] NULL,
	[LocationSiteId] [uniqueidentifier] NULL,
	[ProductModificationId] [uniqueidentifier] NULL,
	[Area] [nvarchar](250) NOT NULL,
	[LayoutRu] [nvarchar](500) NOT NULL,
	[LayoutEn] [nvarchar](500) NOT NULL,
	[Comment] [nvarchar](500) NOT NULL,
	[PackageTypeId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[PackageQuantity] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[Rate] [decimal](18, 4) NOT NULL,
	[AccessTypeId] [uniqueidentifier] NULL,
	[ProfessionalAreaId] [uniqueidentifier] NULL,
	[RegionMDSId] [uniqueidentifier] NULL,
	[PublicationTypeId] [uniqueidentifier] NULL,
	[ServiceItemId] [uniqueidentifier] NULL,
	[Format] [nvarchar](250) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSales_Kd]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales_Kd](
	[InvoiceDate] [date] NULL,
	[InvoiceNumber] [nvarchar](250) NULL,
	[EmployerIDName] [nvarchar](303) NULL,
	[EmployerID] [int] NULL,
	[PaymentDate] [date] NULL,
	[ManagerHHID] [int] NULL,
	[ProductCode] [nvarchar](300) NULL,
	[ProductName] [nvarchar](250) NULL,
	[Amount] [numeric](33, 6) NULL,
	[AmountExVAT] [float] NULL,
	[PaymaentSource] [varchar](3) NOT NULL,
	[SotrCode] [nvarchar](10) NULL,
	[JiraTask] [varchar](19) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSales_manual_correction]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales_manual_correction](
	[InvoiceNumber] [nvarchar](250) NULL,
	[ManagerHHIDFrom] [int] NULL,
	[ManagerHHIDTo] [int] NULL,
	[SotrCodeFrom] [nvarchar](10) NULL,
	[SotrCodeTo] [nvarchar](10) NULL,
	[JiraTask] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[IsService] [bit] NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[CodeMDS] [nvarchar](50) NOT NULL,
	[ServicePeriodId] [uniqueidentifier] NULL,
	[UnitId] [uniqueidentifier] NULL,
	[Description] [nvarchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionaryInTag]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionaryInTag](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[TagId] [uniqueidentifier] NULL,
	[EntityId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[QuestionaryTag]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionaryTag](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[TypeId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Queue_Scoring_Snapshots]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Queue_Scoring_Snapshots](
	[SnapshotDate] [datetime] NULL,
	[ContactDepartmentName] [nvarchar](500) NULL,
	[ManagerName] [nvarchar](500) NULL,
	[Themes] [varchar](8000) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[BlokingActivity] [varchar](30) NULL,
	[SumScoring] [int] NULL,
	[ContactDepartmentId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 29.03.2020 11:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[CountryId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[CodeForSite] [int] NULL,
	[DayStartMSK] [time](7) NULL,
	[DayEndMSK] [time](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationCountPlan]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationCountPlan](
	[CodeForSite] [int] NULL,
	[Date] [date] NULL,
	[RegistrationCountPlan] [int] NULL,
	[WorkDaysCount] [int] NULL,
	[Deduction] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationPlatform]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationPlatform](
	[ID] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationReactionSpeed]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationReactionSpeed](
	[ClientSiteCode] [int] NULL,
	[ID] [uniqueidentifier] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[AccountName] [nvarchar](250) NULL,
	[RegistrationState] [nvarchar](250) NULL,
	[StatusChangeDate] [datetime2](7) NULL,
	[AccountType] [nvarchar](250) NULL,
	[EmployeesNumber] [nvarchar](250) NULL,
	[Region] [nvarchar](250) NULL,
	[SellerAccount] [nvarchar](50) NULL,
	[RegionHHid] [uniqueidentifier] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[VirtualRegistration] [varchar](26) NULL,
	[PredRegistration] [varchar](18) NULL,
	[DisqualificationReason] [nvarchar](250) NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[reg_Code] [int] NULL,
	[RegistrationSite] [nvarchar](250) NULL,
	[ManagerCodeForSite] [int] NULL,
	[StatusChangeType] [varchar](12) NOT NULL,
	[StatusChangeType1] [varchar](29) NOT NULL,
	[Reaction] [int] NULL,
	[Country] [nvarchar](250) NULL,
	[WorkingTime] [varchar](16) NOT NULL,
	[Department] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[RegistrationReactionSpeed___]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationReactionSpeed___](
	[ClientSiteCode] [int] NULL,
	[ID] [uniqueidentifier] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[AccountName] [nvarchar](250) NULL,
	[RegistrationState] [nvarchar](250) NULL,
	[StatusChangeDate] [datetime2](7) NULL,
	[AccountType] [nvarchar](250) NULL,
	[EmployeesNumber] [nvarchar](250) NULL,
	[Region] [nvarchar](250) NULL,
	[SellerAccount] [nvarchar](50) NULL,
	[RegionHHid] [uniqueidentifier] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[VirtualRegistration] [varchar](26) NULL,
	[PredRegistration] [varchar](18) NULL,
	[DisqualificationReason] [nvarchar](250) NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[reg_Code] [int] NULL,
	[RegistrationSite] [nvarchar](250) NULL,
	[ManagerCodeForSite] [int] NULL,
	[StatusChangeType] [varchar](12) NOT NULL,
	[StatusChangeType1] [varchar](29) NOT NULL,
	[Reaction] [int] NULL,
	[Country] [nvarchar](250) NULL,
	[WorkingTime] [varchar](16) NOT NULL,
	[Department] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationReactionSpeed__________]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationReactionSpeed__________](
	[ClientSiteCode] [int] NULL,
	[ID] [uniqueidentifier] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[AccountName] [nvarchar](250) NULL,
	[RegistrationState] [nvarchar](250) NULL,
	[StatusChangeDate] [datetime2](7) NULL,
	[AccountType] [nvarchar](250) NULL,
	[EmployeesNumber] [nvarchar](250) NULL,
	[Region] [nvarchar](250) NULL,
	[SellerAccount] [nvarchar](50) NULL,
	[RegionHHid] [uniqueidentifier] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[VirtualRegistration] [varchar](26) NULL,
	[PredRegistration] [varchar](18) NULL,
	[DisqualificationReason] [nvarchar](250) NULL,
	[AccountDateChangeTypeRegistr] [datetime2](7) NULL,
	[reg_Code] [int] NULL,
	[RegistrationSite] [nvarchar](250) NULL,
	[ManagerCodeForSite] [int] NULL,
	[StatusChangeType] [varchar](12) NOT NULL,
	[Reaction] [varchar](29) NOT NULL,
	[StatusChangeType1] [int] NULL,
	[Country] [nvarchar](250) NULL,
	[WorkingTime] [varchar](16) NOT NULL,
	[Department] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[RegistrationSite]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationSite](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelationshipLog]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelationshipLog](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](0) NULL,
	[Action] [varchar](255) NULL,
	[ActionDoneById] [uniqueidentifier] NULL,
	[RelationshipId] [uniqueidentifier] NULL,
	[AccountAId] [uniqueidentifier] NULL,
	[AccountBId] [uniqueidentifier] NULL,
	[removeAccountAId] [uniqueidentifier] NULL,
	[removeAccountBId] [uniqueidentifier] NULL,
	[RelationTypeId] [uniqueidentifier] NULL,
	[ReverseRelationTypeId] [uniqueidentifier] NULL,
	[RemovableRelationTypeId] [uniqueidentifier] NULL,
	[ValidTill] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelationType]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelationType](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[ForContactContact] [bit] NULL,
	[ForAccountContact] [bit] NULL,
	[ForContactAccount] [bit] NULL,
	[ForAccountAccount] [bit] NULL,
	[ReverseRelationTypeId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Code] [int] NULL,
	[TimeLife] [int] NULL,
	[MinLifeTime] [int] NULL,
	[RememberAfter] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesCRMTaskStatisticData]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesCRMTaskStatisticData](
	[Id] [uniqueidentifier] NULL,
	[Date] [date] NULL,
	[Category] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
	[SubDepartment] [nvarchar](255) NULL,
	[Manager] [nvarchar](250) NULL,
	[ActivityEquivalentCalls] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDepartment]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDepartment](
	[Name] [nvarchar](255) NULL,
	[FederalNode] [nvarchar](255) NULL,
	[RegionalNode] [nvarchar](255) NULL,
	[ContactDepartmentID] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesManager_Activity]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesManager_Activity](
	[ManagerID] [uniqueidentifier] NULL,
	[DateMonth] [date] NULL,
	[Name] [nvarchar](250) NULL,
	[ActivityCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesManager_CallDuration]    Script Date: 29.03.2020 11:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesManager_CallDuration](
	[DateCall] [date] NULL,
	[Телефон менеджера] [nvarchar](4000) NULL,
	[mail] [nvarchar](150) NULL,
	[Duration_min] [float] NULL,
	[Calls_count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesManager_ClientBase]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesManager_ClientBase](
	[SnapshotDate] [date] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[CodeForSite] [int] NULL,
	[ClientBase] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesManager_Payments1C]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesManager_Payments1C](
	[PeriodMonth] [date] NULL,
	[ObjectCode] [nvarchar](100) NULL,
	[FirstPay] [int] NULL,
	[MonthSum] [float] NULL,
	[EmployerCountD] [int] NULL,
	[PaymentCount] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[SalesManager_ProductsPayments]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesManager_ProductsPayments](
	[PaymentMonth] [date] NULL,
	[ManagerHHID] [int] NULL,
	[AmountExVAT] [float] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[SplitActivityCategory]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SplitActivityCategory](
	[CreatedOn] [datetime2](0) NULL,
	[SplittypeId] [int] NULL,
	[ActivityCategoryId] [uniqueidentifier] NULL,
	[Name] [nvarchar](400) NULL,
	[Description] [nvarchar](2000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysAdminUnit]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysAdminUnit](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](500) NULL,
	[Description] [nvarchar](500) NULL,
	[ParentRoleId] [uniqueidentifier] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[TimeZoneId] [nvarchar](500) NULL,
	[UserPassword] [nvarchar](500) NULL,
	[SysAdminUnitTypeValue] [int] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[Active] [bit] NULL,
	[LoggedIn] [bit] NULL,
	[SynchronizeWithLDAP] [bit] NULL,
	[LDAPEntry] [nvarchar](500) NULL,
	[LDAPEntryId] [nvarchar](500) NULL,
	[LDAPEntryDN] [nvarchar](500) NULL,
	[IsDirectoryEntry] [bit] NULL,
	[ProcessListeners] [int] NULL,
	[SysCultureId] [uniqueidentifier] NULL,
	[LoginAttemptCount] [int] NULL,
	[SourceControlLogin] [nvarchar](500) NULL,
	[SourceControlPassword] [nvarchar](500) NULL,
	[PasswordExpireDate] [datetime2](3) NULL,
	[HomePageId] [uniqueidentifier] NULL,
	[ConnectionType] [int] NULL,
	[UnblockTime] [datetime2](3) NULL,
	[ForceChangePassword] [bit] NULL,
	[LDAPElementId] [uniqueidentifier] NULL,
	[ActivityStatusNotificationId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysUserInRole]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysUserInRole](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[SysUserId] [uniqueidentifier] NULL,
	[SysRoleId] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[tbl_olap-2534]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_olap-2534](
	[CreatedOn] [datetime2](7) NULL,
	[LeadType] [nvarchar](255) NULL,
	[Stage] [nvarchar](250) NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[TsRelationship_forTableau]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TsRelationship_forTableau](
	[CreatedOn] [datetime2](7) NULL,
	[AccountIdSource] [uniqueidentifier] NULL,
	[AccountIdDest] [uniqueidentifier] NULL,
	[regtype] [varchar](22) NOT NULL,
	[Active] [bit] NULL,
	[ClientSiteCodeSource] [int] NULL,
	[AccountSource] [nvarchar](250) NULL,
	[ClientSiteCode] [int] NULL,
	[Account] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[ASum12before] [numeric](38, 2) NULL,
	[ASum24before] [numeric](38, 2) NULL,
	[ASum24after] [numeric](38, 2) NULL,
	[ASum12after] [numeric](38, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TsRelationType_test]    Script Date: 29.03.2020 11:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TsRelationType_test](
	[CreatedOn] [datetime2](7) NULL,
	[ReverseRelationType] [nvarchar](250) NULL,
	[Active] [bit] NULL,
	[Description] [nvarchar](250) NULL,
	[ManagerB] [nvarchar](250) NULL,
	[DepartmentB] [nvarchar](250) NULL,
	[AccountAId] [uniqueidentifier] NULL,
	[AccountBId] [uniqueidentifier] NULL,
	[AccountB] [nvarchar](250) NULL,
	[ClientSiteCodeB] [int] NULL,
	[BSum12before] [numeric](38, 2) NULL,
	[BSum24before] [numeric](38, 2) NULL,
	[BSum24after] [numeric](38, 2) NULL,
	[BSum12after] [numeric](38, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tu_ReplDelay]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tu_ReplDelay](
	[id] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ReplDelay] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[Tu_SyncDelay]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tu_SyncDelay](
	[id] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[SyncDelay] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[UserActivityOnSite]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserActivityOnSite](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[ContactId] [uniqueidentifier] NULL,
	[ActivityTypeCode] [int] NULL,
	[Activity] [nvarchar](250) NULL,
	[Date] [datetime2](7) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[NrbDomainId] [uniqueidentifier] NULL,
	[NrbPageId] [uniqueidentifier] NULL,
	[EmployerId] [int] NULL,
	[UserId] [int] NULL
) ON [CRMData750_new]
GO
/****** Object:  Table [dbo].[UsrContrKind]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsrContrKind](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[NotActive] [bit] NOT NULL,
	[DocumentName] [nvarchar](250) NOT NULL,
	[DontNeedNumber] [bit] NOT NULL,
	[IsParentRequired] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsrUtensils]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsrUtensils](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VacancyTitleMLM]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancyTitleMLM](
	[ClientSiteCode] [int] NULL,
	[RegistrationDate] [date] NULL,
	[AccountName] [nvarchar](250) NULL,
	[Title] [nvarchar](500) NULL,
	[alreadyReg] [int] NOT NULL,
	[SimpleDel] [int] NOT NULL,
	[EmptyReason] [int] NOT NULL,
	[Joblist] [int] NOT NULL,
	[UserClaim] [int] NOT NULL,
	[MLM] [int] NOT NULL,
	[NotConnected] [int] NOT NULL,
	[Refusal] [int] NOT NULL,
	[NoActive] [int] NOT NULL,
	[ErrorProfarea] [int] NOT NULL,
	[NoName] [int] NOT NULL,
	[NoRegDosc] [int] NOT NULL,
	[VacancyClose] [int] NOT NULL,
	[NoPhone] [int] NOT NULL,
	[PMWork] [int] NOT NULL,
	[PostingVacancy] [int] NOT NULL,
	[NoLastName] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisaDurationReport]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisaDurationReport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VisaOwnerName] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NULL,
	[VisaStatusName] [nvarchar](250) NULL,
	[ContractClassName] [nvarchar](250) NULL,
	[YearVisaCreatedOn] [int] NULL,
	[MonthVisaCreatedOn] [int] NULL,
	[WeekVisaCreatedOn] [int] NULL,
	[YearVisaSetDate] [int] NULL,
	[MonthVisaSetDate] [int] NULL,
	[WeekVisaSetDate] [int] NULL,
	[VisaCreatedOn] [datetime2](0) NULL,
	[VisaSetDate] [datetime2](0) NULL,
	[DatediffBetweenVisaCreatedOnAndSetDate] [int] NULL,
	[DatediffBetweenVisaCreatedOnAndSetDate_OnlyWorkTime] [int] NULL,
	[VisaCreatedByName] [nvarchar](500) NULL,
	[SetByName] [nvarchar](250) NULL,
	[Number] [nvarchar](250) NOT NULL,
	[UsrContractName] [nvarchar](500) NOT NULL,
	[ContractCreatedOn] [datetime2](7) NULL,
	[Visaid] [uniqueidentifier] NOT NULL,
	[ContractId] [uniqueidentifier] NOT NULL,
	[Objective] [nvarchar](max) NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[ContractOwnerName] [nvarchar](500) NULL,
	[IsCanceled] [bit] NOT NULL,
	[NotWorkDay] [bit] NULL,
	[MoreThen1440Min] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisaStatus]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisaStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[ProcessListeners] [int] NOT NULL,
	[IsFinal] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vw_TS_UserOwner]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vw_TS_UserOwner](
	[ContactDepartmentId] [uniqueidentifier] NULL,
	[AB] [int] NULL,
	[UserId] [uniqueidentifier] NULL,
	[OwnerId] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VwRelationship]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VwRelationship](
	[Id] [uniqueidentifier] NULL,
	[CreatedOn] [datetime2](3) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](3) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NULL,
	[ContactAId] [uniqueidentifier] NULL,
	[AccountAId] [uniqueidentifier] NULL,
	[ContactBId] [uniqueidentifier] NULL,
	[AccountBId] [uniqueidentifier] NULL,
	[RelationTypeId] [uniqueidentifier] NULL,
	[ReverseRelationTypeId] [uniqueidentifier] NULL,
	[Description] [nvarchar](250) NULL,
	[Active] [bit] NULL,
	[Our] [nvarchar](250) NULL,
	[Related] [nvarchar](250) NULL,
	[OutputRelationType] [nvarchar](250) NULL,
	[OutputReverseRelationType] [nvarchar](250) NULL,
	[ValidTill] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkingTimeInterval]    Script Date: 29.03.2020 11:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkingTimeInterval](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[DayInCalendarId] [uniqueidentifier] NULL,
	[From] [time](7) NULL,
	[To] [time](7) NULL,
	[Index] [int] NOT NULL,
	[DayOffId] [uniqueidentifier] NULL
) ON [CRMData750_new]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "lc"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 278
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 316
               Bottom = 136
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "st"
            Begin Extent =
               Top = 6
               Left = 619
               Bottom = 136
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'account_on_competitors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'account_on_competitors'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountIndustryGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountIndustryGrouped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "o"
            Begin Extent =
               Top = 6
               Left = 280
               Bottom = 119
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountReactionTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountReactionTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "reg"
            Begin Extent =
               Top = 6
               Left = 341
               Bottom = 136
               Right = 516
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "frr"
            Begin Extent =
               Top = 6
               Left = 554
               Bottom = 136
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cu"
            Begin Extent =
               Top = 6
               Left = 762
               Bottom = 136
               Right = 932
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "ab"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent =
               Top = 6
               Left = 251
               Bottom = 136
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ai"
            Begin Extent =
               Top = 6
               Left = 476
               Bottom = 136
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountToIndustry'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AccountToIndustry'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 428
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cd"
            Begin Extent =
               Top = 6
               Left = 281
               Bottom = 366
               Right = 481
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Contact_Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Contact_Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "Contact"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Contact_isSKS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Contact_isSKS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "e"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 254
               Bottom = 136
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'event_participation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'event_participation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "eo"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 259
               Bottom = 136
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Managers1C_CRM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Managers1C_CRM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Account_without_opportunity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Account_without_opportunity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ac"
            Begin Extent =
               Top = 6
               Left = 285
               Bottom = 136
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 513
               Bottom = 136
               Right = 718
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 756
               Bottom = 136
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Activity_by_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Activity_by_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a_1"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 263
               Bottom = 136
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 3555
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Activity_not_finish'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Activity_not_finish'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "cal"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 454
               Bottom = 136
               Right = 637
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Calls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Calls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "o"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 509
               Bottom = 136
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 812
               Bottom = 136
               Right = 1017
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 102
               Left = 301
               Bottom = 232
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent =
               Top = 6
               Left = 301
               Bottom = 102
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Churn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Churn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "Contact"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Contact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Contact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 329
               Bottom = 136
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Invoice_not_pay_60'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Invoice_not_pay_60'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 329
               Bottom = 136
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2670
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Invoices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_Invoices'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "o"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 487
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 301
               Bottom = 136
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 600
               Bottom = 136
               Right = 805
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 843
               Bottom = 136
               Right = 1026
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "os"
            Begin Extent =
               Top = 138
               Left = 38
               Bottom = 268
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2115
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_OpportunityPredict'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP_2782_OpportunityPredict'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "ad"
            Begin Extent =
               Top = 6
               Left = 287
               Bottom = 136
               Right = 564
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o_1"
            Begin Extent =
               Top = 138
               Left = 38
               Bottom = 234
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-1854'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-1854'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "t"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 102
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ad"
            Begin Extent =
               Top = 6
               Left = 269
               Bottom = 136
               Right = 530
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-2036'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-2036'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "a"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent =
               Top = 6
               Left = 337
               Bottom = 136
               Right = 515
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "inv"
            Begin Extent =
               Top = 6
               Left = 553
               Bottom = 136
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-2271'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-2271'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'olap-2534'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'olap-2534'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "AccountSnapshot"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AccountSnapshot_ChangeManager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AccountSnapshot_ChangeManager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "u"
            Begin Extent =
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "oe"
            Begin Extent =
               Top = 6
               Left = 454
               Bottom = 136
               Right = 637
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Calls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_Calls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "Account"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_DEV_Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_DEV_Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LG_withCancel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_LG_withCancel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ManagerSCD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ManagerSCD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "opp"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pay"
            Begin Extent =
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OLAP-2625'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_OLAP-2625'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductSales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "p"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent =
               Top = 6
               Left = 258
               Bottom = 102
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductSales_manager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductSales_manager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties =
   Begin PaneConfigurations =
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane =
      Begin Origin =
         Top = 0
         Left = 0
      End
      Begin Tables =
         Begin Table = "t2_1"
            Begin Extent =
               Top = 6
               Left = 38
               Bottom = 136
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane =
   End
   Begin DataPane =
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane =
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_TsRelationship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_TsRelationship'
GO

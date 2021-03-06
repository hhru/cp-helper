USE [CRMData750]
GO
/****** Object:  Schema [mart]    Script Date: 29.03.2020 11:11:40 ******/
CREATE SCHEMA [mart]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountEmployeesNumber] (
    [Id] [uniqueidentifier] NULL,
    [Name] [nvarchar](255) NULL
) ON [PRIMARY]
GO
INSERT INTO [dbo].[AccountEmployeesNumber] (Id, Name) VALUES
('0580DE07-55E6-DF11-971B-001D60E938C6', N'До 20'),
('3A80060F-55E6-DF11-971B-001D60E938C6', N'51-100'),
('2C344115-55E6-DF11-971B-001D60E938C6',N'251-500'),
('2D344115-55E6-DF11-971B-001D60E938C6',N'Более 500'),
('BF7E2290-F36B-1410-849F-0026185BFCD3',N'101-250'),
('EF7F0EB0-F36B-1410-849F-0026185BFCD3', N'21-50'),
('AFBE32D2-F36B-1410-849F-0026185BFCD3', N'2-4'),
('F07C12D8-F36B-1410-849F-0026185BFCD3', N'5-10'),
('FDBF1EDE-F36B-1410-849F-0026185BFCD3', N'Больше 1000'),
('EEBC1EBC-F36B-1410-849F-0026185BFCD3', N'Частный предприниматель')
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] NULL,
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

INSERT INTO [dbo].[Account] (Id, EmployeesNumberId)
VALUES
(1455, '2D344115-55E6-DF11-971B-001D60E938C6'),
(1870, '3A80060F-55E6-DF11-971B-001D60E938C6'),
(84585, '2D344115-55E6-DF11-971B-001D60E938C6'),
(2096237,'3A80060F-55E6-DF11-971B-001D60E938C6'),
(2605703, 'FDBF1EDE-F36B-1410-849F-0026185BFCD3'),
(2624107, '3A80060F-55E6-DF11-971B-001D60E938C6'),
(1269556,'2D344115-55E6-DF11-971B-001D60E938C6')
GO



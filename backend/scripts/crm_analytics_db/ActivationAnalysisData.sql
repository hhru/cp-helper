USE [ActivationAnalysisData]
GO
/****** Object:  Schema [stg]    Script Date: 29.03.2020 11:09:01 ******/
CREATE SCHEMA [stg]
GO
/****** Object:  Table [dbo].[segment_month]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[segment_month](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[month] [date] NULL,
	[service_duration_name] [int] NULL,
	[days_in_year] [int] NULL,
	[segment_by_duration] [int] NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_vacancy_to_month] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[segment] [int] NULL,
	[segment_name] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_segment_month]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_segment_month]
AS
SELECT        [employer_id], [year], [month], COALESCE (lead([month]) OVER (partition BY [employer_id]
ORDER BY [month]), eomonth(getdate())) next_month, [service_duration_name], [days_in_year], [segment_by_duration], [max_segment_by_duration_name], [max_vacancy_to_month], [segment_by_vacancy_count], 
[max_segment_by_vacancy_count_name], [segment], [segment_name]
FROM            [ActivationAnalysisData].[dbo].[segment_month]
GO
/****** Object:  Table [dbo].[employer_max_segment]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_employer_max_segment]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_employer_max_segment]
AS
SELECT        employer_id, MAX([max_segment]) max_segment, CASE MAX([max_segment]) WHEN 1 THEN 'S' WHEN 2 THEN 'M' WHEN 3 THEN 'L' END AS max_segment_name
FROM            dbo.employer_max_segment
GROUP BY employer_id
GO
/****** Object:  Table [dbo].[employer_max_segment_snapshot]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_snapshot](
	[SnapshotDate] [date] NULL,
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_employer_max_segment_SMB]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_employer_max_segment_SMB]
AS
SELECT        employer_id, year, CASE WHEN MIN([max_segment]) = 1 THEN 'S' WHEN MIN([max_segment]) = 2 THEN 'M' WHEN MIN([max_segment]) = 3 THEN 'L' END AS max_segment
FROM            dbo.employer_max_segment_snapshot
GROUP BY employer_id, year
GO
/****** Object:  View [dbo].[OLAP-170-1]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-170-1]
AS
SELECT     dbo.orders_all_new.employer_id AS ClientCode, 'http://hh.ru/employer/' + CAST(dbo.orders_all_new.employer_id AS varchar) AS ClientLink, 
                      CRMData.dbo.tbl_Account.OfficialAccountName AS OfficialName, CRMData.dbo.tbl_Contact.Name AS Manager, 
                      CRMData.dbo.tbl_ContactDepartment.Name AS ManagerDepartment, COUNT(*) AS ActivationFact
FROM         dbo.orders_all_new LEFT OUTER JOIN
                      CRMData.dbo.tbl_Account ON CRMData.dbo.tbl_Account.CustomerSiteCode = dbo.orders_all_new.employer_id LEFT OUTER JOIN
                      CRMData.dbo.tbl_Contact ON CRMData.dbo.tbl_Contact.ID = CRMData.dbo.tbl_Account.OwnerID LEFT OUTER JOIN
                      CRMData.dbo.tbl_ContactDepartment ON CRMData.dbo.tbl_ContactDepartment.ID = CRMData.dbo.tbl_Account.ContactDepartmentID
WHERE     (dbo.orders_all_new.activation_time >= DATEADD(month, - 6, GETDATE())) AND (dbo.orders_all_new.cnt > 4) AND (dbo.orders_all_new.cnt < 21) AND 
                      (dbo.orders_all_new.code = 'VP') AND (dbo.orders_all_new.order_cost > 0) AND (dbo.orders_all_new.seller_account_id = 1)
GROUP BY dbo.orders_all_new.employer_id, CRMData.dbo.tbl_Account.OfficialAccountName, CRMData.dbo.tbl_Contact.Name, CRMData.dbo.tbl_ContactDepartment.Name
GO
/****** Object:  View [dbo].[OLAP-170-1-FINAL]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-170-1-FINAL]
AS
SELECT     dbo.[OLAP-170-1].ClientCode, dbo.[OLAP-170-1].ClientLink, dbo.[OLAP-170-1].OfficialName, dbo.[OLAP-170-1].Manager, dbo.[OLAP-170-1].ManagerDepartment, 
                      dbo.[OLAP-170-1].ActivationFact, MAX(VacancySnapshot.dbo.Vacancy.CreationDate) AS VacancyCreationDate
FROM         dbo.[OLAP-170-1] LEFT OUTER JOIN
                      VacancySnapshot.dbo.Vacancy ON VacancySnapshot.dbo.Vacancy.EmployerID = dbo.[OLAP-170-1].ClientCode
GROUP BY dbo.[OLAP-170-1].ClientCode, dbo.[OLAP-170-1].ClientLink, dbo.[OLAP-170-1].OfficialName, dbo.[OLAP-170-1].Manager, dbo.[OLAP-170-1].ManagerDepartment, 
                      dbo.[OLAP-170-1].ActivationFact
GO
/****** Object:  View [dbo].[OLAP-170-2]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-170-2]
AS
SELECT     dbo.orders_all_new.employer_id AS ClientCode, 'http://hh.ru/employer/' + CAST(dbo.orders_all_new.employer_id AS varchar) AS ClientLink, 
                      CRMData.dbo.tbl_Account.OfficialAccountName AS OfficialName, CRMData.dbo.tbl_Contact.Name AS Manager, 
                      CRMData.dbo.tbl_ContactDepartment.Name AS ManagerDepartment, COUNT(*) AS ActivationFact
FROM         dbo.orders_all_new LEFT OUTER JOIN
                      CRMData.dbo.tbl_Account ON CRMData.dbo.tbl_Account.CustomerSiteCode = dbo.orders_all_new.employer_id LEFT OUTER JOIN
                      CRMData.dbo.tbl_Contact ON CRMData.dbo.tbl_Contact.ID = CRMData.dbo.tbl_Account.OwnerID LEFT OUTER JOIN
                      CRMData.dbo.tbl_ContactDepartment ON CRMData.dbo.tbl_ContactDepartment.ID = CRMData.dbo.tbl_Account.ContactDepartmentID
WHERE     (dbo.orders_all_new.activation_time >= DATEADD(month, - 6, GETDATE())) AND (dbo.orders_all_new.cnt > 0) AND (dbo.orders_all_new.cnt < 5) AND 
                      (dbo.orders_all_new.code = 'RENEWAL_VP') AND (dbo.orders_all_new.order_cost > 0) AND (dbo.orders_all_new.seller_account_id = 1)
GROUP BY dbo.orders_all_new.employer_id, CRMData.dbo.tbl_Account.OfficialAccountName, CRMData.dbo.tbl_Contact.Name, CRMData.dbo.tbl_ContactDepartment.Name
GO
/****** Object:  View [dbo].[OLAP-170-2-FINAL]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OLAP-170-2-FINAL]
AS
SELECT     dbo.[OLAP-170-2].ClientCode, dbo.[OLAP-170-2].ClientLink, dbo.[OLAP-170-2].OfficialName, dbo.[OLAP-170-2].Manager, dbo.[OLAP-170-2].ManagerDepartment, 
                      dbo.[OLAP-170-2].ActivationFact, MAX(VacancySnapshot.dbo.Vacancy.CreationDate) AS VacancyCreationDate
FROM         dbo.[OLAP-170-2] LEFT OUTER JOIN
                      VacancySnapshot.dbo.Vacancy ON VacancySnapshot.dbo.Vacancy.EmployerID = dbo.[OLAP-170-2].ClientCode
GROUP BY dbo.[OLAP-170-2].ClientCode, dbo.[OLAP-170-2].ClientLink, dbo.[OLAP-170-2].OfficialName, dbo.[OLAP-170-2].Manager, dbo.[OLAP-170-2].ManagerDepartment, 
                      dbo.[OLAP-170-2].ActivationFact
GO
/****** Object:  Table [dbo].[orders_all_cleansed]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed](
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
/****** Object:  Table [dbo].[spending]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[spending](
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
/****** Object:  View [dbo].[vw_order_all_cleansed_activeproducts]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_order_all_cleansed_activeproducts]
AS
SELECT        U.employer_id, U.employer_service_id, U.order_id, U.service_id, U.creation_time, U.activation_time, U.expiration_time, U.code, U.original_cnt, s.qtty, U.adjusted_cnt, U.original_cost, U.adjusted_cost, 
                         U.order_cost
FROM            dbo.orders_all_cleansed AS U LEFT OUTER JOIN
                             (SELECT        employer_service_id, SUM(CAST(qtty AS int)) AS qtty
                               FROM            dbo.spending
                               GROUP BY employer_service_id) AS s ON s.employer_service_id = U.employer_service_id
WHERE        (COALESCE (U.expiration_time, DATEADD(year, 1, U.activation_time)) >= GETDATE()) AND (U.original_cnt - s.qtty <> 0) OR
                         (COALESCE (U.expiration_time, DATEADD(year, 1, U.activation_time)) >= GETDATE()) AND (s.qtty IS NULL)
GO
/****** Object:  Table [dbo].[service_area]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_area](
	[serviceID] [nvarchar](50) NULL,
	[areaID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[price_rus_2013]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[price_rus_2013](
	[region_name] [nvarchar](255) NULL,
	[profarea_name] [nvarchar](255) NULL,
	[period] [float] NULL,
	[type] [nvarchar](255) NULL,
	[BUR] [float] NULL,
	[KZT] [nvarchar](255) NULL,
	[RUR] [nvarchar](255) NULL,
	[UAH] [nvarchar](255) NULL,
	[region_id] [float] NULL,
	[profarea_id] [float] NULL,
	[rur_cost] [float] NULL,
	[seller_account_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[price_rus]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[price_rus](
	[region_name] [nvarchar](255) NULL,
	[profarea_name] [nvarchar](255) NULL,
	[period] [float] NULL,
	[type] [nvarchar](255) NULL,
	[BUR] [float] NULL,
	[KZT] [nvarchar](255) NULL,
	[RUR] [nvarchar](255) NULL,
	[UAH] [nvarchar](255) NULL,
	[region_id] [float] NULL,
	[profarea_id] [float] NULL,
	[rur_cost] [float] NULL,
	[seller_account_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PriceRegion]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PriceRegion]
AS
SELECT DISTINCT [region_name], [region_id]
FROM            [ActivationAnalysisData].[dbo].[price_rus]
UNION
SELECT DISTINCT [region_name], [region_id]
FROM            [ActivationAnalysisData].[dbo].[price_rus_2013]
union
select 'Несколько регионов', -1
GO
/****** Object:  View [dbo].[service_area_group_name]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[service_area_group_name]
AS
SELECT e.[serviceID], 
(
    SELECT t.region_name + ', '
    FROM
    (
        SELECT [serviceID], 
               p.region_name
        FROM [ActivationAnalysisData].[dbo].[service_area] s
             LEFT JOIN ActivationAnalysisData.dbo.PriceRegion p ON s.areaID = p.region_id
    ) t
    WHERE t.[serviceID] = e.[serviceID] FOR XML PATH('')
) region_name
FROM [ActivationAnalysisData].[dbo].[service_area] e
GO
/****** Object:  Table [dbo].[service_professional_area]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_professional_area](
	[serviceID] [nvarchar](50) NULL,
	[areaID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[service_professional_area_group_name]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[service_professional_area_group_name]
AS
SELECT e.[serviceID], 
(
    SELECT t.name + '| '
    FROM
    (
        SELECT [serviceID], 
               p.name
        FROM [ActivationAnalysisData].[dbo].[service_professional_area] s
             LEFT JOIN CommonData.dbo.ProfArea p ON s.areaID = p.id
    ) t
    WHERE t.[serviceID] = e.[serviceID] FOR XML PATH('')
) prof_name
FROM [ActivationAnalysisData].[dbo].[service_area] e
GO
/****** Object:  Table [dbo].[orders_all_uncleansed]    Script Date: 29.03.2020 11:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_uncleansed](
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
/****** Object:  View [dbo].[vw_olap_314]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_olap_314]
AS
SELECT        CAST(dbo.orders_all_uncleansed.activation_time AS date) AS activation_date, dbo.spending.employer_id, CRMData750.dbo.Account.Name AS OfficialAccountName, dbo.spending.code, 
                         SUM(CAST(dbo.spending.qtty AS float)) AS sqtty, dbo.orders_all_uncleansed.cnt, CRMData750.dbo.Contact.Name AS Manager, CRMData750.dbo.ContactDepartment.Name AS Department
FROM            dbo.spending LEFT OUTER JOIN
                         dbo.orders_all_uncleansed ON dbo.orders_all_uncleansed.employer_service_id = dbo.spending.employer_service_id AND dbo.orders_all_uncleansed.code = dbo.spending.code AND 
                         dbo.orders_all_uncleansed.creation_time > '2015-01-01' AND dbo.spending.Date > '2015-01-01' LEFT OUTER JOIN
                         CRMData750.dbo.Account ON dbo.spending.employer_id = CRMData750.dbo.Account.ClientSiteCode LEFT OUTER JOIN
                         CRMData750.dbo.Contact ON CRMData750.dbo.Contact.ID = CRMData750.dbo.Account.OwnerId LEFT OUTER JOIN
                         CRMData750.dbo.ContactDepartment ON CRMData750.dbo.ContactDepartment.Id = CRMData750.dbo.Contact.ContactDepartmentID
WHERE        (dbo.spending.code = 'RENEWAL_VP') AND (dbo.spending.Date > '2015-01-01') AND (dbo.orders_all_uncleansed.creation_time > '2015-01-01')
GROUP BY CAST(dbo.orders_all_uncleansed.activation_time AS date), dbo.spending.employer_id, CRMData750.dbo.Account.Name, dbo.spending.code, dbo.orders_all_uncleansed.cnt, CRMData750.dbo.Contact.Name, 
                         CRMData750.dbo.ContactDepartment.Name
GO
/****** Object:  View [dbo].[RrejectionEmployer]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  *****
 and year(s1.Date)=2013
  and month(s1.Date)=5
  */
CREATE VIEW [dbo].[RrejectionEmployer]
AS
SELECT DISTINCT 
                      CAST(s1.Date AS date) AS SpendingDate, MONTH(s1.Date) AS SpendingMonth, YEAR(s1.Date) AS SpendingYear, DAY(s1.Date) AS SpendingDay, s1.employer_id, 
                      CRMData.dbo.EmployerIDToManager.Name AS Manager
FROM         dbo.spending AS s1 LEFT OUTER JOIN
                      dbo.spending AS s2 ON s1.employer_id = s2.employer_id AND DATEADD(day, 30, s1.Date) < s2.Date AND DATEDIFF(month, DATEADD(day, 30, s1.Date), s2.Date) 
                      >= 3 LEFT OUTER JOIN
                      CRMData.dbo.EmployerIDToManager ON s1.employer_id = CRMData.dbo.EmployerIDToManager.CustomerSiteCode
WHERE     (s1.code = 'FA') AND (s1.qtty = 30)
GO
/****** Object:  Table [dbo].[service_professional_area_2012]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_professional_area_2012](
	[serviceID] [float] NULL,
	[areaID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[All_service_prof_area]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[All_service_prof_area]
AS
SELECT        [serviceID], [areaID]
FROM            [ActivationAnalysisData].[dbo].[service_professional_area]
UNION 
SELECT DISTINCT [service_id] AS serviceID, '0'
FROM            [ActivationAnalysisData].[dbo].[orders_all_new]
WHERE        [service_id] NOT IN
                             (SELECT        [serviceID]
                               FROM            [ActivationAnalysisData].[dbo].[service_professional_area])
UNION 
 select [serviceID]
           ,[areaID] from [ActivationAnalysisData].[dbo].[service_professional_area_2012]
GO
/****** Object:  Table [dbo].[smb_12month_segment]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[smb_12month_segment](
	[ClientSiteCode] [int] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[AccountName] [nvarchar](250) NULL,
	[RegistrationState] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[AccountType] [nvarchar](250) NULL,
	[Region] [nvarchar](250) NULL,
	[AreaName] [nvarchar](250) NULL,
	[SellerAccount] [nvarchar](50) NULL,
	[vacancy_segment_id] [int] NULL,
	[access_segment_id] [int] NULL,
	[max_segment_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[smb_12month_segment_name]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[smb_12month_segment_name](
	[ID] [int] NOT NULL,
	[Name] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_smb_12month_segment]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_smb_12month_segment]
AS
SELECT        s.ClientSiteCode, s.RegistrationDate, s.AccountName, s.RegistrationState, s.Manager, s.Department, s.AccountType, s.Region, s.AreaName, s.SellerAccount, sm.Name AS max_segment
FROM            dbo.smb_12month_segment AS s LEFT OUTER JOIN
                         dbo.smb_12month_segment_name AS sm ON s.max_segment_id = sm.ID
GO
/****** Object:  Table [dbo].[EmployerExclusions]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerExclusions](
	[EmployerID] [int] NOT NULL,
	[Reason] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_Budget_ExcludeEmployerServiceID]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Budget_ExcludeEmployerServiceID](
	[employer_service_id] [float] NULL,
	[Comment] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ActivationForSale]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ActivationForSale]
AS
SELECT     a.order_id, a.service_id, a.employer_service_id, CAST(a.creation_time AS date) AS creation_date, CAST(a.activation_time AS date) AS activation_date, a.employer_id, 
                      a.account_id, a.payer_id, a.code, a.cnt, CASE WHEN [cnt] = 7 THEN '7' WHEN [cnt] = 14 THEN '14' WHEN [cnt] = 30 THEN '30' WHEN [cnt] >= 90 AND 
                      [cnt] <= 93 THEN '92' WHEN [cnt] >= 180 AND [cnt] <= 183 THEN '183' WHEN [cnt] >= 300 THEN '365' ELSE 'Прочие' END AS cnt_gr, a.order_cost, 
                      a.employer_service_Code, a.employer_Code, a.cost, a.ActivityName, a.FieldName, a.SubField, a.ContactName, a.ContactDepartmentName, 
                      CASE WHEN service_id IN
                          (SELECT     [serviceID]
                            FROM          [ActivationAnalysisData].[dbo].[service_professional_area]) THEN 'Конкретные профобласти' ELSE 'Все профобласти' END AS profarea, at.Type, 
                      einf.CreationSite, einf.StateName, einf.RegoinName, einf.RegistrationPlatform, einf.EmployeesNumber, account.ActivityID, a.SellerAccountId
FROM         dbo.orders_all_test AS a LEFT OUTER JOIN
                      dbo.AccountType AS at ON a.employer_id = at.Employer_ID LEFT OUTER JOIN
                      CRMData.dbo.tbl_Account AS account ON account.CustomerSiteCode = a.employer_id LEFT OUTER JOIN
                      dbo.EmpInfo AS einf ON einf.employer_id = a.employer_id
WHERE     (a.employer_id NOT IN
                          (SELECT     EmployerID
                            FROM          dbo.EmployerExclusions)) AND (a.order_cost > 0) AND (YEAR(a.creation_time) >= 2008) AND (a.cost > 0) AND (a.employer_service_id NOT IN
                          (SELECT     employer_service_id
                            FROM          dbo._Budget_ExcludeEmployerServiceID))
GO
/****** Object:  View [dbo].[EmployerNoSegment]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmployerNoSegment]
AS
SELECT DISTINCT employer_id
FROM            (SELECT        employer_id, MAX(max_segment) AS max_segment
                          FROM            dbo.employer_max_segment
                          GROUP BY employer_id) AS t
WHERE        (max_segment IS NULL)
GO
/****** Object:  Table [dbo].[Region]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[ID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Parent] [int] NULL,
	[OLDGroupName] [varchar](100) NULL,
	[GroupName] [varchar](100) NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AutoSales_OLAP_3482]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AutoSales_OLAP_3482]
AS
SELECT o.employer_id, 
       o.employer_service_id, 
       ad.Department,
       CASE
           WHEN code LIKE 'FA+VPPL%'
           THEN 'Доступ с публикациями '
           WHEN code LIKE 'FA_%'
           THEN 'Доступ '
           ELSE ''
       END + CASE
                 WHEN code LIKE 'FA%'
                 THEN ' Регион: ' + COALESCE(oname.Region, '') + ' Проф.область: ' + COALESCE(oname.ProfArea, '')
                 ELSE ''
             END + p.Name + ' (заканчивается ' + CAST(CAST(o.expiration_time AS DATE) AS NVARCHAR) + ')' AS ActTitle, 
       CAST(GETDATE() AS DATE) AS StartDate, 
       CAST(o.expiration_time AS DATE) AS DueDate, 
       ad.Id AS AccountID, 
       ad.ManagerID AS OwnerID, 
       o.code, 
       'F51C4643-58E6-DF11-971B-001D60E938C6' AS ActivityCategoryId
FROM dbo.orders_all_cleansed AS o
     LEFT OUTER JOIN CRMData750.dbo.AccountDetail AS ad ON ad.ClientSiteCode = o.employer_id
     LEFT OUTER JOIN CommonData.dbo.Product AS p ON p.ID = o.code
     LEFT JOIN
(
    SELECT [employer_id], 
           [employer_service_id], 
           SUBSTRING(r.Region, 0, LEN(r.Region)) region, 
           COALESCE(SUBSTRING(pa.profarea, 0, LEN(pa.profarea)), 'Все проф.области') ProfArea
    FROM [ActivationAnalysisData].[dbo].[orders_all_cleansed] o
         LEFT JOIN
    (
        SELECT DISTINCT 
               sa0.serviceID, -- название задачи
        (
            SELECT r.Name + ', ' -- список исполнителей для задачи через запятую
            FROM ActivationAnalysisData.dbo.service_area sa
                 LEFT JOIN ActivationAnalysisData.dbo.Region r ON sa.areaID = r.ID
            WHERE sa.serviceID = sa0.serviceID FOR XML PATH('')
        ) AS Region
        FROM ActivationAnalysisData.dbo.service_area sa0
    ) AS r ON r.serviceID = o.service_id
         LEFT JOIN
    (
        SELECT DISTINCT 
               sa0.serviceID, -- название задачи
        (
            SELECT r.Name + ', ' -- список исполнителей для задачи через запятую
            FROM ActivationAnalysisData.dbo.[service_professional_area] sa
                 LEFT JOIN CommonData.dbo.ProfArea r ON sa.areaID = r.ID
            WHERE sa.serviceID = sa0.serviceID FOR XML PATH('')
        ) AS profarea
        FROM ActivationAnalysisData.dbo.[service_professional_area] sa0
    ) AS pa ON pa.serviceID = o.service_id
    WHERE code LIKE 'FA%'
) AS oname ON oname.employer_service_id = o.employer_service_id
WHERE(o.unit = 'дн')
     AND (o.seller_account_id = 1)
     AND (o.original_cnt >= 30)
     AND (o.original_cnt >= 30)
     AND (o.original_cnt < 92)
     AND (DATEDIFF(day, CAST(GETDATE() AS DATE), CAST(o.expiration_time AS DATE)) = 14)
     AND (ad.ManagerID IN
(
    SELECT c.ID
    FROM CRMData750.dbo.Contact AS c
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa ON sa.ContactId = c.ID
         INNER JOIN CRMData750.dbo.SysUserInRole AS su ON su.SysUserId = sa.Id
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa1 ON sa1.Id = su.SysRoleId
    WHERE(sa1.Name = 'Роль для нового кейса продаж')
))
    OR (o.unit = 'дн')
    AND (o.seller_account_id = 1)
    AND (o.original_cnt >= 30)
    AND (o.original_cnt >= 92)
    AND (o.original_cnt < 183)
    AND (DATEDIFF(day, CAST(GETDATE() AS DATE), CAST(o.expiration_time AS DATE)) = 30)
    AND (ad.ManagerID IN
(
    SELECT c.ID
    FROM CRMData750.dbo.Contact AS c
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa ON sa.ContactId = c.ID
         INNER JOIN CRMData750.dbo.SysUserInRole AS su ON su.SysUserId = sa.Id
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa1 ON sa1.Id = su.SysRoleId
    WHERE(sa1.Name = 'Роль для нового кейса продаж')
))
    OR (o.unit = 'дн')
    AND (o.seller_account_id = 1)
    AND (o.original_cnt >= 30)
    AND (o.original_cnt >= 183)
    AND (o.original_cnt < 365)
    AND (DATEDIFF(day, CAST(GETDATE() AS DATE), CAST(o.expiration_time AS DATE)) = 60)
    AND (ad.ManagerID IN
(
    SELECT c.ID
    FROM CRMData750.dbo.Contact AS c
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa ON sa.ContactId = c.ID
         INNER JOIN CRMData750.dbo.SysUserInRole AS su ON su.SysUserId = sa.Id
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa1 ON sa1.Id = su.SysRoleId
    WHERE(sa1.Name = 'Роль для нового кейса продаж')
))
    OR (o.unit = 'дн')
    AND (o.seller_account_id = 1)
    AND (o.original_cnt >= 30)
    AND (o.original_cnt >= 365)
    AND (DATEDIFF(day, CAST(GETDATE() AS DATE), CAST(o.expiration_time AS DATE)) = 90)
    AND (ad.ManagerID IN
(
    SELECT c.ID
    FROM CRMData750.dbo.Contact AS c
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa ON sa.ContactId = c.ID
         INNER JOIN CRMData750.dbo.SysUserInRole AS su ON su.SysUserId = sa.Id
         INNER JOIN CRMData750.dbo.SysAdminUnit AS sa1 ON sa1.Id = su.SysRoleId
    WHERE(sa1.Name = 'Роль для нового кейса продаж')
))
GO
/****** Object:  View [dbo].[PriceProfArea]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PriceProfArea]
AS
SELECT DISTINCT [profarea_name], [profarea_id]
FROM            [ActivationAnalysisData].[dbo].[price_rus]
UNION
SELECT DISTINCT [profarea_name], [profarea_id]
FROM            [ActivationAnalysisData].[dbo].[price_rus_2013]
union
select 'Несколько проф.областей', -1
GO
/****** Object:  Table [dbo].[OLAP_3843_VacancyLittleResponse]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_3843_VacancyLittleResponse](
	[AccountID] [uniqueidentifier] NULL,
	[Vacancy] [varchar](52) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_olap_3843_LittleResponse]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_olap_3843_LittleResponse]
AS
SELECT ClientSiteCode [employer_id], 
       'Мало откликов' [ActTitle], 
       CAST(GETDATE() AS DATE) [StartDate], 
       CAST(DATEADD(day, 7, GETDATE()) AS DATE) [DueDate], 
       id [AccountId], 
       [ManagerID] [OwnerId], 
       CAST('F51C4643-58E6-DF11-971B-001D60E938C6' AS UNIQUEIDENTIFIER) [ActivityCategoryId]
	   ,Result
FROM [CRMData750].[dbo].[AccountDetail] ad
inner join (  SELECT 
  [AccountID],
  Result = STUFF((
            SELECT '  ' + [Vacancy]
            FROM [ActivationAnalysisData].[dbo].[OLAP_3843_VacancyLittleResponse] vr1
			where vr1.[AccountID]=vr.[AccountID]
            FOR XML PATH('')
            ), 1, 1, '')
FROM [ActivationAnalysisData].[dbo].[OLAP_3843_VacancyLittleResponse] vr) as vr2
on vr2.AccountID=ad.Id

WHERE [Department] IN('ОКР (Новосибирск)', 'ОКП (Новосибирск)')
GO
/****** Object:  Table [dbo].[OLAP_2345_FastFlow_processed]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_FastFlow_processed](
	[ClientSiteCode] [int] NULL,
	[employer_service_id] [int] NULL,
	[CreatedOn] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP_2345_FastFlow]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_FastFlow](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[ActTitle] [varchar](174) NOT NULL,
	[StartDate] [varchar](30) NULL,
	[DueDate] [varchar](30) NULL,
	[AccountId] [nvarchar](50) NULL,
	[OwnerId] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_for_app_OLAP_2345_FastFlow]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_for_app_OLAP_2345_FastFlow]
AS
SELECT        ff.employer_id, ff.ActTitle, CAST(GETDATE() AS DATE) AS StartDate, DATEADD(day, 21, CAST(GETDATE() AS DATE)) AS DueDate, ff.AccountId, ff.OwnerId, ff.ActivityCategoryId, ad.ClientSiteCode AS HHID, 
                         CAST('5FB76920-53E6-DF11-971B-001D60E938C6' AS nvarchar(50)) AS CurrencyId
FROM            dbo.OLAP_2345_FastFlow AS ff LEFT OUTER JOIN
                         CRMData750.dbo.AccountDetail AS ad ON ad.ClientSiteCode = ff.employer_id
WHERE        (ff.OwnerId IS NOT NULL) AND (ad.Department NOT IN ('ОПМР-1', 'ОПМР-2', 'ОРП-1', 'ОРП-2', 'ОРП-3')) AND (ff.employer_service_id NOT IN
                             (SELECT        employer_service_id
                               FROM            dbo.OLAP_2345_FastFlow_processed))
GO
/****** Object:  Table [dbo].[OLAP_2345_SlowFlow_processed]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_SlowFlow_processed](
	[ClientSiteCode] [int] NULL,
	[SnapshotDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP_2345_SlowFlow]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_SlowFlow](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[ActTitle] [varchar](178) NOT NULL,
	[StartDate] [varchar](30) NULL,
	[DueDate] [varchar](30) NULL,
	[AccountId] [nvarchar](50) NULL,
	[OwnerId] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_for_app_OLAP_2345_SlowFlow]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_for_app_OLAP_2345_SlowFlow]
AS
SELECT DISTINCT sf.employer_id, sf.employer_service_id, sf.ActTitle, sf.StartDate, sf.DueDate, sf.AccountId, sf.OwnerId, sf.ActivityCategoryId, sfp.SnapshotDate
FROM            dbo.OLAP_2345_SlowFlow AS sf LEFT OUTER JOIN
                             (SELECT        ClientSiteCode, MAX(SnapshotDate) AS SnapshotDate
                               FROM            dbo.OLAP_2345_SlowFlow_processed
                               GROUP BY ClientSiteCode) AS sfp ON sf.employer_id = sfp.ClientSiteCode
WHERE        (DATEDIFF(day, sfp.SnapshotDate, GETDATE()) > 37) OR
                         (sfp.SnapshotDate IS NULL)
GO
/****** Object:  View [dbo].[orders_all_new_prof_area_region]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[orders_all_new_prof_area_region]
AS
SELECT        o.employer_service_id, o.service_id, pa.ProfArea_Name, sa.areaID, s.Name AS Region_Name, s.SellerAccountID, o.activation_time, o.employer_id, o.code, o.cnt, o.cost, o.order_cost, o.seller_account_id, 
                         o.IsBarter
FROM            dbo.orders_all_new AS o LEFT OUTER JOIN
                         dbo.service_professional_area AS spa ON o.service_id = spa.serviceID LEFT OUTER JOIN
                             (SELECT DISTINCT ProfArea_Name, ProfArea_ID
                               FROM            CommonData.dbo.HH_PriceList) AS pa ON pa.ProfArea_ID = CAST(COALESCE (spa.areaID, 0) AS int) LEFT OUTER JOIN
                         dbo.service_area AS sa ON o.service_id = sa.serviceID LEFT OUTER JOIN
                         CommonData.dbo.Region_SellerAccount AS s ON s.ID = sa.areaID
WHERE        (o.activation_time >= '2015-01-01') AND (o.code LIKE 'FA%')
GO
/****** Object:  View [dbo].[Churn_OLAP_3708]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Churn_OLAP_3708]
AS
SELECT        a.ClientSiteCode AS employer_id, 'Компания год не пользуется услугами' AS ActTitle, CAST(DATEFROMPARTS(DATEPART(year, GETDATE()), DATEPART(month, GETDATE()), 10) AS NVARCHAR) AS StartDate, 
                         CAST(DATEFROMPARTS(DATEPART(year, GETDATE()), DATEPART(month, GETDATE()), 17) AS NVARCHAR) AS DueDate, a.Id AS AccountID, a.OwnerId, 'F51C4643-58E6-DF11-971B-001D60E938C6' AS ActivityCategoryId
FROM            CRMData750.dbo.Account AS a LEFT OUTER JOIN
                         CRMData750.dbo.Contact AS c ON c.ID = a.OwnerId LEFT OUTER JOIN
                         Sandbox.smb.sales_department_structure AS sd ON sd.crm_division = CAST(c.ContactDepartmentID AS VARCHAR(50)) LEFT OUTER JOIN
                             (SELECT        employer_id, SUM(adjustments_BS_30day + adjustments_JP_30day + IFRS15_adjustment + revenue_IFRS) AS mbsum
                               FROM            [1CData].dbo.Revenue_export AS r
                               WHERE        (EOMONTH(_period) < EOMONTH(CURRENT_TIMESTAMP)) AND (EOMONTH(DATEADD(year, - 1, CURRENT_TIMESTAMP)) <= EOMONTH(_period))
                               GROUP BY employer_id) AS rev ON rev.employer_id = a.ClientSiteCode INNER JOIN
                             (SELECT        employer_id, SUM(adjustments_BS_30day + adjustments_JP_30day + IFRS15_adjustment + revenue_IFRS) AS mbsum
                               FROM            [1CData].dbo.Revenue_export AS r
                               WHERE        (EOMONTH(DATEADD(month, - 13, CURRENT_TIMESTAMP)) = EOMONTH(_period))
                               GROUP BY employer_id) AS rev1 ON rev1.employer_id = a.ClientSiteCode
WHERE        (sd.type IN ('ОКР', 'ОКП', 'КАМ', 'КА')) AND (c.SKS = 0) AND (rev1.mbsum > 0) AND (rev.employer_id IS NULL) OR
                         (sd.type IN ('ОКР', 'ОКП', 'КАМ', 'КА')) AND (c.SKS = 0) AND (rev1.mbsum > 0) AND (rev.mbsum <= 0)
GO
/****** Object:  View [dbo].[EmployerToService]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmployerToService]
AS
SELECT DISTINCT service_id, employer_service_Code
FROM            dbo.orders_all_4analysis
GO
/****** Object:  View [dbo].[OLAP-169]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*WHERE     (employer_service_id NOT IN
                          (SELECT DISTINCT employer_service_id
                            FROM          dbo.orders_all))
*/
CREATE VIEW [dbo].[OLAP-169]
AS
SELECT     dbo.orders_all_new.employer_id AS ClientCode, 'http://hh.ru/employer/' + CAST(dbo.orders_all_new.employer_id AS varchar) AS ClientLink, 
                      CRMData.dbo.tbl_Account.OfficialAccountName AS OfficialName, CRMData.dbo.tbl_Contact.Name AS Manager, 
                      CRMData.dbo.tbl_ContactDepartment.Name AS ManagerDepartment, COUNT(*) AS ActivationFact
FROM         dbo.orders_all_new LEFT OUTER JOIN
                      CRMData.dbo.tbl_Account ON CRMData.dbo.tbl_Account.CustomerSiteCode = dbo.orders_all_new.employer_id LEFT OUTER JOIN
                      CRMData.dbo.tbl_Contact ON CRMData.dbo.tbl_Contact.ID = CRMData.dbo.tbl_Account.OwnerID LEFT OUTER JOIN
                      CRMData.dbo.tbl_ContactDepartment ON CRMData.dbo.tbl_ContactDepartment.ID = CRMData.dbo.tbl_Account.ContactDepartmentID
WHERE     (dbo.orders_all_new.activation_time >= DATEADD(month, - 6, GETDATE())) AND (dbo.orders_all_new.cnt IN (7, 14)) AND (dbo.orders_all_new.code IN ('FA', 'FA+VPP', 
                      'RA')) AND (dbo.orders_all_new.order_cost > 0) AND (dbo.orders_all_new.seller_account_id = 1) AND (dbo.orders_all_new.employer_id NOT IN
                          (SELECT     employer_id
                            FROM          dbo.orders_all_new AS orders_all_new_1
                            WHERE      (activation_time >= DATEADD(month, - 6, GETDATE())) AND (cnt > 29) AND (code IN ('FA', 'FA+VPP', 'RA')) AND (order_cost > 0) AND 
                                                   (seller_account_id = 1)))
GROUP BY dbo.orders_all_new.employer_id, CRMData.dbo.tbl_Account.OfficialAccountName, CRMData.dbo.tbl_Contact.Name, CRMData.dbo.tbl_ContactDepartment.Name
GO
/****** Object:  View [dbo].[vw_olap_314_2]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_olap_314_2]
AS
SELECT        CAST(dbo.orders_all_new.activation_time AS date) AS activation_date, dbo.spending_2013.employer_id, CRMData.dbo.tbl_Account.OfficialAccountName, 
                         dbo.spending_2013.code, SUM(CAST(dbo.spending_2013.qtty AS float)) AS sqtty, dbo.orders_all_new.cnt, CRMData.dbo.tbl_Contact.Name AS Manager, 
                         CRMData.dbo.tbl_ContactDepartment.Name AS Department
FROM            dbo.spending_2013 LEFT OUTER JOIN
                         dbo.orders_all_new ON dbo.orders_all_new.employer_service_id = dbo.spending_2013.employer_service_id AND 
                         dbo.orders_all_new.code = dbo.spending_2013.code LEFT OUTER JOIN
                         CRMData.dbo.tbl_Account ON dbo.spending_2013.employer_id = CRMData.dbo.tbl_Account.CustomerSiteCode LEFT OUTER JOIN
                         CRMData.dbo.tbl_Contact ON CRMData.dbo.tbl_Contact.ID = CRMData.dbo.tbl_Account.OwnerID LEFT OUTER JOIN
                         CRMData.dbo.tbl_ContactDepartment ON CRMData.dbo.tbl_ContactDepartment.ID = CRMData.dbo.tbl_Contact.ContactDepartmentID
WHERE        (dbo.spending_2013.code = 'RENEWAL_VP')
GROUP BY CAST(dbo.orders_all_new.activation_time AS date), dbo.spending_2013.employer_id, CRMData.dbo.tbl_Account.OfficialAccountName, dbo.spending_2013.code, 
                         dbo.orders_all_new.cnt, CRMData.dbo.tbl_Contact.Name, CRMData.dbo.tbl_ContactDepartment.Name
GO
/****** Object:  Table [dbo].[_Budget_ExcludeEmployerID]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Budget_ExcludeEmployerID](
	[employer_id] [float] NULL,
	[Comment] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_Products]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_Products](
	[Id] [int] NOT NULL,
	[ProductCode] [nvarchar](50) NULL,
	[ProductName] [nvarchar](255) NULL,
	[ContinuedService] [bit] NULL,
	[ProductGroup] [nvarchar](200) NULL,
	[Name] [nvarchar](255) NULL,
	[ProductPlanGroup] [nvarchar](150) NULL,
	[PublicationName] [nvarchar](max) NULL,
	[PublicationMetallic] [nchar](10) NULL,
	[Platform] [nchar](50) NULL,
	[GroupName] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[12month_activation]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[12month_activation](
	[employer_id] [int] NULL,
	[activation_days] [int] NULL,
	[segment_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[12month_activation_day_use]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[12month_activation_day_use](
	[employer_id] [int] NULL,
	[used_days] [int] NULL,
	[segment_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[12month_by_day_activation]    Script Date: 29.03.2020 11:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[12month_by_day_activation](
	[seller_account_id] [smallint] NULL,
	[employer_id] [int] NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[code] [nvarchar](50) NULL,
	[PK_Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[12month_vacancy_spending]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[12month_vacancy_spending](
	[employer_id] [int] NULL,
	[spending_cont] [int] NULL,
	[segment_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivationPlan]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivationPlan](
	[Date] [datetime] NULL,
	[Plan] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivationPlanMDS]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivationPlanMDS](
	[Date] [datetime] NULL,
	[ProductCategory] [nvarchar](250) NULL,
	[Value] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AM_Subscriptions]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_Subscriptions](
	[SellerAccountID] [int] NULL,
	[EmployerID] [int] NULL,
	[EmployerName] [varchar](150) NULL,
	[Department] [varchar](150) NULL,
	[AccountManager] [varchar](150) NULL,
	[ServiceID] [int] NULL,
	[EmployerServiceID] [int] NULL,
	[ProductName] [varchar](50) NULL,
	[ActivationDate] [date] NULL,
	[Duration] [int] NULL,
	[ExpirationDate] [date] NULL,
	[OrderCost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AM_SubscriptionsNotRenewed]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AM_SubscriptionsNotRenewed](
	[SellerAccount] [varchar](20) NULL,
	[EmployerID] [int] NULL,
	[EmployerName] [varchar](150) NULL,
	[EmployerServiceID] [int] NULL,
	[ProductName] [varchar](50) NULL,
	[Department] [varchar](150) NULL,
	[AccountManager] [varchar](150) NULL,
	[Duration] [int] NULL,
	[ExpiredOn] [date] NULL,
	[OrderCost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[annual_subscription_churn_reason]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[annual_subscription_churn_reason](
	[service_id] [int] NULL,
	[employer_id] [int] NULL,
	[employer_name] [varchar](255) NULL,
	[department] [varchar](255) NULL,
	[manager] [varchar](255) NULL,
	[expiration_date] [datetime] NULL,
	[reason_id] [int] NULL,
	[comment] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[annual_subscription_renewal]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[annual_subscription_renewal](
	[report_date] [date] NULL,
	[renewal_deadline] [datetime] NULL,
	[Week_Of_Year] [int] NULL,
	[Year] [int] NULL,
	[Week_Start_Date] [date] NULL,
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
	[employer_name] [nvarchar](250) NULL,
	[manager] [nvarchar](4000) NULL,
	[department] [nvarchar](250) NULL,
	[employer_region_group] [varchar](250) NULL,
	[renewed_now] [int] NOT NULL,
	[renewed_now_by_service_id] [int] NULL,
	[renewed_in_30d_after_expiration] [int] NOT NULL,
	[renewed_in_30d_after_expiration_by_service_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Applicantservice]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applicantservice](
	[user_id] [int] NULL,
	[activation_time] [datetime] NULL,
	[type] [smallint] NULL,
	[purchase_source] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicantserviceType]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicantserviceType](
	[ID] [smallint] NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AttractEmployers]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttractEmployers](
	[employer_id] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bargain]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bargain](
	[ID] [smallint] NULL,
	[Description] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bargain_employer_service]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bargain_employer_service](
	[bargain_id] [smallint] NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bargain_plan]    Script Date: 29.03.2020 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bargain_plan](
	[Period] [date] NULL,
	[Value] [int] NULL,
	[Metric] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill_error]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_error](
	[Flat File Source Error Output Column] [varchar](max) NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill_reserve]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_reserve](
	[bill_reserve_id] [int] NULL,
	[bill_id] [int] NULL,
	[spo_type] [tinyint] NULL,
	[amount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bills]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bills](
	[ID] [int] NULL,
	[EmployerID] [int] NULL,
	[PayerID] [int] NULL,
	[CreationTime] [datetime] NULL,
	[PaymentTime] [datetime] NULL,
	[PaymentOrderDate] [datetime] NULL,
	[PaymentAmount] [nvarchar](160) NULL,
	[StatusID] [smallint] NULL,
	[Price] [nvarchar](200) NULL,
	[Currency] [nvarchar](30) NULL,
	[Type] [smallint] NULL,
	[BillNumber] [nvarchar](19) NULL,
	[Source] [nvarchar](70) NULL,
	[CreatedByManagerID] [int] NULL,
	[CartID] [int] NULL,
	[Vat] [smallint] NULL,
	[PriceVat] [bigint] NULL,
	[PriceWithoutVat] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillStatus]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillStatus](
	[ID] [int] NULL,
	[Name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillType]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillType](
	[ID] [smallint] NULL,
	[Name] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BuyType]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BuyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_source]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_source](
	[cart_id] [int] NULL,
	[cart_source] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day_employer_vacancy]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day_employer_vacancy](
	[employer_id] [int] NULL,
	[date] [date] NULL,
	[vacancy_count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day_service]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day_service](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[service_id] [int] NULL,
	[service_code] [nvarchar](50) NULL,
	[service_duration] [int] NULL,
	[service_duration_name] [int] NULL,
	[region_path] [nvarchar](max) NULL,
	[profarea_path] [nvarchar](max) NULL,
	[activation_date] [date] NULL,
	[expiration_date] [date] NULL,
	[date] [date] NULL,
	[revenue] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deed]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deed](
	[deed_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[price] [varchar](10) NULL,
	[days] [int] NULL,
	[seller_account_id] [smallint] NULL,
	[visibility] [nvarchar](1) NULL,
	[number] [varchar](10) NULL,
	[Vat] [smallint] NULL,
	[PriceVat] [int] NULL,
	[PriceWithoutVat] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeedBill]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeedBill](
	[ID] [int] NULL,
	[DeedID] [int] NULL,
	[BillID] [int] NULL,
	[Price] [varchar](10) NULL,
	[Currency] [varchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeedCode]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeedCode](
	[deed_id] [int] NULL,
	[deed_datetime] [datetime] NULL,
	[payer_id] [int] NULL,
	[seller_account_id] [int] NULL,
	[visibility] [nvarchar](50) NULL,
	[is_barter] [nvarchar](50) NULL,
	[employer_service_id] [int] NULL,
	[order_creation_datetime] [datetime] NULL,
	[order_activation_datetime] [datetime] NULL,
	[order_total_cost] [real] NULL,
	[order_line_cost] [real] NULL,
	[order_line_count] [int] NULL,
	[employer_id] [int] NULL,
	[employer_region_group] [varchar](250) NULL,
	[code] [nvarchar](50) NULL,
	[days_in_deed] [int] NULL,
	[days_in_service] [int] NULL,
	[contract_term_id] [int] NULL,
	[Level1] [nvarchar](255) NULL,
	[Level2] [nvarchar](255) NULL,
	[Level3] [varchar](255) NULL,
	[Level4] [varchar](255) NULL,
	[Level5] [varchar](255) NULL,
	[deed_line_cost] [float] NULL,
	[deed_total_cost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeedCode_STG]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeedCode_STG](
	[employer_service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[code] [nvarchar](50) NULL,
	[line_cost] [real] NULL,
	[order_cost] [real] NULL,
	[line_count] [int] NULL,
	[is_barter] [nvarchar](50) NULL,
	[line_cost_total] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deeds_before2013]    Script Date: 29.03.2020 11:09:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deeds_before2013](
	[employer_service_id] [float] NULL,
	[creation_time] [datetime] NULL,
	[employer_id] [float] NULL,
	[account_id] [float] NULL,
	[payer_id] [float] NULL,
	[price] [float] NULL,
	[days] [float] NULL,
	[stored] [datetime] NULL,
	[id] [uniqueidentifier] NULL,
	[isInvisible] [float] NULL,
	[deed_id] [float] NULL,
	[SellerAccountID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL__Products_old]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL__Products_old](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](50) NULL,
	[ProductName] [nvarchar](255) NULL,
	[ContinuedService] [bit] NULL,
	[ProductGroup] [nvarchar](200) NULL,
	[Name] [nvarchar](255) NULL,
	[ProductPlanGroup] [nvarchar](150) NULL,
	[PublicationName] [nvarchar](max) NULL,
	[PublicationMetallic] [nchar](10) NULL,
	[Platform] [nchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_activations_chart_for_forecasting]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_activations_chart_for_forecasting](
	[MY] [date] NULL,
	[employer_segment] [varchar](7) NULL,
	[product_group] [varchar](10) NULL,
	[region_group] [varchar](250) NULL,
	[activations_ex_vat] [float] NULL,
	[activations_ex_vat_LY] [float] NULL,
	[customer_count] [int] NULL,
	[customer_count_LY] [int] NULL,
	[pct_growth] [float] NULL,
	[adjusted_pct_growth] [float] NULL,
	[daily_avg_activations_ex_vat] [float] NULL,
	[daily_avg_activations_ex_vat_LY] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_Bills_old]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Bills_old](
	[ID] [int] NULL,
	[EmployerID] [int] NULL,
	[PayerID] [int] NULL,
	[CreationTime] [datetime] NULL,
	[PaymentTime] [datetime] NULL,
	[PaymentOrderDate] [datetime] NULL,
	[StatusID] [smallint] NULL,
	[Price] [decimal](28, 2) NULL,
	[Currency] [varchar](50) NULL,
	[Type] [smallint] NULL,
	[BillNumber] [varchar](50) NULL,
	[Source] [varchar](50) NULL,
	[CreatedByManagerID] [bigint] NULL,
	[CartID] [int] NULL,
	[Vat] [float] NULL,
	[PriceVat] [float] NULL,
	[PriceWithoutVat] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_Deed_1]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Deed_1](
	[deed_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[price] [varchar](10) NULL,
	[days] [int] NULL,
	[seller_account_id] [smallint] NULL,
	[visibility] [varchar](1) NULL,
	[number] [varchar](10) NULL,
	[Vat] [smallint] NULL,
	[PriceVat] [int] NULL,
	[PriceWithoutVat] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_Deed_for_audit]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Deed_for_audit](
	[Название Клиента] [nvarchar](250) NULL,
	[employer_id] [int] NULL,
	[Категория] [varchar](1) NULL,
	[Кол-во сотрудников] [nvarchar](250) NULL,
	[Кол-во HR] [nvarchar](250) NULL,
	[Дата регистрации] [date] NULL,
	[Дата акта] [datetime] NULL,
	[Месяц акта] [date] NULL,
	[Продукт] [nvarchar](255) NULL,
	[original_code] [nvarchar](4000) NULL,
	[Количество] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[Сумма акта на продукт] [float] NULL,
	[Менеджер клиента] [nvarchar](250) NULL,
	[Отдел менеджера клиента] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_Deed_old]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_Deed_old](
	[deed_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[price] [float] NULL,
	[days] [int] NULL,
	[seller_account_id] [int] NULL,
	[visibility] [nvarchar](50) NULL,
	[number] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_employer_max_segment_snapshot]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_employer_max_segment_snapshot](
	[SnapshotDate] [date] NULL,
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_For_Danina_step1_1]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_For_Danina_step1_1](
	[creation_time] [datetime] NULL,
	[Название Клиента] [nvarchar](250) NULL,
	[employer_id] [int] NULL,
	[Кол-во сотрудников] [nvarchar](250) NULL,
	[Кол-во HR] [nvarchar](250) NULL,
	[Дата регистрации] [date] NULL,
	[Дата акта] [datetime] NULL,
	[Месяц акта] [date] NULL,
	[code] [nvarchar](4000) NULL,
	[Продукт] [nvarchar](255) NULL,
	[Сумма акта на продукт] [float] NULL,
	[Менеджер клиента] [nvarchar](250) NULL,
	[Отдел менеджера клиента] [nvarchar](250) NULL,
	[original_cnt] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[adjusted_cost] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_LongSalese_FastFlow]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_LongSalese_FastFlow](
	[employer_id] [int] NULL,
	[ActivityDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_LongSalese_SlowFlow]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_LongSalese_SlowFlow](
	[employer_id] [int] NULL,
	[ActivityDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_orders_all_upload_fromPG]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_orders_all_upload_fromPG](
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
	[cost] [nvarchar](100) NULL,
	[order_cost] [nvarchar](100) NULL,
	[seller_account_id] [smallint] NULL,
	[buyed_by_manager_id] [int] NULL,
	[given_discount_rate] [nvarchar](250) NULL,
	[service_name] [nvarchar](3000) NULL,
	[SpecialOfferID] [nvarchar](50) NULL,
	[Splitted] [nvarchar](50) NULL,
	[IsBarter] [nvarchar](50) NULL,
	[prolongates] [int] NULL,
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_pp]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_pp](
	[Value] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEL_spending]    Script Date: 29.03.2020 11:09:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEL_spending](
	[ID] [int] NULL,
	[date] [datetime] NULL,
	[order_id] [int] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[code] [varchar](50) NULL,
	[qtty] [varchar](50) NULL,
	[t] [int] NULL,
	[seller_account_id] [int] NULL,
	[object_id] [int] NULL,
	[employer_manager_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscardedOrders]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscardedOrders](
	[seller_account_id] [smallint] NULL,
	[employer_id] [int] NULL,
	[payer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[code] [nvarchar](50) NULL,
	[cnt] [int] NULL,
	[original_cost] [real] NULL,
	[adjusted_cost] [real] NULL,
	[order_cost] [real] NULL,
	[buyed_by_manager_id] [int] NULL,
	[service_name] [nvarchar](3000) NULL,
	[is_barter] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dominant_service_duration]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dominant_service_duration](
	[year] [int] NULL,
	[employer_id] [int] NULL,
	[dominant_service_duration_name] [int] NULL,
	[frequency] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dominant_service_duration_month]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dominant_service_duration_month](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[month] [date] NULL,
	[service_duration_name] [int] NULL,
	[days_in_year] [int] NULL,
	[segment_by_duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dominant_service_duration_month_temp]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dominant_service_duration_month_temp](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[month] [date] NULL,
	[service_duration_name] [int] NULL,
	[days_in_year] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dominant_service_duration_temp]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dominant_service_duration_temp](
	[employer_id] [int] NULL,
	[service_duration_name] [int] NULL,
	[year] [int] NULL,
	[days] [int] NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_duration]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_duration](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[frequency] [int] NULL,
	[total_revenue] [float] NULL,
	[segment_by_duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_duration_curr_kz]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_duration_curr_kz](
	[employer_id] [int] NULL,
	[segment_by_duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_long_sales_slow_flow]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_long_sales_slow_flow](
	[employer_id] [int] NULL,
	[ActivityDate] [date] NULL,
	[ActTitle] [varchar](177) NOT NULL,
	[GetReq] [nvarchar](568) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_max_segment_by]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_by](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_max_segment_curr_kz]    Script Date: 29.03.2020 11:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_curr_kz](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_max_segment_kz]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_kz](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_max_segment_last]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_last](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL,
	[max_segment] [int] NULL,
	[max_segment_by_duration] [int] NULL,
	[max_segment_by_vacancy_count] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[max_segment_by_duration_name] [varchar](1) NULL,
	[max_segment_by_vacancy_count_name] [varchar](1) NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_max_segment_old_new]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_max_segment_old_new](
	[employer_id] [int] NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[max_segment_new] [int] NULL,
	[max_segment_old] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_month]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_month](
	[DateMonth] [date] NULL,
	[ClientSiteCode] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[total_service_days] [int] NULL,
	[total_service_months] [float] NULL,
	[dominant_service_duration_name] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment_by]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment_by](
	[employer_id] [int] NULL,
	[segment_id] [int] NULL,
	[segment_name] [varchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment_curr_kz]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment_curr_kz](
	[employer_id] [int] NULL,
	[account_state] [nvarchar](250) NULL,
	[account_type] [nvarchar](250) NULL,
	[vintage_MY] [date] NULL,
	[vintage_Y] [int] NULL,
	[year] [int] NULL,
	[segment_by_duration] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL,
	[segment] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment_month_action]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment_month_action](
	[DateMonth] [date] NULL,
	[ClientSiteCode] [int] NULL,
	[month_active] [date] NULL,
	[last_active_month] [date] NULL,
	[diff_month] [int] NULL,
	[max_segment_name] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment_month_churn]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment_month_churn](
	[DateMonth] [date] NULL,
	[ClientSiteCode] [int] NULL,
	[max_segment_name] [varchar](1) NULL,
	[diff_month] [int] NULL,
	[ChurnType] [varchar](9) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_segment_OLAP_3469]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_segment_OLAP_3469](
	[employer_id] [int] NULL,
	[segment_id] [int] NULL,
	[segment_name] [varchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_service_area]    Script Date: 29.03.2020 11:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_service_area](
	[employer_service_id] [float] NULL,
	[service_id] [float] NULL,
	[area_id] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_service_professional_area]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_service_professional_area](
	[employer_service_id] [float] NULL,
	[service_id] [float] NULL,
	[professional_area_id] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_vacancy]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_vacancy](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_vacancy_curr_kz]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_vacancy_curr_kz](
	[employer_id] [int] NULL,
	[vacancy_count] [int] NULL,
	[segment_by_vacancy_count] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_Xsegment]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_Xsegment](
	[employer_id] [int] NULL,
	[segment_id] [int] NULL,
	[segment_name] [varchar](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employer_Xsegment_snapshot]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employer_Xsegment_snapshot](
	[snapsptdate] [date] NULL,
	[employer_id] [int] NULL,
	[segment_id] [int] NULL,
	[segment_name] [varchar](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerNoUsePeriod]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerNoUsePeriod](
	[EmployerID] [float] NULL,
	[startdate] [datetime] NULL,
	[enddate] [datetime] NULL,
	[NextPublicationDate] [datetime] NULL,
	[dayt] [float] NULL,
	[noUse] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeRates]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeRates](
	[Period] [datetime] NULL,
	[Valuta] [nvarchar](10) NULL,
	[Kurs] [numeric](10, 4) NULL,
	[Kratnost] [numeric](10, 0) NULL,
	[SallerAccountID] [int] NULL,
	[LCYVAT] [numeric](3, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HRSpacePlan]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HRSpacePlan](
	[Date] [date] NULL,
	[Plan] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadGenProducts]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadGenProducts](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedById] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[ModifiedById] [uniqueidentifier] NULL,
	[ProcessListeners] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[Score] [int] NOT NULL,
	[DaysForEnd] [int] NOT NULL,
	[NewProduct] [bit] NOT NULL,
	[COMM] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK96qInAvkjqKwBc104p0Up48yI] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagersClients]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagersClients](
	[EmployerID] [bigint] NULL,
	[Manager] [nvarchar](4000) NULL,
	[Department] [nvarchar](250) NULL,
	[OfficialAccountName] [nvarchar](250) NULL,
	[sellerAccountId] [int] NULL,
	[Region] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManualOrderProductPrices]    Script Date: 29.03.2020 11:09:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManualOrderProductPrices](
	[employer_service_id] [int] NULL,
	[code] [varchar](50) NULL,
	[cost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MergeSubscriptions]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MergeSubscriptions](
	[employer_id] [float] NULL,
	[creation_date] [datetime] NULL,
	[service_id] [float] NULL,
	[grouping_service_id] [float] NULL,
	[code] [nvarchar](255) NULL,
	[cnt] [float] NULL,
	[adjusted_cost] [float] NULL,
	[preceeding_service_id] [float] NULL,
	[succeeding_service_id] [float] NULL,
	[region_path] [nvarchar](255) NULL,
	[profarea_path] [nvarchar](255) NULL,
	[activated_by] [nvarchar](255) NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[comment] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MergeSubscriptions_with_Data]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MergeSubscriptions_with_Data](
	[employer_id] [float] NULL,
	[creation_date] [datetime] NULL,
	[service_id] [float] NULL,
	[grouping_service_id] [float] NULL,
	[code] [nvarchar](255) NULL,
	[cnt] [float] NULL,
	[adjusted_cost] [float] NULL,
	[preceeding_service_id] [float] NULL,
	[succeeding_service_id] [float] NULL,
	[region_path] [nvarchar](255) NULL,
	[profarea_path] [nvarchar](255) NULL,
	[activated_by] [nvarchar](255) NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[comment] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[month_employer_vacancy]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[month_employer_vacancy](
	[employer_id] [int] NULL,
	[date] [date] NULL,
	[max_vacancy_in_month] [int] NULL,
	[max_vacancy_to_month] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[month_payments_not_activated_at_month_end]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[month_payments_not_activated_at_month_end](
	[t] [varchar](15) NOT NULL,
	[Year] [int] NULL,
	[adjusted_month_no] [int] NULL,
	[adjusted_month_name_RU] [varchar](10) NULL,
	[amount_sum] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP_2345_FastFlow_control]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_FastFlow_control](
	[DateProcess] [date] NULL,
	[employer_id] [int] NULL,
	[ActTitle] [varchar](500) NULL,
	[StartDate] [date] NULL,
	[DueDate] [date] NULL,
	[AccountId] [nvarchar](50) NULL,
	[OwnerId] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NULL,
	[HHID] [int] NULL,
	[CurrencyId] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP_2345_FastFlow_processed_old]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_FastFlow_processed_old](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP_2345_SlowFlow_control]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP_2345_SlowFlow_control](
	[DateProcess] [date] NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[ActTitle] [varchar](178) NULL,
	[StartDate] [varchar](30) NULL,
	[DueDate] [varchar](30) NULL,
	[AccountId] [nvarchar](50) NULL,
	[OwnerId] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OLAP-1958]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OLAP-1958](
	[F1] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_actualdate]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_actualdate](
	[creation_time] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all](
	[order_id] [float] NULL,
	[service_id] [float] NULL,
	[employer_service_id] [float] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[employer_id] [float] NULL,
	[account_id] [float] NULL,
	[payer_id] [float] NULL,
	[code] [varchar](50) NULL,
	[cnt] [float] NULL,
	[unit] [varchar](2) NULL,
	[price1_old] [float] NULL,
	[cost_old] [float] NULL,
	[order_cost] [float] NULL,
	[employer_service_Code] [varchar](50) NULL,
	[employer_Code] [varchar](50) NULL,
	[price1] [float] NULL,
	[cost] [float] NULL,
	[price_avg] [float] NULL,
	[ActivityName] [nvarchar](250) NULL,
	[FieldName] [nvarchar](250) NULL,
	[SubField] [nvarchar](250) NULL,
	[ContactName] [nvarchar](250) NULL,
	[ContactDepartmentName] [nvarchar](250) NULL,
	[employer_organization_type_id] [int] NULL,
	[OldContactName] [nvarchar](250) NULL,
	[OldContactDepartmentName] [nvarchar](250) NULL,
	[SellerAccountId] [int] NULL,
	[buyed_by_manager_id] [int] NULL,
	[given_discount_rate] [float] NULL,
	[service_name] [nvarchar](2000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_2013]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_2013](
	[order_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[account_id] [int] NULL,
	[payer_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[cnt] [int] NULL,
	[unit] [nvarchar](50) NULL,
	[price1] [nvarchar](50) NULL,
	[cost] [real] NULL,
	[order_cost] [real] NULL,
	[cost_first] [real] NULL,
	[order_cost_first] [real] NULL,
	[seller_account_id] [smallint] NULL,
	[buyed_by_manager_id] [int] NULL,
	[given_discount_rate] [nvarchar](250) NULL,
	[service_name] [nvarchar](3000) NULL,
	[SpecialOfferID] [nvarchar](50) NULL,
	[Splitted] [int] NULL,
	[IsBarter] [int] NULL,
	[employer_service_Code] [nvarchar](100) NULL,
	[employer_Code] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_cleansed_backup_17032020]    Script Date: 29.03.2020 11:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_backup_17032020](
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
/****** Object:  Table [dbo].[orders_all_cleansed_backup26032020]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_backup26032020](
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
/****** Object:  Table [dbo].[orders_all_cleansed_before_merge]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_before_merge](
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
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_cleansed_merge_tmp]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_merge_tmp](
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
	[grouping_subcription_cnt] [float] NULL,
	[grouping_subcription_original_cost] [float] NULL,
	[grouping_subcription_adjusted_cost] [float] NULL,
	[grouping_subcription_expiration_time] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_cleansed_stg]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_stg](
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
	[activated_by_user_name] [nvarchar](250) NULL,
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
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_cleansed_test]    Script Date: 29.03.2020 11:09:10 ******/
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
/****** Object:  Table [dbo].[orders_all_cleansed_with_zero]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleansed_with_zero](
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
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_cleased_accrued]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_cleased_accrued](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[date] [date] NULL,
	[accrued_cnt] [int] NULL,
	[accrued_cost] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_compare_whith_source]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_compare_whith_source](
	[y] [int] NULL,
	[sum of order cost from billing] [float] NULL,
	[sum of adjusted cost] [float] NULL,
	[difference] [float] NULL,
	[difference due to cancellations] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_DI_code_exclude]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_DI_code_exclude](
	[employer_service_id] [int] NULL,
	[code] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_ForSales_ExpDate]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_ForSales_ExpDate](
	[seller_account_id] [smallint] NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[OfficialAccountName] [nvarchar](250) NULL,
	[Manager] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[creation_time] [datetime] NULL,
	[TrainActivation] [varchar](3) NOT NULL,
	[activation_time] [date] NULL,
	[expiration_time] [date] NULL,
	[UsedQttyCount] [int] NULL,
	[adjusted_cost] [real] NULL,
	[order_cost] [real] NULL,
	[code] [nvarchar](50) NULL,
	[ProductName] [nvarchar](255) NULL,
	[ProductGroupName] [nvarchar](255) NULL,
	[original_cnt] [int] NULL,
	[PersonalAccount] [numeric](18, 2) NULL,
	[employer_id_detail] [int] NULL,
	[service_name_detail] [nvarchar](3000) NULL,
	[code_detail] [nvarchar](50) NULL,
	[cnt_detail] [int] NULL,
	[cost_detail] [real] NULL,
	[activation_time_detail] [date] NULL,
	[Region_Detail] [nvarchar](255) NULL,
	[ProductNameDetail] [nvarchar](255) NULL,
	[ProductGroupNameDetail] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_new_prof_area_region_std]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_new_prof_area_region_std](
	[employer_service_id] [int] NULL,
	[service_id] [int] NULL,
	[ProfArea_Name] [nvarchar](250) NULL,
	[areaID] [nvarchar](50) NULL,
	[Region_Name] [nvarchar](250) NULL,
	[SellerAccountID] [int] NULL,
	[activation_time] [datetime] NULL,
	[employer_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[cnt] [int] NULL,
	[cost] [real] NULL,
	[order_cost] [real] NULL,
	[seller_account_id] [smallint] NULL,
	[IsBarter] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_upload]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_upload](
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
	[cost] [nvarchar](100) NULL,
	[order_cost] [nvarchar](100) NULL,
	[seller_account_id] [smallint] NULL,
	[buyed_by_manager_id] [int] NULL,
	[given_discount_rate] [nvarchar](250) NULL,
	[service_name] [nvarchar](3000) NULL,
	[SpecialOfferID] [nvarchar](50) NULL,
	[Splitted] [nvarchar](50) NULL,
	[IsBarter] [nvarchar](50) NULL,
	[prolongates] [int] NULL,
	[withdraw_type] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_with_product_seller_account_id]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_with_product_seller_account_id](
	[SaleCountry] [varchar](11) NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[OfficialAccountName] [nvarchar](250) NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[adjusted_code] [nvarchar](63) NOT NULL,
	[code] [nvarchar](50) NULL,
	[adjusted_cost] [real] NULL,
	[order_cost] [real] NULL,
	[PriceCost] [float] NULL,
	[OwnerCountry] [varchar](11) NULL,
	[Name] [nvarchar](255) NULL,
	[region_name] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders_all_with_product_stg]    Script Date: 29.03.2020 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders_all_with_product_stg](
	[SaleCountry] [varchar](11) NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[OfficialAccountName] [nvarchar](250) NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[adjusted_code] [nvarchar](63) NOT NULL,
	[code] [nvarchar](50) NULL,
	[adjusted_cost] [real] NULL,
	[order_cost] [real] NULL,
	[spa_areaID] [int] NULL,
	[s_areaID] [nvarchar](50) NULL,
	[adjusted_cnt] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[packages]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[packages](
	[employer_service_id] [int] NULL,
	[package_name] [nvarchar](max) NULL,
	[duration] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_activation_register]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_activation_register](
	[account_type] [int] NULL,
	[bill_type_id] [int] NULL,
	[bill_type_name] [varchar](50) NULL,
	[entry_type] [int] NULL,
	[entry_time_orderdate] [datetime] NULL,
	[entry_time_activationdate] [datetime] NULL,
	[employer_id] [int] NULL,
	[bill_id] [int] NULL,
	[bill_paymentdate] [datetime] NULL,
	[employer_service_id] [int] NULL,
	[amount] [float] NULL,
	[amount_exvat] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_activation_register_orderdate]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_activation_register_orderdate](
	[account_type] [int] NULL,
	[bill_type_id] [int] NULL,
	[bill_type_name] [nvarchar](50) NULL,
	[entry_type] [int] NULL,
	[entry_time_orderdate] [datetime] NULL,
	[employer_id] [int] NULL,
	[bill_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[amount] [float] NULL,
	[amount_exvat] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postings_balances_monthly]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postings_balances_monthly](
	[Date] [date] NULL,
	[code] [varchar](30) NULL,
	[in_package] [int] NULL,
	[qty_balance_month_end] [int] NULL,
	[s_mRUB_ex_vat] [float] NULL,
	[qty_activations] [int] NULL,
	[qty_spend] [int] NULL,
	[s_mRUB_ex_vat_activations] [float] NULL,
	[s_mRUB_ex_vat_spend] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postings_register]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postings_register](
	[seller_account_id] [smallint] NULL,
	[entry_type] [smallint] NULL,
	[entry_datetime] [datetime] NULL,
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[in_package] [int] NULL,
	[code] [varchar](30) NULL,
	[qty] [int] NULL,
	[price] [float] NULL,
	[use_type] [smallint] NULL,
	[use_object_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Price_Cost]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price_Cost](
	[creation_date] [date] NULL,
	[profarea_id] [float] NULL,
	[region_id] [float] NULL,
	[region_name] [nvarchar](255) NULL,
	[profarea_name] [nvarchar](255) NULL,
	[cnt] [float] NULL,
	[employer_service_Code] [varchar](50) NULL,
	[cost_pirce_LCY] [float] NULL,
	[cost_pirce_LCYVAT] [float] NULL,
	[costextvat] [float] NULL,
	[cost] [float] NULL,
	[seller_account_id] [int] NULL,
	[cost_pirce] [float] NULL,
	[cost_pirce_VAT] [float] NULL,
	[employer_id] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[price_rus_25032015]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[price_rus_25032015](
	[region_name] [nvarchar](255) NULL,
	[profarea_name] [nvarchar](255) NULL,
	[period] [float] NULL,
	[type] [nvarchar](255) NULL,
	[BYR] [float] NULL,
	[KZT] [float] NULL,
	[RUR] [float] NULL,
	[UAH] [float] NULL,
	[AZN] [float] NULL,
	[region_id] [float] NULL,
	[profarea_id] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[price_rus_26052017]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[price_rus_26052017](
	[region_id] [float] NULL,
	[region_name] [nvarchar](255) NULL,
	[profarea_id] [float] NULL,
	[profarea_name] [nvarchar](255) NULL,
	[period] [float] NULL,
	[type] [nvarchar](255) NULL,
	[price] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCodeReplacement]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCodeReplacement](
	[employer_service_id] [int] NULL,
	[code] [varchar](100) NULL,
	[replacement_code] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductExclusions]    Script Date: 29.03.2020 11:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductExclusions](
	[code] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSegmentRegionPlan]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSegmentRegionPlan](
	[segment] [varchar](1) NULL,
	[region] [varchar](250) NULL,
	[product_group] [varchar](250) NULL,
	[date] [datetime] NULL,
	[plansum] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseSource]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseSource](
	[ID] [smallint] NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RightGiftCost]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RightGiftCost](
	[employer_service_id] [int] NULL,
	[code] [varchar](50) NULL,
	[cnt] [smallint] NULL,
	[cost] [int] NULL,
	[correct cost] [int] NULL,
	[order_cost] [real] NULL,
	[seller_account_id] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_table_period]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_table_period](
	[period] [varchar](33) NOT NULL,
	[year] [int] NULL,
	[adjusted_month_name_RU] [varchar](10) NULL,
	[adjusted_month_no] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[start_date_ly] [date] NULL,
	[end_date_ly] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service_area_path]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_area_path](
	[serviceID] [nvarchar](50) NULL,
	[region_path] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service_area_profarea_price]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_area_profarea_price](
	[service_id] [nvarchar](50) NULL,
	[region_id] [nvarchar](50) NULL,
	[profarea_id] [int] NULL,
	[Total_RRP_inclVAT] [float] NULL,
	[RRP_inclVAT] [float] NULL,
	[FA_Total_RRP_inclVAT] [float] NULL,
	[FA_RRP_inclVAT] [float] NULL,
	[total_adjusted_cost] [real] NULL,
	[adjusted_cost] [float] NULL,
	[FA_adjusted_cost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service_professional_area_all]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_professional_area_all](
	[serviceID] [float] NULL,
	[areaID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[service_professional_area_path]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[service_professional_area_path](
	[serviceID] [nvarchar](50) NULL,
	[profarea_path] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceAreaEmpCode]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceAreaEmpCode](
	[employer_service_Code] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceProfAreaAll]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceProfAreaAll](
	[serviceID] [float] NULL,
	[areaID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpecialOfferProductPrices]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecialOfferProductPrices](
	[special_offer_id] [nvarchar](255) NULL,
	[order_cost] [float] NULL,
	[code] [nvarchar](255) NULL,
	[cost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subscription_churn_reason]    Script Date: 29.03.2020 11:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subscription_churn_reason](
	[id] [int] NULL,
	[name] [varchar](250) NULL,
	[comment] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subscription_history_as_string]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subscription_history_as_string](
	[employer_id] [int] NULL,
	[subscription_history] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchingFromUnlimForCube]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchingFromUnlimForCube](
	[employer_id] [int] NULL,
	[report_date] [date] NULL,
	[product] [nvarchar](50) NULL,
	[adjusted_cnt] [int] NULL,
	[adjusted_cost] [real] NULL,
	[activation_type] [varchar](21) NOT NULL,
	[with_contact] [varchar](26) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AutoSales_OLAP_3482]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoSales_OLAP_3482](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[Department] [nvarchar](250) NULL,
	[ActTitle] [nvarchar](max) NULL,
	[StartDate] [date] NULL,
	[DueDate] [date] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[code] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AutoSales_OLAP_3482_all]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoSales_OLAP_3482_all](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[Department] [nvarchar](250) NULL,
	[original_cnt] [int] NULL,
	[ActTitle] [nvarchar](max) NULL,
	[StartDate] [date] NULL,
	[DueDate] [date] NULL,
	[AccountID] [uniqueidentifier] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[code] [nvarchar](50) NULL,
	[ActivityCategoryId] [varchar](36) NOT NULL,
	[pr] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_AutoSales_OLAP_3482_processed]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoSales_OLAP_3482_processed](
	[employer_service_id] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_olap_314]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_olap_314](
	[activation_date] [date] NULL,
	[employer_id] [int] NULL,
	[OfficialAccountName] [varchar](150) NULL,
	[code] [varchar](50) NULL,
	[sqtty] [float] NULL,
	[cnt] [int] NULL,
	[Manager] [nvarchar](4000) NULL,
	[Department] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[total_service_duration]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[total_service_duration](
	[employer_id] [int] NULL,
	[year] [int] NULL,
	[days] [int] NULL,
	[months] [float] NULL,
	[revenue] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transact_Sales_Products_TEMP_04_00_28]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transact_Sales_Products_TEMP_04_00_28](
	[employer_id] [int] NULL,
	[employer_service_id] [int] NULL,
	[creation_time] [datetime] NULL,
	[activation_time] [datetime] NULL,
	[expiration_time] [datetime] NULL,
	[MaxUsedDate] [datetime] NULL,
	[Code] [nvarchar](50) NULL,
	[original_cnt] [int] NULL,
	[adjusted_cnt] [int] NULL,
	[UsedQttyCount] [int] NOT NULL,
	[region_path] [nvarchar](max) NULL,
	[profarea_path] [nvarchar](max) NULL,
	[service_name] [nvarchar](3000) NULL,
	[unit] [nvarchar](50) NULL,
	[ProductName] [nvarchar](255) NULL,
	[adjustment_info] [varchar](250) NULL,
	[original_cost] [real] NULL,
	[adjusted_cost] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VacancyActivations_SpecCompany]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancyActivations_SpecCompany](
	[Id] [uniqueidentifier] NULL,
	[ClientSiteCode] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[code] [nvarchar](50) NULL,
	[employer_service_id] [int] NULL,
	[activation_time] [datetime] NULL,
	[spending_month] [date] NULL,
	[BuyedByUserID] [int] NULL,
	[BuyedByUsername] [nvarchar](100) NULL,
	[event_id] [uniqueidentifier] NULL,
	[event] [nvarchar](250) NULL,
	[cnt] [int] NULL,
	[qtty] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VacancySnapshotLast_temp]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacancySnapshotLast_temp](
	[VacancyID] [int] NULL,
	[PublicationDate] [date] NULL,
	[ArhivationDate] [date] NULL,
	[VacancyStateID] [int] NULL,
	[code] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebPlanLMS]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebPlanLMS](
	[Date] [datetime] NULL,
	[PlanSum] [float] NULL,
	[Segment] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebServiceBDZPPlan]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebServiceBDZPPlan](
	[Date] [date] NULL,
	[Plan] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebServicePlan]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebServicePlan](
	[Date] [date] NULL,
	[Plan] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Для отчета по активациям]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Для отчета по активациям](
	[data] [datetime] NULL,
	[plan] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[bargain_element]    Script Date: 29.03.2020 11:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[bargain_element](
	[bargain_element_id] [int] NULL,
	[bargain_id] [int] NULL,
	[billing_professional_area_id] [int] NULL,
	[price_region_id] [int] NULL,
	[temporal_service] [nvarchar](1024) NULL,
	[temporal_service_duration] [int] NULL,
	[countable_services] [nvarchar](1024) NULL,
	[price] [bigint] NULL,
	[currency] [nvarchar](3) NULL,
	[service_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DF96qInAvkjqKwBc104p0Up48yI]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DF7qMYP4FcoPgpY7eEffUC6dAEgQ]  DEFAULT (getutcdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DFwtEZEolrU8NI8DZY9mj2Ws6n5Cc]  DEFAULT (getutcdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DFYktvEJdsjiSPFket4jpqBROT5o]  DEFAULT ((0)) FOR [ProcessListeners]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DFQzbWCJr72Fui2MI1pUoRY6mQYo]  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DFyCCwtZ9sqbn2jlxm75SY6K9Exs]  DEFAULT ('') FOR [ProductName]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DF7TnNHUkV5x3219bc93YAD6d7X4]  DEFAULT ((0)) FOR [Score]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DFqyMYYXFLBhGBgeoodNIRiqhiM]  DEFAULT ((0)) FOR [DaysForEnd]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DF3npC6ghmHv7I1j2rHxQxOh89lE8]  DEFAULT ((0)) FOR [NewProduct]
GO
ALTER TABLE [dbo].[LeadGenProducts] ADD  CONSTRAINT [DF0LL9qZQARmNnpywODELynUfEjE]  DEFAULT ('') FOR [COMM]
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
         Begin Table = "at"
            Begin Extent = 
               Top = 6
               Left = 321
               Bottom = 101
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "account"
            Begin Extent = 
               Top = 6
               Left = 529
               Bottom = 135
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "einf"
            Begin Extent = 
               Top = 6
               Left = 776
               Bottom = 135
               Right = 974
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 256
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActivationForSale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ActivationForSale'
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
         Top = -384
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'All_service_prof_area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'All_service_prof_area'
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
         Begin Table = "ad"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 136
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 600
               Bottom = 136
               Right = 770
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
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AutoSales_OLAP_3482'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AutoSales_OLAP_3482'
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
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 341
               Bottom = 136
               Right = 546
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sd"
            Begin Extent = 
               Top = 6
               Left = 584
               Bottom = 136
               Right = 782
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rev"
            Begin Extent = 
               Top = 6
               Left = 820
               Bottom = 102
               Right = 990
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rev1"
            Begin Extent = 
               Top = 6
               Left = 1028
               Bottom = 102
               Right = 1198
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Churn_OLAP_3708'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Churn_OLAP_3708'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Churn_OLAP_3708'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployerNoSegment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployerNoSegment'
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
         Begin Table = "orders_all_4analysis"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 264
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployerToService'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployerToService'
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
         Begin Table = "orders_all_new"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Account (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 323
               Bottom = 114
               Right = 528
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Contact (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 566
               Bottom = 114
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ContactDepartment (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 806
               Bottom = 84
               Right = 973
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-169'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-169'
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
         Begin Table = "orders_all_new"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Account (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 323
               Bottom = 114
               Right = 528
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Contact (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 566
               Bottom = 114
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ContactDepartment (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 806
               Bottom = 84
               Right = 973
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-1'
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
         Begin Table = "OLAP-170-1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vacancy (VacancySnapshot.dbo)"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 114
               Right = 438
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-1-FINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-1-FINAL'
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
         Begin Table = "orders_all_new"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Account (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 323
               Bottom = 114
               Right = 528
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Contact (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 566
               Bottom = 114
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ContactDepartment (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 806
               Bottom = 84
               Right = 973
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-2'
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
         Begin Table = "OLAP-170-2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vacancy (VacancySnapshot.dbo)"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 114
               Right = 438
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-2-FINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'OLAP-170-2-FINAL'
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
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "spa"
            Begin Extent = 
               Top = 6
               Left = 289
               Bottom = 102
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pa"
            Begin Extent = 
               Top = 6
               Left = 497
               Bottom = 102
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sa"
            Begin Extent = 
               Top = 6
               Left = 707
               Bottom = 102
               Right = 877
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 915
               Bottom = 136
               Right = 1088
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'orders_all_new_prof_area_region'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'orders_all_new_prof_area_region'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PriceProfArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PriceProfArea'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PriceRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PriceRegion'
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
         Begin Table = "s1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s2"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 114
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EmployerIDToManager (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 470
               Bottom = 84
               Right = 639
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RrejectionEmployer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RrejectionEmployer'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_area_group_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_area_group_name'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_professional_area_group_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'service_professional_area_group_name'
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
         Begin Table = "employer_max_segment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 353
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_employer_max_segment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_employer_max_segment'
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
         Begin Table = "employer_max_segment_snapshot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 353
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_employer_max_segment_SMB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_employer_max_segment_SMB'
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
         Begin Table = "ff"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ad"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 136
               Right = 532
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_for_app_OLAP_2345_FastFlow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_for_app_OLAP_2345_FastFlow'
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
         Begin Table = "sf"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sfp"
            Begin Extent = 
               Top = 6
               Left = 271
               Bottom = 102
               Right = 441
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_for_app_OLAP_2345_SlowFlow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_for_app_OLAP_2345_SlowFlow'
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
         Begin Table = "spending"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Account (CRMData750.dbo)"
            Begin Extent = 
               Top = 6
               Left = 594
               Bottom = 135
               Right = 871
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Contact (CRMData750.dbo)"
            Begin Extent = 
               Top = 6
               Left = 909
               Bottom = 135
               Right = 1130
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ContactDepartment (CRMData750.dbo)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "orders_all_uncleansed"
            Begin Extent = 
               Top = 6
               Left = 287
               Bottom = 136
               Right = 510
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
         Alias = 2280
         Table = 4170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314'
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
         Begin Table = "spending_2013"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "orders_all_new"
            Begin Extent = 
               Top = 6
               Left = 287
               Bottom = 135
               Right = 556
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Account (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 594
               Bottom = 135
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_Contact (CRMData.dbo)"
            Begin Extent = 
               Top = 6
               Left = 857
               Bottom = 135
               Right = 1078
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ContactDepartment (CRMData.dbo)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 233
               Right = 224
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
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_314_2'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_3843_LittleResponse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_olap_3843_LittleResponse'
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
         Begin Table = "U"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 102
               Right = 496
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
         Column = 4410
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_order_all_cleansed_activeproducts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_order_all_cleansed_activeproducts'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_segment_month'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_segment_month'
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
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sm"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 102
               Right = 444
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_smb_12month_segment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_smb_12month_segment'
GO

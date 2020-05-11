INSERT INTO VacancyDataMart.mart.VacancyResponses
([RegionID], [VacancyID], [PublicationDate], [VacancyStateID], [ResumeID], [UserID], [EmployerID], [UserTypeID], [SiteID], [ResumeCreationDate], [UserCreationDate], [EmployerType], [ResponseCreationDate], [ResumeRegionID], [ResponseAppType], [ResponsePlatform], [VacancyCreationDate], [ResumeColorTypeID], [ID], [VacancyCollarTypeId], [MetallicId], [VacancyTypeID], [ResumeProfAreaId])
VALUES
(NULL, 100, NULL, NULL, NULL, NULL, 1870, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T11:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(NULL, 200, NULL, NULL, NULL, NULL, 84585, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T12:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL),
(NULL, 300, NULL, NULL, NULL, NULL, 2605703, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T13:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL),
(NULL, 400, NULL, NULL, NULL, NULL, 2624107, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T14:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL),
(NULL, 500, NULL, NULL, NULL, NULL, 1269556, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T15:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL),
(NULL, 101, NULL, NULL, NULL, NULL, 1870, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T15:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL),
(NULL, 101, NULL, NULL, NULL, NULL, 1870, NULL, NULL, NULL, NULL, NULL, CAST(N'2020-05-03T15:10:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL);

INSERT INTO CRMData750.dbo.Account
(Id, ClientSiteCode, RegistrationStateId, TypeId, RegistrationSiteId, EmployeesNumberId, FederalAreaId, RegionId, CountryId, RegistrationPlatformId, IndustryId, OwnerId, RegistrationDate, Name, CreatedOn, PrimaryContactId, SellerAccountID, RegionHHId, ClientCategoryId, LastInvoicePaymentDate, RecorderId, AccountDateChangeTypeRegistr, Phone, Web, DisqualificationReasonId, MlmScore, IsVirtualRegistration, IsHidden, PersonalAccount, PreLoggerDate, PrimaryPersonalAccount, RepeatRegistration, InformationSourceId, OwnershipId, ModifiedOn, CreatedById, ModifiedById, Description, ParentId, Code, AdditionalPhone, Fax, AddressTypeId, CityId, Zip, AccountCategoryId, AnnualRevenueId, AlternativeName, ProcessListeners, GPSN, GPSE, PriceListId, UsrAccountBillboardId, UsrAccountTelevisionId, UsrAccountRadioId, UsrAccountInternetAdvertId, UsrAccountMediaId, UsrAccountUsePaidServKAId, UsrAccountUsePaidSiteId, UsrAccountUseRunningLineId, UsrAccountModulesMediaId, UsrAccountAdvertAgency, UsrAccountDistributor, UsrAccountVendor, UsrAccountIntegrator, MarketingBudgetAvailabilityId, RelationsLevelId, ClientClassId, ExistingAccountId, BudgetOnStaffAvailabilityId, MonthId, BudgetingTypeId, HRQuantityId, UseEDId, ManagerVacanciesNumber, LastSynchronizationDate, ActivityContactId, LastActivityDate, LastInformationUpdateDate, AccountAddToBlackList, CBRating, BadRegistrComment, URLHHru, URLHHua, URLHHby, PaymentAmountByYear, PaymentAmountByHalfYear, PaymentAmountByPreviousYear, LastTaskDate, LastTaskOwnerDate, BaseDepthDate, LastTaskTypeId, LastTaskOwnerId, PersonalAccountCurrencyId, PersonalAccountLockCurrencyId, PersonalAccountLock, QuestionaryAccountId, RecruitingStuffCount, PersonalAccountCurrencyRate, PersonalAccountLockCurRate, PrimaryPersonalAccountLock, PreLoggerId, PreLoggerStatusId, TsSpecialFeatureId, PersonalAccountAd, PrimaryPersonalAccountAd, PersonalAccountAdCurrencyId, PersonalAccountAdCurrencyRate, TsRegistrationSeparationDate, Completeness, AccountLogoId, NrbLastSparkRequestDate, NrbInn, NrbOgrn)
VALUES
(newid(), 1455, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Headhunter', GETDATE(), newid(), 1455, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'hh', newid(), 0, 0, 0, 1455, GETDATE(), 1455, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 100.00, 50.00, 100.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid()),
(newid(), 3911579, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Avito', GETDATE(), newid(), 3911579, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'avt', newid(), 0, 0, 0, 3911579, GETDATE(),3911579, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 200.00, 100.00, 200.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid()),
(newid(), 1870, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Rabota.ru', GETDATE(), newid(), 1870, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'rbru', newid(), 0, 0, 0, 1870, GETDATE(), 1870, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 300.00, 150.00, 300.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid());

INSERT INTO ActivationAnalysisData.dbo.orders_all_cleansed
([seller_account_id], [employer_id], [account_id], [payer_id], [employer_service_id], [order_id], [service_id], [creation_time], [activation_time], [expiration_time], [code], [original_cnt], [adjusted_cnt], [original_cost], [adjusted_cost], [order_cost], [region_path], [profarea_path], [activated_by_user_id], [activated_by_user_name], [activated_by_user_type_id], [given_discount_rate], [service_name], [special_offer_id], [is_barter], [line_count], [adjustment_info], [unit], [prolongates], [has_cart], [withdraw_type], [adjusted_cost_extVAT])
VALUES
(NULL, 1870, NULL, NULL, 1, NULL, NULL, CAST(N'2020-04-27T10:00:00.000' AS DateTime), CAST(N'2020-04-27T11:00:00.000' AS DateTime), NULL, N'VP', 5, NULL, NULL, 5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(NULL, 84585, NULL, NULL, 2, NULL, NULL, CAST(N'2020-04-27T11:00:00.000' AS DateTime), CAST(N'2020-04-27T12:00:00.000' AS DateTime), NULL, N'RENEWAL_VP', 10, NULL, NULL, 10000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(NULL, 2605703, NULL, NULL, 3, NULL, NULL, CAST(N'2020-04-27T12:00:00.000' AS DateTime), CAST(N'2020-04-27T13:00:00.000' AS DateTime), NULL, N'VPREM', 15, NULL, NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(NULL, 2624107, NULL, NULL, 4, NULL, NULL, CAST(N'2020-04-27T13:00:00.000' AS DateTime), CAST(N'2020-04-27T14:00:00.000' AS DateTime), NULL, N'AP', 10, NULL, NULL, 10000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(NULL, 1269556, NULL, NULL, 5, NULL, NULL, CAST(N'2020-04-27T14:00:00.000' AS DateTime), CAST(N'2020-04-27T15:00:00.000' AS DateTime), NULL, N'ADN', 5, NULL, NULL, 5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(NULL, 1870, NULL, NULL, 6, NULL, NULL, CAST(N'2020-04-27T15:00:00.000' AS DateTime), CAST(N'2020-04-27T16:00:00.000' AS DateTime), NULL, N'RENEWAL_VP', 20, NULL, NULL, 17000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ActivationAnalysisData.dbo.spending
([ID], [date], [order_id], [employer_id], [account_id], [employer_service_id], [code], [qtty], [t], [seller_account_id], [object_id], [employer_manager_id])
VALUES
(1, CAST(N'2020-04-28T11:00:00.000' AS DateTime), NULL, 1870, NULL, 1, N'VP', 1, 1, NULL, 100, NULL),
(2, CAST(N'2020-04-28T11:00:00.000' AS DateTime), NULL, 84585, NULL, 2, N'RENEWAL_VP', 1, 1, NULL, 200, NULL),
(3, CAST(N'2020-05-03T11:00:00.000' AS DateTime), NULL, 2605703, NULL, 3, N'VPREM', 1, 1, NULL, 300, NULL),
(4, CAST(N'2020-04-28T11:00:00.000' AS DateTime), NULL, 2624107, NULL, 4, N'AP', 1, 1, NULL, 400, NULL),
(5, CAST(N'2020-04-28T11:00:00.000' AS DateTime), NULL, 1269556, NULL, 5, N'ADN', 1, 1, NULL, 500, NULL),
(6, CAST(N'2020-04-28T11:00:00.000' AS DateTime), NULL, 1870, NULL, 6, N'RENEWAL_VP', 1, 1, NULL, 100, NULL),
(7, CAST(N'2020-04-28T12:00:00.000' AS DateTime), NULL, 1870, NULL, 6, N'RENEWAL_VP', 1, 1, NULL, 101, NULL);

INSERT INTO VacancySnapshot.dbo.VacancySnapshotLast
([VacancyID], [RegionID], [ArhivationDate])
VALUES
(100, 1, NULL),
(200, 1, NULL),
(300, 2, NULL),
(400, 2, NULL),
(500, 3, NULL),
(100, 3, NULL),
(101, 4, NULL);

INSERT INTO VacancySnapshot.dbo.VacancySnapshotProfAreaLast
(ProfAreaID, VacancyID, SnapshotDate)
VALUES
(1, 100, CAST(N'2020-04-28T12:00:00.000' AS DateTime)),
(2, 200, CAST(N'2020-04-28T12:00:00.000' AS DateTime)),
(3, 300, CAST(N'2020-04-28T12:00:00.000' AS DateTime)),
(4, 400, CAST(N'2020-04-28T12:00:00.000' AS DateTime)),
(5, 500, CAST(N'2020-04-28T12:00:00.000' AS DateTime)),
(6, 100, CAST(N'2020-04-15T12:00:00.000' AS DateTime)),
(7, 100, CAST(N'2020-04-20T12:00:00.000' AS DateTime)),
(8, 100, CAST(N'2020-05-01T12:00:00.000' AS DateTime)),
(6, 101, CAST(N'2020-04-28T12:00:00.000' AS DateTime));

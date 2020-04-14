--colums VacancyId, ResumeID, UserID, EmloyerID, CreationDate, ID go to vw_VacancyResponses
INSERT into VacancyDataMart.mart.VacancyResponses
(RegionID, VacancyID, PublicationDate, VacancyStateID, ResumeID, UserID, EmployerID, UserTypeID, SiteID, ResumeCreationDate, UserCreationDate, EmployerType, ResponseCreationDate, ResumeRegionID, ResponseAppType, ResponsePlatform, VacancyCreationDate, ResumeColorTypeID, ID, VacancyCollarTypeId, MetallicId, VacancyTypeID, ResumeProfAreaId)
VALUES
(1,1,GETDATE(),3,101,201,3911579,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,401,14,15,16,17),
(1,1,GETDATE(),3,102,202,3911579,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,402,14,15,16,17),
(1,2,GETDATE(),3,103,201,302,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,403,14,15,16,17),
(2,3,GETDATE(),3,104,203,303,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,404,14,15,16,17),
(2,4,GETDATE(),3,105,204,1870,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,405,14,15,16,17),
(3,5,GETDATE(),3,106,203,1455,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,406,14,15,16,17),
(3,5,GETDATE(),3,107,203,1455,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,407,14,15,16,17),
(3,5,GETDATE(),3,101,201,1455,7,8,GETDATE(),GETDATE(),9,GETDATE(),10,'ggg','ggg',GETDATE(),12,408,14,15,16,17)
;

INSERT INTO CRMData750.dbo.Account
(Id, ClientSiteCode, RegistrationStateId, TypeId, RegistrationSiteId, EmployeesNumberId, FederalAreaId, RegionId, CountryId, RegistrationPlatformId, IndustryId, OwnerId, RegistrationDate, Name, CreatedOn, PrimaryContactId, SellerAccountID, RegionHHId, ClientCategoryId, LastInvoicePaymentDate, RecorderId, AccountDateChangeTypeRegistr, Phone, Web, DisqualificationReasonId, MlmScore, IsVirtualRegistration, IsHidden, PersonalAccount, PreLoggerDate, PrimaryPersonalAccount, RepeatRegistration, InformationSourceId, OwnershipId, ModifiedOn, CreatedById, ModifiedById, Description, ParentId, Code, AdditionalPhone, Fax, AddressTypeId, CityId, Zip, AccountCategoryId, AnnualRevenueId, AlternativeName, ProcessListeners, GPSN, GPSE, PriceListId, UsrAccountBillboardId, UsrAccountTelevisionId, UsrAccountRadioId, UsrAccountInternetAdvertId, UsrAccountMediaId, UsrAccountUsePaidServKAId, UsrAccountUsePaidSiteId, UsrAccountUseRunningLineId, UsrAccountModulesMediaId, UsrAccountAdvertAgency, UsrAccountDistributor, UsrAccountVendor, UsrAccountIntegrator, MarketingBudgetAvailabilityId, RelationsLevelId, ClientClassId, ExistingAccountId, BudgetOnStaffAvailabilityId, MonthId, BudgetingTypeId, HRQuantityId, UseEDId, ManagerVacanciesNumber, LastSynchronizationDate, ActivityContactId, LastActivityDate, LastInformationUpdateDate, AccountAddToBlackList, CBRating, BadRegistrComment, URLHHru, URLHHua, URLHHby, PaymentAmountByYear, PaymentAmountByHalfYear, PaymentAmountByPreviousYear, LastTaskDate, LastTaskOwnerDate, BaseDepthDate, LastTaskTypeId, LastTaskOwnerId, PersonalAccountCurrencyId, PersonalAccountLockCurrencyId, PersonalAccountLock, QuestionaryAccountId, RecruitingStuffCount, PersonalAccountCurrencyRate, PersonalAccountLockCurRate, PrimaryPersonalAccountLock, PreLoggerId, PreLoggerStatusId, TsSpecialFeatureId, PersonalAccountAd, PrimaryPersonalAccountAd, PersonalAccountAdCurrencyId, PersonalAccountAdCurrencyRate, TsRegistrationSeparationDate, Completeness, AccountLogoId, NrbLastSparkRequestDate, NrbInn, NrbOgrn)
VALUES
(newid(), 1455, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Headhunter', GETDATE(), newid(), 1455, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'hh', newid(), 0, 0, 0, 1455, GETDATE(), 1455, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 100.00, 50.00, 100.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid()),
(newid(), 3911579, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Avito', GETDATE(), newid(), 3911579, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'avt', newid(), 0, 0, 0, 3911579, GETDATE(),3911579, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 200.00, 100.00, 200.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid()),
(newid(), 1870, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(),GETDATE(), 'Rabota.ru', GETDATE(), newid(), 1870, newid(), newid(), GETDATE(), newid(),GETDATE(), 'Phonenum', 'rbru', newid(), 0, 0, 0, 1870, GETDATE(), 1870, 0, newid(), newid(), GETDATE(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, 0, 0, 0, newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), newid(), 0, GETDATE(), newid(), GETDATE(), GETDATE(), 0, 0, newid(), newid(), newid(), newid(), 300.00, 150.00, 300.00, GETDATE(), GETDATE(),GETDATE(), newid(), newid(), newid(), newid(), 0, newid(), 0, 0, 0, 0, newid(), newid(), newid(), 0, 0, newid(), 0, GETDATE(), 0, newid(), GETDATE(), newid(), newid())
;

INSERT INTO ActivationAnalysisData.dbo.spending
(ID, [date], order_id, employer_id, account_id, employer_service_id, code, qtty, t, seller_account_id, object_id, employer_manager_id)
VALUES
(1, GETDATE(), 1, 1455, 1455, 1455, 'hh_code', 3, 0, 1455, 1455, 333),
(2, GETDATE(), 2, 3911579, 3911579, 3911579, 'avito_code', 4, 0, 13911579, 3911579, 333),
(3, GETDATE(), 3, 1870, 1870, 1870, 'rabotaru_code', 2, 0, 1870, 1870, 333)
;

INSERT INTO ActivationAnalysisData.dbo.orders_all_cleansed
(seller_account_id, employer_id, account_id, payer_id, employer_service_id, order_id, service_id, creation_time, activation_time, expiration_time, code, original_cnt, adjusted_cnt, original_cost, adjusted_cost, order_cost, region_path, profarea_path, activated_by_user_id, activated_by_user_name, activated_by_user_type_id, given_discount_rate, service_name, special_offer_id, is_barter, line_count, adjustment_info, unit, prolongates, has_cart, withdraw_type, adjusted_cost_extVAT)
VALUES
(14, 1455, 1455, 1455, 1455, 1, 1455, GETDATE(), GETDATE(), GETDATE(), 'hh_code', 3, 3, 50.00, 50.00, 50.00, 'Moscow', 'Hiring', 1455, 'hh', 0, '0', 'servicename_hh', 'no_special_offer', 'not barter', 23, 'adjustment', 'headunit', 0, 0, 'CASH', 0),
(39, 3911579, 3911579, 3911579, 3911579, 2, 1455, GETDATE(), GETDATE(), GETDATE(), 'avito_code', 4, 4, 100.00, 100.00, 100.00, 'Moscow', 'Hiring', 3911579, 'hh', 0, '0', 'servicename_hh', 'no_special_offer', 'not barter', 23, 'adjustment', 'headunit', 0, 0, 'CASH', 0),
(18, 1870, 1870, 1870, 1870, 3, 1870, GETDATE(), GETDATE(), GETDATE(), 'rabotaru_code', 2, 2, 150.00, 150.00, 150.00, 'Moscow', 'Hiring', 1870, 'hh', 0, '0', 'servicename_hh', 'no_special_offer', 'not barter', 23, 'adjustment', 'headunit', 0, 0, 'CASH', 0)
;

Feature: Wallets Creation and Verification

#  All scenarios are commented for wallets because it is deprecate.
#  @TestType-Smoke
#  Scenario: Create and verify wallet form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/wallets
#    And click on link: ejar.wallet.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: form[@name='basicInfoForm'] text: ejar.wallet.label.firstpage.text
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Wallets,المحافظ                                                         | h1      |
#      | New Wallet Top Up,رصيد محفظة جديد                                       | span    |
#      | Basic information,المعلومات الأساسية                                     | div     |
#      | Name [en],الاسـم [en]                                                    | label   |
#      | Name [ar],الاسـم [ar]                                                    | label   |
#      | Description,الوصف                                                       | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                     | isEditable | isRequired |
#      | ejar.wallet.englishname.byxpath                                |   True     |   True     |
#      | ejar.wallet.arabicname.byxpath                                 |   True     |   True     |
#      | ejar.wallet.description.byxpath                                |   True     |   False    |
#      | ejar.wallet.next.firstpage.byxpath                             |   False    |   False    |
#      | ejar.generic.save.action.byxpath                               |   False    |   False    |
#      | ejar.generic.cancel.action.byxpath                             |   True     |   False    |
#    Then user enter value : UI Wallet English Name in field : ejar.wallet.englishname.byxpath
#    Then user enter value : UI Wallet Arabic Name in field : ejar.wallet.arabicname.byxpath
#    Then user enter value : UI Automation wallet description in field : ejar.wallet.description.byxpath
#    Then click on element: ejar.wallet.next.firstpage.byxpath
#    And click on link: ejar.wallet.customercriteria.twisty.byxpath
#    And click on element: ejar.wallet.customercriteria.externalLoyalty.twisty.byxpath
#    And verify ejar fields label with soft assertion in form: form[@name='filtersForm'] text: ejar.wallet.label.secondpage.customercriteria.text
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Top Up Details,تفاصيل التعبئة                                           | div     |
#      | Customer Criteria,معايير العميل                                         | span    |
#      | All Users,كل المستخدمين                                                 | span    |
#      | Latest Contract After,احدث عقد تم بعد                                   | span    |
#      | Latest Contract Before,احدث عقد تم قبل                                  | span    |
#      | Minimum contract value per year,أقل قيمة عقود بالسنة                    | span    |
#      | Minimum number of contracts per year,أقل عدد عقود بالسنة                | span    |
#      | External Loyalties,العضويات الخارجية                                    | span    |
#      | VIP,كبار العملاء                                                         | div     |
#      | User Joining Date,تاريخ انضمام المستخدم                                 | span    |
#      | From,من                                                                 | label   |
#      | To,الى                                                                  | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.wallet.customercriteria.allUsers.field.byxpath                   |   True     |   False    |
#      | ejar.wallet.customercriteria.latestContractAfterCheck.field.byxpath   |   True     |   False    |
#      | ejar.wallet.customercriteria.latestContractAfterDate.field.byxpath    |   False    |   False    |
#      | ejar.wallet.customercriteria.latestContractBeforeCheck.field.byxpath  |   True     |   False    |
#      | ejar.wallet.customercriteria.latestContractBeforeDate.field.byxpath   |   False    |   False    |
#      | ejar.wallet.customercriteria.minimumContractValueCheck.field.byxpath  |   True     |   False    |
#      | ejar.wallet.customercriteria.minimumContractValue.field.byxpath       |   False    |   False    |
#      | ejar.wallet.customercriteria.minimumContractNumberCheck.field.byxpath |   True     |   False    |
#      | ejar.wallet.customercriteria.minimumContractNumber.field.byxpath      |   False    |   False    |
#      | ejar.wallet.customercriteria.externalLoyalty.field.byxpath            |   True     |   False    |
#      | ejar.wallet.customercriteria.VIP.field.byxpath                        |   True     |   False    |
#      | ejar.wallet.customercriteria.joiningDateCheck.field.byxpath           |   True     |   False    |
#      | ejar.wallet.customercriteria.joiningFromDate.field.byxpath            |   False    |   False    |
#      | ejar.wallet.customercriteria.joiningToDate.field.byxpath              |   False    |   False    |
#      | ejar.wallet.customercriteria.calculateCustomers.button.byxpath        |   False    |   False    |
#    And click on link: ejar.wallet.topupvalueandvalidity.twisty.byxpath
#    And click on element: ejar.wallet.topupvaluevalidity.validSetDateRadio.field.byxpath
#    And click on element: ejar.wallet.topupvaluevalidity.validSetDateRadio.field.byxpath
#    And verify ejar fields label with soft assertion in form: form[@name='valueAndValidityForm'] text: ejar.wallet.label.secondpage.topupvalueandvalidty.text
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Top Up Value and Validity,قيمة الشحن وصلاحيته                            | span    |
#      | Flat Rate,رصيد محدد                                                     | label   |
#      | Percentage of Current Balance,نسبة من الرصيد الحالي                     | label   |
#      | Valid For,صالحة لغاية                                                   | label   |
#      | One Year,سنة                                                            | label   |
#      | No Expiry,بدون تاريخ صلاحية                                              | label   |
#      | Set Date,تاريخ محدد                                                     | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.wallet.topupvaluevalidity.flatRateRadio.field.byxpath            |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.flatRate.field.byxpath                 |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.percentageOfBalanceRadio.field.byxpath |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.percentageOfBalance.field.byxpath      |   False    |   False    |
#      | ejar.wallet.topupvaluevalidity.validForYearRadio.field.byxpath        |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.validNoExpiryRadio.field.byxpath       |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.validSetDateRadio.field.byxpath        |   True     |   True     |
#      | ejar.wallet.topupvaluevalidity.validSetDate.field.byxpath             |   True     |   True     |


#  @TestType-Smoke
#  Scenario: Create and verify customer wallet
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/wallets
#    And click on link: ejar.customerwallet.create.button.byxpath
#    And verify ejar fields label with soft assertion in form: app-new-customers-wallet text: ejar.customerwallet.labels.text
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Wallets,المحافظ                                                         | h1      |
#      | New Wallet Top Up,رصيد محفظة جديد                                       | span    |
#      | Basic information,المعلومات الأساسية                                     | li      |
#      | Name [en],الاسـم [en]                                                    | label   |
#      | Name [ar],الاسـم [ar]                                                    | label   |
#      | Description,الوصف                                                       | label   |
#      | User Joining Date,تاريخ انضمام المستخدم                                 | label   |
#      | Start Date,تاريخ بداية الإتفاقية                                         | label   |
#      | End Date,تاريخ نهاية الإتفاقية                                           | label   |
#      | Flat Rate,رصيد محدد                                                     | label   |
#      | One Year,سنة                                                            | label   |
#      | No Expiry,بدون تاريخ صلاحية                                              | label   |
#      | Set Date,تاريخ محدد                                                     | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.customerwallet.nameEN.field.byxpath                              |   True     |   True     |
#      | ejar.customerwallet.nameAR.field.byxpath                              |   True     |   True     |
#      | ejar.customerwallet.description.field.byxpath                         |   True     |   False    |
#      | ejar.customerwallet.startDate.field.byxpath                           |   True     |   True     |
#      | ejar.customerwallet.endDate.field.byxpath                             |   True     |   True     |
#      | ejar.customerwallet.flatRateRadio.field.byxpath                       |   True     |   True     |
#      | ejar.customerwallet.flatRate.field.byxpath                            |   True     |   True     |
#      | ejar.customerwallet.oneYear.field.byxpath                             |   True     |   True     |
#      | ejar.customerwallet.noExpiry.field.byxpath                            |   True     |   True     |
#      | ejar.customerwallet.setDate.field.byxpath                             |   True     |   True     |
#      | ejar.generic.cancel.action.byxpath                                    |   True     |   False    |
#      | ejar.generic.save.action.byxpath                                      |   False    |   False    |
#    And set random text in variable and into element: ejar.customerwallet.nameEN.field.byxpath with size: 10 and initial string: UI English Customer Wallet and store value in variable: walletName
#    And set random text into element: ejar.customerwallet.nameAR.field.byxpath with size: 10 and initial string: UI Arabic Customer Wallet
#    And user select date in ejar calendar field: ejar.customerwallet.startDate.input.byxpath plus days: 1
#    And user select date in ejar calendar field: ejar.customerwallet.endDate.input.byxpath plus days: 5
#    And click on element: ejar.customerwallet.flatRateRadio.field.byxpath
#    And set random number into element: ejar.customerwallet.flatRate.field.byxpath of size: 2
#    And click on element: ejar.customerwallet.oneYear.field.byxpath
#    And click on element: ejar.generic.save.action.byxpath
#    And click on element: ejar.generic.yes.action.byxpath
#    And filter view on column name: Name,الاسم and enter value stored in variable: walletName
#    And user click on view action: View,عرض related to record with text stored in variable: walletName then select record at index: 1
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Wallets,المحافظ                                                         | h1      |
#      | New Wallet Top Up,رصيد محفظة جديد                                       | span    |
#      | Basic information,المعلومات الأساسية                                     | li      |
#      | Name [en],الاسـم [en]                                                    | label   |
#      | Name [ar],الاسـم [ar]                                                    | label   |
#      | Description,الوصف                                                       | label   |
#      | User Joining Date,تاريخ انضمام المستخدم                                 | label   |
#      | Start Date,تاريخ بداية الإتفاقية                                         | label   |
#      | End Date,تاريخ نهاية الإتفاقية                                           | label   |
#      | Flat Rate,رصيد محدد                                                     | label   |
#      | One Year,سنة                                                            | label   |
#      | No Expiry,بدون تاريخ صلاحية                                              | label   |
#      | Set Date,تاريخ محدد                                                     | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.customerwallet.deactivate.button.byxpath                         |   True     |   False    |
#      | ejar.generic.cancel.action.byxpath                                    |   True     |   False    |
#      | ejar.generic.save.action.byxpath                                      |   False    |   False    |
#    And click on element: ejar.customerwallet.deactivate.button.byxpath
#    And click on element: ejar.generic.yes.action.byxpath
#    And wait for element present: ejar.customerwallet.create.button.byxpath for period in seconds: 20
    
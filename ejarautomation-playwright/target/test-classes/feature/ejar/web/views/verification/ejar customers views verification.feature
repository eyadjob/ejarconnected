Feature: Customers View Verification

  @TestType-Regression
  Scenario: Customers view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customers
    And verify ejar view title text: ejar.customers.view.title.label.text
    And verify ejar view sub title text: ejar.customers.view.subtitle.label.text
    And verify ejar fields label in view: Customers,العملاء text: ejar.customers.view.fields.label.text
    And verify ejar buttons label in view: Customers,العملاء text: ejar.customers.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Customers,العملاء text: ejar.customers.view.secondary.bar.actions.label.text
    And verify ejar view: Customers,العملاء table headers: ejar.customers.view.table.headers.text
    And verify ejar view: Customers,العملاء table headers with filter: ejar.customers.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And wait for element not present: ejar.search.loading.byxpath
    And verify element present: ejar.generic.clear.action.byxpath
    And wait for element not present: ejar.search.loading.byxpath
    And user click on action with id: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And wait for element not present: ejar.search.loading.byxpath
    And wait for element present: ejar.customer.search.byxpath for period in seconds: 20
    And wait for element not present: ejar.search.loading.byxpath
    And click on link: ejar.customers.createnew.byxpath
    And user click on action with id: ejar.customers.skip.CustomerProvidersIntegration.byxpath
    And click on action if exist with wait: ejar.customers.skip.CustomerProvidersSecondIntegration.byxpath waiting number of seconds: 1
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Customer Surveys view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/surveys
    And verify ejar view title text: ejar.surveys.view.title.label.text
    And verify ejar view sub title text: ejar.surveys.view.subtitle.label.text
    And verify ejar buttons label in view: Surveys,الاستبيانات text: ejar.surveys.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Surveys,الاستبيانات text: ejar.surveys.view.secondary.bar.actions.label.text
    And verify ejar view: Surveys,الاستبيانات table headers: ejar.surveys.view.table.headers.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Customer Loyalty view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customerloyalitylist
    And verify ejar view title text: ejar.customerloyaltylist.view.title.label.text
    And verify ejar view sub title text: ejar.customerloyaltylist.view.subtitle.label.text
    And verify ejar fields label in view: Customer Loyalty List,العضويات  text: ejar.customerloyaltylist.view.fields.label.text
    And verify ejar buttons label in view: Customer Loyalty List,العضويات  text: ejar.customerloyaltylist.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Customer Loyalty List,العضويات  text: ejar.customerloyaltylist.view.secondary.bar.actions.label.text
    And verify ejar view: Customer Loyalty List,العضويات  table headers: ejar.customerloyaltylist.view.table.headers.text
    And verify ejar view: Customer Loyalty List,العضويات  table headers with filter: ejar.customerloyaltylist.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And click on link: ejar.customerloyalty.createnew.byxpath
    And user click on action with id: ejar.customerloyalty.cancel.button.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with form name: customer-loyality-list and action id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Shared Loyalty Requests view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/shared-loyalty-requests
    And verify ejar view title text: ejar.sharedloyaltyrequests.view.title.label.text
    And verify ejar view sub title text: ejar.sharedloyaltyrequests.view.subtitle.label.text
    And verify ejar fields label in view: Shared Loyalty Requests,طلبات العضويات المشتركة text: ejar.sharedloyaltyrequests.view.fields.label.text
    And verify ejar buttons label in view: Shared Loyalty Requests,طلبات العضويات المشتركة text: ejar.sharedloyaltyrequests.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Shared Loyalty Requests,طلبات العضويات المشتركة text: ejar.sharedloyaltyrequests.view.secondary.bar.actions.label.text
    And verify ejar view: Shared Loyalty Requests,طلبات العضويات المشتركة table headers: ejar.sharedloyaltyrequests.view.table.headers.text
    And verify ejar view: Shared Loyalty Requests,طلبات العضويات المشتركة table headers with filter: ejar.sharedloyaltyrequests.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And click on link: ejar.SharedLoyaltyRequests.createnew.byxpath
    And user click on action with xpath: //form[@name='requestForm']//button[contains(.,'Cancel') or contains(.,'الغاء') or contains(.,'إلغاء')]
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: External Loyalty Transaction List view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/external-loyalty-transactions
    And verify ejar view title text: ejar.externalloyaltytransactionlist.view.title.label.text
    And verify ejar view sub title text: ejar.externalloyaltytransactionlist.view.subtitle.label.text
    And verify ejar fields label in view: External Loyalty Transaction List,قائمة عمليات العضويات الخارجية text: ejar.externalloyaltytransactionlist.view.fields.label.text
    And verify ejar buttons label in view: External Loyalty Transaction List,قائمة عمليات العضويات الخارجية text: ejar.externalloyaltytransactionlist.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: External Loyalty Transaction List,قائمة عمليات العضويات الخارجية text: ejar.externalloyaltytransactionlist.view.secondary.bar.actions.label.text
    And verify ejar view: External Loyalty Transaction List,قائمة عمليات العضويات الخارجية table headers: ejar.externalloyaltytransactionlist.view.table.headers.text
    And verify ejar view: External Loyalty Transaction List,قائمة عمليات العضويات الخارجية table headers with filter: ejar.externalloyaltytransactionlist.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And verify element present with xpath: (//external-loyalty-transactions//button[contains(.,'Clear') or contains(.,'إفراغ')])[2]
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: External Loyalty Configuration List view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/external-loyalties-configurations
    And verify ejar view title text: ejar.externalloyaltyconfiguration.view.title.label.text
    And verify element present with xpath: //operational-page-header-bar//div/button[contains(text(),'Close') or contains(text(),'إغلاق')]
    And verify ejar view secondary bar buttons in view: External Loyalty Configuration,إعدادات العضويات الخارجية text: ejar.externalloyaltyconfiguration.view.secondary.bar.actions.label.text
    And verify ejar view: External Loyalty Configuration,إعدادات العضويات الخارجية table headers: ejar.externalloyaltyconfiguration.view.table.headers.text
    And verify ejar view: External Loyalty Configuration,إعدادات العضويات الخارجية table headers with filter: ejar.externalloyaltyconfiguration.view.table.headers.with.filter.text
    And user click on action with id: ejar.externalloyaltyconfiguration.createnew.button.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And click on element: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Organizations view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/organizations
    And verify ejar view title text: ejar.organizations.view.title.label.text
    And verify ejar view sub title text: ejar.organizations.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Organizations,المؤسسات text: ejar.organizations.view.secondary.bar.actions.label.text
    And verify ejar view: Organizations,المؤسسات table headers: ejar.organizations.view.table.headers.text
    And verify ejar view: Organizations,المؤسسات table headers with filter: ejar.organizations.view.table.headers.with.filter.text
    And user click on action with id: ejar.organizations.createnew.byxpath
    And wait for action to be clickable: ejar.organizations.cancel.button.byxpath
    And user click on action with id: ejar.organizations.cancel.button.byxpath
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.organizations.export.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Corporates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/corporates
    And verify ejar view title text: ejar.corporates.view.title.label.text
    And verify ejar view secondary bar buttons in view: Corporates,الشركات text: ejar.corporates.view.secondary.bar.actions.label.text
    And verify ejar view: Corporates,الشركات table headers: ejar.corporates.view.table.headers.text
    And verify ejar view: Corporates,الشركات table headers with filter: ejar.corporates.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.corporate.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Feedback view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/inquiries
    And verify ejar view title text: ejar.feedback.view.title.label.text
    And verify ejar view sub title text: ejar.feedback.view.subtitle.label.text
    And verify ejar fields label in view: Inquiries,استفسارات أو شكاوى text: ejar.feedback.view.fields.label.text
    And verify ejar buttons label in view: Inquiries,استفسارات أو شكاوى text: ejar.feedback.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Inquiries,استفسارات أو شكاوى text: ejar.feedback.view.secondary.bar.actions.label.text
    And verify ejar view: Inquiries,استفسارات أو شكاوى table headers: ejar.feedback.view.table.headers.text
    And verify ejar view: Inquiries,استفسارات أو شكاوى table headers with filter: ejar.feedback.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

#  Obsolete New business is created for the wallets
#  @TestType-Regression
#  Scenario: Wallet view page verification
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/wallets
#    And verify ejar view title text: ejar.wallets.view.title.label.text
#    And verify ejar view sub title text: ejar.wallets.view.subtitle.label.text
#    And verify ejar view secondary bar buttons in view: Wallets,المحافظ text: ejar.wallets.view.secondary.bar.actions.label.text
#    And verify ejar view: Wallets,المحافظ table headers: ejar.wallets.view.table.headers.text
#    And verify ejar view: Wallets,المحافظ table headers with filter: ejar.wallets.view.table.headers.with.filter.text
#    And verify ejar view pages footer
#    And user click on action if enabled with id: ejar.generic.export.action.byxpath
#    And user click on action with id: ejar.wallet.createnew.byxpath
#    And user click on action with id: ejar.generic.cancel.action.byxpath
#    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: User Registration Requests view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/registration-requests
      And verify ejar view title text: ejar.userregistrationrequests.view.title.label.text
      And verify ejar view sub title text: ejar.userregistrationrequests.view.subtitle.label.text
      And verify ejar view: Users Registration Requests,طلبات تسجيل المستخدمين table headers: ejar.userregistrationrequests.view.table.headers.text
      And verify ejar view: Users Registration Requests,طلبات تسجيل المستخدمين table headers with filter: ejar.userregistrationrequests.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.userregistrationrequests.view.labels.text
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Customers Document Requests view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/document-requests
      And verify ejar view title text: ejar.customersdocumentrequests.view.title.label.text
      And verify ejar view sub title text: ejar.customersdocumentrequests.view.subtitle.label.text
      And verify ejar view: Customers Document Requests,طلبات مستندات العملاء table headers: ejar.customersdocumentrequests.view.table.headers.text
      And verify ejar view: Customers Document Requests,طلبات مستندات العملاء table headers with filter: ejar.customersdocumentrequests.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.customersdocumentrequests.view.labels.text
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Wallet Rewards view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customers/wallet-rewards
    And verify ejar view title text: ejar.walletrewards.view.title.label.text
    And verify ejar view sub title text: ejar.walletrewards.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Wallet Rewards,مكافآت المحفظة text: ejar.walletrewards.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Wallet Rewards,مكافآت المحفظة text: ejar.walletrewards.view.labels.text
    And verify element present: ejar.walletrewards.view.newRegReward.button.byxpath
    And verify element present: ejar.walletrewards.view.newGeneralReward.button.byxpath
    And verify element present: ejar.walletrewards.view.filter.showInactive.input.byxpath
    And verify ejar view: Wallet Rewards,مكافآت المحفظة table headers: ejar.walletrewards.view.table.headers.text
    And verify ejar view: Wallet Rewards,مكافآت المحفظة table headers with filter: ejar.walletrewards.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible


  @TestType-Regression
  Scenario: Inquiries And Complains view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/complaint-categories
    And verify ejar view title text: ejar.inquiriesandcomplains.view.title.label.text
    And verify ejar view sub title text: ejar.inquiriesandcomplains.view.subtitle.label.text
    And verify ejar view: Inquiries And Complains,الاستفسارات والشكاوي table headers: ejar.inquiriesandcomplains.view.table.headers.text
    And verify ejar view: Inquiries And Complains,الاستفسارات والشكاوي table headers with filter: ejar.inquiriesandcomplains.view.table.headers.with.filters.text
    And click on action if exist: ejar.generic.export.action.byxpath
    And click on action if exist: ejar.inquiriesandcomplains.create.button.action.byxpath
    And click on action if exist: ejar.inquiriesandcomplains.close.button.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Corporates Details Report view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/reports/corporates-details-report
      And verify ejar view title text: ejar.corporatesdetailsreport.view.title.label.text
      And verify ejar view: Corporates Details Report,تقرير عملاء الشركات table headers: ejar.corporatesdetailsreport.view.table.headers.text
      And verify ejar view: Corporates Details Report,تقرير عملاء الشركات table headers with filter: ejar.corporatesdetailsreport.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.corporatesdetailsreport.view.labels.text
      And click on action if exist: ejar.generic.clear.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And click on action if exist: ejar.generic.export.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Customer report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/reports/customer-report
    And verify ejar view title text: ejar.customerreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Customer Report,تقرير العملاء text: ejar.customerreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Customer Report,تقرير العملاء text: ejar.customerreport.view.labels.text
    And verify element present: ejar.customerreport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.customerreport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Customer Report,تقرير العملاء text: ejar.customerreport.view.buttons.label.text
    And verify ejar view: Customer Report,تقرير العملاء table headers: ejar.customerreport.view.table.headers.text
    And verify ejar view: Customer Report,تقرير العملاء table headers with filter: ejar.customerreport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Customer Loyalties Report view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/reports/customer-loyalties-report
      And verify ejar view title text: ejar.customerloyaltiesreport.view.title.label.text
      And verify ejar view: Customer Loyalties Report,تقرير عضويات العملاء table headers: ejar.customerloyaltiesreport.view.table.headers.text
      And verify ejar view: Customer Loyalties Report,تقرير عضويات العملاء table headers with filter: ejar.customerloyaltiesreport.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.customerloyaltiesreport.view.labels.text
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Loyalty Points Report
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/reports/loyalty-points-report
      And verify ejar view title text: ejar.loyaltypointsreport.view.title.label.text
      And verify ejar view: Loyalty Points Report,تقرير نقاط العضوية table headers: ejar.loyaltypointsreport.view.table.headers.text
      And verify ejar view: Loyalty Points Report,تقرير نقاط العضوية table headers with filter: ejar.loyaltypointsreport.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.loyaltypointsreport.view.labels.text
      And click on action if exist with wait: ejar.generic.popupok.action.byxpath waiting number of seconds: 3
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Online Registered Customers Report view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/reports/online-registered-customers-report
      And verify ejar view title text: ejar.onlineregisteredcustomers.view.title.label.text
      And verify ejar view: Online Registered Customers,العملاء المسجلين اون لاين table headers: ejar.onlineregisteredcustomers.view.table.headers.text
      And verify ejar view: Online Registered Customers,العملاء المسجلين اون لاين table headers with filter: ejar.onlineregisteredcustomers.view.table.headers.with.filters.text
      And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.onlineregisteredcustomers.view.labels.text
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
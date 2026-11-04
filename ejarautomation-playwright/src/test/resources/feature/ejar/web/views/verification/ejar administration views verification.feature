Feature: Administration View Verification

  @TestType-Regression
  Scenario: Employees view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/employees
    And verify ejar view title text: ejar.employees.title.label.text
    And verify ejar view sub title text: ejar.employees.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Employees,الموظفين text: ejar.employees.view.secondary.bar.actions.label.text
    And verify ejar view: Employees,الموظفين table headers: ejar.employees.view.table.headers.text
    And verify ejar view: Employees,الموظفين table headers with filter: ejar.employees.view.table.headers.with.filter.text
    And user click on action with id: ejar.employees.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible

  @TestType-Regression
  Scenario: Roles view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/roles
    And verify ejar view title text: ejar.roles.title.label.text
    And verify ejar view sub title text: ejar.roles.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Roles,الأدوار text: ejar.roles.view.secondary.bar.actions.label.text
    And verify list of elements present by labels in view: //h1[contains(text(),'Roles') or contains(text(),'الأدوار')]/ancestor::ng-component[1]//div[contains(@class,'align-items-center')]//table/thead//th text: ejar.roles.view.table.headers.text
    And user click on action with id: ejar.generic.refresh.action.byxpath
    And user click on action if enabled with id: ejar.roles.createnew.button.byxpath
    And user click on action with id: ejar.roles.cancel.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Users view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/users
    And verify ejar view title text: ejar.users.title.label.text
    And verify ejar view sub title text: ejar.users.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Users,المستخدمين text: ejar.users.view.buttons.label.text
    And verify ejar view: Users,المستخدمين table headers: ejar.users.view.table.headers.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Cities view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/cities
    And verify ejar view title text: ejar.cities.title.label.text
    And verify ejar view sub title text: ejar.cities.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Cities,المدن text: ejar.cities.view.secondary.bar.actions.label.text
    And verify ejar view: Cities,المدن table headers: ejar.cities.view.table.headers.text
    And verify ejar view: Cities,المدن table headers with filter: ejar.cities.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.cities.createnew.byxpath
    And user click on action with form name: createoreditcitymodal and action id: ejar.generic.cancel.withoutclassname.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Currencies Exchange Rates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/currencies-exchange-rates
    And verify ejar view title text: ejar.currenciesexchangerates.title.label.text
    And verify ejar view sub title text: ejar.currenciesexchangerates.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Currencies Exchange Rates,أسعار صرف العملات text: ejar.currenciesexchangerates.view.secondary.bar.actions.label.text
    And verify ejar view: Currencies Exchange Rates,أسعار صرف العملات table headers: ejar.currenciesexchangerates.view.table.headers.text
    And verify ejar view: Currencies Exchange Rates,أسعار صرف العملات table headers with filter: ejar.currenciesexchangerates.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.currencyexchange.createnew.byxpath
    And user click on action with form name: create-or-edit-currency-exchange-rate and action id: ejar.generic.cancel.withoutclassname.action.byxpath
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Admin lookups page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/lookups
    And verify ejar view title text: ejar.systemlookups.title.label.text
    And verify ejar view sub title text: ejar.systemlookups.subtitle.label.text
    And verify ejar fields label in view: System Lookups, قوائم النظام text: ejar.systemlookups.view.fields.label.text
    And verify element present with xpath: //select[@name='lookupTypesCombobox']
    And verify ejar view: System Lookups, قوائم النظام table headers: ejar.systemlookups.view.table.headers.text
    And verify ejar view: System Lookups, قوائم النظام table headers with filter: ejar.systemlookups.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user select value in drop down field: ejar.lookups.list.byxpath by option text: Accident Report Source, مصدر تقرير الحوادث
    And click on link: ejar.lookups.createnew.byxpath
    And user click on action with form name: createoreditlookupmodal and action id: ejar.generic.cancel.withoutclassname.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: SMS Logs view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/smsLogs
    And verify ejar view title text: ejar.smslogs.title.label.text
    And verify ejar fields label in view: SMS Logs,سجلات الرسائل النصية text: ejar.smslogs.view.fields.label.text
    And verify ejar buttons label in view: SMS Logs,سجلات الرسائل النصية text: ejar.smslogs.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: SMS Logs,سجلات الرسائل النصية text: ejar.smslogs.view.secondary.bar.actions.label.text
    And verify ejar buttons label in view: SMS Logs,سجلات الرسائل النصية text: ejar.smslogs.view.buttons.label.text
    And verify ejar view: SMS Logs,سجلات الرسائل النصية table headers: ejar.smslogs.view.table.headers.text
    And verify ejar view: SMS Logs,سجلات الرسائل النصية table headers with filter: ejar.smslogs.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Operational Countries view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And verify ejar view title text: ejar.operationalcountries.title.label.text
    And verify ejar view sub title text: ejar.operationalcountries.subtitle.label.text
    And verify ejar view: Operational Countries,الدول التشغيلية table headers: ejar.operationalcountries.view.table.headers.text
    And verify ejar view pages footer
    And user click on action with xpath: (//i[@title='Settings' or @title='الإعدادات']//parent::a)[1]
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element present with xpath: (//i[@title='Settings' or @title='الإعدادات']//parent::a)[1]
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Printer Settings view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-printer-settings-list
    And verify ejar view title text: ejar.printersettings.title.label.text
    And verify ejar view sub title text: ejar.printersettings.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Printer Settings,إعدادات الطابعة text: ejar.printersettings.view.secondary.bar.actions.label.text
    And verify ejar view: Printer Settings,إعدادات الطابعة table headers: ejar.printersettings.view.table.headers.text
    And verify ejar view pages footer
    And user click on action with xpath: //button[contains(.,'Add') or contains(.,'اضافه')]
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Notifications view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-notifications
    And verify ejar view title text: ejar.notifications.title.label.text
    And verify ejar view secondary bar buttons in view: Notifications,إخطارات text: ejar.notifications.view.secondary.bar.actions.label.text
    And verify ejar view: Notifications,إخطارات table headers: ejar.notifications.view.table.headers.text
    And verify ejar view: Notifications,إخطارات table headers with filter: ejar.notifications.view.table.headers.with.filter.text
    And user click on action with id: ejar.notifications.createnew.button.byxpath
    And user click on action with id: ejar.notifications.cancelform.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Employee Achievements report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/employees/reports/employee-achievements-report
    And verify ejar fields count in the opened report view: 5
    And verify ejar fields label in the opened report view: ejar.rental.employeeachievements.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Tax Configurations view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.taxconfigurations.tax.button.byxpath
    And verify ejar view title text: eja.taxconfigurations.title.label.text
    And verify ejar view sub title text: eja.taxconfigurations.subtitle.label.text
    And verify ejar view: Tax Configurations,إعدادات الضريبة table headers: ejar.taxconfigurations.table.label.text
    And verify ejar view: Tax Configurations,إعدادات الضريبة table headers with filter: ejar.taxconfigurations.tablewithfilters.label.text
    And verify element present: ejar.taxconfigurations.addtax.button.byxpath
    And verify element present: ejar.taxconfigurations.close.button.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Fuel Types view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.fueltypes.fuletype.button.byxpath
    And verify ejar view title text: eja.fueltypes.title.label.text
    And verify ejar view sub title text: eja.fueltypes.subtitle.label.text
    And verify ejar view: Fuel Types,انواع الوقود table headers: ejar.fueltypes.table.label.text
    And verify ejar view: Fuel Types,انواع الوقود table headers with filter: ejar.fueltypes.tablewithfilters.label.text
    And verify element present: ejar.fueltypes.add.button.byxpath
    And verify element present: ejar.fueltypes.export.button.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Accident Policies view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.accidentpolicies.button.byxpath
    And verify ejar view title text: eja.accidentpolicies.title.label.text
    And verify ejar view sub title text: eja.accidentpolicies.subtitle.label.text
    And verify ejar view: Accident Policies,بوليصات التحمل table headers: ejar.accidentpolicies.table.label.text
    And verify ejar view: Accident Policies,بوليصات التحمل table headers with filter: ejar.accidentpolicies.tablewithfilters.label.text
    And verify element present: ejar.accidentpolicies.add.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Preventive Maintenance view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.preventivemaintenance.button.byxpath
    And verify ejar view title text: eja.preventivemaintenance.title.label.text
    And verify ejar view sub title text: eja.preventivemaintenance.subtitle.label.text
    And verify ejar view: Preventive Maintenance,الصيانة الوقائية table headers: ejar.preventivemaintenance.table.label.text
    And verify ejar view: Preventive Maintenance,الصيانة الوقائية table headers with filter: ejar.preventivemaintenance.tablewithfilters.label.text
    And verify element present: ejar.preventivemaintenance.add.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Rental Rates schema view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.rentalrates.button.byxpath
    And verify ejar view title text: eja.rentalrates.title.label.text
    And verify ejar view sub title text: eja.rentalrates.subtitle.label.text
    And verify ejar view: Rental Rates,انماط اسعار التأجير table headers: ejar.rentalrates.table.label.text
    And verify ejar view: Rental Rates,انماط اسعار التأجير table headers with filter: ejar.rentalrates.tablewithfilters.label.text
    And verify element present: ejar.rentalrates.export.button.byxpath
    And verify element present: ejar.rentalrates.close.button.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Occupations view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.occupations.button.byxpath
    And verify ejar view title text: eja.occupations.title.label.text
    And verify ejar view sub title text: eja.occupations.subtitle.label.text
    And verify ejar view: Occupations,ادارة الوظائف table headers: ejar.occupations.table.label.text
    And verify ejar view: Occupations,ادارة الوظائف table headers with filter: ejar.occupations.tablewithfilters.label.text
    And verify element present: ejar.occupations.add.button.byxpath
    And verify element present: ejar.occupations.export.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Regions view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.regions.button.byxpath
    And verify ejar view title text: eja.regions.title.label.text
    And verify ejar view sub title text: eja.regions.subtitle.label.text
    And verify ejar view: Regions,المناطق table headers: ejar.regions.table.label.text
    And verify ejar view: Regions,المناطق table headers with filter: ejar.regions.tablewithfilters.label.text
    And verify element present: ejar.regions.add.button.byxpath
    And verify element present: ejar.regions.export.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Transfer Cost view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on link: ejar.transfercost.button.byxpath
    And verify ejar view title text: eja.transfercost.title.label.text
    And verify ejar view sub title text: eja.transfercost.subtitle.label.text
    And verify element present: ejar.transfercost.save.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



    @TestType-Regression
    Scenario: Login Quotes view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url:  /app/admin/loggingQuotes
      And verify ejar view title text: ejar.loginquotes.title.label.text
      And verify element present: ejar.generic.save.action.byxpath
      And user click on action with id: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



    @TestType-Regression
    Scenario: Help Videos view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/help-videos
      And verify ejar view title text: ejar.helpvideos.title.label.text
      And verify ejar view sub title text: ejar.helpvideos.subtitle.label.text
      And verify ejar view: Help Videos,فيديوهات المساعدة table headers: ejar.helpvideos.view.table.headers.text
      And verify ejar view: Help Videos,فيديوهات المساعدة table headers with filter: ejar.helpvideos.view.table.headers.with.filter.text
      And click on link: ejar.helpvideo.createnew.action.byxpath
      And user click on action with id: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: General Settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-tenant-settings
      And verify ejar view title text: ejar.generalsettings.title.label.text
      And verify ejar view sub title text: ejar.generalsettings.subtitle.label.text
      And verify form fields using labels xpath: //form//ul[child::li] text: ejar.generalsettings.fields.label.text
      And verify element present: ejar.generalsettings.save.button.byxpath
      And click on element: ejar.generalsettings.cancel.button.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Country Settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
      And click on element: ejar.countrysettings.button.byxpath
      And verify ejar view title text: ejar.countrysettings.title.label.text
      And verify ejar view sub title text: ejar.countrysettings.subtitle.label.text
      And verify form fields using labels xpath: //app-operational-country-settings//h5 text: ejar.countrysettings.fields.label.text
      And verify element present: ejar.countrysettings.save.button.byxpath
      And click on element: ejar.countrysettings.cancel.button.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Branches Settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries/branches-settings/1
      And verify ejar view title text: ejar.branchessettings.title.label.text
      And verify form fields using labels xpath: //app-branch-settings//h5 text: ejar.branchessettings.fields.label.text
      And verify element present: ejar.branchessettings.save.button.byxpath
      And click on element: ejar.branchessettings.cancel.button.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Tajeer Configuration view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries/tajeer-configuration/1
      And verify ejar view title text: ejar.tajeerconfig.title.label.text
      And verify ejar view sub title text: ejar.tajeerconfig.subtitle.label.text
      And verify element present with xpath: //label[normalize-space()='Source' or normalize-space()='مصدر']//following-sibling::kendo-dropdownlist
      And verify element present: ejar.generic.save.action.byxpath
      And click on element: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Identity settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-country-settings
      And verify ejar view title text: ejar.identitysettings.title.label.text
      And verify ejar view sub title text: ejar.identitysettings.subtitle.label.text
      And verify element present: ejar.identitysettings.save.button.byxpath
      And click on element: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Soft POS Mapping view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/pos-device-configuration
      And verify ejar view title text: ejar.softposmapping.title.label.text
      And verify ejar view sub title text: ejar.softposmapping.subtitle.label.text
      And verify ejar view: Soft POS Mapping,ربط نقاط البيع الافتراضية table headers: ejar.softposmapping.view.table.headers.text
      And verify ejar view: Soft POS Mapping,ربط نقاط البيع الافتراضية table headers with filter: ejar.softposmapping.view.table.headers.with.filter.text
      And user click on action with id: ejar.SoftPOSMapping.createnew.action.byxpath
      And user click on action with form name: create-or-edit-pos-device-configuration-modal and action id: ejar.generic.cancel.withoutclassname.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Organization Units view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/organization-units
      And verify ejar view title text: ejar.organizationunits.title.label.text
      And verify ejar view sub title text: ejar.organizationunits.subtitle.label.text
      And verify element text present: ejar.organizationunits.members.label.byxpath with text: ejar.organizationunits.members.label.text
      And verify element text present: ejar.organizationunits.roles.label.byxpath with text: ejar.organizationunits.roles.label.text
      And verify element text present: ejar.organizationunits.members-text.label.byxpath with text: ejar.organizationunits.members-text.label.text
      And click on link: ejar.organizationunits.addrootunit.button.byxpath
      And verify element text present: ejar.organizationunits.new-organization.label.byxpath with text: ejar.organizationunits.organization.label.text
      And verify element text present: ejar.organizationunits.alllabels.label.byxpath with text: ejar.organizationunits.alllabels.label.text
      And verify element present: ejar.organizationunits.name.field.byxpath
      And verify element present: ejar.organizationunits.save.button.byxpath
      And verify element present: ejar.organizationunits.cancel.button.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



    @TestType-Regression
    Scenario: Settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/tenantSettings
      And verify ejar view title text: ejar.settings.title.label.text
      And verify ejar view sub title text: ejar.settings.subtitle.label.text
      And verify form fields using labels xpath: //tabset//li text: ejar.settings.labels.text
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: User reports view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/report/user-report
      And verify ejar report view toolbar present
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: User Discounts view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/report/users-discounts-report
      And verify ejar view title text: ejar.userdiscounts.title.label.text
      And verify form fields using labels xpath: //gridpagelayout//table/thead//th text: ejar.userdiscounts.view.table.headers.text
      And verify form fields using labels xpath: //gridpagelayout//table/thead//th[descendant::kendo-grid-filter-menu] text: ejar.userdiscounts.view.table.headers.with.filter.text
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Insurance Deposits view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
      And user click on action with id: ejar.insurancedeposit.view.action.byxpath
      And verify ejar view title text: ejar.insurancedeposit.title.label.text
      And verify element present: ejar.generic.create.action.byxpath
      And verify element present: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Driver Authorization view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
      And user click on action with id: ejar.driverauthorization.view.action.byxpath
      And verify ejar view title text: ejar.driverauthorization.title.label.text
      And verify form fields using labels xpath: //ejar-content-template//label text: ejar.driverauthorization.view.fields.label.text
      And verify element present: ejar.generic.save.action.byxpath
      And verify element present: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Simah Settings view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
      And user click on action with id: ejar.simahsettings.view.action.byxpath
      And verify ejar view title text: ejar.simahsettings.title.label.text
      And verify form fields using labels xpath: //ejar-content-template//label text: ejar.simahsettings.view.fields.label.text
      And verify element present: ejar.generic.save.action.byxpath
      And verify element present: ejar.generic.cancel.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

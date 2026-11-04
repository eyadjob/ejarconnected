Feature: Rental View Verification

  @TestType-Regression
  Scenario: booking view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    And verify ejar view title text: ejar.booking.view.title.label.text
    And verify ejar view sub title text: ejar.booking.view.subtitle.label.text
    And verify ejar fields label in view: Bookings,الحجوزات text: ejar.booking.view.fields.label.text
    And verify ejar buttons label in view: Bookings,الحجوزات text: ejar.booking.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Bookings,الحجوزات text: ejar.booking.view.secondary.bar.actions.label.text
    And change zoom level: 0.2
    And wait for element present: ejar.booking.view.tableTH.span.byxpath for period in seconds: 10
    And verify ejar view: Bookings,الحجوزات table headers: ejar.booking.view.table.headers.text
    And verify ejar view: Bookings,الحجوزات table headers with filter: ejar.booking.view.table.headers.with.filter.text
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 100
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on element: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And user click on action with id: ejar.generic.export.action.byxpath
    And click on link: ejar.bookings.createnew.byxpath
    And user click on action with form name: app-create-or-edit-booking and action id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Closed contracts out city view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/closed-contracts-out-city
    And verify ejar view title text: ejar.closedcontractoutcity.view.title.label.text
    And verify ejar view sub title text: ejar.closedcontractoutcity.view.subtitle.label.text
    And verify ejar fields label in view: Closed contracts out city,العقود المغلقة خارج المدينة text: ejar.closedcontractoutcity.view.fields.label.text
    And verify ejar buttons label in view: Closed contracts out city,العقود المغلقة خارج المدينة text: ejar.closedcontractoutcity.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Closed contracts out city,العقود المغلقة خارج المدينة text: ejar.closedcontractoutcity.view.secondary.bar.actions.label.text
    And verify ejar view: Closed contracts out city,العقود المغلقة خارج المدينة table headers: ejar.closedcontractoutcity.view.table.headers.text
    And verify ejar view: Closed contracts out city,العقود المغلقة خارج المدينة table headers with filter: ejar.closedcontractoutcity.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: contract view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/contracts
    And verify ejar view title text: ejar.contract.view.title.label.text
    And verify ejar view sub title text: ejar.contract.view.subtitle.label.text
    And verify ejar fields label in view: Contracts,العقود text: ejar.contract.view.fields.label.text
    And verify ejar buttons label in view: Contracts,العقود text: ejar.contract.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Contracts,العقود text: ejar.contract.view.secondary.bar.actions.label.text
    And verify ejar view: Contracts,العقود table headers: ejar.contract.view.table.headers.text
    And verify ejar view: Contracts,العقود table headers with filter: ejar.contract.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on element: ejar.generic.advancedsearch.action.byxpath
    And click on element: ejar.generic.advancedsearch.close.action.byxpath
    And click on link: ejar.contract.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: branch vehicle view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/branches-vehicles
    And verify ejar view title text: ejar.branchvehicle.view.title.label.text
    And verify ejar view sub title text: ejar.branchvehicle.view.subtitle.label.text
    And verify ejar fields label in view: Branch Vehicles,مركبات الفرع text: ejar.branchvehicle.view.fields.label.text
    And verify ejar buttons label in view: Branch Vehicles,مركبات الفرع text: ejar.branchvehicle.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Branch Vehicles,مركبات الفرع text: ejar.branchvehicle.view.secondary.bar.actions.label.text
    And verify ejar view: Branch Vehicles,مركبات الفرع table headers: ejar.branchvehicle.view.table.headers.text
    And verify ejar view: Branch Vehicles,مركبات الفرع table headers with filter: ejar.branchvehicle.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.branches.vehicles.VehiclesWithoutCheck.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: leasing switch view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/leasing-switches
    And verify ejar view title text: ejar.leasingswitches.view.title.label.text
    And verify ejar fields label in view: Leasing Switches,الإستبدالات text: ejar.leasingswitches.view.fields.label.text
    And verify ejar buttons label in view: Leasing Switches,الإستبدالات text: ejar.leasingswitches.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Leasing Switches,الإستبدالات text: ejar.leasingswitches.view.secondary.bar.actions.label.text
    And verify ejar view: Leasing Switches,الإستبدالات table headers: ejar.leasingswitches.view.table.headers.text
    And verify ejar view: Leasing Switches,الإستبدالات table headers with filter: ejar.leasingswitches.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: self contracts view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/SelfContracts
    And verify ejar view title text: ejar.selfcontracts.view.title.label.text
    And verify ejar fields label in view: Self Contracts,العقود المنفذة ذاتياً text: ejar.selfcontracts.view.fields.label.text
    And verify ejar buttons label in view: Self Contracts,العقود المنفذة ذاتياً text: ejar.selfcontracts.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Self Contracts,العقود المنفذة ذاتياً text: ejar.selfcontracts.view.secondary.bar.actions.label.text
    And verify ejar view: Self Contracts,العقود المنفذة ذاتياً table headers: ejar.selfcontracts.view.table.headers.text
    And verify ejar view: Self Contracts,العقود المنفذة ذاتياً table headers with filter: ejar.selfcontracts.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: late contracts with Tajeer view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/late-contracts
    And verify ejar view title text: ejar.latecontracts.view.title.label.text
    And verify ejar view sub title text: ejar.latecontracts.view.subtitle.label.text
    And verify ejar fields label in view: Late Contracts,عقود المتأخرين text: ejar.latecontracts.view.fields.label.text
    And verify ejar buttons label in view: Late Contracts,عقود المتأخرين text: ejar.latecontracts.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Late Contracts,عقود المتأخرين text: ejar.latecontracts.view.secondary.bar.actions.label.text
    And verify ejar view: Late Contracts,عقود المتأخرين table headers: ejar.latecontracts.view.table.headers.text
    And verify ejar view: Late Contracts,عقود المتأخرين table headers with filter: ejar.latecontracts.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And user click on action with id: ejar.latecontracts.distribute.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And user click on action with form name: distribute-contracts and action id: ejar.generic.dialog.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And click on element: ejar.latecontracts.firstRowViewStatement.action.byxpath
    And verify element present: ejar.latecontracts.statementsForm.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And click on element: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    
  @TestType-Regression
  Scenario: Integrated Contracts view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/Integrated-Contracts
    And verify ejar view title text: ejar.integratedwithtajeer.view.title.label.text
    And verify ejar view sub title text: ejar.integratedwithtajeer.view.subtitle.label.text
#    And verify ejar fields label in view:  External Booking ,العقود المتكاملة مع تأجير text: ejar.integratedwithtajeer.view.fields.label.text
    And verify ejar buttons label in view: Integrated Contracts with Tajeer ,العقود المتكاملة مع تأجير text: ejar.integratedwithtajeer.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Integrated Contracts with Tajeer ,العقود المتكاملة مع تأجير text: ejar.integratedwithtajeer.view.secondary.bar.actions.label.text
    And verify ejar view: Integrated Contracts with Tajeer ,العقود المتكاملة مع تأجير table headers: ejar.integratedwithtajeer.view.table.headers.text
    And verify ejar view: Integrated Contracts with Tajeer ,العقود المتكاملة مع تأجير table headers with filter: ejar.integratedwithtajeer.view.table.headers.with.filter.text
    And click on element: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Admin Usage Bookings view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/owned-corporate-bookings
    And verify ejar view title text: ejar.adminusagebookings.view.title.label.text
    And verify ejar view sub title text: ejar.adminusagebookings.view.subtitle.label.text
    And verify ejar fields label in view: Admin Usage Bookings,حجوزات الاستخدام الاداري text: ejar.adminusagebookings.view.fields.label.text
    And verify ejar buttons label in view: Admin Usage Bookings,حجوزات الاستخدام الاداري text: ejar.adminusagebookings.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Admin Usage Bookings,حجوزات الاستخدام الاداري text: ejar.adminusagebookings.view.secondary.bar.actions.label.text
    And verify ejar view: Admin Usage Bookings,حجوزات الاستخدام الاداري table headers: ejar.adminusagebookings.view.table.headers.text
    And verify ejar view: Admin Usage Bookings,حجوزات الاستخدام الاداري table headers with filter: ejar.adminusagebookings.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on element: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Short Term Quotations view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/short-term-quotations
    And verify ejar view title text: ejar.shorttermquotations.view.title.label.text
    And verify ejar view sub title text: ejar.shorttermquotations.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Short Term Quotations,عروض الأسعار القصيرة text: ejar.shorttermquotations.view.secondary.bar.actions.label.text
    And verify ejar view: Short Term Quotations,عروض الأسعار القصيرة table headers: ejar.shorttermquotations.view.table.headers.text
    And verify ejar view: Short Term Quotations,عروض الأسعار القصيرة table headers with filter: ejar.shorttermquotations.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.shorttermquotation.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And user click on action with id: ejar.generic.viewexpired.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Leasing Quotations view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/leasing-quotations
    And verify ejar view title text: ejar.leasingquotations.view.title.label.text
    And verify ejar view sub title text: ejar.leasingquotations.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Leasing Quotations,عروض الأسعار السنوية text: ejar.leasingquotations.view.secondary.bar.actions.label.text
    And verify ejar view: Leasing Quotations,عروض الأسعار السنوية table headers: ejar.leasingquotations.view.table.headers.text
    And verify ejar view: Leasing Quotations,عروض الأسعار السنوية table headers with filter: ejar.leasingquotations.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.leasingquotation.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And user click on action with id: ejar.generic.viewexpired.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Leasing Requests view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/leasing-requests
    And verify ejar view title text: ejar.leasingrequests.view.title.label.text
    And verify ejar view sub title text: ejar.leasingrequests.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Leasing Requests,تعميد العقود السنوية text: ejar.leasingrequests.view.secondary.bar.actions.label.text
    And verify ejar view: Leasing Requests,تعميد العقود السنوية table headers: ejar.leasingrequests.view.table.headers.text
    And verify ejar view: Leasing Requests,تعميد العقود السنوية table headers with filter: ejar.leasingrequests.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.leasingRequest.createnew.byxpath
    And user click on action with form name: leasing-request-creation and action id: ejar.generic.cancel.withoutclassname.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Brokers view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/brokers
    And verify ejar view title text: ejar.brokers.view.title.label.text
    And verify ejar view secondary bar buttons in view: Brokers,وسطاء الشركات text: ejar.brokers.view.secondary.bar.actions.label.text
    And verify ejar view: Brokers,وسطاء الشركات table headers: ejar.brokers.view.table.headers.text
    And verify ejar view: Brokers,وسطاء الشركات table headers with filter: ejar.brokers.view.table.headers.with.filter.text
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.brokers.create.button.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Offers view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/offers
    And verify ejar view title text: ejar.offers.view.title.label.text
    And verify ejar view sub title text: ejar.offers.view.subtitle.label.text
    And verify ejar fields label in view: Offers,العروض الترويجية text: ejar.offers.view.fields.label.text
    And verify ejar view secondary bar buttons in view: Offers,العروض الترويجية text: ejar.offers.view.secondary.bar.actions.label.text
    And verify ejar view: Offers,العروض الترويجية table headers: ejar.offers.view.table.headers.text
    And verify ejar view: Offers,العروض الترويجية table headers with filter: ejar.offers.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action if enabled with id: ejar.generic.ShowInactive.action.byxpath
    And click on link: ejar.offers.createnew.specific.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.offers.createnew.public.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Dynamic rental rates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/utilizationRates
    And verify ejar view title text: ejar.utilization.view.title.label.text
    And verify ejar view sub title text: ejar.utilization.view.subtitle.label.text
    And verify ejar fields label in view: Dynamic Rates,الاسعار الدينامكية text: ejar.utilization.view.fields.label.text
    And verify ejar buttons label in view: Dynamic Rates,الاسعار الدينامكية text: ejar.utilization.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Dynamic Rates,الاسعار الدينامكية text: ejar.utilization.view.secondary.bar.actions.label.text
    And verify ejar view: Dynamic Rates,الاسعار الدينامكية table headers: ejar.utilization.view.table.headers.text
    And verify ejar view: Dynamic Rates,الاسعار الدينامكية table headers with filter: ejar.utilization.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.ViewExpired2.action.byxpath
    And click on link: ejar.DynamicRates.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Rental Rates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/rental-rate
    And verify ejar view title text: ejar.rentalrates.view.title.label.text
    And verify ejar view sub title text: ejar.rentalrates.view.subtitle.label.text
    And verify ejar fields label in view: Rental Rates,أسعار التأجير text: ejar.rentalrates.view.fields.label.text
    And verify ejar buttons label in view: Rental Rates,أسعار التأجير text: ejar.rentalrates.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Rental Rates,أسعار التأجير text: ejar.rentalrates.view.secondary.bar.actions.label.text
    And verify ejar view: Rental Rates,أسعار التأجير table headers: ejar.rentalrates.view.table.headers.text
    And verify ejar view: Rental Rates,أسعار التأجير table headers with filter: ejar.rentalrates.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on link: ejar.rentalrates.createdaily.button.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.rentalrates.createmonthly.button.byxpath
    And click on action if exist: ejar.generic.popupok.action.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 10
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Simah view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/simah
    And verify ejar view title text: ejar.simah.view.title.label.text
    And verify ejar view sub title text: ejar.simah.view.subtitle.label.text
    And verify ejar fields label in view: Simah,سمة text: ejar.simah.view.fields.label.text
    And verify ejar buttons label in view: Simah,سمة text: ejar.simah.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Simah,سمة text: ejar.simah.view.secondary.bar.actions.label.text
    And verify ejar view: Simah,سمة table headers: ejar.simah.view.table.headers.text
    And verify ejar view: Simah,سمة table headers with filter: ejar.simah.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: OPL requests view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/opl-requests
    And verify ejar view title text: ejar.oplrequests.view.title.label.text
    And verify ejar view sub title text: ejar.oplrequests.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: OPL requests,طلبات عقود الأفراد السنوية text: ejar.oplrequests.view.secondary.bar.actions.label.text
    And verify ejar view: OPL requests,طلبات عقود الأفراد السنوية table headers: ejar.oplrequests.view.table.headers.text
    And verify ejar view: OPL requests,طلبات عقود الأفراد السنوية table headers with filter: ejar.oplrequests.view.table.headers.with.filter.text
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.oplrequests.createNew.byxpath
    And wait for number of seconds: 1
    And wait for element not present: ejar.oplrequests.createNewLoading.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: OPL rates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/opl-rental-rate
    And verify ejar view title text: ejar.oplrates.view.title.label.text
    And verify ejar view sub title text: ejar.oplrates.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: OPL Rates,اسعار الافراد السنويه text: ejar.oplrates.view.secondary.bar.actions.label.text
    And verify ejar view: OPL Rates,اسعار الافراد السنويه table headers: ejar.oplrates.view.table.headers.text
    And verify ejar view: OPL Rates,اسعار الافراد السنويه table headers with filter: ejar.oplrates.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on link: ejar.oplrates.createNew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Franchise view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/franchises
    And verify ejar view title text: ejar.franchise.view.title.label.text
    And verify ejar view secondary bar buttons in view: Franchise, فرنشايز text: ejar.franchise.view.secondary.bar.actions.label.text
    And verify ejar view: Franchise, فرنشايز table headers: ejar.franchise.view.table.headers.text
    And verify ejar view:  Franchise, فرنشايز table headers with filter: ejar.franchise.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Booking Availability view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/booking-availabilities
    And verify ejar view title text: ejar.bookingavailability.view.title.label.text
    And verify ejar view sub title text: ejar.bookingavailability.view.subtitle.label.text
    And verify ejar buttons label in view: Booking Availability,إتاحة حجز text: ejar.bookingavailability.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Booking Availability,إتاحة حجز text: ejar.bookingavailability.view.secondary.bar.actions.label.text
    And verify ejar view: Booking Availability,إتاحة حجز table headers: ejar.bookingavailability.view.table.headers.text
    And verify ejar view: Booking Availability,إتاحة حجز table headers with filter: ejar.bookingavailability.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on element: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And click on link: ejar.bookingavailability.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Extras view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/extras
    And verify ejar view title text: ejar.extras.view.title.label.text
    And verify ejar view sub title text: ejar.extras.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Extras,الاضافات text: ejar.extras.view.secondary.bar.actions.label.text
    And verify ejar view: Extras,الاضافات table headers: ejar.extras.view.table.headers.text
    And verify ejar view: Extras,الاضافات table headers with filter: ejar.extras.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.extras.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Rental Restrictions view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/rental-restrictions
    And verify ejar view title text: ejar.rentalrestrictions.view.title.label.text
    And verify ejar view sub title text: ejar.rentalrestrictions.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Rental Restrictions,موانع التأجير text: ejar.rentalrestrictions.view.secondary.bar.actions.label.text
    And verify ejar view: Rental Restrictions,موانع التأجير table headers: ejar.rentalrestrictions.view.table.headers.text
    And verify ejar view: Rental Restrictions,موانع التأجير table headers with filter: ejar.rentalrestrictions.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Advance Reservations And Promotions report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/advanced-and-promotion-report
    And verify ejar fields count in the opened report view: 5
    And verify ejar fields label in the opened report view: ejar.rental.advancereservationsandpromotions.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Utilization report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/utilization-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.utilization.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Late Contract Voucher report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/Late-Contract-Voucher-Report
    And verify ejar fields count in the opened report view: 2
    And verify ejar fields label in the opened report view: ejar.rental.latecontractvoucher.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Late Contract report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/late-contracts-report
    And verify ejar view title text: ejar.latecontract.view.title.label.text
    And verify ejar buttons label in view: Late Contracts Report,تقرير العقود المتأخرة text: ejar.latecontract.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Late Contracts Report,تقرير العقود المتأخرة text: ejar.latecontract.view.secondary.bar.actions.label.text
    And verify ejar view: Late Contracts Report,تقرير العقود المتأخرة table headers: ejar.latecontract.view.table.headers.text
    And verify ejar view: Late Contracts Report,تقرير العقود المتأخرة table headers with filter: ejar.latecontract.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Contract With Payment Less Than Due Amount report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/contract-with-payment-lessthan-due-amount-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.contractweithpaymentlessthandueamount.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Corporates Contracts report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/corporates-contracts-report
    And verify ejar fields count in the opened report view: 4
    And verify ejar fields label in the opened report view: ejar.rental.corporatescontracts.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Spot Idle Vehicle report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/spot-idle-vehicle-report
    And verify ejar fields count in the opened report view: 4
    And verify ejar fields label in the opened report view: ejar.rental.spotidlevehicle.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Spot Vehicle Switches Report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/spot-vehicle-switches-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.spotvehiclesswitches.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Canceled Contracts report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/cancel-contracts-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.canceledcontracts.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Contracts Revenue report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/daily-revenue-report
    And verify ejar view title text: ejar.contractsrevenue.view.title.label.text
    And verify ejar fields label in view: Contracts Revenue ,إيرادات العقود text: ejar.contractsrevenue.view.fields.label.text
    And verify ejar buttons label in view: Contracts Revenue ,إيرادات العقود text: ejar.contractsrevenue.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Contracts Revenue ,إيرادات العقود text: ejar.contractsrevenue.view.secondary.bar.actions.label.text
    And verify ejar view: Contracts Revenue ,إيرادات العقود table headers: ejar.contractsrevenue.view.table.headers.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: User Discount report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/user-discount-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.userdiscount.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Employee Achievements Reports page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/employees/reports/employee-achievements-report
    And verify ejar fields count in the opened report view: 5
    And verify ejar fields label in the opened report view: ejar.rental.employee-achievements-report.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Average Agility Daily Report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/average-daily-rate-report
    And verify ejar fields count in the opened report view: 2
    And verify ejar fields label in the opened report view: ejar.rental.averageagilitydaily.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



  @TestType-Regression
  Scenario: Old Indebt Contracts view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/old-indebt-contracts
    And verify ejar view title text: ejar.oldindebtcontracts.view.title.label.text
    And verify ejar view: Old Indebt Contracts,عقود المطالبة القديمة table headers: ejar.oldindebtcontracts.view.table.headers.text
    And verify ejar view: Old Indebt Contracts,عقود المطالبة القديمة table headers with filter: ejar.oldindebtcontracts.view.table.headers.with.filters.text
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: External Booking view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/partnerBookings
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.generic.clear.action.byxpath
    And verify ejar view title text: ejar.externalbooking.view.title.label.text
    And verify ejar view sub title text: ejar.externalbooking.view.subtitle.label.text
    And verify ejar fields label in view:  External Booking ,الحجوزات الخارجية text: ejar.externalbooking.view.fields.label.text
    And verify ejar view: External Booking,الحجوزات الخارجية table headers: ejar.externalbooking.view.table.headers.text
    And verify ejar view: External Booking,الحجوزات الخارجية table headers with filter: ejar.externalbooking.view.table.headers.with.filter.text
    And click on element: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Broker Short Term Quotations view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/brokers/short-term-quotations
    And verify ejar view title text: ejar.brokerQuotation.view.title.label.text
    And verify ejar view sub title text: ejar.brokerQuotation.view.subtitle.label.text
    And verify ejar view: Broker Short Term Quotations,عروض الأسعار القصيرة للوسطاء table headers: ejar.brokerQuotation.view.table.headers.text
    And verify ejar view: Broker Short Term Quotations,عروض الأسعار القصيرة للوسطاء table headers with filter: ejar.brokerQuotation.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.viewexpired.byxpath
    And click on link: ejar.brokerQuotation.createnew.quotation.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Airport Revenue Reports view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/airport-revenue-reports
    And verify ejar view title text: ejar.airportrevenuereports.view.title.label.text
    And verify ejar fields label in view: Airport Revenue Reports,تقرير عوائد المطارات text: ejar.airportrevenuereports.view.fields.label.text
    And user click on action with id: ejar.airportrevenuereports.view.generatereport.byxpath
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Contracts Report view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/contracts-reports
    And verify ejar view title text: ejar.contractsreport.view.title.label.text
    And verify ejar fields label in view: Contracts Report,تقرير العقود text: ejar.contractsreport.view.fields.label.text
    And verify ejar view: Contracts Report,تقرير العقود table headers: ejar.contractsreport.view.table.headers.text
    And verify ejar view: Contracts Report,تقرير العقود table headers with filter: ejar.contractsreport.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Contract Offers view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/contract-offers-reports
    And verify ejar view title text: ejar.contractofferreport.view.title.label.text
    And verify ejar fields label in view: Contract Offers,العروض الترويجية للعقود text: ejar.contractofferreport.view.fields.label.text
    And verify ejar view: Contract Offers,العروض الترويجية للعقود table headers: ejar.contractofferreport.view.table.headers.text
    And verify ejar view: Contract Offers,العروض الترويجية للعقود table headers with filter: ejar.contractofferreport.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Contracts Revenue Summary view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/contracts-revenues-summary-report
    And verify ejar view title text: ejar.contractsrevenuesummary.view.title.label.text
    And verify ejar fields label in view: Contracts Revenue Summary,ملخص إيرادات العقود text: ejar.contractsrevenuesummary.view.fields.label.text
    And user click on action if enabled with id: ejar.contractsrevenuesummary.search.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



  @TestType-Regression
  Scenario: Vehicle Model Performance Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/vehicle-model-performance-report
    And verify ejar view title text: ejar.modelperformancereport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Vehicle Model Performance Report,آداء موديلات السيارات text: ejar.modelperformancereport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Vehicle Model Performance Report,آداء موديلات السيارات text: ejar.modelperformancereport.view.labels.text
    And verify element present: ejar.modelperformancereport.view.filter.country.dropdown.byxpath
    And verify element present: ejar.modelperformancereport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.modelperformancereport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Vehicle Model Performance Report,آداء موديلات السيارات text: ejar.modelperformancereport.view.buttons.label.text
    And verify ejar view: Vehicle Model Performance Report,آداء موديلات السيارات table headers: ejar.modelperformancereport.view.table.headers.text
    And verify ejar view: Vehicle Model Performance Report,آداء موديلات السيارات table headers with filter: ejar.modelperformancereport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible

  @TestType-Regression
  Scenario: Employees Rental Operations Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/employees-rental-operations-report
    And verify ejar view title text: ejar.employeerentalreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Employees Rental Operations Report,تقرير عمليات التاجير للموظفين text: ejar.employeerentalreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Employees Rental Operations Report,تقرير عمليات التاجير للموظفين text: ejar.employeerentalreport.view.labels.text
    And verify element present: ejar.employeerentalreport.view.filter.country.dropdown.byxpath
    And verify element present: ejar.employeerentalreport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.employeerentalreport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Employees Rental Operations Report,تقرير عمليات التاجير للموظفين text: ejar.employeerentalreport.view.buttons.label.text
    And verify ejar view: Employees Rental Operations Report,تقرير عمليات التاجير للموظفين table headers: ejar.employeerentalreport.view.table.headers.text
    And verify ejar view: Employees Rental Operations Report,تقرير عمليات التاجير للموظفين table headers with filter: ejar.employeerentalreport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible


  @TestType-Regression
  Scenario: Branch Operational Performance Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/reports/branch-operational-performance-report
    And verify ejar view title text: ejar.branchperformancereport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Branch Operational Performance,آداء الفروع في عمليات التأجير text: ejar.branchperformancereport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Branch Operational Performance,آداء الفروع في عمليات التأجير text: ejar.branchperformancereport.view.labels.text
    And verify element present: ejar.branchperformancereport.view.filter.country.dropdown.byxpath
    And verify element present: ejar.branchperformancereport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.branchperformancereport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Branch Operational Performance,آداء الفروع في عمليات التأجير text: ejar.branchperformancereport.view.buttons.label.text
    And verify ejar view: Branch Operational Performance,آداء الفروع في عمليات التأجير table headers: ejar.branchperformancereport.view.table.headers.text
    And verify ejar view: Branch Operational Performance,آداء الفروع في عمليات التأجير table headers with filter: ejar.branchperformancereport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible
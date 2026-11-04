Feature: Collections View Verification

  @TestType-Regression
  Scenario: Feedback view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/collections/collection-requests/collection-requests-list
    And verify ejar view title text: ejar.collectionrequests.view.title.label.text
    And verify ejar view sub title text: ejar.collectionrequests.view.subtitle.label.text
    And verify ejar fields label in view: Collection Requests,طلبات التحصيل text: ejar.collectionrequests.view.fields.label.text
    And verify ejar buttons label in view: Collection Requests,طلبات التحصيل text: ejar.collectionrequests.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Collection Requests,طلبات التحصيل text: ejar.collectionrequests.view.secondary.bar.actions.label.text
    And verify ejar view: Collection Requests,طلبات التحصيل table headers: ejar.collectionrequests.view.table.headers.text
    And verify ejar view: Collection Requests,طلبات التحصيل table headers with filter: ejar.collectionrequests.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Collection Vouchers report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/collections/reports/collection-voucher-report
    And verify ejar fields count in the opened report view: 2
    And verify ejar fields label in the opened report view: ejar.rental.collectionvouchers.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Indebt Contracts report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/collections/reports/indebt-contracts-report
    And verify ejar view title text: ejar.indebtcontracts.view.title.label.text
    And verify ejar fields label in view: Indebt Contracts,عقود المطالبة text: ejar.indebtcontracts.view.fields.label.text
    And verify ejar buttons label in view: Indebt Contracts,عقود المطالبة text: ejar.indebtcontracts.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Indebt Contracts,عقود المطالبة text: ejar.indebtcontracts.view.secondary.bar.actions.label.text
    And verify ejar view: Indebt Contracts,عقود المطالبة table headers: ejar.indebtcontracts.view.table.headers.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
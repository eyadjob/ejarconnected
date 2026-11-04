Feature: Financial View Verification

  @TestType-Regression
  Scenario: Vouchers view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/vouchers
    And verify ejar view title text: ejar.vouchers.view.title.label.text
    And verify ejar view sub title text: ejar.vouchers.view.subtitle.label.text
    And verify ejar fields label in view: Vouchers,السندات text: ejar.vouchers.view.fields.label.text
    And verify ejar buttons label in view: Vouchers,السندات text: ejar.vouchers.view.buttons.label.text
    And verify ejar view: Vouchers,السندات table headers: ejar.vouchers.view.table.headers.text
    And verify ejar view: Vouchers,السندات table headers with filter: ejar.vouchers.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And wait for element not present: ejar.vouchers.view.loading.byxpath
    And user click on action with id: ejar.vouchers.view.search.byxpath
    And wait for element not present: ejar.vouchers.view.loading.byxpath
    And user click on action with id: ejar.vouchers.view.clear.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Individual Invoices view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/invoices
    And verify ejar view title text: ejar.individualinvoices.view.title.label.text
    And verify ejar view sub title text: ejar.individualinvoices.view.subtitle.label.text
    And verify ejar fields label in view: Individual Invoices,فواتير الأفراد text: ejar.individualinvoices.view.fields.label.text
    And verify ejar buttons label in view: Individual Invoices,فواتير الأفراد text: ejar.individualinvoices.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Individual Invoices,فواتير الأفراد text: ejar.individualinvoices.view.secondary.bar.actions.label.text
    And verify ejar view: Individual Invoices,فواتير الأفراد table headers: ejar.individualinvoices.view.table.headers.text
    And verify ejar view: Individual Invoices,فواتير الأفراد table headers with filter: ejar.individualinvoices.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.search.action.byxpath
    And user click on action if enabled with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Corporate Invoices view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And verify ejar view title text: ejar.corporateinvoices.view.title.label.text
    And verify ejar view sub title text: ejar.corporateinvoices.view.subtitle.label.text
    And verify ejar fields label in view: Corporate Invoices,فواتير الشركات text: ejar.corporateinvoices.view.fields.label.text
    And verify ejar buttons label in view: Corporate Invoices,فواتير الشركات text: ejar.corporateinvoices.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Corporate Invoices,فواتير الشركات text: ejar.corporateinvoices.view.secondary.bar.actions.label.text
    And verify ejar view: Corporate Invoices,فواتير الشركات table headers: ejar.corporateinvoices.view.table.headers.text
    And verify ejar view: Corporate Invoices,فواتير الشركات table headers with filter: ejar.corporateinvoices.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on action if exist: ejar.generic.popupok.action.byxpath
    And click on action if exist: ejar.generic.swal-footer.close.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Refunds view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/refunds
    And verify ejar view title text: ejar.refunds.view.title.label.text
    And verify ejar fields label in view: Refunds,الرديات text: ejar.refunds.view.fields.label.text
    And verify ejar buttons label in view: Refunds,الرديات text: ejar.refunds.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Refunds,الرديات text: ejar.refunds.view.secondary.bar.actions.label.text
    And verify ejar view: Refunds,الرديات table headers: ejar.refunds.view.table.headers.text
    And verify ejar view: Refunds,الرديات table headers with filter: ejar.refunds.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with form name: refundssearch and action id: ejar.generic.clear.toUseWithFormName.action.byxpath
    And user click on action with form name: refundssearch and action id: ejar.generic.search.toUseWithFormName.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Insurance Deposits view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/insurance-deposits
    And verify ejar view title text: ejar.insurancedepositlist.view.title.label.text
    And verify ejar view sub title text: ejar.insurancedepositlist.view.subtitle.label.text
    And verify ejar fields label in view: Insurance Deposit List,قائمة دفعات التأمينات text: ejar.insurancedepositlist.view.fields.label.text
    And verify ejar buttons label in view: Insurance Deposit List,قائمة دفعات التأمينات text: ejar.insurancedepositlist.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Insurance Deposit List,قائمة دفعات التأمينات text: ejar.insurancedepositlist.view.secondary.bar.actions.label.text
    And verify ejar view: Insurance Deposit List,قائمة دفعات التأمينات table headers: ejar.insurancedepositlist.view.table.headers.text
    And verify ejar view: Insurance Deposit List,قائمة دفعات التأمينات table headers with filter: ejar.insurancedepositlist.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Fund Transaction report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/fund-transaction-report
    And wait for element present: ejar.report.view.previewLastPage.fields.byxpath for period in seconds: 20
    And verify ejar fields count in the opened report view: 6
    And verify ejar fields label in the opened report view: ejar.rental.fundtransaction.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Payment Transaction report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/payment-transaction-report
    And wait for element present: ejar.report.view.previewLastPage.fields.byxpath for period in seconds: 100
    And verify ejar fields count in the opened report view: 7
    And verify ejar fields label in the opened report view: ejar.rental.paymenttransaction.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Vouchers report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/voucher-report
    And verify ejar fields count in the opened report view: 7
    And verify ejar fields label in the opened report view: ejar.rental.vouchers.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Vouchers (without Branches) report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/voucher-report-without-branch
    And verify ejar fields count in the opened report view: 5
    And verify ejar fields label in the opened report view: ejar.rental.voucherswithoutbranches.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Corporate Invoices Lines report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/viewCorporateInvoiceLineItems
    And verify ejar view title text: ejar.corporateinvoiceslines.view.title.label.text
    And verify ejar fields label in view: Corporate Invoices Lines Report,تقرير بنود فواتير الشركات text: ejar.corporateinvoiceslines.view.fields.label.text
    And verify ejar buttons label in view: Corporate Invoices Lines Report,تقرير بنود فواتير الشركات text: ejar.corporateinvoiceslines.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Corporate Invoices Lines Report,تقرير بنود فواتير الشركات text: ejar.corporateinvoiceslines.view.secondary.bar.actions.label.text
    And verify ejar view: Corporate Invoices Lines Report,تقرير بنود فواتير الشركات table headers: ejar.corporateinvoiceslines.view.table.headers.text
    And verify ejar view: Corporate Invoices Lines Report,تقرير بنود فواتير الشركات table headers with filter: ejar.corporateinvoiceslines.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Corporate invoices summary
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/corporate-invoices-summary
    And verify ejar view title text: ejar.corporateinvoicessummary.view.title.label.text
    And verify ejar fields label in view: Corporate Invoices Summary,ملخص فواتير الشركات text: ejar.corporateinvoicessummary.view.fields.label.text
    And verify ejar buttons label in view: Corporate Invoices Summary,ملخص فواتير الشركات text: ejar.corporateinvoicessummary.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Corporate Invoices Summary,ملخص فواتير الشركات text: ejar.corporateinvoicessummary.view.secondary.bar.actions.label.text
    And verify ejar view: Corporate Invoices Summary,ملخص فواتير الشركات table headers: ejar.corporateinvoicessummary.view.table.headers.text
    And verify ejar view: Corporate Invoices Summary,ملخص فواتير الشركات table headers with filter: ejar.corporateinvoicessummary.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Individual Invoices report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/individual-invoice-report
    And verify ejar view title text: ejar.individualinvoicesreportview.view.title.label.text
    And verify ejar fields label in view: Individual Invoice Report,تقرير فواتير الافراد text: ejar.individualinvoicesreportview.view.fields.label.text
    And verify ejar buttons label in view: Individual Invoice Report,تقرير فواتير الافراد text: ejar.individualinvoicesreportview.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Individual Invoice Report,تقرير فواتير الافراد text: ejar.individualinvoicesreportview.view.secondary.bar.actions.label.text
    And verify ejar view: Individual Invoice Report,تقرير فواتير الافراد table headers: ejar.individualinvoicesreportview.view.table.headers.text
    And verify ejar view: Individual Invoice Report,تقرير فواتير الافراد table headers with filter: ejar.individualinvoicesreportview.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



    @TestType-Regression
    Scenario: Cash In Hand Entries view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/cash-in-hand-entries
      And verify ejar view title text: ejar.cashinhandentries.view.title.label.text
      And verify ejar view sub title text: ejar.cashinhandentries.view.subtitle.label.text
      And verify ejar view: Cash In Hand Entries,قيود الصندوق النقدي table headers: ejar.cashinhandentries.view.table.headers.text
      And verify ejar view: Cash In Hand Entries,قيود الصندوق النقدي table headers with filter: ejar.cashinhandentries.view.table.headers.with.filters.text
      And click on action if exist: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.cashinhandentries.create.button.action.byxpath
      And click on action if exist: ejar.cashinhandentries.close.button.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

    @TestType-Regression
    Scenario: Cash In Hand Report view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/cash-in-hand-report
      And verify ejar fields count in the opened report view: 5
      And verify ejar fields label in the opened report view: ejar.financial.cashinhandentries.report.view.preview.fields.labels.text
      And verify ejar report view standard actions present
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


    @TestType-Regression
    Scenario: Integrated Invoices view verification
      Given user open ejar project url
      Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/reports/integrated-invoices-report
      And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 50
      And click on action if exist with wait: login.internal.temp.byxpath waiting number of seconds: 4
      And verify ejar view title text: ejar.integratedinvoices.view.title.label.text
      And verify ejar view: Integrated Invoices,الفواتير المتكاملة table headers: ejar.integratedinvoices.view.table.headers.text
      And verify form fields using labels xpath: //sub-header//following-sibling::div//label text: ejar.integratedinvoices.view.labels.text
      And user click on action if enabled with id: ejar.generic.export.action.byxpath
      And click on action if exist: ejar.generic.clear.action.byxpath
      And click on action if exist: ejar.generic.search.action.byxpath
      And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
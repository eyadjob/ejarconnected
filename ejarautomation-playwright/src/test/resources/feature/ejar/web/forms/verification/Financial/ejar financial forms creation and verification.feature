Feature: Ejar Financial forms verification and creation

  @TestType-Smoke
  Scenario: Create and verify corporate invoice form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And wait for element present: ejar.corporateinvoice.create.button.byxpath for period in seconds: 100
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.corporateinvoice.firstRow.button.byxpath
    And store ejar element value: ejar.corporateinvoice.contract.field.byxpath and value name: contractNumber and keep number only: false
    And store ejar element value: ejar.corporateinvoice.corporateName.field.byxpath and value name: corporateName and keep number only: false
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.contract.view.firstRow.field.byxpath for period in seconds: 120
    And set value into field: ejar.contract.view.contractNo.field.byxpath from stored variable: contractNumber
    And click on element: ejar.generic.search.action.byxpath
    And store ejar element value: ejar.contract.view.contractType.field.byxpath and value name: contractType and keep number only: false
    And click on element: ejar.contract.view.moreOptions.button.byxpath
    And click on element if exist: ejar.contract.view.addCharges.button.byxpath with wait: 5
    And click on element if exist: ejar.contract.view.addCharges2.button.byxpath with wait: 5
    And click on element: ejar.contract.otherCharges.add.button.byxpath
    And select option in ejar kendo option field: ejar.contract.otherCharges.type.field.byxpath by index: 0
    And set value into element : ejar.contract.otherCharges.amount.field.byxpath value: 100
    And select option in ejar kendo option field: ejar.contract.otherCharges.plate.field.byxpath by index: 0
    And click on element: ejar.contract.otherCharges.save.button.byxpath
    And click on element: ejar.contract.otherCharges.save2.button.byxpath
    And wait for element not present: ejar.contract.otherCharges.modal.button.byxpath
    And open page using url: /app/rental/financial/corporate/invoices
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.corporateinvoice.create.button.byxpath
    And verify ejar fields label with soft assertion in form: create-corporate-invoice text: ejar.corporateinvoice.labels.text
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Create Invoice,إضافة فاتورة                               | h4      |
      | Corporate,الشركة                                          | label   |
      | Date,التاريخ                                              | label   |
      | Contract Type,نوع العقد                                   | label   |
      | Quotation No,رقم العرض                                    | label   |
      | Invoice Due Date,تاريخ استحقاق الفاتورة                   | label   |
      | Comment,ملاحظات                                            | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                    | isEditable | isRequired |
      | ejar.corporateinvoice.corporate.field.byxpath                 | True       | True       |
      | ejar.corporateinvoice.date.field.byxpath                      | True       | True       |
      | ejar.corporateinvoice.contractType.field.dropdownlist.byxpath | True       | True       |
      | ejar.corporateinvoice.quotationNumber.field.byxpath           | True       | False      |
      | ejar.corporateinvoice.dueDate.field.byxpath                   | True       | True       |
      | ejar.corporateinvoice.comment.field.byxpath                   | True       | False      |
      | ejar.corporateinvoice.search.button.byxpath                   | False      | False      |
      | ejar.corporateinvoice.selectAll.button.byxpath                | True       | False      |
      | ejar.corporateinvoice.cancel.button.byxpath                   | True       | False      |
      | ejar.corporateinvoice.preview.button.byxpath                  | False      | False      |
    And click on element: ejar.corporateinvoice.corporate.field.byxpath
    And user select option by text in ejar kendo option field without click on empty field: ejar.corporateinvoice.corporateSearch.field.byxpath with option value from stored variable: corporateName
    And user select option by text in ejar kendo option field without click on empty field: ejar.corporateinvoice.contractType.field.byxpath with option value from stored variable: contractType
    And click on element: ejar.corporateinvoice.search.button.byxpath
    And click on element: ejar.corporateinvoice.selectAll.button.byxpath
    And remove attribute for element: ejar.corporateinvoice.preview.button.byxpath attribute: disabled
    And click on element: ejar.corporateinvoice.preview.button.byxpath
    And wait for element present: ejar.corporateinvoice.invoiceImg.button.byxpath for period in seconds: 60
    And click on element: ejar.corporateinvoice.generateInvoice.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.corporateinvoice.firstRow.button.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Invoice Profile,بيانات الفاتورة                           | li      |
      | Corporate,الشركة                                          | label   |
      | Due Date,تاريخ الاستحقاق                                   | label   |
      | Payment status,حالة الدفع                                 | label   |
      | Net Amount,صافي القيمة                                    | label   |
      | Paid Amount,المبلغ المدفوع                                | label   |
      | Tax Amount,القيمة المضافة                                 | label   |
      | CN Amount,قيمة إشعار الدائن                               | label   |
      | Contract No.,رقم العقد                                    | span    |
      | Item,البند                                                | span    |
      | Quantity,الكمية                                           | span    |
      | Unit Price,سعر الوحدة                                     | span    |
      | Tax %,القيمة المضافة %                                    | span    |
      | Tax Amount,القيمة المضافة                                 | span    |
      | Net Amount,صافي القيمة                                    | span    |
      | CN Invoices,فواتير الإشعار الدائن                          | b       |
      | Invoice Number,رقم الفاتورة                               | span    |
      | Invoice Date,تاريخ الفاتورة                               | span    |
      | Amount,القيمة                                             | span    |
      | Tax Amount,القيمة المضافة                                 | span    |
      | Status,الحالة                                             | span    |
      | Reason,سبب الإصدار                                         | span    |
      | DN Invoices,فواتير اشعار المدين                           | b       |
      | Invoice Number,رقم الفاتورة                               | span    |
      | Invoice Date,تاريخ الفاتورة                               | span    |
      | Amount,القيمة                                             | span    |
      | Tax Amount,القيمة المضافة                                 | span    |
      | Status,الحالة                                             | span    |
      | Reason,سبب الإصدار                                         | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.corporateinvoice.corporateName.field.byxpath          | False      | False      |
      | ejar.corporateinvoice.dueDate.field.read.byxpath           | False      | False      |
      | ejar.corporateinvoice.paymentStatus.field.read.byxpath     | False      | False      |
      | ejar.corporateinvoice.netAmount.field.read.byxpath         | False      | False      |
      | ejar.corporateinvoice.paidAmount.field.read.byxpath        | False      | False      |
      | ejar.corporateinvoice.taxAmount.field.read.byxpath         | False      | False      |
      | ejar.corporateinvoice.CNAmount.field.read.byxpath          | False      | False      |
      | ejar.corporateinvoice.item.field.byxpath                   | False      | False      |
      | ejar.corporateinvoice.quantity.field.byxpath               | False      | False      |
      | ejar.corporateinvoice.unitPrice.field.byxpath              | False      | False      |
      | ejar.corporateinvoice.tax.field.byxpath                    | False      | False      |
      | ejar.corporateinvoice.taxAmount.field.byxpath              | False      | False      |
      | ejar.corporateinvoice.netAmount.field.byxpath              | False      | False      |
    And store ejar element value: ejar.corporateinvoice.invoiceNumber.field.byxpath and value name: invoiceNumber and keep number only: false
    And click on element: ejar.generic.close.action.byxpath
    And set value into field: ejar.corporateinvoice.invoiceNumberSearch.field.byxpath from stored variable: invoiceNumber
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.corporateinvoice.cancelInvoice.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath

  @TestType-Smoke
  Scenario: Create and verify bulk corporate invoices
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And wait for element present: ejar.corpbulkinvoices.create.button.byxpath for period in seconds: 100
    And click on element: ejar.corpbulkinvoices.create.button.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Corporate Invoices,فواتير الشركات                         | h1      |
      | Bulk Create Invoices,إضافة عدة فواتير                     | span    |
      | Corporate Invoices,فواتير الشركات                         | li      |
      | Country,الدولة                                            | label   |
      | Invoice Due Date,تاريخ استحقاق الفاتورة                   | label   |
      | Attachment Instructions,تعليمات المرفقات                  | label   |
      | Attachment,المرفق                                         | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.corpbulkinvoices.country.field.byxpath                | True       | True       |
      | ejar.corpbulkinvoices.invoiceDueDate.field.byxpath         | True       | True       |
      | ejar.generic.save.action.byxpath                           | False      | False      |
      | ejar.generic.cancel.action.byxpath                         | True       | False      |
    And user select date time in ejar calendar field: ejar.corpbulkinvoices.invoiceDueDate.input.byxpath plus days: 3 and time: 12:00
    And upload file to element: ejar.corpbulkinvoices.uploadfile.button.byxpath with path: //uploadFiles//TrafficViolation.xlsx
    And click on element: ejar.generic.save.action.byxpath
    And click on element if exist: ejar.generic.popupok.action.byxpath with wait: 30
    And click on action if exist: ejar.generic.cancel.action.byxpath


  @TestType-Smoke
  Scenario: Create and verify bulk corporate notes
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And wait for element present: ejar.corpbulknotes.create.button.byxpath for period in seconds: 100
    And click on element: ejar.corpbulknotes.create.button.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Corporate Invoices,فواتير الشركات                         | h1      |
      | Bulk Create Notes,إضافة عدة إشعارات                       | span    |
      | Corporate Invoices,فواتير الشركات                         | li      |
      | Country,الدولة                                            | label   |
      | Note Type,نوع الإشعار                                      | label   |
      | Attachment,المرفق                                         | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.corpbulknotes.country.field.byxpath                   | True       | True       |
      | ejar.corpbulknotes.noteType.field.byxpath                  | True       | True       |
      | ejar.generic.save.action.byxpath                           | False      | False      |
      | ejar.generic.cancel.action.byxpath                         | True       | False      |
      | ejar.corpbulknotes.downloadTemplate.button.byxpath         | True       | False      |
    And select option in ejar kendo option field: ejar.corpbulknotes.noteType.span.byxpath by index: 1
    And upload file to element: ejar.corpbulknotes.uploadfile.button.byxpath with path: //uploadFiles//TrafficViolation.xlsx
    And click on element: ejar.generic.save.action.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And click on action if exist with wait: ejar.corpbulknotes.delete.button.byxpath waiting number of seconds: 5
    And click on action if exist: ejar.generic.yes.action.byxpath


  @TestType-Smoke
  Scenario: Create and verify pay invoices
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And wait for element present: ejar.payinvoice.create.button.byxpath for period in seconds: 150
    And filter view based on state column name: Payment status,حالة الدفع and enter value:Unpaid,غير مدفوع
    And store ejar element value: ejar.payinvoice.corpName.span.byxpath and value name: corpName and keep number only: false
    And click on element: ejar.payinvoice.create.button.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Pay Invoices,دفع الفواتير                                 | h4      |
      | Corporate,الشركة                                          | label   |
      | Corporate Code,كود الشركة                                 | label   |
      | Payment Method,طريقة الدفع                                | label   |
      | Comment,ملاحظات                                            | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.payinvoice.corporate.field.byxpath                    | True       | False      |
      | ejar.payinvoice.corporateCode.field.byxpath                | True       | False      |
      | ejar.payinvoice.paymentMethod.field.byxpath                | True       | True       |
      | ejar.payinvoice.search.button.byxpath                      | False      | False      |
      | ejar.payinvoice.comment.field.byxpath                      | True       | False      |
      | ejar.payinvoice.cancel.action.byxpath                      | True       | False      |
      | ejar.payinvoice.save.action.byxpath                        | False      | False      |
    And click on element: ejar.payinvoice.corporate.field.byxpath
    And set value into field: ejar.payinvoice.corpSearch.input.byxpath from stored variable: corpName
    And click on element: ejar.payinvoice.corporateSelection.button.byxpath
    And click on element: ejar.payinvoice.paymentMethod.field.byxpath
    And click on element: ejar.payinvoice.cashPaymentMethod.button.byxpath
    And click on element: ejar.payinvoice.search.button.byxpath
    And click on element: ejar.payinvoice.selectAllInvoices.field.byxpath
    And click on element: ejar.payinvoice.save.action.byxpath


  @TestType-Smoke
  Scenario: Create and verify bulk pay invoices
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/corporate/invoices
    And wait for element present: ejar.bulkpayinvoice.create.button.byxpath for period in seconds: 100
    And click on element: ejar.bulkpayinvoice.create.button.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Bulk Pay Invoices,دفع عدة فواتير                          | h4      |
      | Country,الدولة                                            | label   |
      | Attachment,المرفق                                         | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.bulkpayinvoice.country.field.byxpath                  | True       | True       |
      | ejar.bulkpayinvoice.downloadTemplate.button.byxpath        | True       | False      |
      | ejar.generic.save.action.byxpath                           | False      | False      |
      | ejar.bulkpayinvoice.cancel.button.byxpath                  | True       | False      |
    And upload file to element: ejar.bulkpayinvoice.uploadfile.field.byxpath with path: //uploadFiles//TrafficViolation.xlsx
    And click on element: ejar.generic.save.action.byxpath
    And click on action if exist with wait: ejar.bulkpayinvoice.yes.button.byxpath waiting number of seconds: 1
    And click on action if exist with wait: ejar.corpbulknotes.delete.button.byxpath waiting number of seconds: 3
    And click on action if exist: ejar.generic.yes.action.byxpath



  @TestType-Smoke
  Scenario: Create and verify Cash in hand entries
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/financial/cash-in-hand-entries
    And wait for element present: ejar.cashInHandEntries.createnew.byxpath for period in seconds: 130
    And click on element: ejar.cashInHandEntries.createnew.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Add Entry,إضافة قيد                                       | h4      |
      | Branch,الفرع                                              | label   |
      | Vouchers Total From Last Entry,إجمالي السندات من أخر قيد  | label   |
      | Date,التاريخ                                              | label   |
      | Recipient,المستلم                                         | label   |
      | Amount,القيمة                                             | label   |
      | Comment,الملاحظه                                           | label   |
      | Proof of Entry,إثباتات القيد                              | label   |
      | Drag files here to upload,اسحب الملفات هنا للتحميل        | div     |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.cashInHandEntries.branch.field.byxpath                | False      | False      |
      | ejar.cashInHandEntries.lastEntryVoucherTotal.field.byxpath | False      | False      |
      | ejar.cashInHandEntries.date.field.byxpath                  | True       | True       |
      | ejar.cashInHandEntries.recipient.field.byxpath             | True       | True       |
      | ejar.cashInHandEntries.amount.field.byxpath                | True       | True       |
      | ejar.cashInHandEntries.comment.field.byxpath               | True       | False      |
      | ejar.cashInHandEntries.save.field.byxpath                  | False      | False      |
      | ejar.cashInHandEntries.cancel.field.byxpath                | True       | False      |
    And set value into element : ejar.cashInHandEntries.employeeName.field.byxpath value: Eyad
    And click on element: ejar.cashInHandEntries.employeeName.li.byxpath
    And set value into element : ejar.cashInHandEntries.amount.field.byxpath value: 1000
    And click on element: ejar.cashInHandEntries.modalHeader.byxpath
    And upload file to element: ejar.cashInHandEntries.uploadFile.field.byxpath with path: //uploadFiles//logo_high.png
    And store element value: ejar.cashInHandEntries.recipient.field.byxpath and value name: recipientName and keep number only: false
    And click on element: ejar.cashInHandEntries.save.field.byxpath
    And wait for element present: ejar.cashInHandEntries.modal.div.byxpath for period in seconds: 120
    And click on element: ejar.cashInHandEntriesDepsoit.firstRowButton.byxpath
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Bank Deposit Details,بيانات الإيداع البنكي                 | h4      |
      | Bank Name,اسم البنك                                       | label   |
      | Deposit Reference Number,الرقم المرجعي للإيداع             | label   |
      | Deposit Slip,قسيمة الإيداع                                 | label   |
      | Drag files here to upload,اسحب الملفات هنا للتحميل        | div     |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                 | isEditable | isRequired |
      | ejar.cashInHandEntriesDepsoit.bankName.byxpath             | True       | True       |
      | ejar.cashInHandEntriesDepsoit.depositReference.byxpath     | True       | False      |
      | ejar.cashInHandEntriesDepsoit.cancel.field.byxpath         | True       | False      |
    And user select value in drop down field: ejar.cashInHandEntriesDepsoit.bankName.byxpath by index: 1
    And upload file to element: ejar.cashInHandEntriesDepsoit.selectFile.byxpath with path: //uploadFiles//logo_high.png
    And click on element: ejar.cashInHandEntriesDepsoit.save.field.byxpath
    And wait for number of seconds: 1

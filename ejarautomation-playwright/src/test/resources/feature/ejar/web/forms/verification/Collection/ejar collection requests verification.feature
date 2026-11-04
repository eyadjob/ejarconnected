Feature: Collection Requests(Distribute) Profile Verification

  @TestType-Smoke
  Scenario: Collection Requests(Distribute) form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/collections/collection-requests/collection-requests-list
    And click on link: ejar.collectionrequests.createnew.byxpath
    And verify ejar fields label with soft assertion in form: distribute-contracts-modal text: ejar.collectionrequests.label.text
    And verify form page labels and text:
      | Text                                  | TagType |
      | Distribute,توزيع                      | span    |
      | Stage,المرحلة                         | label   |
      | From,من                               | label   |
      | To,الى                                | label   |
      | Contract Number,رقم العقد             | span    |
      | Customer Name,اسم العميل              | span    |
      | Stage entry date,تاريخ دخول المرحلة   | span    |
      | Indebt Amount,قيمة المطالبة           | span    |
      | Close Date,وقت الاغلاق                  | span    |
      | Stage,المرحلة                         | span    |
      | Assigned Employee,الموظف المخصص       | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.collectionrequests.stage.fields.byxpath                     | True       | True       |
      | ejar.collectionrequests.fromdate.fields.byxpath                  | True       | False      |
      | ejar.collectionrequests.todate.fields.byxpath                    | True       | False      |
      | ejar.collectionrequests.search.button.byxpath                    | False      | False      |
      | ejar.collectionrequests.save.button.byxpath                      | False      | False      |
      | ejar.collectionrequests.cancel.button.byxpath                    | True       | False      |



  @TestType-Smoke
  Scenario: Collection Requests Statements creation and verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/collections/collection-requests/collection-requests-list
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 120
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.collectionrequestsstatement.firstContractNo.a.byxpath for period in seconds: 100
    And click on element if exist: ejar.collectionrequestsstatement.more.a.byxpath with wait: 1
    And store ejar element value: ejar.collectionrequestsstatement.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element if exist: ejar.collectionrequestsstatement.viewStatement.a.byxpath with wait: 1
    And click on element: ejar.collectionrequestsstatement.addStatement.a.byxpath
    And verify form page labels and text:
      | Text                                  | TagType |
      | Statements,افادات                     | h1      |
      | Statement,افادة                       | li      |
      | Statement Type,نوع الافادة             | label   |
      | Call Status,حالة الاتصال               | label   |
      | Statement Status,حالة الافادة          | label   |
      | Statement Details,تفاصيل الافادة       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.collectionrequestsstatement.statementType.field.byxpath     | True       | True       |
      | ejar.collectionrequestsstatement.callStatus.field.byxpath        | True       | True       |
      | ejar.collectionrequestsstatement.statementStatus.field.byxpath   | True       | True       |
      | ejar.collectionrequestsstatement.statementDetails.field.byxpath  | True       | False      |
      | ejar.generic.save.action.byxpath                                 | False      | False      |
      | ejar.generic.cancel.action.byxpath                               | True       | False      |
    And user select option by text in ejar kendo option field without typing: ejar.collectionrequestsstatement.statementType.field.byxpath option: Phone,هاتف
    And user select option by text in ejar kendo option field without typing: ejar.collectionrequestsstatement.callStatus.field.byxpath option: Answered,رد
    And user select option by text in ejar kendo option field without typing: ejar.collectionrequestsstatement.statementStatus.field.byxpath option: Refuse To Pay,رفض السداد
    And set random text into element: ejar.collectionrequestsstatement.statementDetails.field.byxpath with size: 6 and initial string: UI Automation Statement Details
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.collectionrequestsstatement.contractNumber.field.byxpath for period in seconds: 100
    And set value into field: ejar.collectionrequestsstatement.contractNumber.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.collectionrequestsstatement.firstContractNo.a.byxpath for period in seconds: 100
    And click on element if exist: ejar.collectionrequestsstatement.more.a.byxpath with wait: 2
    And click on element if exist: ejar.collectionrequestsstatement.viewStatement.a.byxpath with wait: 2
    And verify element present: ejar.collectionrequestsstatement.statementHistory.field.byxpath
    And click on element: ejar.generic.close.action.byxpath
Feature: System Lookups Profile Verification

  @TestType-Smoke
  Scenario: System Lookups form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/lookups
    And user select value in drop down field: ejar.lookups.list.byxpath by option text: Accident Report Source, مصدر تقرير الحوادث
    And click on link: ejar.lookups.createnew.byxpath
    And verify ejar fields label with soft assertion in form: createoreditlookupmodal text: ejar.lookups.labelAccidentReport.text
    And verify form page labels and text:
      | Text                       | TagType |
      | Name [en],الاسـم [en]       | label   |
      | Name [ar],الاسـم [ar]       | label   |
      | Name [de],الاسـم [de]       | label   |
      | Name [fr],الاسـم [fr]       | label   |
      | Country,الدولة             | label   |
      | Value,القيمة               | label   |
      | Sequence,التسلسل           | label   |
      | Is Active,فعال             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.lookups.name_en.fields.edit.byxpath                         | True       | True       |
      | ejar.lookups.name_ar.fields.edit.byxpath                         | True       | True       |
      | ejar.lookups.country.fields.edit.byxpath                         | True       | True       |
      | ejar.lookups.value.fields.edit.byxpath                           | True       | False      |
      | ejar.lookups.inputSequence.fields.edit.byxpath                   | True       | True       |
      | ejar.lookups.isActive.fields.edit.byxpath                        | True       | False      |
      | ejar.lookups.save.button.byxpath                                 | False      | False      |
      | ejar.lookups.cancel.button.byxpath                               | True       | False      |

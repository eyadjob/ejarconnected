Feature: Identity Settings Profile Verification

  @TestType-Smoke
  Scenario: Identity settings profile form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-country-settings
    And verify ejar fields label with soft assertion in form: app-country-settings text: ejar.identitysettings.alllabels.label.text
    And verify form page labels and text:
      | Text                                                                                | TagType |
      | Identity settings,اعدادات الاثباتات                                                  |  h1     |
      | Show and change country settings.,عرض وتغيير إعدادات الدولة                         | span    |
      | Countries,الدول                                                                     | label   |
      | Customers,العملاء                                                                    |  h5     |
      | Identity number digits,عدد خانات الهوية الشخصية                                     | label   |
      | Passport number digits,عدد خانات جواز السفر                                         | label   |
      | Visa number digits,عدد خانات التأشيرة                                               | label   |
      | Iqama number digits,عدد خانات الإقامة                                                | label   |
      | Driver license number digits,عدد خانات رخصة القيادة                                 | label   |
      | Identity copy number digits,عدد خانات رقم نسخة الهوية                               | label   |
      | Iqama copy number digits,عدد خانات رقم نسخة الإقامة                                  | label   |
      | Border ID Digits,عدد خانات رقم الحدود                                               | label   |
      | Customer service phone number,رقم هاتف خدمة العملاء                                  | label   |
      | Occupation required,الوظيفة مطلوبة للمقيم                                           | label   |
      | Is Copy Number Required For Identity And Iqama,هل رقم النسخه اجبارى للهوية و الاقامة | label   |
      | Is Visa Number Required For Passport,هل رقم التأشيرة اجبارى لجواز السفر             | label   |
      | Is Border Number Required For Passport,هل رقم الحدود اجبارى لجواز السفر             | label   |
      | Corporate Max credit limit,الحد الإئتماني الأقصى للشركات                              | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                               | isEditable | isRequired |
      | ejar.identitysettings.countries.field.edit.byxpath                       | True       | True       |
      | ejar.identitysettings.identitynumberdigits.field.edit.byxpath            | True       | True       |
      | ejar.identitysettings.passportnumberdigits.field.edit.byxpath            | True       | True       |
      | ejar.identitysettings.visanumberdigits.field.edit.byxpath                | True       | True       |
      | ejar.identitysettings.iqamanumberdigits.field.edit.byxpath               | True       | True       |
      | ejar.identitysettings.driverlicensenumberdigits.field.edit.byxpath       | True       | True       |
      | ejar.identitysettings.identitycopynumberdigits.field.edit.byxpath        | True       | True       |
      | ejar.identitysettings.iqamacopynumberdigits.field.edit.byxpath           | True       | True       |
      | ejar.identitysettings.borderIdDigits.field.edit.byxpath                  | True       | True       |
      | ejar.identitysettings.customerServicePhoneNo.field.edit.byxpath          | True       | True       |
      | ejar.identitysettings.occupationrequired.field.edit.byxpath              | True       | False      |
      | ejar.identitysettings.iscopynumberrequiredforidentity.field.edit.byxpath | True       | False      |
      | ejar.isvisanumberrequiredforpassport.field.edit.byxpath                  | True       | False      |
      | ejar.isBorderNumberRequiredForPassport.field.edit.byxpath                | True       | False      |
      | ejar.corporateMaxCreditLimit.field.edit.byxpath                          | True       | True       |
      | ejar.identitysettings.save.button.byxpath                                | False      | False      |
      | ejar.identitysettings.cancel.button.byxpath                              | True       | False      |
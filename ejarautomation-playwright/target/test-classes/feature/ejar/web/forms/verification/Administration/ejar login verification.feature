Feature: Login Verification

  @TestType-Smoke
  Scenario: Login form verification
    Given user open ejar project url
    Given switch to language property
    And wait for element present: ejar.loginpage.username.byxpath for period in seconds: 80
    And verify form page labels and text:
      | Text                                                 | TagType |
      | User name or email,اسم المستخدم أو البريد الإلكتروني  |  label  |
      | Password,كلمة المرور                                 |  label  |
      | Log in,تسجيل الدخول                                  |  button |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.loginpage.yelologo.byxpath                                  | False      | False      |
      | ejar.loginpage.username.byxpath                                  | True       | True       |
      | ejar.loginpage.password.byxpath                                  | True       | True       |
      | ejar.loginpage.loginaction.byxpath                               | False      | False      |
      | ejar.loginpage.arabic.language.icon.byxpath                      | False      | False      |
      | ejar.loginpage.english.language.icon.byxpath                     | False      | False      |
      | ejar.loginpage.yelologo1.byxpath                                 | False      | False      |
      | ejar.loginpage.copyright.byxpath                                 | True       | False      |
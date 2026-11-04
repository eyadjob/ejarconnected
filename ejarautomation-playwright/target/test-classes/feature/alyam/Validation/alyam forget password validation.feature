Feature: Alyam Forget password Validation

  @TestType-Regression
  Scenario: validate forget password - Not registered email - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on link: alyam.forget-password.button.byxpath
    And user enter value : sdfsafdasfs@gmail.com in field : alyam.forget-password.email.input.byxpath
    And click on element: alyam.forget-password.submit.button.byxpath
    And verify text present on page: alyam.forget-password.NotRegisteredEmail.text
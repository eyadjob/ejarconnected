Feature: Yelo Login Page Verification

  @TestType-Regression
  Scenario: verify login page
    Given user open website page: yelo
    And click on link: yelo.header.login-link.byxpath
    And verify text present on page: yelo.login.welcomeback.text
    And verify text present on page: yelo.login.welcome-msg.text
    And verify element text present: yelo.login.termsemail.label.byxpath with text: yelo.login.termsemail.text
    And verify element text present: yelo.login.termspassword.label.byxpath with text: yelo.login.termspassword.text
    And verify element text present: yelo.login.rememberMe.label.byxpath with text: yelo.login.rememberMe.text
    And verify element present: yelo.foreget-password.button.byxpath
    And verify element present: yelo.login.termsemail.field.byxpath
    And verify element present: yelo.login.rememberMe.field.byxpath
    And verify element present: yelo.login.termspassword.field.byxpath
    And verify element present: yelo.login-submit-btn.button.byxpath
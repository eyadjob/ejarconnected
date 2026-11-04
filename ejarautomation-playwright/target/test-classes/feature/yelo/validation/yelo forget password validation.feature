Feature: Yelo Forget password Validation

  @TestType-Regression
  Scenario: validate forget password - Not registered email - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on link: yelo.forget-password.button.byxpath
    And user enter value : sdfsafdasfs@gmail.com in field : yelo.forget-password.email.input.byxpath
    And click on element: yelo.forget-password.submit.button.byxpath
    And verify text present on page: yelo.forget-password.NotRegisteredEmail.text


#captch exists
#  @TestType-Regression
#  Scenario: validate forget password
#    Given register new user using temp email with password:: pass123456
#    And click on element: yelo.header.userArrowDropDown.byxpath
#    And click on element: yelo.register.logout.label.byxpath
#    And click on link: yelo.homepage.loginlink.byxpath
#    And click on link: yelo.forget-password.button.byxpath
#    And set value into element : yelo.forget-password.email.input.byxpath by context key: email
#    And click on element: yelo.forget-password.submit.button.byxpath
#    And verify text present on page: yelo.forget-password.emailSentSuccessMsg.span.text
#    And switch to browser tab : 1
#    And click on element: yelo.forget-password.backBtn.p.byxpath
#    And wait for element present: yelo.forget-password.changePasswordLink.email.a.byxpath for period in seconds: 120
#    And click on element: yelo.forget-password.changePasswordLink.email.a.byxpath
#    And click on element: yelo.forget-password.changePasswordLink.a.byxpath
#    And user enter value : pass1234567 in field : yelo.forget-password.password.input.byxpath
#    And user enter value : pass1234567 in field : yelo.forget-password.confirmPassword.input.byxpath
#    And click on element: yelo.forget-password.resetPassword.input.byxpath
#    And verify text present on page: yelo.forget-password.passwordChanged.text
#    And click on element: yelo.forget-password.login.a.byxpath
#    And set value into element : yelo.login.email.field.byxpath by context key: email
#    And user enter value : pass1234567 in field : yelo.login.password.field.byxpath
#    And click on element: yelo.login.submitlogin.byxpath
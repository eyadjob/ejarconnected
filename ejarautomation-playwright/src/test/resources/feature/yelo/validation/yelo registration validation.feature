Feature: Yelo Register Validation


  @TestType-Regression
  Scenario: validate register - validate email required - error message should be displayed if empty
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.email.field.byxpath value: Eyad@gmail.com
    And clear element: yelo.register.email.field.byxpath by back space: 15
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.field.required.error.span.text

  @TestType-Regression
  Scenario: validate register - wrong email - no @ char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test.com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate register - wrong email - more than one @ char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test@test@test.com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate register - wrong email - special char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test;test@test.com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate register - wrong email - space - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test test@test.com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate register - wrong email - double dot - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test.test@test..com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email then correct email - error message should be displayed then disappeared
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user enter value : test test@test.com in field : yelo.register.email.field.byxpath
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.email.error.required.byxpath with text: yelo.login.email.error.span.text
    And user enter value : test@test.com in field : yelo.register.email.field.byxpath
    And verify element not present: yelo.email.error.required.byxpath within time of seconds: 2 and status: visible

  @TestType-Regression
  Scenario: validate register - validate first name - required - error message should be displayed if empty
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.firstName.field.byxpath value: Eyad
    And click on element: yelo.register.lastName.field.byxpath
    And clear field: yelo.register.firstName.field.byxpath
    And remove attribute for element: yelo.register.registration.button.byxpath attribute: disabled
    And click on element: yelo.register.registration.button.byxpath
    And verify element text present: yelo.firstName.error.span.byxpath with text: yelo.field.required.error.span.text

  @TestType-Regression
  Scenario: validate register - validate first name - contains numbers - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.firstName.field.byxpath value: 1Eyad1
    And click on element: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.firstName.error.span.byxpath with text: yelo.field.invalidFormat.error.span.text

  @TestType-Regression
  Scenario: validate register - validate last name - required - error message should be displayed if empty
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.lastName.field.byxpath value: Mubarak
    And click on element: yelo.register.firstName.field.byxpath
    And clear field: yelo.register.lastName.field.byxpath
    And remove attribute for element: yelo.register.registration.button.byxpath attribute: disabled
    And click on element: yelo.register.registration.button.byxpath
    And verify element text present: yelo.lastName.error.span.byxpath with text: yelo.field.required.error.span.text

  @TestType-Regression
  Scenario: validate register - validate last name - contains numbers - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.lastName.field.byxpath value: 1Mubarak1
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.lastName.error.span.byxpath with text: yelo.field.invalidFormat.latName.error.span.text

  @TestType-Regression
  Scenario: validate register - validate mobile - required - error message should be displayed if empty
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.mobile.field.byxpath value: 516745235
    And click on element: yelo.register.firstName.field.byxpath
    And clear field: yelo.register.mobile.field.byxpath
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.mobile.error.span.byxpath with text: yelo.field.required.error.span.text

  @TestType-Regression
  Scenario: validate register - validate mobile - short number - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.mobile.field.byxpath value: 516
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.mobile.error.inValidFormat.span.byxpath with text: yelo.mobile.short.span.text

  @TestType-Regression
  Scenario: validate register - validate mobile - long number - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.mobile.field.byxpath value: 5165674534875623
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.mobile.error.inValidFormat.span.byxpath with text: yelo.mobile.long.span.text

  @TestType-Regression
  Scenario: validate register - validate mobile - invalid number - error message should be displayed
    Given user open page yelo page: /Home
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.mobile.field.byxpath value: 1111111111
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.mobile.error.inValidFormat.span.byxpath with text: yelo.mobile.inValidFormat.span.text
    And user set in field: yelo.register.mobile.field.byxpath value: 1111111111111
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.mobile.error.inValidFormat.span.byxpath with text: yelo.mobile.long.span.text

  @TestType-Regression
  Scenario: validate register - validate password - required - error message should be displayed if empty
    Given user open page yelo page: /Home
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.Password.field.byxpath value: 123Aabcdefghijk
    And click on element: yelo.register.firstName.field.byxpath
    And clear field: yelo.register.Password.field.byxpath
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.password.error.span.byxpath with text: yelo.field.required.error.span.text

  @TestType-Regression
  Scenario: validate register - validate password - too short - error message should be displayed
    Given user open page yelo page: /Home
    And click on link: yelo.register.button.byxpath
    And user set in field: yelo.register.Password.field.byxpath value: ab
    And click on element: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.password.error.span.byxpath with text: ًyelo.password.short.span.text

#invalid scenario there is a captcha
#  @TestType-Regression
#  Scenario: register new user with valid info - happy case
#    Given user open page yelo page: /Home
#    And click on link: yelo.register.button.byxpath
#    And user set in field: yelo.register.firstName.field.byxpath value: Eyad
#    And user set in field: yelo.register.lastName.field.byxpath value: Sawafteh
#    And open other browser tab: https://cryptogmail.com/
#    And switch to browser tab : 1
#    And store element value: yelo.register.tempMail.input.byxpath and value name: email and keep number only: false
#    And switch to browser tab : 0
#    And set value into element : yelo.register.email.field.byxpath by context key: email
#    And user set in field: yelo.register.mobile.field.byxpath value: 516754786
#    And user set in field: yelo.register.Password.field.byxpath value: pass123456
#    And click on element: yelo.acceptTermsConditions.label.byxpath
#    And remove attribute for element with id: yelo.register.submit.button.id attribute: disabled
#    And click on link: yelo.register.registration.button.byxpath
#    And switch to browser tab : 1
#    And wait for element present: yelo.register.activationCode.email.a.byxpath for period in seconds: 500
#    And user scroll to element: yelo.register.activationCode.email.a.byxpath
#    And click on element: yelo.register.activationCode.email.a.byxpath
#    And store element value: yelo.register.activationCode.b.byxpath and value name: activationCode and keep number only: true
#    And switch to browser tab : 0
#    And set value into element : yelo.register.verifyCodePart.input.byxpath by context key: activationCode
#    And click on element: yelo.register.continue.button.byxpath
#    And click on element: yelo.register.SaudiResident.a.byxpath
#    And click on element: yelo.header.userArrowDropDown.byxpath
#    And click on element: yelo.register.logout.label.byxpath
#    And login to yelo site with context key: email and password: pass123456
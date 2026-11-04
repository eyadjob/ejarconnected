Feature: Alyam login Validation

  @TestType-Regression
  Scenario: validate login email - wrong email - no @ char - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: alyam.login.email.error.span.byxpath
    And user enter value : test.com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - more than one @ char - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: alyam.login.email.error.span.byxpath
    And user enter value : test@test@test.com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - special char - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: alyam.login.email.error.span.byxpath
    And user enter value : test;test@test.com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - space - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: alyam.login.email.error.span.byxpath
    And user enter value : test test@test.com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - double dot - error message should be displayed
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: alyam.login.email.error.span.byxpath
    And user enter value : test.test@test..com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email then correct email - error message should be displayed then disappeared
    Given user open website page: alyam
    And click on link: alyam.homepage.loginlink.byxpath
    And click on the element: alyam.homepage.loginlink.byxpath if element: alyam.login.loginForm.form.byxpath is not present with wait: 5
    And user enter value : test test@test.com in field : alyam.login.email.field.byxpath
    And click on element: alyam.login.password.field.byxpath
    And verify element text present: alyam.login.email.error.span.byxpath with text: alyam.login.email.error.span.text
    And user enter value : test@test.com in field : alyam.login.email.field.byxpath
    And wait for element not present: alyam.login.email.error.span.byxpath


  @TestType-Regression
  Scenario: validate login - wrong password - error message should be displayed
    Given user open website page: alyam
    And login to yelo site with user: yazeedswiss@iyelo.com and password: 123
    And verify element text present: alyam.login.password.error.span.byxpath with text: alyam.login.password.error.span.text

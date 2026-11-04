Feature: Yelo login Validation

  @TestType-Regression
  Scenario: validate login email - wrong email - no @ char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: yelo.login.email.error.span.byxpath
    And user enter value : test.com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - more than one @ char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: yelo.login.email.error.span.byxpath
    And user enter value : test@test@test.com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - special char - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: yelo.login.email.error.span.byxpath
    And user enter value : test;test@test.com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - space - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: yelo.login.email.error.span.byxpath
    And user enter value : test test@test.com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email - double dot - error message should be displayed
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And wait for element not present: yelo.login.email.error.span.byxpath
    And user enter value : test.test@test..com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text

  @TestType-Regression
  Scenario: validate login email - wrong email then correct email - error message should be displayed then disappeared
    Given user open website page: yelo
    And click on link: yelo.homepage.loginlink.byxpath
    And click on the element: yelo.homepage.loginlink.byxpath if element: yelo.login.loginForm.form.byxpath is not present with wait: 5
    And user enter value : test test@test.com in field : yelo.login.email.field.byxpath
    And click on element: yelo.login.password.field.byxpath
    And verify element text present: yelo.login.email.error.span.byxpath with text: yelo.login.email.error.span.text
    And user enter value : test@test.com in field : yelo.login.email.field.byxpath
    And wait for element not present: yelo.login.email.error.span.byxpath


  @TestType-Regression
  Scenario: validate login - wrong password - error message should be displayed
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: 123
    And verify element text present: yelo.login.password.error.span.byxpath with text: yelo.login.password.error.span.text

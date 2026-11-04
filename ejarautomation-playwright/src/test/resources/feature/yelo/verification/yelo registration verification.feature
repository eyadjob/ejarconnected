Feature: Yelo Register Page Verification

  @TestType-Regression
  Scenario: verify register page
    Given user open website page: yelo
    And click on link: yelo.register.button.byxpath
    And verify element present: yelo.register.firstName.field.byxpath
    And verify element text present: yelo.register.firstName.label.byxpath with text: yelo.register.firstName.text
    And verify element present: yelo.register.lastName.field.byxpath
    And verify element text present: yelo.register.lastName.label.byxpath with text: yelo.register.lastName.text
    And verify element present: yelo.register.email.field.byxpath
    And verify element text present: yelo.register.email.label.byxpath with text: yelo.register.email.text
    And verify element present: yelo.register.mobile.field.byxpath
    And verify element text present: yelo.register.mobile.label.byxpath with text: yelo.register.mobile.text
    And verify element present: yelo.register.Password.field.byxpath
    And verify element text present: yelo.register.Password.label.byxpath with text: yelo.register.Password.text
    And verify element present: yelo.register.registration.button.byxpath
    And verify element text present: yelo.register.welcome-back.byxpath with text: yelo.register.welcome-back.text
    And verify text present on page: yelo.register.firstp1.text
    And verify text present on page: yelo.register.firstp2.text
    And verify text present on page: yelo.register.firstp3.text
    And verify text present on page: yelo.register.firstp4.text

Feature: Alyam Services Page Verification

  @TestType-Regression
  Scenario: verify services page
    Given user open website page: alyam
    And user open page yelo page: /services
    And verify text present on page: alyam.services.servicesTitle.text
    And verify text present on page: alyam.services.firstP.text
    And verify text present on page: alyam.services.secondP.text
    And verify text present on page: alyam.services.thirdP.text
    And verify text present on page: alyam.services.forthP.text

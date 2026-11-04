Feature: Alyam About us Page Verification

  @TestType-Regression
  Scenario: verify about us page
    Given user open website page: alyam
    And user open page yelo page: /about
    And verify text present on page: alyam.aboutus.title.text
    And verify element text present: alyam.aboutus.firstP.p.byxpath with text: alyam.aboutus.firstP.text
    And verify text present on page: alyam.aboutus.secondP.text
    And verify element text present: alyam.aboutus.thirdP.p.byxpath with text: alyam.aboutus.thirdP.text
    And verify element text present: alyam.aboutus.forthP.p.byxpath with text: alyam.aboutus.forthP.text
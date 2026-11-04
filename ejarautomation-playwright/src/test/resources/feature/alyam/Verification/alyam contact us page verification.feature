Feature: Alyam contact Us Page Verification

  @TestType-Regression
  Scenario: verify contact us page
    Given user open website page: alyam
    And user open page yelo page: /contact
    And verify element present: alyam.contactus.img.byxpath
    And verify text present on page: alyam.contactus.title.text
    And verify element text present: alyam.contactus.titleDesc.p.byxpath with text: alyam.contactus.titleDesc.text
    And verify element text present: alyam.contactus.needHelp.byxpath with text: alyam.contactus.needHelp.text
    And verify element text present: alyam.contactus.e-mail.byxpath with text: alyam.contactus.e-mail.text
    And verify element text present: alyam.contactus.email.byxpath with text: alyam.contactus.email.text
    And verify element present: alyam.contactus.email.img.byxpath
    And verify element text present: alyam.contactus.callus.byxpath with text: alyam.contactus.callus.text
    And verify element present: alyam.contactus.call-us.byxpath
    And verify element present: alyam.contactus.callus.img.byxpath
    And verify element text present: alyam.contactus.chatwithus.byxpath with text: alyam.contactus.chatwithus.text
    And verify element present: alyam.contactus.chatwith-us.byxpath
    And verify element present: alyam.contactus.chatwithus.img.byxpath
Feature: family membership Page Verification

  @TestType-Regression
  Scenario: verify family membership page
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And user open page yelo page: /profile/familyMembership
    And click on link: yelo.familyMembership.familyMembership.a.byxpath
    And verify element text present: yelo.familyMembership.title.legend.byxpath with text: yelo.familyMembership.title.text
    And verify element text present: yelo.familyMembership.addFamilyMember.h3.byxpath with text: yelo.familyMembership.addFamilyMember.text
    And verify element text present: yelo.familyMembership.show.span.byxpath with text: yelo.familyMembership.show.text
    And verify element present: yelo.familyMembership.chevrondown.i.byxpath
    And click on link: yelo.familyMembership.addFamilyMemberCollapse.div.byxpath
    And verify element text present: yelo.familyMembership.identityNumber.label.byxpath with text: yelo.familyMembership.identityNumber.text
    And verify element present: yelo.familyMembership.identityNumber.input.byxpath
    And verify element text present: yelo.familyMembership.relationType.label.byxpath with text: yelo.familyMembership.relationType.text
    And verify element present: yelo.familyMembership.relationType.select.byxpath
    And verify element text present: yelo.familyMembership.mobileNumber.label.byxpath with text: yelo.familyMembership.mobileNumber.text
    And verify element present: yelo.familyMembership.mobileNumber.div.byxpath
    And verify element present: yelo.familyMembership.mobileNumber.input.byxpath
    And verify element text present: yelo.familyMembership.email.label.byxpath with text: yelo.familyMembership.email.text
    And verify element text present: yelo.familyMembership.name.label.byxpath with text: yelo.familyMembership.name.text
    And verify element present: yelo.familyMembership.name.input.byxpath
    And verify text present on page: yelo.familyMembership.dependencyEvidence.text
    And verify element present: yelo.familyMembership.uploadDefault.img.byxpath
    And verify element text present: yelo.familyMembership.upload.label.byxpath with text: yelo.familyMembership.upload.text
    And verify element text present: yelo.familyMembership.submit.button.byxpath with text: yelo.familyMembership.submit.text
    And verify element text present: yelo.familyMembership.reset.button.byxpath with text: yelo.familyMembership.reset.text
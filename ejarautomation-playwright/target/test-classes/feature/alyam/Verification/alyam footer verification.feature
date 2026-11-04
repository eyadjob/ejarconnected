Feature: Alyam Footer Page Verification

  @TestType-Regression
  Scenario: verify footer page
    Given user open website page: alyam
    And user scroll to the bottom of the page
    And compare list of elements text: yelo.footer.mainTitle.byxpath with text: alyam.footer.mainTitle.text
    And verify element text present: alyam.footer.home.byxpath with text: alyam.footer.home.text
    And verify element text present: yelo.footer.allFleetSubTitle.byxpath with text: yelo.footer.allFleet.label.text
    And verify element text present: yelo.footer.branchesSubTitle.byxpath with text: yelo.footer.branches.label.text
    And verify element text present: yelo.footer.aboutsubtitel.byxpath with text: alyam.footer.aboutus.label.text
    And verify element text present: yelo.footer.contact-usSubTitle.byxpath with text: yelo.footer.contact-us.label.text
    And verify element text present: yelo.footer.servicesSubTitle.byxpath with text: yelo.footer.services.label.text
    And verify element present: yelo.footer.faq.byxpath
    And verify element present: yelo.footer.membershipSubTitle.byxpath
    And verify element present: alyam.footer.appleStore.byxpath
    And verify element present: yelo.footer.googleStore.byxpath
    And verify element present: yelo.footer.linkedin.byxpath
    And verify element present: alyam.footer.twitter.byxpath
    And verify element present: yelo.footer.facebook.byxpath
    And verify element present: alyam.footer.instagram.byxpath
    And verify text present on page: alyam.footer.copyR.text
    And verify element present: yelo.footer.privacypolicy.byxpath
    And verify element present: yelo.footer.termsofuse.byxpath
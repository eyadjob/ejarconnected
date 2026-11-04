Feature: Yelo Footer Page Verification

  @TestType-Regression
  Scenario: verify footer page
    Given user open website page: yelo
    And user scroll to the bottom of the page
    And compare list of elements text: yelo.footer.mainTitle.byxpath with text: yelo.footer.mainTitle.text
    And verify element text present: yelo.footer.aboutsubtitel.byxpath with text: yelo.footer.aboutus.label.text
    And verify element text present: yelo.footer.careerssubtitel.byxpath with text: yelo.footer.careers.label.text
    And verify element text present: yelo.footer.franchise.byxpath with text: yelo.footer.franchise.label.text
    And verify element text present: yelo.footer.allFleetSubTitle.byxpath with text: yelo.footer.allFleet.label.text
    And verify element text present: yelo.footer.branchesSubTitle.byxpath with text: yelo.footer.branches.label.text
    And verify element text present: yelo.footer.contact-usSubTitle.byxpath with text: yelo.footer.contact-us.label.text
    And verify element text present: yelo.footer.servicesSubTitle.byxpath with text: yelo.footer.services.label.text
    And verify element present: yelo.footer.membershipSubTitle.byxpath
    And verify element present: yelo.footer.yelomagazine.byxpath
    And verify element present: yelo.footer.ournews.byxpath
    And verify element present: yelo.footer.privacypolicy.byxpath
    And verify element present: yelo.footer.termsofuse.byxpath
    And verify element present: yelo.footer.cookiepolicy.byxpath
    And verify element present: yelo.footer.faq.byxpath
    And compare list of elements text: yelo.footer.topCitiesLinks.byxpath with text: yelo.footer.topCitiesLinks.text
    And compare list of elements text: yelo.footer.moreCitiesLinks.byxpath with text: yelo.footer.moreCitiesLinks.text
    And compare list of elements text: yelo.footer.sparter-top-contant.byxpath with text: yelo.footer.sparter-top-contant.text
    And compare list of elements text: yelo.footer.sparter-top-contant.subTitle.byxpath with text: yelo.footer.sparter-top-contant.subTitle.text
    And verify element present: yelo.footer.itunes.apple.byxpath
    And verify element present: yelo.footer.googleStore.byxpath
    And verify element present: yelo.footer.linkedin.byxpath
    And verify element present: yelo.footer.twitter.byxpath
    And verify element present: yelo.footer.facebook.byxpath
    And verify element present: yelo.footer.youtube.byxpath
    And verify text present on page: yelo.footer.copyR.text
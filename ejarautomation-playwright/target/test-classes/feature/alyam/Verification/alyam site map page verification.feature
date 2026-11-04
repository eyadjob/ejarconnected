Feature: Alyam site map Page Verification

  @TestType-Regression
  Scenario: verify site map page
    Given user open website page: alyam
    Given user open page yelo page: /Home/SiteMap
    And verify text present on page: yelo.siteMap.title.text
    And verify element text present: yelo.siteMap.home.a.byxpath with text: yelo.siteMap.home.text
    And verify text present on page: yelo.siteMap.fleet.text
    And verify text present on page: yelo.siteMap.aboutUs.text
    And verify text present on page: yelo.siteMap.contactUs.text
    And verify text present on page: yelo.siteMap.membership.text
    And verify text present on page: yelo.siteMap.services.text
    And verify text present on page: yelo.siteMap.mediaCenter.text
    And verify text present on page: yelo.siteMap.faq.text
    And verify text present on page: yelo.siteMap.privacyPolicy.text
    And verify text present on page: yelo.siteMap.cookiePolicy.text
    And verify text present on page: yelo.siteMap.termsOfUse.text
    And verify text present on page: yelo.siteMap.ourNews.text
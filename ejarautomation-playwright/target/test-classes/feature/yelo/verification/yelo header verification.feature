Feature: Yelo header Verification

  @TestType-Regression
  Scenario: verify header elements
    Given user open website page: yelo
    And verify element text present: yelo.header.fleet.a.byxpath with text: yelo.header.fleet.a.text
    And verify element present: yelo.header.login.img.byxpath
    And verify element text present: yelo.header.login.a.byxpath with text: yelo.header.login.a.text
    And verify element text present: yelo.header.register.a.byxpath with text: yelo.header.register.a.text
    And verify element present: yelo.header.moreMenu.img.byxpath
    And verify element text present: yelo.header.moreMenu.span.byxpath with text: yelo.header.moreMenu.span.text
    And verify element text present: yelo.header.lang.a.byxpath with text: yelo.header.lang.a.text
    And verify element present: yelo.header.lang.img.byxpath
    And verify element present: yelo.header.currency.a.byxpath
    And verify element present: yelo.header.currencyArrow.img.byxpath
    And click on element: yelo.header.moreMenu.span.byxpath
    And verify element text present: yelo.header.moreMenu.branches.a.byxpath with text: yelo.header.moreMenu.branches.a.text
    And verify element text present: yelo.header.moreMenu.membership.a.byxpath with text: yelo.header.moreMenu.membership.a.text
    And verify element text present: yelo.header.moreMenu.monthlysubscription.a.byxpath with text: yelo.header.moreMenu.monthlysubscription.a.text
    And verify element text present: yelo.header.moreMenu.longtermlease.a.byxpath with text: yelo.header.moreMenu.longtermlease.a.text
    And verify element text present: yelo.header.moreMenu.opl.individual.a.byxpath with text: yelo.header.moreMenu.opl.individual.a.text
    And verify element text present: yelo.header.moreMenu.opl.corporate.a.byxpath with text: yelo.header.moreMenu.opl.corporate.a.text
    And verify element text present: yelo.header.moreMenu.services.a.byxpath with text: yelo.header.moreMenu.services.a.text
    And verify element text present: yelo.header.moreMenu.contact.a.byxpath with text: yelo.header.moreMenu.contact.a.text
    And verify element text present: yelo.header.moreMenu.careers.a.byxpath with text: yelo.header.moreMenu.careers.a.text
    And verify element text present: yelo.header.moreMenu.city.a.byxpath with text: yelo.header.moreMenu.city.a.text
    And verify element present: yelo.header.yeloLogo.img.byxpath
    And verify element present: yelo.header.close.img.byxpath

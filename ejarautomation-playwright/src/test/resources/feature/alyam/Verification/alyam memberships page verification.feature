Feature: Membership Page Verification


  @TestType-Regression
  Scenario: validate Membership Information page
    Given user open website page: alyam
    Given user open page yelo page: /membership
    And verify text present on page: alyam.membsership.title.text
    And verify element text present: alyam.membership.mainP.byxpath with text: alyam.membership.mainP.text
    And verify count of element: alyam.membership.types.div.byxpath equals: 4
    And verify count of element: alyam.membership.logos.img.byxpath equals: 4
    And verify count of element: alyam.membership.seprator.div.byxpath equals: 4
    And verify text present on page: alyam.membership.infiniteTierTitle.text
    And verify element present: alyam.membership.infiniteTier.img.byxpath
    And verify text present on page: alyam.membership.infiniteIsEligibileP.text
    And verify text present on page: alyam.membership.infiniteEligibilityP.text
    And verify text present on page: alyam.membership.infiniteBenefit1.text
    And verify text present on page: alyam.membership.infiniteBenefit2.text
    And verify text present on page: alyam.membership.infiniteBenefit3.text
    And verify text present on page: alyam.membership.infiniteBenefit4.text
    And verify text present on page: alyam.membership.signatureTierTitle.text
    And verify element present: alyam.membership.signatureTierLogo.img.byxpath
    And verify text present on page: alyam.membership.signatureIsEligibileP.text
    And verify text present on page: alyam.membership.signatureEligibilityP.tex
    And verify text present on page: alyam.membership.signatureBenefit1.text
    And verify text present on page: alyam.membership.signatureBenefit2.text
    And verify text present on page: alyam.membership.signatureBenefit3.text
    And verify text present on page: alyam.membership.signatureBenefit4.text
    And verify text present on page: alyam.membership.platinumTierTitle.text
    And verify element present: alyam.membership.platinumTierLogo.img.byxpath
    And verify text present on page: alyam.membership.platinumIsEligibileP.text
    And verify text present on page: alyam.membership.platinumEligibilityP.tex
    And verify text present on page: alyam.membership.platinumBenefit1.text
    And verify text present on page: alyam.membership.platinumBenefit2.text
    And verify text present on page: alyam.membership.platinumBenefit3.text
    And verify text present on page: alyam.membership.platinumBenefit4.text
    And verify text present on page: alyam.membership.welcomeTierTitle.text
    And verify element present: alyam.membership.welcomeTierLogo.img.byxpath
    And verify text present on page: alyam.membership.welcomeIsEligibileP.text
    And verify text present on page: alyam.membership.welcomeEligibilityP.tex
    And verify text present on page: alyam.membership.welcomeBenefit1.text
    And verify text present on page: alyam.membership.welcomeBenefit2.text
    And verify text present on page: alyam.membership.welcomeBenefit3.text
    And verify text present on page: alyam.membership.welcomeBenefit4.text



#was done based on production because testing environment has this bug id:69004
  @TestType-Regression
  Scenario: validate no membership
    Given user open website page: alyam
    Given login to yelo site with user: alyamqoadautomation@qoad.com and password: Alyam123456
    And click on link: yelo.header.userArrowDropDown.byxpath
    And click on link: yelo.header.myProfile.byxpath
    And click on link: yelo.familyMembership.myMembership.a.byxpath
    And verify element text present: yelo.amyali.title.legend.byxpath with text: amyali.nomembership.membershipTitle.text
    And verify count of element: amyali.nomembership.indicators.div.byxpath equals: 3
    And verify count of element: amyali.nomembership.allLogos.img.byxpath equals: 4
    And verify element present: amyali.nomembership.tier1Logo.img.byxpath
    And verify element present: amyali.nomembership.tier2Logo.img.byxpath
    And verify element present: amyali.nomembership.tier3Logo.img.byxpath
    And verify element present: amyali.nomembership.tier4Logo.img.byxpath
    And compare list of elements text: amyali.nomembership.tiersTitle.div.byxpath with text: amyali.nomembership.tiersTitle.text
    And compare list of elements text: amyali.nomembership.tiersTotalPayment.div.byxpath with text: amyali.nomembership.tiersTotalPayment.text
    And compare list of elements text: amyali.nomembership.tiersTotalContracts.div.byxpath with text: amyali.nomembership.tiersTotalContracts.text
    And verify element text present: yelo.amyali.noMembership.div.byxpath with text: yelo.amyali.noMembership.div.text
    And verify element text present: yelo.amyali.learnMore.span.byxpath with text: amyali.nomembership.learnMore.text
    And verify element text present: yelo.amyali.learnMore.button.byxpath with text: yelo.amyali.learnMorebtn.text
    And verify element present: amyali.nomembership.learnMore.button.byxpath


Feature: Amyali Page Verification


  @TestType-Regression
  Scenario: validate Membership Information page
    Given user open website page: yelo
    Given user open page yelo page: /membership
    And verify element present: yelo.amyalipage.sliderPic.picture.byxpath
    And verify element present: yelo.amyalipage.sliderTitle.h1.byxpath
    And verify element present: yelo.amyalipage.sliderSubText.span.byxpath
    And verify element present: yelo.amyalipage.breadCrumbs.div.byxpath
    And verify element present: yelo.amyalipage.easyYetSatisfying.h2.byxpath
    And verify element present: yelo.amyalipage.cards.div.byxpath
    And verify count of element: yelo.amyalipage.cards.div.byxpath equals: 3
    And verify count of element: yelo.amyalipage.cardsTitle.span.byxpath equals: 3
    And verify count of element: yelo.amyalipage.cardsText.span.byxpath equals: 3
    And verify count of element: yelo.amyalipage.cardsImg.img.byxpath equals: 2
    And verify element present: yelo.amyalipage.becomeMember.h2.byxpath
    And verify element present: yelo.amyalipage.becomeMember.p.byxpath
    And click on element: yelo.amyalipage.tiersTabsYellow.a.byxpath
    And verify element present: yelo.amyalipage.tiersTabsYellowDescription.text.byxpath
    And verify element present: yelo.amyalipage.tiersTabsYellowImg.img.byxpath
    And click on element: yelo.amyalipage.tiersTabsSilver.a.byxpath
    And verify element present: yelo.amyalipage.tiersTabsSilverDescription.text.byxpath
    And verify element present: yelo.amyalipage.tiersTabsYSilverImg.img.byxpath
    And click on element: yelo.amyalipage.tiersTabsGold.a.byxpath
    And verify element present: yelo.amyalipage.tiersTabsGoldDescription.text.byxpath
    And verify element present: yelo.amyalipage.tiersTabsGoldImg.img.byxpath
    And click on element: yelo.amyalipage.tiersTabsPlat.a.byxpath
    And verify element present: yelo.amyalipage.tiersTabsPlatDescription.text.byxpath
    And verify element present: yelo.amyalipage.tiersTabsPlatImg.img.byxpath
    And verify element present: yelo.amyalipage.earnAndRedeem.h2.byxpath
    And verify element present: yelo.amyalipage.earnAndRedeem.p.byxpath
    And verify element present: yelo.amyalipage.earnAndRedeem.img.byxpath
    And verify element present: yelo.amyalipage.earnAndRedeem.div.byxpath
    And verify element present: yelo.amyalipage.redeemAmyaliTitle.h2.byxpath
    And verify element present: yelo.amyalipage.redeemAmyaliText.p.byxpath
    And verify count of element: yelo.amyalipage.redeemAmyaliWays.li.byxpath equals: 4
    And verify element present: yelo.amyalipage.loyaltyRewardTitle.h2.byxpath
    And verify element present: yelo.amyalipage.loyaltyRewardText.p.byxpath
    And verify element present: yelo.amyalipage.loyaltyRewardText.table.byxpath
    And user scroll to element: yelo.amyalipage.familyMembership.div.byxpath
    And verify element present: yelo.amyalipage.familyMembership.img.byxpath
    And verify element present: yelo.amyalipage.familyMembershipTitle.h2.byxpath
    And verify element present: yelo.amyalipage.familyMembershipText.p.byxpath
    And verify element present: yelo.amyalipage.amyaliPartnerShip.h2.byxpath
    And verify element present: yelo.amyalipage.amyaliPartnerShip.a.byxpath
    And verify element present: yelo.amyalipage.amyaliPartnerShip.div.byxpath
    And verify element present: yelo.amyalipage.faq.h2.byxpath
    And verify count of element: yelo.amyalipage.faq.img.byxpath equals: 3
    And verify element present: yelo.amyalipage.faq.div.byxpath



  @TestType-Regression
  Scenario: validate no membership
    Given user open website page: yelo
    And login to yelo site with user: eyadtest@qoad.com and password: Yelo123456
    And click on link: yelo.header.userArrowDropDown.byxpath
    And click on link: yelo.header.myProfile.byxpath
    And click on link: yelo.familyMembership.myMembership.a.byxpath
    And verify element text present: yelo.amyali.title.legend.byxpath with text: yelo.amyali.title.text
    And verify count of element: yelo.amyali.membershipDesc.img.byxpath equals: 4
    And verify element present: yelo.amyali.yellowmembershipDesc.parent.div.byxpath
    And verify element present: yelo.amyali.silvermembershipDesc.parent.div.byxpath
    And verify element present: yelo.amyali.goldmembershipDesc.parent.div.byxpath
    And verify element present: yelo.amyali.platmembershipDesc.parent.div.byxpath
    And verify element text present: yelo.amyali.noMembership.div.byxpath with text: yelo.amyali.noMembership.div.text
    And verify element text present: yelo.amyali.learnMore.span.byxpath with text: yelo.amyali.learnMore.text
    And verify element text present: yelo.amyali.learnMore.button.byxpath with text: yelo.amyali.learnMorebtn.text

#  @TestType-Regression
#  Scenario: validate yellow membership
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomersrfeplmjjz@yelo.com and password: Yelo123456
#    And click on link: yelo.header.userArrowDropDown.byxpath
#    And click on link: yelo.header.myMembership.byxpath
#    And verify element present: yelo.membership.yellowMembershipImg.byxpath
#    And verify count of element: yelo.membership.membership-disabled.byxpath equals: 3
#    And compare list of elements text: yelo.membership.membershipInfo.byxpath with text: yelo.membership.membershipInfo.text
#    And verify element present: yelo.membership.membershipInfo.yellow-brown-title.byxpath
#    And verify element text present: yelo.membership.amyaliSpliter-title.byxpath with text: yelo.membership.amyaliSpliter-title.text
#    And verify element present: yelo.membership.yellowAmyaliSpliter-points.byxpath
#
#  @TestType-Regression
#  Scenario: validate silver membership - my profile
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerpznzidadle@yelo.com and password: Yelo123456
#    And click on link: yelo.header.userArrowDropDown.byxpath
#    And click on link: yelo.header.myMembership.byxpath
#    And verify element present: yelo.membership.yellowMembershipImg.byxpath
#    And verify element present: yelo.membership.silverMembershipImg-active.byxpath
#    And verify element present: yelo.membership.goldMembershipImg-disabled.byxpath
#    And verify element present: yelo.membership.platMembershipImg-disabled.byxpath
#    And verify element present: yelo.membership.silverImg.byxpath
#    And compare list of elements text: yelo.membership.membershipInfo.byxpath with text: yelo.membership.membershipInfo.text
#    And verify element text present: yelo.membership.membershipInfo.currentMembership.byxpath with text: yelo.membership.membershipInfo.currentMembership.silver.text
#    And verify element text present: yelo.membership.amyaliSpliter-title.byxpath with text: yelo.membership.amyaliSpliter-title.text
#    And verify element present: yelo.membership.yellowAmyaliSpliter-points.byxpath
#
#
#  @TestType-Regression
#  Scenario: validate gold membership
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerwswtarumtt@yelo.com and password: Yelo123456
#    And click on link: yelo.header.userArrowDropDown.byxpath
#    And click on link: yelo.header.myMembership.byxpath
#    And verify element present: yelo.membership.yellowMembershipImg.byxpath
#    And verify element present: yelo.membership.silverMembershipImg-active.byxpath
#    And verify element present: yelo.membership.goldMembershipImg.byxpath
#    And verify element present: yelo.membership.platMembershipImg-disabled.byxpath
#    And verify element present: yelo.membership.goldImg.byxpath
#    And compare list of elements text: yelo.membership.membershipInfo.byxpath with text: yelo.membership.membershipInfo.text
#    And verify element present: yelo.membership.membershipInfo.gold-brown-title.byxpath
#    And verify element text present: yelo.membership.amyaliSpliter-title.byxpath with text: yelo.membership.amyaliSpliter-title.text
#    And verify element present: yelo.membership.yellowAmyaliSpliter-points.byxpath

#  @TestType-Regression
#  Scenario: validate gold membership - discount - create booking
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomervmvhzxbazq@yelo.com and password: Yelo123456
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: 600
#    And change zoom level: 0.4
#    And validate tooltip present : yelo.membership.tooltip.goldDiscount.byxpath when hover over: yelo.membership.firstInfo.discount.byxpath
#
#  @TestType-Regression
#  Scenario: validate silver membership - discount - create booking
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerznbcsgnmhv@yelo.com and password: Yelo123456
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: 600
#    And change zoom level: 0.4
#    And validate tooltip present : yelo.membership.tooltip.silverDiscount.byxpath when hover over: yelo.membership.firstInfo.discount.byxpath
#
#  @TestType-Regression
#  Scenario: validate yellow membership - discount - create booking
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerryuzupoqcp@yelo.com and password: Yelo123456
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: 600
#    And change zoom level: 0.4
#    And validate tooltip present : yelo.membership.tooltip.yellowDiscount.byxpath when hover over: yelo.membership.firstInfo.discount.byxpath
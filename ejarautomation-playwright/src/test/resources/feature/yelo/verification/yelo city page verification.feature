Feature: City Page Verification

  @TestType-Regression
  Scenario: Verify All Cities Elements
    Given user open page yelo page: /city/rent-car-riyadh
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-makkah
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-madinah
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 3
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-abha
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-al-ula
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-jeddah
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-al-dammam
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-yanbu
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-umluj
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-hail
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
    And user open page yelo page: /city/rent-car-jazan
    And verify element present: yelo.city.mainTitle.byxpath
    And verify element present: yelo.city.sliderImg.byxpath
    And verify element present: yelo.city.breadCrumbsTitle.byxpath
    And verify element present: yelo.city.centerTitle.byxpath
    And verify count of element: yelo.city.subSliderImg.byxpath equals: 4
    And verify element present: yelo.city.paragraphTitle.byxpath
    And verify element present: yelo.city.paragraph.byxpath
    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text

#  @TestType-Regression
#  Scenario: verify Riyad city
#    Given user open website page: yelo
#    And click on element: yelo.city.riyad.footerLink.byxpath
#    And verify element present: yelo.city.riyad.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.riyad.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.riyad.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.riyad.desc.text
#    And verify element present: yelo.city.riyad.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
#    And verify element present: yelo.city.branchImg.byxpath
#    And verify element present: yelo.city.branchLocationImg.byxpath
#    And verify element present: yelo.city.branchCallUsImg.byxpath
#    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
#    And verify element present: yelo.city.branchHeader.byxpath
#    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
#    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text

#
#  @TestType-Regression
#  Scenario: verify Makkah city
#    Given user open website page: yelo
#    And click on element: yelo.city.makkah.footerLink.byxpath
#    And verify element present: yelo.city.makkah.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.makkah.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.makkah.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.makkah.desc.text
#    And verify element present: yelo.city.makkah.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Madinah city
#    Given user open website page: yelo
#    And click on element: yelo.city.madinah.footerLink.byxpath
#    And verify element present: yelo.city.madinah.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.madinah.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.madinah.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.madinah.desc.text
#    And verify element present: yelo.city.madinah.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Abha city
#    Given user open website page: yelo
#    And click on element: yelo.city.abha.footerLink.byxpath
#    And verify element present: yelo.city.abha.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.abha.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.abha.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.abha.desc.text
#    And verify element present: yelo.city.abha.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify AlUla city
#    Given user open website page: yelo
#    And click on element: yelo.city.alUla.footerLink.byxpath
#    And verify element present: yelo.city.alUla.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.alUla.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.alUla.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.alUla.desc.text
#    And verify element present: yelo.city.alUla.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Jeddah city
#    Given user open website page: yelo
#    And click on element: yelo.city.jeddah.footerLink.byxpath
#    And verify element present: yelo.city.jeddah.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.jeddah.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.jeddah.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.jeddah.desc.text
#    And verify element present: yelo.city.jeddah.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
##passed ,uncomment the commented line when fixed , one of the branches doesn't have a mobile number
#  @TestType-Regression
#  Scenario: verify Dammam city
#    Given user open website page: yelo
#    And click on element: yelo.city.dammam.footerLink.byxpath
#    And verify element present: yelo.city.dammam.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.dammam.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.dammam.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.dammam.desc.text
#    And verify element present: yelo.city.dammam.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Yanbu city
#    Given user open website page: yelo
#    And click on element: yelo.city.yanbu.footerLink.byxpath
#    And verify element present: yelo.city.yanbu.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.yanbu.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.yanbu.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.yanbu.desc.text
#    And verify element present: yelo.city.yanbu.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Umluj city
#    Given user open website page: yelo
#    And click on element: yelo.city.umluj.footerLink.byxpath
#    And verify element present: yelo.city.umluj.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.umluj.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.umluj.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.umluj.desc.text
#    And verify element present: yelo.city.umluj.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Hail city
#    Given user open website page: yelo
#    And click on element: yelo.city.hail.footerLink.byxpath
#    And verify element present: yelo.city.hail.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.hail.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.hail.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.hail.desc.text
#    And verify element present: yelo.city.hail.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
#
#
#  @TestType-Regression
#  Scenario: verify Jazan city
#    Given user open website page: yelo
#    And click on element: yelo.city.jazan.footerLink.byxpath
#    And verify element present: yelo.city.jazan.mainImg.byxpath
#    And verify element text present: yelo.city.mainTitle.byxpath with text: yelo.city.jazan.mainTitle.text
#    And verify element text present: yelo.city.title.byxpath with text: yelo.city.jazan.title.text
#    And verify element text present: yelo.city.desc.byxpath with text: yelo.city.jazan.desc.text
#    And verify element present: yelo.city.jazan.sliderImg.byxpath
#    And verify element text present: yelo.city.branchesTitle.byxpath with text: yelo.city.branchesTitle.text
##    And verify element present: yelo.city.branchImg.byxpath
##    And verify element present: yelo.city.branchLocationImg.byxpath
##    And verify element present: yelo.city.branchCallUsImg.byxpath
##    And verify element text present: yelo.city.branchCallUs.byxpath with text: yelo.city.branchCallUs.text
##    And verify element present: yelo.city.branchHeader.byxpath
##    And verify element present: yelo.city.branchWorkingHoursImg.byxpath
##    And verify element text present: yelo.city.branchBookNow.byxpath with text: yelo.city.branchBookNow.text
Feature: Yelo OPl Page Verification


  @TestType-Regression
  Scenario: verify opl page
    Given user open website page: yelo
    Given user open page yelo page: /long-term-car-rental
    And verify element present: yelo.homepage.opl-title.byxpath
    And verify text present on page: yelo.opl.opl-title.text
    And verify element text present: yelo.opl.opl-title-text.byxpath with text: yelo.opl.opl-title-text.text
    And verify element text present: yelo.opl.firstsectiontext.byxpath with text: yelo.opl.firstsectiontext.text
    And compare list of elements text: yelo.opl.advantages.label.byxpath with text: yelo.opl.advantages.text
    And verify element present: yelo.opl.first-P1.byxpath
    And verify element present: yelo.opl.first-P2.byxpath
    And verify element present: yelo.opl.first-P3.byxpath
    And verify element present: yelo.opl.first-P4.byxpath
    And verify element present: yelo.opl.first-P5.byxpath
    And verify element present: yelo.opl.first-P6.byxpath
    And verify text present on page: yelo.opl.howitworkstitle.text
    And compare list of elements text: yelo.opl.howitworks.label.byxpath with text: yelo.opl.howitworks.text
    And verify element present: yelo.opl.first-P7.byxpath
    And verify element present: yelo.opl.first-P8.byxpath
    And verify element present: yelo.opl.first-P9.byxpath
    And verify element present: yelo.opl.first-P10.byxpath
    And verify element present: yelo.opl.first-P11.byxpath
    And verify text present on page: yelo.opl.individualstext.text
    And verify element present: yelo.opl.rentnow.img.byxpath
    And verify element text present: yelo.opl.rentnowtitle.byxpath with text: yelo.opl.rentnowtitle.text
    And verify text present on page: yelo.opl.rentnow.text
    And verify element present: yelo.opl.city.byxpath
    And verify element present: yelo.opl.category.byxpath
    And verify element present: yelo.opl.carcontainer.byxpath
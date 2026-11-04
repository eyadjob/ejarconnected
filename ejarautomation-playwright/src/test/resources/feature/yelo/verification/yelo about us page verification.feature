Feature: About us Page Verification

  @TestType-Regression
  Scenario: verify about us page
    Given user open website page: yelo
    Given user open page yelo page: /about
    And verify text present on page: yelo.aboutus.title.text
    And verify element present: yelo.aboutus.ourVision.img.byxpath
    And verify text present on page: yelo.aboutus.ourVisionTitle.text
    And verify text present on page: yelo.aboutus.ourVisionDesc.text
    And verify text present on page: yelo.aboutus.ourMissionTitle.text
    And verify text present on page: yelo.aboutus.ourMissionDesc.text
    And verify element present: yelo.aboutus.ourBeliefs.img.byxpath
    And verify element present: yelo.aboutus.ourBeliefs2.img.byxpath
    And verify element present: yelo.aboutus.ourBeliefs3.img.byxpath
    And verify element present: yelo.aboutus.ourBeliefs4.img.byxpath
    And verify text present on page: yelo.aboutus.ourBeliefsTitle.text
    And verify text present on page: yelo.aboutus.proud.text
    And verify text present on page: yelo.aboutus.experience.text
    And verify text present on page: yelo.aboutus.thinkAhead.text
    And verify text present on page: yelo.aboutus.communityMinded.text
    And verify element present: yelo.aboutus.quality.img.byxpath
    And verify text present on page: yelo.aboutus.quality.text
    And verify text present on page: yelo.aboutus.qualityDesc.text
    And verify element present: yelo.aboutus.teamWork.img.byxpath
    And verify text present on page: yelo.aboutus.teamWork.text
    And verify text present on page: yelo.aboutus.teamWorkDesc.text
    And verify element present: yelo.aboutus.growth.img.byxpath
    And verify text present on page: yelo.aboutus.growth.text
    And verify text present on page: yelo.aboutus.growthDesc.text
    And verify element present: yelo.aboutus.community.img.byxpath
    And verify text present on page: yelo.aboutus.community.text
    And verify text present on page: yelo.aboutus.communityDesc.text
    And click on element: yelo.aboutus.quality.section.tab.byxpath
    And verify element: yelo.aboutus.quality.section.byxpath attribute: class contains value: active is: true
    And verify element: yelo.aboutus.teamwork.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.growth.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.community.section.byxpath attribute: class contains value: active is: false
    And click on element: yelo.aboutus.teamwork.section.tab.byxpath
    And verify element: yelo.aboutus.quality.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.teamwork.section.byxpath attribute: class contains value: active is: true
    And verify element: yelo.aboutus.growth.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.community.section.byxpath attribute: class contains value: active is: false
    And click on element: yelo.aboutus.growth.section.tab.byxpath
    And verify element: yelo.aboutus.quality.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.teamwork.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.growth.section.byxpath attribute: class contains value: active is: true
    And verify element: yelo.aboutus.community.section.byxpath attribute: class contains value: active is: false
    And click on element: yelo.aboutus.community.section.tab.byxpath
    And verify element: yelo.aboutus.quality.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.teamwork.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.growth.section.byxpath attribute: class contains value: active is: false
    And verify element: yelo.aboutus.community.section.byxpath attribute: class contains value: active is: true
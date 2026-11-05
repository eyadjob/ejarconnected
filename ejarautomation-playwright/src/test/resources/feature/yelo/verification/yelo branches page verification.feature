Feature: Branches Page Verification


  @TestType-Regression
  Scenario: verify branches page
    Given user open website page: yelo
    And click on element: yelo.header.moreMenu.span.byxpath
    And click on element: yelo.header.moreMenu.branches.a.byxpath
    And verify element text present: yelo.branches.title.byxpath with text: yelo.branches.title.text
    And verify element text present: yelo.branches.findBranch.byxpath with text: yelo.branches.findBranch.text
    And compare list of elements text: yelo.branches.filterLabel.byxpath with text: yelo.branches.filterLabel.text
    And verify element present: yelo.branches.filterByCity.byxpath
    And verify element present: yelo.branches.filterByBranch.byxpath
    And verify element present: yelo.branches.filterByAirport.byxpath
    And verify element text present: yelo.branches.clickonlocation.byxpath with text: yelo.branches.clickonlocation.text
    And verify element present: yelo.branches.googleMap.byxpath
    And check page requests contains the following request GetCityDetails
    And check console has no error messages with assertion: soft
    And check console contains the following error message Error getting user location with assertion: hard
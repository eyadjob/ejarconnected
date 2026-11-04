Feature: Branches Page Verification

  @TestType-Regression
  Scenario: verify branches page
    Given user open website page: alyam
    And user open page yelo page: /our-branches
    And verify element text present: yelo.branches.title.byxpath with text: yelo.branches.title.text
    And verify element text present: alyam.branches.findBranch.byxpath with text: alyam.branches.findBranch.text
    And compare list of elements text: yelo.branches.filterLabel.byxpath with text: yelo.branches.filterLabel.text
    And verify element present: yelo.branches.filterByCity.byxpath
    And verify element present: yelo.branches.filterByBranch.byxpath
    And verify element present: yelo.branches.filterByAirport.byxpath
    And verify element present: yelo.branches.googleMap.byxpath
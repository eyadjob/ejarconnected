Feature: Alyam Search Validation


  @TestType-Regression
  Scenario: validate search - search without filling pickup branch
    Given user open website page: alyam
    And click on element: alyam.homepage.differentreturnlocation.checkbox.byxpath
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And user set date time V2 in yelo pickup field plus days: 1 and time: 1:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 1:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify element text present: yelo.search.pickup-error.text.byxpath with text: yelo.search.pickup-error.text
    And verify element text present: yelo.search.return-error.text.byxpath with text: yelo.search.return-error.text




  @TestType-Regression
  Scenario: validate search - filter - price slider validation
    Given user open website page: alyam
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 3 and time: 1:30 pm
    And user set date time V2 in yelo return field plus days: 4 and time: 1:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And validate price of elements: yelo.search.car-price.span.byxpath minPriceElement: yelo.search.minPrice.div.byxpath maxPriceElement: yelo.search.maxPrice.div.byxpath
    And drag the element: yelo.search.minPrice.div.byxpath horizontally by pixels: 100 and vertically by pixels: 0


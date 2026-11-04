Feature: Alyam Currency Validation

  @TestType-Regression
  Scenario: validate Alyam currency - change currency - currency in displayed prices should be changed
    Given user open website page: alyam
    And login to yelo site with user: alyamqoadautomation@qoad.com and password: Alyam123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 5 and time: 1:30 pm
    And user set date time V2 in yelo return field plus days: 7 and time: 1:30 pm
    And user scroll to the top of the page
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And switch page currency to: Riyal,ريال
    And verify page currency : SAR,ريال exists in page and other currencies are not exist
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And switch page currency to: Riyal,ريال
    And verify page currency : SAR,ريال exists in page and other currencies are not exist
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on element: yelo.pay.SaveBooking.button.byxpath
    And  user open page yelo page: /profile/mybookings
    And switch page currency to: Riyal,ريال
    And verify page currency : SAR,ريال exists in page and other currencies are not exist
    And cancel latest booking if exist on yelo with assertion and page refresh
Feature: Yelo Currency Validation

  @TestType-Regression
  Scenario: validate yelo currency - change currency - currency in displayed prices should be changed
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 5 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 7 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And switch page currency to: EUR,اليورو
    And verify page currency : EUR,اليورو exists in page and other currencies are not exist
    And switch page currency to: EGP,جنيه
    And verify page currency : EGP,جنيه exists in page and other currencies are not exist
    And switch page currency to: AED,درهم
    And verify page currency : AED,درهم exists in page and other currencies are not exist
    And switch page currency to: Riyal,ريال
    And verify page currency : Riyal,ريال exists in page and other currencies are not exist
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And switch page currency to: EUR,اليورو
    And verify page currency : EUR,اليورو exists in page and other currencies are not exist
    And switch page currency to: EGP,جنيه
    And verify page currency : EGP,جنيه exists in page and other currencies are not exist
    And switch page currency to: AED,درهم
    And verify page currency : AED,درهم exists in page and other currencies are not exist
    And switch page currency to: Riyal,ريال
    And verify page currency : Riyal,ريال exists in page and other currencies are not exist
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on element: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And user open page yelo page: /profile/mybookings
    And switch page currency to: EUR,اليورو
    And verify page currency : EUR,اليورو exists in page and other currencies are not exist
    And switch page currency to: EGP,جنيه
    And verify page currency : EGP,جنيه exists in page and other currencies are not exist
    And switch page currency to: AED,درهم
    And verify page currency : AED,درهم exists in page and other currencies are not exist
    And switch page currency to: Riyal,ريال
    And verify page currency : Riyal,ريال exists in page and other currencies are not exist
    And cancel latest booking if exist on yelo with assertion and page refresh
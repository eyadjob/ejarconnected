Feature: Yelo Pay Later Page Validation


  @TestType-Regression
  Scenario: validate yelo pay later - happy case
    Given user open website page: yelo
    Given login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.pay.paynow.button.byxpath is not present to: /Profile/MyBookings
    And wait for element present: yelo.pay.paynow.button.byxpath for period in seconds: 120
    And cancel latest booking if exist on yelo with assertion and page refresh

  @TestType-Regression
  Scenario: validate user can't place more than one pay later bookings with date intersection - manual cancel - verify error message
    Given user open website page: yelo
    Given login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user open page yelo page: /
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify text present on page: yelo.moreThanOnePayNow.error.text
    And cancel all bookings if exist on yelo sequentially


  @TestType-Regression
  Scenario: validate yelo pay later - without login
    Given user open website page: yelo
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.login.button.byxpath
    And user set in field: yelo.login.termsemail.field.byxpath value: yazeedautomationui@qoad.com
    And user set in field: yelo.login.termspassword.field.byxpath value: Yelo123456
    And click on link: yelo.login-submit-btn.button.byxpath
    And user scroll to the top of the page
    And verify element present: yelo.terms&conditions.pickup-info.byxpath
    And verify element present: yelo.terms&conditions.pickup-info-title.byxpath
    And verify element present: yelo.terms&conditions.pickupLocation.byxpath
    And verify element present: yelo.terms&conditions.pickupDateTime.byxpath
    And verify element present: yelo.terms&conditions.dropoff-info.byxpath
    And verify element present: yelo.terms&conditions.dropoff-info-title.byxpath
    And verify element present: yelo.terms&conditions.dropoffLocation.byxpath
    And verify element present: yelo.terms&conditions.dropoffDateTime.byxpath
    And verify element present: yelo.terms&conditions.booking-conditions.byxpath
    And verify element present: yelo.terms&conditions.booking-step.byxpath
    And verify text present on page: yelo.terms&conditions.tabletext1.text
    And verify element present: yelo.terms&conditions.price-duration.byxpath
    And verify element present: yelo.terms&conditions.price-now.byxpath
    And verify element present: yelo.terms&conditions.termsandConditions.byxpath
    And verify element present: yelo.terms&conditions.fulltermsandConditions.byxpath
    And click on link: yelo.terms&conditions.termsandConditions-chbx.byxpath
    And click on link: yelo.confirm-btn.button.byxpath
    And verify yelo booking confirmation page
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate yelo pay later - two pay later bookings - without date intersection
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: rentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: FirstBookingNumberInConfirmationTabWithText and keep number only: false
    And click on link: yelo.header.yelo-logo.byxpath
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: rentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: SecondBookingNumberInConfirmationTabWithText and keep number only: false
    And navigate if the element: yelo.pay.cancel.button.byxpath is not present to: /Profile/MyBookings
    And verify number of bookings in my booking page: 2
    And cancel all bookings if exist on yelo sequentially

  @TestType-Regression
  Scenario: validate yelo pay later - from fleet
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on link: yelo.header.fleet.a.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -2000
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 5 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 6 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: rentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: bookingId and keep number only: true
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And verify yelo booking confirmation page
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.pay.cancel.button.byxpath is not present to: /Profile/MyBookings
    And store element value: yelo.my.bookings.booking.id.byxpath and value name: myBookingBookingId and keep number only: true
    And store element value: yelo.my.bookings.rental.total.byxpath and value name: myBookingsRentalValue and keep number only: true
    And verify two values are equal, first value: myBookingBookingId second value: bookingId param type: string
    And verify two values are equal, first value: myBookingsRentalValue second value: rentalTotalInTermsAndConditions param type: decimal
    And cancel latest booking if exist on yelo with assertion and page refresh

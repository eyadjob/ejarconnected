Feature: Manage My Booking Validation

  @TestType-Regression
  Scenario: validate manage my booking - search for existing booking
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: RentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.paynow.rentalPrice.paymentTab.span.byxpath and value name: RentalTotalInPaymentTab and keep number only: true
    And verify two values are equal, first value: RentalTotalInTermsAndConditions second value: RentalTotalInPaymentTab param type: decimal
    And store element value: yelo.paynow.rentalPrice.confirmationTab.div.byxpath and value name: RentalTotalInConfirmationTab and keep number only: true
    And verify two values are equal, first value: RentalTotalInTermsAndConditions second value: RentalTotalInConfirmationTab param type: decimal
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTab and keep number only: true
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    And store element value: yelo.my.bookings.rental.total.byxpath and value name: RentalTotalInMyBookings and keep number only: true
    And verify two values are equal, first value: RentalTotalInTermsAndConditions second value: RentalTotalInMyBookings param type: decimal
    And store element value: yelo.my.bookings.booking.id.byxpath and value name: BookingNumberInMyBookings and keep number only: true
    And verify two values are equal, first value: BookingNumberInConfirmationTab second value: BookingNumberInMyBookings param type: string
    And click on element: yelo.header.userArrowDropDown.byxpath
    And click on link: yelo.header.myProfile.byxpath
    And store element attribute value: yelo.myProfile.lastName.input.byxpath and value name: UserLastName and keep number only: false
    And click on element: yelo.header.userArrowDropDown.byxpath
    And click on element: yelo.register.logout.label.byxpath
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And set value into element : yelo.homepage.manageBooking.bookingId.input.byxpath by context key: BookingNumberInConfirmationTabWithText
    And set value into element : yelo.homepage.manageBooking.customerLastName.input.byxpath by context key: UserLastName
    And click on element: yelo.homepage.manageBooking.submit.button.byxpath
    And store element value: yelo.my.bookings.booking.id.byxpath and value name: BookingNumberInManageMyBookings and keep number only: true
    And verify two values are equal, first value: BookingNumberInManageMyBookings second value: BookingNumberInConfirmationTab param type: string
    And wait for element present: yelo.pay.cancel.button.byxpath for period in seconds: 120
    And click on element: yelo.pay.cancel.button.byxpath
    And click on element: yelo.pay.confirmCancel.button.byxpath
    And wait for element present: yelo.confrimCancelled.button.byxpath for period in seconds: 90


  @TestType-Regression
  Scenario: validate manage my booking - required Booking Id
    Given user open website page: yelo
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And set value into element : yelo.homepage.manageBooking.customerLastName.input.byxpath value: bineluj
    And click on element: yelo.homepage.manageBooking.submit.button.byxpath
    And verify element text present: yelo.manageMyBooking.bookingId.error.byxpath with text: yelo.manageMyBooking.bookingId.error.text


  @TestType-Regression
  Scenario: validate manage my booking - required Last Name
    Given user open website page: yelo
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And set value into element : yelo.homepage.manageBooking.bookingId.input.byxpath value: 12345678
    And click on element: yelo.homepage.manageBooking.submit.button.byxpath
    And verify element text present: yelo.manageMyBooking.lastName.error.byxpath with text: yelo.manageMyBooking.lastName.error.text
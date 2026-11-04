Feature: Yelo Pay Now Validation


  @TestType-Regression
  Scenario: validate yelo pay now - one pay now
    Given user open website page: yelo
    Given login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 4 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 5 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: RentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    Then cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate yelo pay now - one pay now with wrong credit card number
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
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 98908 and ccv: 123 and expire date: 05/23
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And verify text present on page: yelo.payment-wrong-card-msg.text



  @TestType-Regression
  Scenario: validate yelo now - place pay later booking then pay using the pay now button in my bookings
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And place pay later booking on branch: Automation Branch,Automation Branch and pickup day: 3 and time: 01:30 pm and return day: 4 and time: 01:30 pm
    And user open page yelo page: /Profile/MyBookings
    And click on element: yelo.mybookings.payNow.button.byxpath
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on element: yelo.mybookings.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    Then cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate that user can place more than one pay now bookings without date intersection
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
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And click on element: yelo.homepage.image.icon.byxpath
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 4 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 5 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -100
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user scroll to the top of the page
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And cancel all bookings if exist on yelo sequentially


  @TestType-Regression
  Scenario: validate user can't place more than one pay now with date intersection - error message is displayed "Sorry, you already have an active booking.
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user scroll to the top of the page
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And click on element: yelo.homepage.image.icon.byxpath
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify text present on page: yelo.moreThanOnePayNow.error.text
    And verify element text present: yelo.moreThanOnePayNow.error.byxpath with text: yelo.moreThanOnePayNow.error.text
    And cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate yelo pay now - select extras - back from payment step - extras should be still selected
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
    And scroll by pixcels horizontally: 0 and vertically: -700
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on element: yelo.pay.firstextras.button.byxpath
    And click on element if exist: yelo.pay.agreeExtra.button.byxpath with wait: 3
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on element: yelo.pay.back.button.byxpath
    And wait for element present: yelo.pay.extraslist.span.byxpath for period in seconds: 60


  @TestType-Regression
  Scenario: validate yelo pay now - from fleet section
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.header.fleet.a.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.paylater.rental.total.byxpath and value name: RentalTotalInTermsAndConditions and keep number only: true
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.paynow.rentalPrice.paymentTab.span.byxpath and value name: RentalTotalInPaymentTab and keep number only: true
    And verify two values are equal, first value: RentalTotalInTermsAndConditions second value: RentalTotalInPaymentTab param type: decimal
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And store element value: yelo.paynow.rentalPrice.confirmationTab.div.byxpath and value name: RentalTotalInConfirmationTab and keep number only: true
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTab and keep number only: true
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    And store element value: yelo.my.bookings.booking.id.byxpath and value name: BookingNumberInMyBookings and keep number only: true
    And verify two values are equal, first value: BookingNumberInConfirmationTab second value: BookingNumberInMyBookings param type: string
    And cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate yelo create booking - blacklisted customer
    Given user open website page: yelo
    And login to yelo site with user: taramusuj.nuquhijob@mentonit.net and password: 123456
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify element present: yelo.blacklist.removeSign.byxpath


  @TestType-Regression
  Scenario: validate yelo pay now - select extras - extras should be displayed in payment page
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on element: yelo.extras.yeloShieldExtra.byxpath
    And click on action if exist: yelo.pay.agreeExtra.button.byxpath
    And click on element: yelo.extras.GPSExtra.byxpath
    And click on action if exist: yelo.pay.agreeExtra.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And verify element present: yelo.payment.yeloShieldExtra.byxpath
    And verify element present: yelo.payment.GPSExtra.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on link: yalo.payment.selectcreditcardoption.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 4508750015741019 and ccv: 100 and expire date: 01/39
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And cancel latest booking if exist on yelo with assertion and page refresh


  @TestType-Regression
  Scenario: validate yelo pay now - amex payment
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: 250
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And click on link: yelo.pay.amex-option.button.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 371881634498004 and ccv: 1000 and expire date: 05/28
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And change Yelo iframe with id: challengeFrame and click on element with id: yelo.paymentgatewaysubmit.button.byxpath
    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
    And click on link: yelo.pay.GetBookingContentView.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And cancel latest booking if exist on yelo with assertion and page refresh

  @TestType-Regression
  Scenario: validate yelo pay now - amex payment - wrong number
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -250
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user scroll to the top of the page
    And click on link: yelo.pay.amex-option.button.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 123456 and ccv: 350 and expire date: 05/23
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And verify text present on page: yelo.payment-wrong-card-msg.text


  @TestType-Regression
  Scenario: validate yelo pay now - mada payment - wrong number
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 11 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 12 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylnow.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And user scroll to the top of the page
    And click on link: yelo.pay.mada-option.button.byxpath
    And fill credit card info in yelo fill name: Eyad and card number: 123456 and ccv: 350 and expire date: 05/23
    And click on link: yelo.pay.SubmitPayment.button.byxpath
    And verify text present on page: yelo.payment-wrong-card-msg.text

#when we create a pay now booking for a dubai branch We get an error 404 after submitting the payment method
#  @TestType-Regression
#  Scenario: validate yelo pay now - dubai
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomereltblltxef@yelo.com and password: Yelo123456
#    And place pay now booking on branch: Dubai Airport Terminal 1,مطار دبي الصالة 1 and pickup day: 7 and time: 01:30 pm and return day: 8 and time: 01:30 pm and credit card name: Eyad and credit card number: 4508750015741019 and credit card ccv: 100 and credit card expiry date: 01/39
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: bookingId and keep number only: true
#    And cancel latest booking if exist on yelo

#there is no europe branch that exists
#  @TestType-Regression
#  Scenario: validate yelo pay now - Europcar
#    Given user open page yelo page: /Home
#    And login to yelo site with user: EyadYeloRegressionTestCustomereltblltxef@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Munich Bmw Automag, Munich Bmw Automag
#    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And verify element present: yelo.pay.europcarlogo.img.byxpath
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.paylnow.button.byxpath
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And wait for number of seconds: 1
#    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    And user scroll to the top of the page
#    And click on link: yelo.pay.mada-option.button.byxpath
#    And click on link: yalo.payment.selectcreditcardoption.byxpath
#    And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#    And click on link: yelo.pay.SubmitPayment.button.byxpath
#    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
#    Then cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com


#mada payment method doesn't work there is no card that works.
#      @TestType-Regression
#  Scenario: validate yelo pay now - mada payment
#    Given user open page yelo page: /Home
#    And login to yelo site with user: EyadYeloRegressionTestCustomereltblltxef@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    And user scroll to the top of the page
#    And click on link: yelo.pay.mada-option.button.byxpath
#    And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/29
#    And click on link: yelo.pay.SubmitPayment.button.byxpath
#    And wait for element present: yelo.gateway.iframe.byxpath for period in seconds: 30
#    And change iframe with id: challengeFrame
#    And click on link: yelo.paymentgatewaysubmit.button.byxpath
#    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: bookingId and keep number only: true
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
#    Then cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com
    #Then delete the created booking from the database

#mada payment method doesn't work there is no card that works.
#  @TestType-Regression
#  Scenario: validate yelo pay now - mada payment - cancel booking
#    Given user open page yelo page: /Home
#    And login to yelo site with user: EyadYeloRegressionTestCustomereltblltxef@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#    And user set date time V2 in yelo pickup field plus days: 4 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 5 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.paylnow.button.byxpath
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    And user scroll to the top of the page
#    And click on link: yelo.pay.mada-option.button.byxpath
#    And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#    And click on link: yelo.pay.SubmitPayment.button.byxpath
#    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
#    Then cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomereltblltxef@yelo.com

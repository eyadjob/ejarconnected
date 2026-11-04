Feature: Confirmation page Validation

  @TestType-Regression
  Scenario: validate yelo confirmation page - pay later
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Abha Airport,مطار ابها
    And user set date time V2 in yelo pickup field plus days: 7 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 8 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on action if exist: yelo.pay.SaveBooking.button.byxpath
    And store element value: yelo.booking.confirmation.id.byxpath and value name: BookingNumberInConfirmationTabWithText and keep number only: false
    And verify element present: yelo.booking.confirmation.id.byxpath
    And verify element present: yelo.booking.booking-pickup-info.byxpath
    And verify element present: yelo.booking.booking-dropoff-info.byxpath
    And verify element present: yelo.booking.booking-step-header.byxpath
    And verify text present on page: yelo.register.booking-step-header.text
    And verify element present: yelo.booking.booking-confirmation-info.byxpath
    And verify element present: yelo.booking.booking-reference.byxpath
    And verify element present: yelo.booking.car-details.byxpath
    And verify element present: yelo.booking.row-TotalRent.byxpath
    And verify element present: yelo.booking.booking-confirmation.byxpath
    And verify element present: yelo.booking.booking-confirmation-amyali-box.byxpath
    And verify element present: yelo.booking.confirmation-assistance.byxpath
    And verify element present: yelo.booking.membership.byxpath
    And verify element present: yelo.booking.contact.byxpath
    And verify element present: yelo.booking.booking-confirmation-questions.byxpath
    And verify element present: yelo.booking.booking-confirmation-Disclaimer.byxpath
    And verify element present: yelo.booking.booking-step.byxpath
    And verify text present on page: yelo.register.thank-u-message.text
    And verify text present on page: yelo.register.thank-u-message1.text
    And verify text present on page: yelo.register.amyali-membership.text
    And verify text present on page: yelo.register.need-assistance.text
    And verify text present on page: yelo.register.message1.text
    And verify text present on page: yelo.register.message2.text
    And verify text present on page: yelo.register.questions.text
    And verify text present on page: yelo.register.message3.text
    And verify text present on page: yelo.register.disclaimer.text
    And verify text present on page: yelo.register.message4.text
    And cancel all bookings if exist on yelo sequentially
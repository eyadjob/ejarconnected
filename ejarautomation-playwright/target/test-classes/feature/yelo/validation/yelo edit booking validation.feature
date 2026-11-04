Feature: Yelo Edit Booking Validation

  @TestType-Regression
  Scenario: validate edit booking - pay later - edit pickup date - price should be changed
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And place pay later booking on branch: Automation Branch,Automation Branch and pickup day: 3 and time: 01:30 pm and return day: 4 and time: 01:30 pm
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    And click on element: yelo.myBookings.latestBooking.byxpath
    And store element value: yelo.pay.tripdaysprice.byxpath and value name: BookingPrice and keep number only: true
    And click on element: yelo.editBooking.editDate.a.byxpath
    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
    And click on element: yelo.homepage.returnDateTime.img.byxpath
    And user scroll to element: yelo.editBooking.search.button.byxpath
    And click on element: yelo.editBooking.search.button.byxpath
    And wait for element present: yelo.editBooking.2DaysTripDuration.label.byxpath for period in seconds: 180
    And scroll by pixcels horizontally: 0 and vertically: 500
    And click on yelo action with xpath: //button[ancestor::div[@class='card car-for-booking is-available' and descendant::p[normalize-space()='${DynamicVariable}']]] with replacing variable with stored value: carModalName
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And store element value: yelo.pay.newPrice.td.byxpath and value name: NewBookingPrice and keep number only: true
    And verify two values are equal after operation, first value: BookingPrice second value: NewBookingPrice param type: decimal and operation on second value: divide by value: 2
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And cancel latest booking if exist on yelo with assertion and page refresh

  @TestType-Regression
  Scenario: validate edit booking - pay later - edit return date - price should be changed
    Given user open website page: yelo
    And login to yelo site with user: yazeedautomationui@qoad.com and password: Yelo123456
    And cancel all bookings if exist on yelo sequentially
    And place pay later booking on branch: Automation Branch,Automation Branch and pickup day: 3 and time: 01:30 pm and return day: 4 and time: 01:30 pm
    And user open page yelo page: /Profile/MyBookings
    And navigate if the element: yelo.myBookings.latestBooking.byxpath is not present to: /Profile/MyBookings
    And click on element: yelo.myBookings.latestBooking.byxpath
    And store element value: yelo.pay.tripdaysprice.byxpath and value name: BookingPrice and keep number only: true
    And click on element: yelo.editBooking.editDate.a.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 5 and time: 01:30 pm
    And click on element: yelo.homepage.pickupDateTime.img.byxpath
    And click on element: yelo.editBooking.search.button.byxpath
    And verify text present on page: yelo.editBooking.2DaysTripDuration.text
    And scroll by pixcels horizontally: 0 and vertically: 500
    And click on element: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And store element value: yelo.pay.newPrice.td.byxpath and value name: NewBookingPrice and keep number only: true
    And verify two values are equal after operation, first value: BookingPrice second value: NewBookingPrice param type: decimal and operation on second value: divide by value: 2
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And cancel latest booking if exist on yelo with assertion and page refresh
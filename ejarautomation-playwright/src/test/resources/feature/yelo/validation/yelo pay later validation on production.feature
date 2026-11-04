Feature: Yelo Pay Later Health Check Validation On Production Environment


  @TestType-Regression
  Scenario: booking pay later validation Yelo production (iyelo.com)
    Given user open page using url: https://www.iyelo.com/en
    Given login to yelo site with user: e.mubarak@qoad.com and password: thesame1
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Dubai Airport Terminal 2,مطار دبي الصالة 2
    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify array of elements: yelo.search.result.cars.price.byxpath contains value:⃁
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And user scroll to the top of the page
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And verify element not present: yelo.booking.error.byxpath within time of seconds: 2 and status: present
    And verify yelo booking confirmation page
    And cancel latest booking if exist on yelo with assertion and page refresh

  @TestType-Regression
  Scenario: booking pay later validation Yelo production (iyelo.ch)
    Given user open page using url: https://www.iyelo.ch/en
    Given login to yelo site with user: e.mubarak@qoad.com and password: thesame1
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Dubai Airport Terminal 2,مطار دبي الصالة 2
    And user set date time V2 in yelo pickup field plus days: 4 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 5 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify array of elements: yelo.search.result.cars.price.byxpath contains value:CHF
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And user scroll to the top of the page
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And user scroll to element: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And verify element not present: yelo.booking.error.byxpath within time of seconds: 2 and status: present
    And verify yelo booking confirmation page
    And cancel latest booking if exist on yelo with assertion and page refresh
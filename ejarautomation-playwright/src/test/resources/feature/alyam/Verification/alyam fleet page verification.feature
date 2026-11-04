Feature: Alyam Fleet Page Verification

  @TestType-Regression
  Scenario: verify fleet page
    Given user open website page: alyam
    And click on element: yelo.header.fleet.a.byxpath
    And verify element present: alyam.fleet.mainImage.byxpath
    And compare list of elements text: yelo.fleet.mainOperations.li.byxpath with text: alyam.fleet.mainOperations.li.text
    And verify element text present: yelo.homepage.searchNow.span.byxpath with text: alyam.fleet.searchNow.span.text
    And verify element text present: alyam.fleet.manageMyBooking.span.byxpath with text: alyam.fleet.manageMyBooking.span.text
    And verify element text present: alyam.fleet.samelocation.label.byxpath with text: alyam.fleet.samelocation.label.text
    And verify element present: alyam.fleet.samelocation.input.byxpath
    And verify element text present: alyam.fleet.differentLocation.span.byxpath with text: alyam.fleet.differentLocation.span.text
    And verify element present: alyam.fleet.differentLocation.input.byxpath
    And verify element present: alyam.fleet.searchLocation.img.byxpath
    And verify element present: yelo.homepage.searchLocation.input.byxpath
    And verify element present: yelo.homepage.pickupDateTime.img.byxpath
    And verify element present: yelo.homepage.pickupDate.input.byxpath
    And verify element present: yelo.homepage.returnDateTime.img.byxpath
    And verify element present: yelo.homepage.returnDate.input.byxpath
    And verify element text present: yelo.homepage.vehicle.search.button.byxpath with text: alyam.fleet.submit.button.text
    And verify element: alyam.fleet.searchNow.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: false
    And scroll by pixcels horizontally: 0 and vertically: -1000
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: true
    And verify element: alyam.fleet.searchNow.li.byxpath attribute: class contains value: active is: false
    And verify element present: yelo.homepage.manageBooking.bookingId.input.byxpath
    And verify element present: yelo.homepage.manageBooking.customerLastName.input.byxpath
    And verify element text present: yelo.homepage.manageBooking.submit.button.byxpath with text: yelo.homepage.manageBooking.submit.button.text
    And verify element present: yelo.homepage.manageBooking.search.img.byxpath
    And verify element present: yelo.search.minPrice.div.byxpath
    And verify element present: yelo.search.maxPrice.div.byxpath
    And verify element present: yelo.fleet.priceSlider.byxpath
    And click on element: alyam.fleet.category.input.byxpath
    And verify element text present: alyam.fleet.sortBy.byxpath with text: alyam.fleet.sortBy.text
    And verify element present: yelo.fleet.sortByList.byxpath
    And click on element: yelo.fleet.outofstock.input.byxpath
    And verify element present: alyam.fleet.bookingVehicleImg.byxpath
    And verify element present: alyam.fleet.bookingModelInfo.byxpath
    And verify element present: alyam.fleet.vehicleSeatImg.byxpath
    And verify element present: alyam.fleet.vehicleSeatSpan.byxpath
    And verify element present: alyam.fleet.vehicleDoorImg.byxpath
    And verify element present: alyam.fleet.vehicleDoorSpan.byxpath
    And verify element present: alyam.fleet.vehicleBagImg.byxpath
    And verify element present: alyam.fleet.vehicleBagSpan.byxpath
    And verify element present: alyam.fleet.airConditionImg.byxpath
    And verify element present: alyam.fleet.autoTransmissionImg.byxpath
    And verify element present: alyam.fleet.vehicleCategoryImg.byxpath
    And verify element present: yelo.fleet.vehiclePriceDuration.byxpath
    And verify element present: yelo.fleet.vehiclePrice.byxpath
Feature: Fleet Page Verification

  @TestType-Regression
  Scenario: verify fleet page
    Given user open website page: yelo
    And click on element: yelo.header.fleet.a.byxpath
    And verify element present: yelo.fleet.mainImage.byxpath
    And compare list of elements text: yelo.fleet.mainOperations.li.byxpath with text: yelo.fleet.mainOperations.li.text
    And verify element present: yelo.homepage.searchNow.img.byxpath
    And verify element text present: yelo.homepage.searchNow.span.byxpath with text: yelo.homepage.searchNow.span.text
    And verify element present: yelo.homepage.manageMyBooking.img.byxpath
    And verify element text present: yelo.homepage.manageMyBooking.span.byxpath with text: yelo.homepage.manageMyBooking.span.text
    And verify element text present: yelo.homepage.pickupAndReturn.label.byxpath with text: yelo.homepage.pickupAndReturn.label.text
    And verify element present: yelo.homepage.differentLocation.div.byxpath
    And verify element text present: yelo.homepage.differentLocation.span.byxpath with text: yelo.homepage.differentLocation.span.text
    And verify element present: yelo.homepage.searchLocation.img.byxpath
    And verify element present: yelo.homepage.searchLocation.input.byxpath
    And verify element text present: yelo.homepage.pickupDateTime.label.byxpath with text: yelo.homepage.pickupDateTime.label.text
    And verify element present: yelo.homepage.pickupDateTime.img.byxpath
    And verify element present: yelo.homepage.pickupDate.input.byxpath
    And verify element present: yelo.homepage.pickupTime.input.byxpath
    And verify element text present: yelo.homepage.returnDateTime.label.byxpath with text: yelo.homepage.returnDateTime.label.text
    And verify element present: yelo.homepage.returnDateTime.img.byxpath
    And verify element present: yelo.homepage.returnDate.input.byxpath
    And verify element present: yelo.homepage.returnTime.input.byxpath
    And verify element text present: yelo.homepage.vehicle.search.button.byxpath with text: yelo.homepage.submit.button.text
    And verify element present: yelo.homepage.search.img.byxpath
    And verify element: yelo.homepage.searchNow.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: false
    And scroll by pixcels horizontally: 0 and vertically: -1000
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.searchNow.li.byxpath attribute: class contains value: active is: false
    And compare list of elements text: yelo.homepage.manageBookingItems.label.byxpath with text: yelo.homepage.manageBookingItems.label.text
    And verify element present: yelo.homepage.manageBooking.bookingId.input.byxpath
    And verify element present: yelo.homepage.manageBooking.customerLastName.input.byxpath
    And verify element text present: yelo.homepage.manageBooking.submit.button.byxpath with text: yelo.homepage.manageBooking.submit.button.text
    And verify element present: yelo.homepage.manageBooking.search.img.byxpath
    And verify element present: yelo.search.minPrice.div.byxpath
    And verify element present: yelo.search.maxPrice.div.byxpath
    And verify element present: yelo.fleet.priceSlider.byxpath
    And click on element: yelo.fleet.category.input.byxpath
    And verify element present: yelo.fleet.categoryFilterLabel.byxpath
    And verify element present: yelo.search.saveForLaterBtn.byxpath
    And verify element text present: yelo.fleet.sortBy.byxpath with text: yelo.fleet.sortBy.text
    And verify element present: yelo.fleet.sortByList.byxpath
    And click on element: yelo.fleet.outofstock.input.byxpath
    And verify element present: yelo.fleet.bookingVehicleImg.byxpath
    And verify element present: yelo.fleet.bookingModelInfo.byxpath
    And verify element present: yelo.fleet.vehicleSeatImg.byxpath
    And verify element present: yelo.fleet.vehicleSeatSpan.byxpath
    And verify element present: yelo.fleet.vehicleDoorImg.byxpath
    And verify element present: yelo.fleet.vehicleDoorSpan.byxpath
    And verify element present: yelo.fleet.vehicleBagImg.byxpath
    And verify element present: yelo.fleet.vehicleBagSpan.byxpath
    And verify element present: yelo.fleet.airConditionImg.byxpath
    And verify element present: yelo.fleet.airConditionSpan.byxpath
    And verify element present: yelo.fleet.autoTransmissionImg.byxpath
    And verify element present: yelo.fleet.autoTransmissionSpan.byxpath
    And verify element present: yelo.fleet.vehicleCategoryImg.byxpath
    And verify element present: yelo.fleet.vehicleCategorySpan.byxpath
    And verify element present: yelo.fleet.vehiclePriceDuration.byxpath
    And verify element present: yelo.fleet.vehiclePrice.byxpath
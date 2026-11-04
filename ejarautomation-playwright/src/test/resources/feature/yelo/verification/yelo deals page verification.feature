Feature: Deals Page Verification

  @TestType-Regression
  Scenario: verify deals page
    Given user open page yelo page: /booking/car-renting-deals
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
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.searchNow.li.byxpath attribute: class contains value: active is: false
    And compare list of elements text: yelo.homepage.manageBookingItems.label.byxpath with text: yelo.homepage.manageBookingItems.label.text
    And verify element present: yelo.homepage.manageBooking.bookingId.input.byxpath
    And verify element present: yelo.homepage.manageBooking.customerLastName.input.byxpath
    And verify element text present: yelo.homepage.manageBooking.submit.button.byxpath with text: yelo.homepage.manageBooking.submit.button.text
    And verify element present: yelo.homepage.manageBooking.search.img.byxpath
    And click on element: yelo.homepage.searchNow.li.byxpath
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Abha Airport,مطار ابها
    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And verify element present: yelo.fleet.priceFilter.byxpath
    And verify element present: yelo.search.minPrice.div.byxpath
    And verify element present: yelo.search.maxPrice.div.byxpath
    And verify element present: yelo.fleet.priceSlider.byxpath
    And click on element: yelo.fleet.category.input.byxpath
    And verify element present: yelo.fleet.categoryFilterLabel.byxpath
    And verify element present: yelo.search.saveForLaterBtn.byxpath
    And verify element text present: yelo.fleet.sortBy.byxpath with text: yelo.fleet.sortBy.text
    And verify element present: yelo.fleet.sortByList.byxpath
    And verify element present: yelo.deals.bookingVehicleImg.byxpath
    And verify element present: yelo.deals.bookingModelInfo.byxpath
    And verify element present: yelo.deals.vehicleSeatImg.byxpath
    And verify element present: yelo.deals.vehicleSeatSpan.byxpath
    And verify element present: yelo.deals.vehicleDoorImg.byxpath
    And verify element present: yelo.deals.vehicleDoorSpan.byxpath
    And verify element present: yelo.deals.vehicleBagImg.byxpath
    And verify element present: yelo.deals.vehicleBagSpan.byxpath
    And verify element present: yelo.deals.airConditionImg.byxpath
    And verify element present: yelo.deals.airConditionSpan.byxpath
    And verify element present: yelo.deals.autoTransmissionImg.byxpath
    And verify element present: yelo.deals.autoTransmissionSpan.byxpath
    And verify element present: yelo.deals.vehicleCategoryImg.byxpath
    And verify element present: yelo.deals.vehicleCategorySpan.byxpath
    And verify element present: yelo.deals.vehiclePriceDuration.byxpath
    And verify element present: yelo.deals.vehiclePrice.byxpath
    And verify element text present: yelo.fleet.bookNowBtn.byxpath with text: yelo.fleet.bookNowBtn.text
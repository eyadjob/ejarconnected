Feature: Alyam Home Page Verification

  @TestType-Regression
  Scenario: verify home page
    Given user open website page: alyam
    And click on element: yelo.header.yelo-logo.byxpath
    And verify element present: alyam.header.alyam-logo.byxpath
    And compare list of elements text: yelo.homepage.mainOperations.li.byxpath with text: alyam.homepage.mainOperations.li.text
    And verify text present on page: alyam.homepage.mainOperations.description1.text
    And verify text present on page: alyam.homepage.mainOperations.description2.text
    And verify text present on page: alyam.homepage.mainOperations.description3.text
    And verify element present: alyam.homepage.mainOperations.description3.byxpath
    And verify text present on page: alyam.homepage.mainOperations.description4.text
    And verify element present: alyam.homepage.mainOperations.description4.byxpath
    And verify element present: yelo.homepage.searchLocation.input.byxpath
    And verify element present: yelo.homepage.searchLocation.img.byxpath
    And verify element present: yelo.homepage.pickupDate.input.byxpath
    And verify element present: yelo.homepage.pickupDateTime.img.byxpath
    And verify element present: alyam.homepage.mainOperations.rentCar.dropDate.byxpath
    And verify element present: yelo.homepage.returnDateTime.img.byxpath
    And verify element text present: alyam.homepage.vehicle.search.button.byxpath with text: alyam.homepage.submit.button.text
    And click on element: alyam.homepage.mainOperations.description4.byxpath
    And verify element present: alyam.homepage.mainOperations.rentCar.dropDateLocation.byxpath
    And verify element present: alyam.homepage.mainOperations.rentCar.dropDateLocation.img.byxpath
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: true
    And verify element: alyam.homepage.searchNow.li.byxpath attribute: class contains value: active is: false
    And verify text present on page: alyam.homepage.mainOperations.findBooking.text
    And verify element present: yelo.homepage.manageBooking.bookingId.input.byxpath
    And verify element present: alyam.homepage.mainOperations.bookingId.img.byxpath
    And verify element present: yelo.homepage.manageBooking.customerLastName.input.byxpath
    And verify element present: alyam.homepage.mainOperations.lastName.img.byxpath
    And verify element text present: yelo.homepage.manageBooking.submit.button.byxpath with text: yelo.homepage.manageBooking.submit.button.text
    And verify element present: yelo.homepage.manageBooking.search.img.byxpath
    And user scroll to element: yelo.homepage.rentGroup.img.byxpath
    And verify text present on page: alyam.homepage.featuredCars.text
    And verify text present on page: alyam.homepage.featuredCarsDesc.text
    And verify element present: yelo.homepage.rentGroup.img.byxpath
    And verify element text present: yelo.homepage.dealsLink.a.byxpath with text: yelo.homepage.dealsLink.a.text
    And verify element present: yelo.homepage.deals.smallImg.img.byxpath
    And verify element present: yelo.homepage.deals.modelName.span.byxpath
    And verify element present: yelo.homepage.deals.largeImg.img.byxpath
    And verify element present: yelo.homepage.deals.dealsName.div.byxpath
    And verify element text present: yelo.homepage.deals.bookNow.div.byxpath with text: yelo.homepage.deals.bookNow.div.text
    And verify element present: yelo.homepage.deals.newPrice.div.byxpath
    And verify element present: alyam.homepage.deals.Vat.byxpath
    And verify element present: alyam.homepage.deals.leftarrow.byxpath
    And verify element present: alyam.homepage.deals.rightarrow.byxpath

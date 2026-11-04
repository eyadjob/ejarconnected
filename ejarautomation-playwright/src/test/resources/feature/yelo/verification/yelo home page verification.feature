Feature: Yelo Home Page Verification

  @TestType-Regression
  Scenario: verify home page
    Given user open website page: yelo
    And click on element: yelo.header.yelo-logo.byxpath
    And verify element present: yelo.homepage.mainImage.img.byxpath
    And compare list of elements text: yelo.homepage.mainOperations.li.byxpath with text: yelo.homepage.mainOperations.li.text
    And verify element present: yelo.homepage.searchNow.img.byxpath
    And verify element text present: yelo.homepage.searchNow.span.byxpath with text: yelo.homepage.searchNow.span.text
    And verify element present: yelo.homepage.manageMyBooking.img.byxpath
    And verify element text present: yelo.homepage.manageMyBooking.span.byxpath with text: yelo.homepage.manageMyBooking.span.text
    And verify element present: yelo.homepage.carSubscription.img.byxpath
    And verify element text present: yelo.homepage.carSubscription.span.byxpath with text: yelo.homepage.carSubscription.span.text
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
    And verify element: yelo.homepage.carSubscription.li.byxpath attribute: class contains value: active is: false
    And click on element: yelo.homepage.manageMyBooking.li.byxpath
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.searchNow.li.byxpath attribute: class contains value: active is: false
    And verify element: yelo.homepage.carSubscription.li.byxpath attribute: class contains value: active is: false
    And compare list of elements text: yelo.homepage.manageBookingItems.label.byxpath with text: yelo.homepage.manageBookingItems.label.text
    And verify element present: yelo.homepage.manageBooking.bookingId.input.byxpath
    And verify element present: yelo.homepage.manageBooking.customerLastName.input.byxpath
    And verify element text present: yelo.homepage.manageBooking.submit.button.byxpath with text: yelo.homepage.manageBooking.submit.button.text
    And verify element present: yelo.homepage.manageBooking.search.img.byxpath
    And click on element: yelo.homepage.carSubscription.li.byxpath
    And verify element: yelo.homepage.carSubscription.li.byxpath attribute: class contains value: active is: true
    And verify element: yelo.homepage.searchNow.li.byxpath attribute: class contains value: active is: false
    And verify element: yelo.homepage.manageMyBooking.li.byxpath attribute: class contains value: active is: false
    And compare list of elements text: yelo.homepage.carSubscriptionItems.label.byxpath with text: yelo.homepage.carSubscriptionItems.label.text
    And verify element present: yelo.homepage.carSubscription.cities.select.byxpath
    And verify element present: yelo.homepage.carSubscription.cities.img.byxpath
    And verify element present: yelo.homepage.carSubscription.categories.select.byxpath
    And verify element present: yelo.homepage.carSubscription.categories.img.byxpath
    And verify element text present: yelo.homepage.carSubscription.submit.button.byxpath with text: yelo.homepage.carSubscription.submit.button.text
    And verify element present: yelo.homepage.carSubscription.search.img.byxpath
    And verify element present: yelo.homepage.rentGroup.img.byxpath
    And verify element text present: yelo.homepage.featuredCars.title.span.byxpath with text: yelo.homepage.featuredCars.title.span.text
    And verify element text present: yelo.homepage.dealsText.span.byxpath with text: yelo.homepage.dealsText.span.text
    And verify element text present: yelo.homepage.dealsLink.a.byxpath with text: yelo.homepage.dealsLink.a.text
    And verify element present: yelo.homepage.deals.smallImg.img.byxpath
    And verify element present: yelo.homepage.deals.modelName.span.byxpath
    And verify element present: yelo.homepage.deals.largeImg.img.byxpath
    And verify element present: yelo.homepage.deals.dealsName.div.byxpath
    And verify element present: yelo.homepage.deals.bookNow.div.byxpath
    And verify element present: yelo.homepage.deals.newPrice.div.byxpath
    And verify element present: yelo.homepage.deals.leftArrow.img.byxpath
    And verify element present: yelo.homepage.deals.rightArrow.img.byxpath
    And verify text present on page: yelo.homepage.rentCar.span.text
    And verify element text present: yelo.homepage.campaigns.h.byxpath with text: yelo.homepage.campaigns.h.text
    And verify count of element: yelo.homepage.campaigns.img.byxpath equals: 5
    And verify element text present: yelo.homepage.experience.title.h2.byxpath with text: yelo.homepage.experience.title.h2.text
    And verify element text present: yelo.homepage.experience.firstCard.title.h5.byxpath with text: yelo.homepage.experience.firstCard.title.h5.text
    And verify element text present: yelo.homepage.experience.firstCard.secondTitle.span.byxpath with text: yelo.homepage.experience.firstCard.secondTitle.span.text
    And verify element present: yelo.homepage.experience.yeloExperience.img.byxpath
    And compare list of elements text: yelo.homepage.experience.cardItems.span.byxpath with text: yelo.homepage.experience.cardItems.span.text
    And verify count of element: yelo.homepage.experience.cardItems.img.byxpath equals: 3
    And compare list of elements text: yelo.homepage.experience.subCards.span.byxpath with text: yelo.homepage.experience.subCards.span.text
    And verify count of element: yelo.homepage.experience.subCardsarrows.img.byxpath equals: 4
    And verify count of element: yelo.homepage.experience.linkableImg.img.byxpath equals: 4
    And verify element present: yelo.homepage.experience.img.byxpath
    And verify element present: yelo.homepage.experience.airportRental.img.byxpath
    And verify element present: yelo.homepage.experience.yeloShield.img.byxpath
    And verify element present: yelo.homepage.experience.curSubscription.img.byxpath
    And verify element present: yelo.homepage.experience.contact.img.byxpath





#   categories section doesn't exist anymore the steps for categories:

#    And verify count of element: yelo.homepage.categories.smallImg.img.byxpath equals: 6
#    And verify count of element: yelo.homepage.categories.name.span.byxpath equals: 6
#    And verify count of element: yelo.homepage.categories.largeImg.img.byxpath equals: 6
#    And verify count of element: yelo.homepage.categories.description.span.byxpath equals: 6
#    And verify count of element: yelo.homepage.categories.discoverMore.span.byxpath equals: 6
#    And verify element present: yelo.homepage.categories.smallcarsSmallImg.img.byxpath
#    And verify element present: yelo.homepage.categories.sedanandcompactSmallImg.img.byxpath
#    And verify element present: yelo.homepage.categories.SUVSmallImg.img.byxpath
#    And verify element present: yelo.homepage.categories.electric.img.byxpath
#    And verify element present: yelo.homepage.categories.luxurySmallImg.img.byxpath
#    And verify element present: yelo.homepage.categories.familySmallImg.img.byxpath
#    And compare list of elements text: yelo.homepage.categories.categoryName.span.byxpath with text: yelo.homepage.categories.categoryName.span.text
#    And verify element text present: yelo.homepage.categories.smallcarsDescription.span.byxpath with text: yelo.homepage.categories.smallcarsDescription.span.text
#    And verify element text present: yelo.homepage.categories.sedanDescription.span.byxpath with text: yelo.homepage.categories.sedanDescription.span.text
#    And verify element text present: yelo.homepage.categories.SUVDescription.span.byxpath with text: yelo.homepage.categories.SUVDescription.span.text
#    And verify element text present: yelo.homepage.categories.electricDescription.span.byxpath with text: yelo.homepage.categories.electricDescription.span.text
#    And verify element text present: yelo.homepage.categories.luxuryDescription.span.byxpath with text: yelo.homepage.categories.luxuryDescription.span.text
#    And verify element text present: yelo.homepage.categories.familyDescription.span.byxpath with text: yelo.homepage.categories.familyDescription.span.text
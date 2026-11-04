Feature: Yelo Services Page Verification

  @TestType-Regression
  Scenario: verify services page
    Given user open page yelo page: /services
    And verify text present on page: yelo.services.carRentalServices.text
    And verify text present on page: yelo.services.firstsectiontext.text
    And verify text present on page: yelo.services.excutebookingtitle.text
    And verify text present on page: yelo.services.excutebooking.text
    And verify element text present: yelo.services.executeBooking.a.byxpath with text: yelo.services.moreinfo.text
    And verify text present on page: yelo.services.openkilometertitle.text
    And verify text present on page: yelo.services.openkilometer.text
    And verify element text present: yelo.services.openkilometer.a.byxpath with text: yelo.services.moreinfo.text
    And verify text present on page: yelo.services.shippingservicetitle.text
    And verify text present on page: yelo.services.shippingservice.text
    And verify element text present: yelo.services.shippingservice.a.byxpath with text: yelo.services.moreinfo.text
    And verify text present on page: yelo.services.yeloshieldplustitle.text
    And verify text present on page: yelo.services.yeloshieldplus.text
    And verify element text present: yelo.services.yeloshield.a.byxpath with text: yelo.services.moreinfo.text
    And verify element present: yelo.services.excecuteBookingImg.byxpath
    And verify element present: yelo.services.openKmImg.byxpath
    And verify element present: yelo.services.shippingCitiesImg.byxpath
    And verify element present: yelo.services.shieldPlusImg.byxpath
    And verify text present on page: yelo.services.otherservice.text
    And verify element text present: yelo.services.otherservice.a.byxpath with text: yelo.services.moreinfo.text
    And verify text present on page: yelo.services.otherservicetitle.text
    And verify text present on page: yelo.services.otherservice.p.text
    And verify text present on page: yelo.services.otherservicesubtitle.text
    And verify element present: yelo.services.Spot-img.byxpath
    And verify text present on page: yelo.services.Spottitle.text
    And verify element present: yelo.services.corporate-img.byxpath
    And verify text present on page: yelo.services.corporatetitle.text
    And verify element present: yelo.services.luxury-cars-img.byxpath
    And verify text present on page: yelo.services.luxury-carstitle.text
    And verify element present: yelo.services.airport-img.byxpath
    And verify text present on page: yelo.services.airport-title.text
    And verify element present: yelo.services.government-img.byxpath
    And verify text present on page: yelo.services.governmenttitle.text
    And verify element present: yelo.services.officialevents-img.byxpath
    And verify text present on page: yelo.services.officialeventstitle.text.en
    And verify element present: yelo.services.roadside-img.byxpath
    And verify text present on page: yelo.services.roadsidetitle.text
    And verify element present: yelo.services.navigation-img.byxpath
    And verify text present on page: yelo.services.navigationtitle.text
    And verify element present: yelo.services.available24/7-img.byxpath
    And verify text present on page: yelo.services.available24/7title.text

  @TestType-Regression
  Scenario: verify execute booking page
    Given user open page yelo page: /services
    And click on element: yelo.services.executeBooking.a.byxpath
    And verify element present: yelo.executebooking.slider.img.byxpath
    And verify element text present: yelo.executebooking.title.byxpath with text: yelo.executebooking.title.text
    And verify text present on page: yelo.executebooking.firstp.text
    And verify element present: yelo.executebooking.paragraph.img.byxpath
    And verify element text present: yelo.executebooking.benefitstitle.byxpath with text: yelo.executebooking.benefitstitle.text
    And compare list of elements text: yelo.executebooking.benefits.byxpath with text: yelo.executebooking.benefits.text
    And verify element present: yelo.executebooking.benefits.img.1.byxpath
    And verify element present: yelo.executebooking.benefits.img.2.byxpath
    And verify element present: yelo.executebooking.benefits.img.3.byxpath
    And verify element present: yelo.executebooking.benefits.img.4.byxpath
    And verify text present on page: yelo.executebooking.relatedservices.text
    And verify text present on page: yelo.executebooking.discovernow.text
    And compare list of elements text: yelo.executebooking.discovernow.span.byxpath with text: yelo.executebooking.discovernow.span.text
    And verify element present: yelo.executebooking.discovernow.img.1.byxpath
    And verify element present: yelo.executebooking.discovernow.img.2.byxpath
    And verify element present: yelo.executebooking.discovernow.img.3.byxpath
    And verify element present: yelo.executebooking.discovernow.img.4.byxpath

  @TestType-Regression
  Scenario: verify open kilometers page
    Given user open page yelo page: /services
    And click on element: yelo.services.openkilometer.a.byxpath
    And verify element present: yelo.openkilo.slider.img.byxpath
    And verify element text present: yelo.openkilo.title.byxpath with text: yelo.openkilo.title.text
    And verify text present on page: yelo.openkilo.firstp.text
    And verify element present: yelo.openkilo.paragraph.img.byxpath
    And verify element text present: yelo.openkilo.benefitstitle.byxpath with text: yelo.openkilo.benefitstitle.text
    And compare list of elements text: yelo.openkilo.benefits.byxpath with text: yelo.openkilo.benefits.text
    And verify element present: yelo.openkilo.benefits.img.1.byxpath
    And verify element present: yelo.openkilo.benefits.img.2.byxpath
    And verify element present: yelo.openkilo.benefits.img.3.byxpath
    And verify text present on page: yelo.openkilo.relatedservices.text
    And verify text present on page: yelo.openkilo.discovernow.text
    And compare list of elements text: yelo.openkilo.discovernow.span.byxpath with text: yelo.openkilo.discovernow.span.text
    And verify element present: yelo.openkilo.discovernow.img.1.byxpath
    And verify element present: yelo.openkilo.discovernow.img.2.byxpath
    And verify element present: yelo.openkilo.discovernow.img.3.byxpath
    And verify element present: yelo.openkilo.discovernow.img.4.byxpath

  @TestType-Regression
  Scenario: verify yelo shield plus page
    Given user open page yelo page: /services
    And click on element: yelo.services.yeloshield.a.byxpath
    And verify element present: yelo.shieldplus.slider.img.byxpath
    And verify element text present: yelo.shieldplus.title.byxpath with text: yelo.shieldplus.title.text
    And verify text present on page: yelo.shieldplus.firstp.title.text
    And verify text present on page: yelo.shieldplus.firstp.text
    And verify element present: yelo.shieldplus.firstp.img.byxpath
    And verify text present on page: yelo.shieldplus.secondp.title.text
    And verify text present on page: yelo.shieldplus.secondp.text
    And verify text present on page: yelo.shieldplus.benefits.title.text
    And compare list of elements text: yelo.shieldplus.benefits.label.byxpath with text: yelo.shieldplus.benefits.text
    And verify element present: yelo.shieldplus.benefits.img.1.byxpath
    And verify element present: yelo.shieldplus.benefits.img.2.byxpath
    And verify element present: yelo.shieldplus.benefits.img.3.byxpath
    And verify element present: yelo.shieldplus.benefits.img.4.byxpath
    And verify text present on page: yelo.shieldplus.relatedservices.text
    And verify text present on page: yelo.shieldplus.discovernow.text
    And compare list of elements text: yelo.shieldplus.discovernow.span.byxpath with text: yelo.shieldplus.discovernow.span.text
    And verify element present: yelo.shieldplus.discovernow.img.1.byxpath
    And verify element present: yelo.shieldplus.discovernow.img.2.byxpath
    And verify element present: yelo.shieldplus.discovernow.img.3.byxpath
    And verify element present: yelo.shieldplus.discovernow.img.4.byxpath

  @TestType-Regression
  Scenario: verify shipping between cities page
    Given user open page yelo page: /services
    And click on element: yelo.services.shippingservice.a.byxpath
    And verify element present: yelo.shipping.slider.img.byxpath
    And verify element text present: yelo.shipping.title.byxpath with text: yelo.shipping.title.text
    And verify text present on page: yelo.shipping.firstp.text
    And verify element present: yelo.shipping.firstp.img.byxpath
    And verify element text present: yelo.shipping.benefitstitle.byxpath with text: yelo.shipping.benefitstitle.text
    And compare list of elements text: yelo.shipping.benefits.byxpath with text: yelo.shipping.benefits.text
    And verify element present: yelo.shipping.benefits.img.1.byxpath
    And verify element present: yelo.shipping.benefits.img.2.byxpath
    And verify element present: yelo.shipping.benefits.img.3.byxpath
    And verify element present: yelo.shipping.benefits.img.4.byxpath
    And verify text present on page: yelo.shipping.relatedservices.text
    And verify text present on page: yelo.shipping.discovernow.text
    And compare list of elements text: yelo.shipping.discovernow.span.byxpath with text: yelo.shipping.discovernow.span.text
    And verify element present: yelo.shipping.discovernow.img.1.byxpath
    And verify element present: yelo.shipping.discovernow.img.2.byxpath
    And verify element present: yelo.shipping.discovernow.img.3.byxpath
    And verify element present: yelo.shipping.discovernow.img.4.byxpath

  @TestType-Regression
  Scenario: verify other services page
    Given user open page yelo page: /services
    And click on element: yelo.services.otherservice.a.byxpath
    And verify element present: yelo.otherservices.slider.img.byxpath
    And verify element text present: yelo.otherservices.title.byxpath with text: yelo.otherservices.title.text
    And verify text present on page: yelo.otherservices.firstp.title.text
    And verify text present on page: yelo.otherservices.firstp.text
    And verify text present on page: yelo.otherservices.airport.title.text
    And verify text present on page: yelo.otherservices.airport.text
    And verify element present: yelo.otherservices.airport.img.byxpath
    And verify text present on page: yelo.otherservices.corporate.title.text
    And verify text present on page: yelo.otherservices.corporate.text
    And verify element present: yelo.otherservices.corporate.img.byxpath
    And verify element present: yelo.otherservices.corporate.a.byxpath
    And verify text present on page: yelo.otherservices.roadside.title.text
    And verify text present on page: yelo.otherservices.roadside.text
    And verify element present: yelo.otherservices.roadside.img.byxpath
    And verify text present on page: yelo.otherservices.spotrentals.title.text
    And verify text present on page: yelo.otherservices.spotrentals.text
    And verify element present: yelo.otherservices.spotrentals.img.byxpath
    And verify text present on page: yelo.otherservices.24/7available.title.text
    And verify text present on page: yelo.otherservices.24/7available.text
    And verify element present: yelo.otherservices.24/7available.img.byxpath
    And verify element present: yelo.otherservices.24/7available.a.byxpath
    And verify text present on page: yelo.otherservices.government.title.text
    And verify text present on page: yelo.otherservices.government.text
    And verify element present: yelo.otherservices.government.img.byxpath
    And verify text present on page: yelo.otherservices.events.title.text
    And verify text present on page: yelo.otherservices.events.text
    And verify element present: yelo.otherservices.events.img.byxpath
    And verify text present on page: yelo.otherservices.navigationsys.title.text
    And verify text present on page: yelo.otherservices.navigationsys.text
    And verify element present: yelo.otherservices.navigationsys.img.byxpath
    And verify text present on page: yelo.otherservices.discovernow.text
    And compare list of elements text: yelo.otherservices.discovernow.span.byxpath with text: yelo.otherservices.discovernow.span.text
    And verify element present: yelo.otherservices.discovernow.img.1.byxpath
    And verify element present: yelo.otherservices.discovernow.img.2.byxpath
    And verify element present: yelo.otherservices.discovernow.img.3.byxpath
    And verify element present: yelo.otherservices.discovernow.img.4.byxpath
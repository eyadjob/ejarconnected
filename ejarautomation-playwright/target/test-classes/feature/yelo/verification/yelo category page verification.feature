Feature: Category Page Verification

  @TestType-Regression
  Scenario: verify small cars category
    Given user open page yelo page: /fleet/categories/economy
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath
    And user open page yelo page: /fleet/categories/sedan-and-compact
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath
    And user open page yelo page: /fleet/categories/suv-and-crossover
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath
    And user open page yelo page: /fleet/categories/electric
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath
    And user open page yelo page: /fleet/categories/luxury
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath
    And user open page yelo page: /fleet/categories/family
    And verify element present: yelo.category.sliderImg.byxpath
    And verify element present: yelo.category.searchCarForm.byxpath
    And verify element present: yelo.category.title.byxpath
    And verify element present: yelo.category.paragraph.byxpath
    And verify element present: yelo.category.discoverOurFleetImg.byxpath
    And verify element present: yelo.category.discoverOurFleetTitle.byxpath
    And verify element present: yelo.category.discoverOurFleetP.byxpath
    And verify element present: yelo.category.discoverOurFleet.button.byxpath


#  @TestType-Regression
#  Scenario: verify small cars category
#    Given user open website page: yelo
#    And click on element: yelo.category.smallcars.homeLink.byxpath
#    And verify element present: yelo.category.smallcars.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.smallcars.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.smallcars.firstSectionParag.text
#    And compare list of elements text: yelo.category.subCategory.byxpath with text: yelo.category.smallcars.subCategory.text
#    And verify element present: yelo.category.economy.subCategory.smallImg.byxpath
#    And verify element present: yelo.category.subCategory.largeImg.byxpath
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.smallcars.featuredCard.smallImg.byxpath
#    And verify element text present: yelo.category.featuredCard.title.byxpath with text: yelo.category.smallcars.featuredCard.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
#
#
#
#  @TestType-Regression
#  Scenario: verify sedan & compact category
#    Given user open website page: yelo
#    And click on element: yelo.category.sedan.homeLink.byxpath
#    And verify element present: yelo.category.sedan.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.sedan.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.sedan.firstSectionParag.text
#    And compare list of elements text: yelo.category.subCategory.byxpath with text: yelo.category.sedan.subCategory.text
#    And verify count of element: yelo.category.sedan.subCategory.smallImg.byxpath equals: 4
#    And verify count of element: yelo.category.sedan.subCategory.largeImg.byxpath equals: 4
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
#
#
#  @TestType-Regression
#  Scenario: verify SUV & Crossover category
#    Given user open website page: yelo
#    And click on element: yelo.category.crossOver.homeLink.byxpath
#    And verify element present: yelo.category.crossOver.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.crossOver.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.crossOver.firstSectionParag.text
#    And compare list of elements text: yelo.category.subCategory.byxpath with text: yelo.category.crossOver.subCategory.text
#    And verify count of element: yelo.category.crossOver.subCategory.smallImg.byxpath equals: 6
#    And verify count of element: yelo.category.crossOver.subCategory.largeImg.byxpath equals: 6
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
#
#
#  @TestType-Regression
#  Scenario: verify electric category
#    Given user open website page: yelo
#    And click on element: yelo.category.electric.homeLink.byxpath
#    And verify element present: yelo.category.electric.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.electric.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.electric.firstSectionParag.text
#    And verify element text present: yelo.category.subCategory.byxpath with text: yelo.category.electric.subCategory.text
#    And verify count of element: yelo.category.electric.subCategory.smallImg.byxpath equals: 1
#    And verify count of element: yelo.category.electric.subCategory.largeImg.byxpath equals: 1
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
#
#
#
#  @TestType-Regression
#  Scenario: verify luxury category
#    Given user open website page: yelo
#    And click on element: yelo.category.luxury.homeLink.byxpath
#    And verify element present: yelo.category.luxury.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.luxury.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.luxury.firstSectionParag.text
#    And compare list of elements text: yelo.category.subCategory.byxpath with text: yelo.category.luxury.subCategory.text
#    And verify count of element: yelo.category.luxury.subCategory.smallImg.byxpath equals: 5
#    And verify count of element: yelo.category.luxury.subCategory.largeImg.byxpath equals: 5
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
#
#
#  @TestType-Regression
#  Scenario: verify family category
#    Given user open website page: yelo
#    And click on element: yelo.category.family.homeLink.byxpath
#    And verify element present: yelo.category.family.mainImg.byxpath
#    And verify element text present: yelo.category.firstSection.byxpath with text: yelo.category.family.firstSection.text
#    And verify element text present: yelo.category.firstSectionParag.byxpath with text: yelo.category.family.firstSectionParag.text
#    And compare list of elements text: yelo.category.subCategory.byxpath with text: yelo.category.family.subCategory.text
#    And verify count of element: yelo.category.family.subCategory.smallImg.byxpath equals: 5
#    And verify count of element: yelo.category.family.subCategory.largeImg.byxpath equals: 5
#    And verify element text present: yelo.category.featuredCars.title.byxpath with text: yelo.category.featuredCars.title.text
#    And verify element present: yelo.category.featuredCard.largeImg.byxpath
#    And verify element present: yelo.category.featuredCard.dealName.byxpath
#    And verify element text present: yelo.category.featuredCard.bookNow.byxpath with text: yelo.category.featuredCard.bookNow.text
#    And verify element present: yelo.category.featuredCard.newPrice.byxpath
#    And verify element present: yelo.category.footerImg.byxpath
#    And verify element text present: yelo.category.footerTitle.byxpath with text: yelo.category.footerTitle.text
#    And verify element text present: yelo.category.footerTitleDesc.byxpath with text: yelo.category.footerTitleDesc.text
#    And verify element text present: yelo.category.discoverFleetBtn.byxpath with text: yelo.category.discoverFleetBtn.text
#    And verify element present: yelo.category.discoverFleetImg.byxpath
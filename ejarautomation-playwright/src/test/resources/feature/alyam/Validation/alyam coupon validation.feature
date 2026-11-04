Feature: Alyam Coupon Validation


  @TestType-Regression
  Scenario: validate and verify coupon - open ejar create new offer - create new booking with coupon - verify removing coupon and entering again - then disable offer
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: admin and password: 123456 url:  /app/rental/contracts
    And create offer from ejar discount on trip days with percentage: 25 and store promoCode in variable: promoCode the store offer name in variable: offerName
    And user open website page: alyam
    And login to yelo site with user: alyamqoadautomation@qoad.com and password: Alyam123456
    And cancel all bookings if exist on yelo sequentially
    And click on element: yelo.homepage.searchLocation.input.byxpath
    And select branch in home page in yelo: Automation Branch,Automation Branch
    And user set date time V2 in yelo pickup field plus days: 8 and time: 1:30 pm
    And user set date time V2 in yelo return field plus days: 9 and time: 1:30 pm
    And click on link: yelo.homepage.vehicle.search.button.byxpath
    And click on link: yelo.pay.book-now.button.byxpath
    And click on action if exist: yelo.pay.confirm.button.byxpath
    And scroll by pixcels horizontally: 0 and vertically: -800
    And click on link: yelo.pay.paylater.button.byxpath
    And click on link: yelo.pay.confirmpaytype.byxpath
    And store element value: yelo.termsConditions.netAmount.byxpath and value name: OldNetAmount and keep number only: true
    And store element value: yelo.termsConditions.totalAmount.byxpath and value name: TotalAmount and keep number only: true
    And enter promo code from variable: promoCode in field: yelo.termsConditions.couponCode.byxpath and apply button: yelo.termsConditions.couponCodeApply-enabled.byxpath
    And click on element: yelo.termsConditions.couponCodeRemove-visible.byxpath
    And check element not contains ar contains empty value: yelo.termsConditions.couponCode.byxpath for attribute: disabled
    And check element not contains ar contains empty value: yelo.termsConditions.couponCode.byxpath for attribute: value
    And verify element not present: yelo.termsConditions.couponCodeApply-enabled.byxpath within time of seconds: 5 and status: visible
    And verify element not present: yelo.termsConditions.couponCodeApplyCheck-enabled.byxpath within time of seconds: 5 and status: visible
    And verify element not present: yelo.termsConditions.couponCodeRemove-visible.byxpath within time of seconds: 1 and status: present
    And verify element not present: yelo.termsConditions.couponCodeSuccessSection-visible.byxpath within time of seconds: 1 and status: present
    And enter promo code from variable: promoCode in field: yelo.termsConditions.couponCode.byxpath and apply button: yelo.termsConditions.couponCodeApply-enabled.byxpath
    And store element value: yelo.termsConditions.netAmount.byxpath and value name: NewNetAmount and keep number only: true
    And store element value: yelo.termsConditions.discount.byxpath and value name: NewDiscount and keep number only: true
    And validate new amount after discount: 25
    And validate new discount
    And click on link: yelo.pay.agreebookingconditions.button.byxpath
    And click on link: yelo.pay.SaveBooking.button.byxpath
    And cancel latest booking if exist on yelo with assertion and page refresh
    And change execution project to: ejar
    And disable offer with the name stored in variable: offerName

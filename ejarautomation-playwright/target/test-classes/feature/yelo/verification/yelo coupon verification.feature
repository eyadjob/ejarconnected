#commented because it needs specific data (coupon)

#Feature: Coupon Verification
#
#  @TestType-Regression
#  Scenario: verify coupon fields not present without clicking on apply coupon then apply coupon
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerudyfzfiqat@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomerudyfzfiqat@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 2 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 3 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -800
#    And click on link: yelo.pay.paylater.button.byxpath
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And verify element present: yelo.termsConditions.couponCodelbl.byxpath
#    And verify element present: yelo.termsConditions.couponCode.byxpath
#    And verify element not present: yelo.termsConditions.couponCodeApply-enabled.byxpath within time of seconds: 5 and status: visible
#    And verify element not present: yelo.termsConditions.couponCodeSuccessSection-visible.byxpath within time of seconds: 1 and status: present
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And verify element present: yelo.termsConditions.couponCodeApplyCheck-enabled.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And verify element: yelo.termsConditions.couponCode.byxpath attribute: disabled contains value: disabled is: true
#    And verify element not present: yelo.termsConditions.couponCodeApply-enabled.byxpath within time of seconds: 5 and status: visible
#    And verify element present: yelo.termsConditions.couponCodeRemove-visible.byxpath
#    And verify element present: yelo.termsConditions.couponCodeSuccessSection-visible.byxpath
#    And verify element present: yelo.termsConditions.couponCodeSuccessCheck.byxpath
#    And verify element present: yelo.termsConditions.validCouponCode.byxpath
#    And verify element present: yelo.termsConditions.couponBenefits.byxpath
#    And verify element text present: yelo.termsConditions.couponofferDetails.byxpath with text: yelo.termsConditions.couponofferDetails.text
#
#

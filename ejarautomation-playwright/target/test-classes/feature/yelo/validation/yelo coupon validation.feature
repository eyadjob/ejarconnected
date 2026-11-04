Feature: Yelo Coupon Validation


#  @TestType-Regression
#  Scenario: validate and verify coupon removal coupon - discount - create booking
#    Given user open website page: yelo
#    And login to yelo site with user: EyadYeloRegressionTestCustomerluscufvvou@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomerluscufvvou@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: Automation Branch,Automation Branch
#    And user set date time V2 in yelo pickup field plus days: 8 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 9 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -800
#    And click on link: yelo.pay.paylater.button.byxpath
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And store element value: yelo.termsConditions.netAmount.byxpath and value name: OldNetAmount and keep number only: true
#    And store element value: yelo.termsConditions.totalAmount.byxpath and value name: TotalAmount and keep number only: true
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And click on element: yelo.termsConditions.couponCodeRemove-visible.byxpath
#    And check element not contains ar contains empty value: yelo.termsConditions.couponCode.byxpath for attribute: disabled
#    And check element not contains ar contains empty value: yelo.termsConditions.couponCode.byxpath for attribute: value
#    And verify element not present: yelo.termsConditions.couponCodeApply-enabled.byxpath within time of seconds: 5 and status: visible
#    And verify element not present: yelo.termsConditions.couponCodeApplyCheck-enabled.byxpath within time of seconds: 5 and status: visible
#    And verify element not present: yelo.termsConditions.couponCodeRemove-visible.byxpath within time of seconds: 1 and status: present
#    And verify element not present: yelo.termsConditions.couponCodeSuccessSection-visible.byxpath within time of seconds: 1 and status: present
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And store element value: yelo.termsConditions.netAmount.byxpath and value name: NewNetAmount and keep number only: true
#    And store element value: yelo.termsConditions.discount.byxpath and value name: NewDiscount and keep number only: true
#    And validate new amount after discount: 25
#    And validate new discount
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    Then cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomerluscufvvou@yelo.com

#  @TestType-Regression
#  Scenario: validate coupon - create booking - wrong branch
#    Given user open page yelo page: /Home
#    And login to yelo site with user: EyadYeloRegressionTestCustomerluscufvvou@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomerluscufvvou@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And wait for number of seconds: 7
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -250
#    And click on link: yelo.pay.paylnow.button.byxpath
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And verify element text present: yelo.termsConditions.couponCodeError.byxpath with text: yelo.termsConditions.couponCode.notMatchError.text
#
#  @TestType-Regression
#  Scenario: validate coupon - create two bookings - single coupon
#    Given user open page yelo page: /Home
#    And login to yelo site with user: EyadYeloRegressionTestCustomerluscufvvou@yelo.com and password: Yelo123456
#    And cancel latest booking if exist on yelo by user email: EyadYeloRegressionTestCustomerluscufvvou@yelo.com
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#    And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And wait for number of seconds: 7
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -350
#    And click on link: yelo.pay.paylnow.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: 350
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And user scroll to element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    And user scroll to the top of the page
#    And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#    And click on link: yelo.pay.SubmitPayment.button.byxpath
#    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: FirstBookingNumberInConfirmationTabWithText and keep number only: false
#    And user open page yelo page: /Home
#    And click on element: yelo.homepage.searchLocation.input.byxpath
#    And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#    And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
#    And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
#    And click on link: yelo.homepage.vehicle.search.button.byxpath
#    And wait for number of seconds: 7
#    And click on link: yelo.pay.book-now.button.byxpath
#    And click on action if exist: yelo.pay.confirm.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: -350
#    And click on link: yelo.pay.paylnow.button.byxpath
#    And scroll by pixcels horizontally: 0 and vertically: 350
#    And click on link: yelo.pay.confirmpaytype.byxpath
#    And user enter value of property: yelo.termsConditions.singleCouponValue.text in field : yelo.termsConditions.couponCode.byxpath
#    And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#    And click on link: yelo.pay.agreebookingconditions.button.byxpath
#    And click on link: yelo.pay.SaveBooking.button.byxpath
#    And user scroll to the top of the page
#    And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#    And click on link: yelo.pay.SubmitPayment.button.byxpath
#    And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#    And click on link: yelo.pay.GetBookingContentView.button.byxpath
#    And store element value: yelo.booking.confirmation.id.byxpath and value name: SecondBookingNumberInConfirmationTabWithText and keep number only: false
#    Then cancel latest booking if exist on yelo by user email: alwefaqsilvermembership2@gmail.com
#
#
#  #@TestType-Regression
#  #Scenario: validate multi coupon - create booking
#  #  Given user open page yelo page: /Home
#  #  And login to yelo site with user: EyadYeloRegressionTestCustomerluscufvvou@yelo.com and password: Yelo123456
#  #  And click on element: yelo.homepage.searchLocation.input.byxpath
#  #  And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#  #  And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#  #  And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
#  #  And click on link: yelo.homepage.vehicle.search.button.byxpath
#  #  And wait for number of seconds: 7
#  #  And click on link: yelo.pay.book-now.button.byxpath
#  #  And click on action if exist: yelo.pay.confirm.button.byxpath
#  #  And scroll by pixcels horizontally: 0 and vertically: -250
#  #  And click on link: yelo.pay.paylnow.button.byxpath
#  #  And click on link: yelo.pay.confirmpaytype.byxpath
#  #  And store element value: yelo.termsConditions.netAmount.byxpath and value name: OldNetAmount and keep number only: true
#  #  And store element value: yelo.termsConditions.totalAmount.byxpath and value name: TotalAmount and keep number only: true
#  #  And user enter value of property: yelo.termsConditions.multiCouponFirstValue.text in field : yelo.termsConditions.couponCode.byxpath
#  #  And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#  #  And store element value: yelo.termsConditions.netAmount.byxpath and value name: NewNetAmount and keep number only: true
#  #  And store element value: yelo.termsConditions.discount.byxpath and value name: NewDiscount and keep number only: true
#  #  And validate new new amount: 25
#  #  And validate new discount
#  #  And click on link: yelo.pay.agreebookingconditions.button.byxpath
#  #  And click on link: yelo.pay.SaveBooking.button.byxpath
#  #  And user scroll to the top of the page
#  #  And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#  #  And click on link: yelo.pay.SubmitPayment.button.byxpath
#  #  And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#  #  And click on link: yelo.pay.GetBookingContentView.button.byxpath
#  #  Then cancel latest booking if exist on yelo
#
#  #@TestType-Regression
#  #Scenario: validate multi coupon - two bookings - create booking
#  #  Given user open page yelo page: /Home
#  #  And login to yelo site with user: EyadYeloRegressionTestCustomerluscufvvou@yelo.com and password: Yelo123456
#  #  And click on element: yelo.homepage.searchLocation.input.byxpath
#  #  And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#  #  And user set date time V2 in yelo pickup field plus days: 1 and time: 01:30 pm
#  #  And user set date time V2 in yelo return field plus days: 2 and time: 01:30 pm
#  #  And click on link: yelo.homepage.vehicle.search.button.byxpath
#  #  And wait for number of seconds: 7
#  #  And click on link: yelo.pay.book-now.button.byxpath
#  #  And click on action if exist: yelo.pay.confirm.button.byxpath
#  #  And scroll by pixcels horizontally: 0 and vertically: -250
#  #  And click on link: yelo.pay.paylnow.button.byxpath
#  #  And click on link: yelo.pay.confirmpaytype.byxpath
#  #  And user enter value of property: yelo.termsConditions.multiCouponSecondValue.text in field : yelo.termsConditions.couponCode.byxpath
#  #  And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#  #  And click on link: yelo.pay.agreebookingconditions.button.byxpath
#  #  And click on link: yelo.pay.SaveBooking.button.byxpath
#  #  And user scroll to the top of the page
#  #  And fill credit card info in yelo fill name: Eyad and card number: 5297412542005689 and ccv: 350 and expire date: 05/23
#  #  And click on link: yelo.pay.SubmitPayment.button.byxpath
#  #  And verify element text present: yelo.payment-common.error.byxpath with text: yelo.payment-success-message.text
#  #  And click on link: yelo.pay.GetBookingContentView.button.byxpath
#  #  And user open page yelo page: /Home
#  #  And click on element: yelo.homepage.searchLocation.input.byxpath
#  #  And select branch in home page in yelo: King Khalid Airport Terminal 2 - Riyadh,مطار الملك خالد الصالة 2 - الرياض
#  #  And user set date time V2 in yelo pickup field plus days: 3 and time: 01:30 pm
#  #  And user set date time V2 in yelo return field plus days: 4 and time: 01:30 pm
#  #  And click on link: yelo.homepage.vehicle.search.button.byxpath
#  #  And wait for number of seconds: 7
#  #  And click on link: yelo.pay.book-now.button.byxpath
#  #  And click on action if exist: yelo.pay.confirm.button.byxpath
#  #  And scroll by pixcels horizontally: 0 and vertically: -250
#  #  And click on link: yelo.pay.paylnow.button.byxpath
#  #  And click on link: yelo.pay.confirmpaytype.byxpath
#  #  And user enter value of property: yelo.termsConditions.multiCouponSecondValue.text in field : yelo.termsConditions.couponCode.byxpath
#  #  And click on element: yelo.termsConditions.couponCodeApply-enabled.byxpath
#  #  And verify element text present: yelo.termsConditions.couponCodeError.byxpath with text: yelo.termsConditions.couponCode.expiredError.text
#  #  Then cancel latest booking if exist on yelo

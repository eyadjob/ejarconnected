Feature: Extend Existing Data Verification

  @TestType-Smoke
  Scenario: Edit existing individual booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
#     And change ejar branch: ejar.secondBranch then navigate to: /app/rental/bookings
    And open page using url: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 50
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 50
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.editbooking.more.a.byxpath
    And click on element: ejar.editbooking.edit.a.byxpath
    And wait for element present: ejar.editbooking.dropOffDate.input.byxpath for period in seconds: 60
    And store date dynamically from the attribute input in field: ejar.editbooking.dropOffDate.input.byxpath and add days: 5 with time: 10:00 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Booking,الحجز                                            | h1      |
      | Edit Booking,تعديل حجز                                   | span    |
      | Booking Details,تفاصيل الحجز                             | div     |
      | Vehicle,المركبة                                          | div     |
      | Extras,الاضافات                                           | div     |
      | Payment,الدفع                                            | div     |
      | Countries,الدول                                          | label   |
      | Pick-up & Return,الإستلام و التسليم                        | label   |
      | Return at pickup location,التسليم مكان الإستلام            | label   |
      | Pick-up Date,وقت الخروج                                  | label   |
      | Drop-off Date,وقت العودة                                 | label   |
      | External authorization,تفويض خارجي                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbooking.country.field.read.byxpath                           | false      | false      |
      | ejar.editbooking.returnAtPickup.field.edit.byxpath                    | true       | false      |
      | ejar.editbooking.pickupAndReturn.field.edit.byxpath                   | true       | true       |
      | ejar.editbooking.pickupDate.field.edit.byxpath                        | true       | true       |
      | ejar.editbooking.DropOffDate.field.edit.byxpath                       | true       | true       |
      | ejar.editbooking.externalAuthorization.field.edit.byxpath             | true       | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.editbooking.next1.button.byxpath                                 | true       | false      |
    And click on element: ejar.editbooking.next1.button.byxpath
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Categories,الفئات                                        | label   |
      | Models,الموديلات                                          | label   |
      | Years,السنوات                                            | label   |
      | Rental Rate:,سعر تأجير:                                  | label   |
      | Extra KM Rate:,سعر الكم الزائد:                          | label   |
      | Free KM:,الكم المجاني:                                   | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbooking.categories.field.edit.byxpath                        | true       | true       |
      | ejar.editbooking.models.field.edit.byxpath                            | true       | true       |
      | ejar.editbooking.years.field.edit.byxpath                             | true       | true       |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.editbooking.next2.button.byxpath                                 | true       | false      |
      | ejar.editbooking.back1.field.edit.byxpath                             | true       | false      |
    And click on element: ejar.editbooking.next2.button.byxpath
    And click on action if exist with wait: ejar.editbooking.extrasPopUp.button.byxpath waiting number of seconds: 10
    And click on element: ejar.editbooking.next3.button.byxpath
    And wait for element present: ejar.closecontract.paymentDetailsSection.li.byxpath for period in seconds: 30
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Item,البند                                                                  | span    |
      | Quantity,الكمية                                                             | span    |
      | Unit,الوحدة                                                                 | span    |
      | Unit Price,سعر الوحدة                                                       | span    |
      | Amount,التكلفة                                                              | span    |
      | Discount %,خصم %                                                            | span    |
      | Discount Amount,مبلغ الخصم                                                  | span    |
      | Tax %,الضريبة %                                                             | span    |
      | Tax Amount,قيمة الضريبة                                                     | span    |
      | Net Price,السعر الكلي                                                       | span    |
      | Payments details for the current operation,البيانات المالية للعملية الحالية | li      |
      | Type:,النوع:                                                                | label   |
      | Transaction Type:,نوع الإجراء:                                               | label   |
      | Date:,التاريخ:                                                              | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Driver Information,معلومات السائق                                           | span    |
      | Name:,الاسم:                                                                 | label   |
      | Identity number:,رقم الإثبات:                                                | label   |
      | Phone number:,رقم الجوال:                                                   | label   |
      | Vehicle,المركبة                                                             | span    |
      | Category:,الفئة:                                                            | label   |
      | Model:,الموديل:                                                             | label   |
      | Manufacturing Year:,سنة الصنع:                                              | label   |
      | Financial,المالية                                                           | span    |
      | Remaining:,المتبقي:                                                         | label   |
      | Voucher Amount:,قيمة السند:                                                 | label   |
      | Comment,الملاحظه                                                             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbooking.type.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.transactionType.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.date.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.paid.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.netAmount.field.read.byxpath                         | false      | false      |
      | ejar.editbooking.summaryName.field.read.byxpath                       | false      | false      |
      | ejar.editbooking.summaryIdentity.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.summaryPhone.field.read.byxpath                      | false      | false      |
      | ejar.editbooking.summaryCategory.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.summaryModel.field.read.byxpath                      | false      | false      |
      | ejar.editbooking.summaryManufacturingYear.field.read.byxpath          | false      | false      |
      | ejar.editbooking.summaryNetAmount.field.read.byxpath                  | false      | false      |
      | ejar.editbooking.summaryPaid.field.read.byxpath                       | false      | false      |
      | ejar.editbooking.remaining.field.byxpath                              | false      | false      |
      | ejar.editbooking.summaryComment.field.edit.byxpath                    | true       | false      |
      | ejar.editbooking.back3.button.edit.byxpath                            | true       | false      |
      | ejar.generic.save.action.byxpath                                      | true       | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And click on link: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 80
    And store ejar element value: ejar.editbooking.checkDate.td.byxpath and value name: actualDate and keep number only: false
    And compare expected from stored variable: expectedDate with actual variable: actualDate

  @TestType-Smoke
  Scenario: Edit existing broker booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 60
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسيط
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 60
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.editbooking.more.a.byxpath
    And click on element: ejar.editbooking.edit.a.byxpath
    And wait for element present: ejar.editbooking.dropOffDate.input.byxpath for period in seconds: 80
    And store date dynamically from the attribute input in field: ejar.editbooking.dropOffDate.input.byxpath and add days: 10 with time: 10:00 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Broker Booking,حجز وسيط                                  | h1      |
      | Edit Booking,تعديل حجز                                   | span    |
      | Booking Details,تفاصيل الحجز                             | div     |
      | Vehicle,المركبة                                          | div     |
      | Extras,الاضافات                                           | div     |
      | Payment,الدفع                                            | div     |
      | Countries,الدول                                          | label   |
      | Broker Booking Reference No,رقم الحجز من الوسيط          | label   |
      | Product Code,رمز المنتج                                  | label   |
      | Pick-up Branch,فرع الخروج                                | label   |
      | Drop-off Branch,فرع العودة                               | label   |
      | Pick-up Date,وقت الخروج                                  | label   |
      | Drop-off Date,وقت العودة                                 | label   |
      | External authorization,تفويض خارجي                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbrokerbooking.country.field.read.byxpath                     | false      | false      |
      | ejar.editbrokerbooking.brokerRefNo.field.read.byxpath                 | false      | false      |
      | ejar.editbrokerbooking.productCode.field.read.byxpath                 | false      | false      |
      | ejar.editbrokerbooking.pickupBranch.field.read.byxpath                | true       | true       |
      | ejar.editbrokerbooking.dropOffBranch.field.read.byxpath               | true       | true       |
      | ejar.editbrokerbooking.pickupDate.field.edit.byxpath                  | true       | true       |
      | ejar.editbrokerbooking.DropOffDate.field.edit.byxpath                 | true       | true       |
      | ejar.editbrokerbooking.externalAuthorization.field.edit.byxpath       | false      | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.editbooking.next1.button.byxpath                                 | true       | false      |
    And click on element: ejar.editbooking.next1.button.byxpath
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Categories,الفئات                                        | label   |
      | Models,الموديلات                                          | label   |
      | Years,السنوات                                            | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbrokerbooking.categories.field.edit.byxpath                  | true       | true       |
      | ejar.editbrokerbooking.models.field.edit.byxpath                      | true       | true       |
      | ejar.editbrokerbooking.years.field.edit.byxpath                       | true       | true       |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.editbooking.next2.button.byxpath                                 | true       | false      |
      | ejar.editbooking.back1.field.edit.byxpath                             | true       | false      |
    And click on element: ejar.editbooking.next2.button.byxpath
    And click on action if exist with wait: ejar.editbooking.extrasPopUp.button.byxpath waiting number of seconds: 10
    And click on element: ejar.editbooking.next3.button.byxpath
    And wait for element present: ejar.closecontract.paymentDetailsSection.li.byxpath for period in seconds: 90
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Item,البند                                                                  | span    |
      | Quantity,الكمية                                                             | span    |
      | Unit,الوحدة                                                                 | span    |
      | Unit Price,سعر الوحدة                                                       | span    |
      | Amount,التكلفة                                                              | span    |
      | Discount %,خصم %                                                            | span    |
      | Discount Amount,مبلغ الخصم                                                  | span    |
      | Tax %,الضريبة %                                                             | span    |
      | Tax Amount,قيمة الضريبة                                                     | span    |
      | Net Price,السعر الكلي                                                       | span    |
      | Payments details for the current operation,البيانات المالية للعملية الحالية | li      |
      | Type:,النوع:                                                                | label   |
      | Transaction Type:,نوع الإجراء:                                               | label   |
      | Date:,التاريخ:                                                              | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Driver Information,معلومات السائق                                           | span    |
      | Name:,الاسم:                                                                 | label   |
      | Identity number:,رقم الإثبات:                                                | label   |
      | Phone number:,رقم الجوال:                                                   | label   |
      | Vehicle,المركبة                                                             | span    |
      | Category:,الفئة:                                                            | label   |
      | Model:,الموديل:                                                             | label   |
      | Manufacturing Year:,سنة الصنع:                                              | label   |
      | Financial,المالية                                                           | span    |
      | Remaining:,المتبقي:                                                         | label   |
      | Comment,الملاحظه                                                             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.editbooking.type.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.transactionType.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.date.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.paid.field.read.byxpath                              | false      | false      |
      | ejar.editbooking.netAmount.field.read.byxpath                         | false      | false      |
      | ejar.editbooking.summaryName.field.read.byxpath                       | false      | false      |
      | ejar.editbooking.summaryIdentity.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.summaryPhone.field.read.byxpath                      | false      | false      |
      | ejar.editbooking.summaryCategory.field.read.byxpath                   | false      | false      |
      | ejar.editbooking.summaryModel.field.read.byxpath                      | false      | false      |
      | ejar.editbooking.summaryManufacturingYear.field.read.byxpath          | false      | false      |
      | ejar.editbooking.summaryNetAmount.field.read.byxpath                  | false      | false      |
      | ejar.editbooking.summaryPaid.field.read.byxpath                       | false      | false      |
      | ejar.editbooking.remaining.field.byxpath                              | false      | false      |
      | ejar.editbooking.summaryComment.field.edit.byxpath                    | true       | false      |
      | ejar.editbooking.back3.button.edit.byxpath                            | true       | false      |
      | ejar.generic.save.action.byxpath                                      | true       | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And click on link: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.editbooking.more.a.byxpath for period in seconds: 80
    And store ejar element value: ejar.editbooking.checkDate.td.byxpath and value name: actualDate and keep number only: false
    And compare expected from stored variable: expectedDate with actual variable: actualDate

  @TestType-Smoke
  Scenario: Extend existing individual contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/contracts
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.extendcontract.extendContract.a.byxpath
    And click on action if exist with wait: ejar.closecontract.continueComment.button.byxpath waiting number of seconds: 5
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.extendcontract.driverAuthorization.kendooption.byxpath option: Internal Authorization,تفويض داخلي
    And click on element: ejar.extendcontract.skipAuthorization.checkbox.byxpath
    And set minimum odometer value into field: ejar.extendcontract.odometer.input.byxpath with wait for camera: 2
    And store date dynamically from the attribute input in field: ejar.extendcontract.dropOffDate.input.byxpath and add days: 10 with time: 10:00 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Extend Contract,تمديد عقد                                                   | h1      |
      | Contract,العقد                                                              | span    |
      | Extend Contract Information,بيانات تمديد العقد                              | div     |
      | Payment Details,البيانات المالية                                            | div     |
      | Pick-up Branch,فرع الخروج                                                   | label   |
      | Pick-up Date,وقت الخروج                                                     | label   |
      | Odometer Out,كم الخروج                                                      | label   |
      | Drop-off Branch,فرع العودة                                                  | label   |
      | Drop-off Date,وقت العودة                                                    | label   |
      | Is Vehicle Available?,بوجود المركبة؟                                        | span    |
      | Current Odometer,الكم الحالي                                                | label   |
      | Driver Authorization,تفويض السائق                                           | label   |
      | Skip Internal Authorization,تخطى التفويض الداخلي                            | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.closecontract.pickupBranch.label.read.byxpath                    | false      | false      |
      | ejar.closecontract.pickupDate.label.read.byxpath                      | false      | false      |
      | ejar.closecontract.odometerOut.label.read.byxpath                     | false      | false      |
      | ejar.extendcontract.dropOffBranch.field.edit.byxpath                  | true       | true       |
      | ejar.extendcontract.dropOffDate.field.edit.byxpath                    | true       | true       |
      | ejar.extendcontract.isVehicleAvailable.field.edit.byxpath             | true       | false      |
      | ejar.extendcontract.odometer.input.byxpath                            | true       | true       |
      | ejar.extendcontract.next1.button.byxpath                              | true       | false      |
      | ejar.extendcontract.skipAuthorization.checkbox.byxpath                | false      | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And click on element: ejar.extendcontract.next1.button.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Extend Contract,تمديد عقد                                                   | h1      |
      | Item,البند                                                                  | span    |
      | Quantity,الكمية                                                             | span    |
      | Unit,الوحدة                                                                 | span    |
      | Unit Price,سعر الوحدة                                                       | span    |
      | Amount,التكلفة                                                              | span    |
      | Discount %,خصم %                                                            | span    |
      | Discount Amount,مبلغ الخصم                                                  | span    |
      | Tax %,الضريبة %                                                             | span    |
      | Tax Amount,قيمة الضريبة                                                     | span    |
      | Net Price,السعر الكلي                                                       | span    |
      | Payments details for the current operation,البيانات المالية للعملية الحالية | li      |
      | Type:,النوع:                                                                | label   |
      | Transaction Type:,نوع الإجراء:                                               | label   |
      | Date:,التاريخ:                                                              | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Customer Information,بيانات العميل                                          | span    |
      | Loyalty:,العضويات:                                                          | label   |
      | Organization:,الشركة:                                                       | label   |
      | Email:,البريد الإلكتروني:                                                    | label   |
      | Phone:,الهاتف:                                                              | label   |
      | VIP :,كبار العملاء :                                                         | label   |
      | Vehicle,المركبة                                                             | span    |
      | Plate Number:,رقم اللوحة:                                                   | label   |
      | Category:,الفئة:                                                            | label   |
      | Model:,الموديل:                                                             | label   |
      | Rental Rate:,سعر تأجير:                                                     | label   |
      | Financial,المالية                                                           | span    |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Remaining:,المتبقي:                                                         | label   |
      | Comment,الملاحظه                                                             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.closecontract.type.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath                 | false      | false      |
      | ejar.closecontract.date.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath                       | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath                  | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath                 | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryRentalRate.field.read.byxpath               | false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath                | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.remaining.field.byxpath                            | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath                  | true       | false      |
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.extendcontract.modal.field.byxpath for period in seconds: 100
    And click on action if exist: ejar.extendcontract.ratingDialog.firstStar.byxpath
    And click on action if exist: ejar.extendcontract.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.extendcontract.cancelPrint.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 150
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And store ejar element value: ejar.extendcontract.dropOffDateActual.div.byxpath and value name: actualDate and keep number only: false
    And compare expected from stored variable: expectedDate with actual variable: actualDate


  @TestType-Smoke
  Scenario: Extend existing Broker spot contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/contracts
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسطاء
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.extendcontract.extendContract.a.byxpath
    And click on action if exist with wait: ejar.closecontract.continueComment.button.byxpath waiting number of seconds: 5
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.extendcontract.driverAuthorization.kendooption.byxpath option: Internal Authorization,تفويض داخلي
    And click on element: ejar.extendcontract.skipAuthorization.checkbox.byxpath
    And set minimum odometer value into field: ejar.extendcontract.odometer.input.byxpath with wait for camera: 2
    And store date dynamically from the attribute input in field: ejar.extendcontract.dropOffDate.input.byxpath and add days: 10 with time: 10:00 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Extend Contract,تمديد عقد                                                   | h1      |
      | Contract,العقد                                                              | span    |
      | Extend Contract Information,بيانات تمديد العقد                              | div     |
      | Payment Details,البيانات المالية                                            | div     |
      | Pick-up Branch,فرع الخروج                                                   | label   |
      | Pick-up Date,وقت الخروج                                                     | label   |
      | Odometer Out,كم الخروج                                                      | label   |
      | Drop-off Branch,فرع العودة                                                  | label   |
      | Drop-off Date,وقت العودة                                                    | label   |
      | Is Vehicle Available?,بوجود المركبة؟                                        | span    |
      | Current Odometer,الكم الحالي                                                | label   |
      | Driver Authorization,تفويض السائق                                           | label   |
      | Skip Internal Authorization,تخطى التفويض الداخلي                            | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.closecontract.pickupBranch.label.read.byxpath                    | false      | false      |
      | ejar.closecontract.pickupDate.label.read.byxpath                      | false      | false      |
      | ejar.closecontract.odometerOut.label.read.byxpath                     | false      | false      |
      | ejar.extendcontract.dropOffBranch.field.edit.byxpath                  | true       | true       |
      | ejar.extendcontract.dropOffDate.field.edit.byxpath                    | true       | true       |
      | ejar.extendcontract.isVehicleAvailable.field.edit.byxpath             | true       | false      |
      | ejar.extendcontract.odometer.input.byxpath                            | true       | true       |
      | ejar.extendcontract.next1.button.byxpath                              | true       | false      |
      | ejar.extendcontract.skipAuthorization.checkbox.byxpath                | false      | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And click on element: ejar.extendcontract.next1.button.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Extend Contract,تمديد عقد                                                   | h1      |
      | Item,البند                                                                  | span    |
      | Quantity,الكمية                                                             | span    |
      | Unit,الوحدة                                                                 | span    |
      | Unit Price,سعر الوحدة                                                       | span    |
      | Amount,التكلفة                                                              | span    |
      | Discount %,خصم %                                                            | span    |
      | Discount Amount,مبلغ الخصم                                                  | span    |
      | Tax %,الضريبة %                                                             | span    |
      | Tax Amount,قيمة الضريبة                                                     | span    |
      | Net Price,السعر الكلي                                                       | span    |
      | Payments details for the current operation,البيانات المالية للعملية الحالية | li      |
      | Type:,النوع:                                                                | label   |
      | Transaction Type:,نوع الإجراء:                                               | label   |
      | Date:,التاريخ:                                                              | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Customer Information,بيانات العميل                                          | span    |
      | Loyalty:,العضويات:                                                          | label   |
      | Organization:,الشركة:                                                       | label   |
      | Email:,البريد الإلكتروني:                                                    | label   |
      | Phone:,الهاتف:                                                              | label   |
      | VIP :,كبار العملاء :                                                         | label   |
      | Vehicle,المركبة                                                             | span    |
      | Plate Number:,رقم اللوحة:                                                   | label   |
      | Category:,الفئة:                                                            | label   |
      | Model:,الموديل:                                                             | label   |
      | Rental Rate:,سعر تأجير:                                                     | label   |
      | Financial,المالية                                                           | span    |
      | Net Amount:,صافي القيمة:                                                    | label   |
      | Paid:,المدفوع:                                                              | label   |
      | Remaining:,المتبقي:                                                         | label   |
      | Comment,الملاحظه                                                             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.closecontract.type.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath                 | false      | false      |
      | ejar.closecontract.date.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath                            | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath                       | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath                  | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath                 | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryRentalRate.field.read.byxpath               | false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath                | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.remaining.field.byxpath                            | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath                  | true       | false      |
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.extendcontract.modal.field.byxpath for period in seconds: 100
    And click on action if exist: ejar.extendcontract.ratingDialog.firstStar.byxpath
    And click on action if exist: ejar.extendcontract.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.extendcontract.cancelPrint.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And store ejar element value: ejar.extendcontract.dropOffDateActual.div.byxpath and value name: actualDate and keep number only: false
    And compare expected from stored variable: expectedDate with actual variable: actualDate





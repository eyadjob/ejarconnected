Feature:Cancel Existing Data Verification


  @TestType-Smoke
  Scenario: Cancel existing Individual Spot contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And change free minutes to cancel value in country setting to: 2147483645
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 150
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 60
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.cancelcontract.cancelContract.a.byxpath
    And fill e-check form
    And change zoom level: 0.3
    And user click on element using java script executor: ejar.cancelcontract.next1.button.byxpath
    And change zoom level: 1
    And verify form page labels and text:
      | Text                                   | TagType |
      | Contract,العقد                         | h1      |
      | Cancel Contract,الغاء العقد            | span    |
      | Rental Check,تشيك السيارة              | div     |
      | Cancel Details,بيانات الالغاء           | div     |
      | Payment Details,البيانات المالية       | div     |
      | Pick-up Branch,فرع الخروج              | label   |
      | Pick-up Date,وقت الخروج                | label   |
      | Odometer Out,كم الخروج                 | label   |
      | Drop-off Branch,فرع العودة             | label   |
      | Drop-off Date,وقت العودة               | label   |
      | Fuel-Out,وقود الخروج                   | label   |
      | Adopted membership,العضوية المعتمدة    | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                               | isEditable | isRequired |
      | ejar.cancelcontract.pickupBranch.field.read.byxpath      | false      | false      |
      | ejar.cancelcontract.pickupDate.field.read.byxpath        | false      | false      |
      | ejar.cancelcontract.odometerOut.field.read.byxpath       | false      | false      |
      | ejar.cancelcontract.dropOffBranch.field.read.byxpath     | false      | false      |
      | ejar.cancelcontract.dropOffDate.field.edit.byxpath       | true       | true       |
      | ejar.cancelcontract.fuelOut.field.read.byxpath           | false      | false      |
      | ejar.cancelcontract.adoptedMembership.field.edit.byxpath | true       | false      |
      | ejar.cancelcontract.next2.button.byxpath                 | true       | false      |
      | ejar.cancelcontract.back1.button.byxpath                 | true       | false      |
      | ejar.generic.save.action.byxpath                         | true       | false      |
      | ejar.generic.cancel.action.byxpath                       | true       | false      |
    And click on element: ejar.cancelcontract.next2.button.byxpath
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And wait for element present: ejar.generic.save.action.byxpath for period in seconds: 90
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
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.closecontract.type.field.read.byxpath             | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath  | false      | false      |
      | ejar.closecontract.date.field.read.byxpath             | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath             | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath        | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath   | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath  | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryRentalRate.field.read.byxpath| false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath      | false      | false      |
      | ejar.closecontract.remaining.field.byxpath             | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath   | true       | false      |
      | ejar.generic.cancel.action.byxpath                     | true       | false      |
      | ejar.closecontract.save.button.byxpath                 | true       | false      |
      | ejar.cancelcontract.back2.button.byxpath               | true       | false      |
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 120
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 120
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 100
    And verify element present: ejar.assert.checkCancelled.field.byxpath

  @TestType-Smoke
  Scenario: Cancel existing broker booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/bookings
    And open page using url: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 150
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 60
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسيط
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 60
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.cancelbooking.more.a.byxpath
    And click on element: ejar.cancelbooking.cancel.a.byxpath
    And wait for element present: ejar.cancelbooking.reasonToCancel.droplist.byxpath for period in seconds: 100
    And verify form page labels and text:
      | Text                                   | TagType |
      | Booking,الحجز                          | h1      |
      | Cancel Booking,الغاء الحجز             | span    |
      | Number,الرقم                           | label   |
      | Created Date,تاريخ الإضافة              | label   |
      | Pick-up Date,وقت الخروج                | label   |
      | Customer Name,اسم العميل               | label   |
      | Mobile,الموبايل                        | label   |
      | Customer Email,البريد الالكتروني للعميل | label   |
      | Duration,المدة                         | label   |
      | Vehicle,المركبة                        | label   |
      | Cancel Reason,سبب الالغاء               | label   |
      | Net Amount,صافي القيمة                 | label   |
      | Paid Amount,المبلغ المدفوع             | label   |
      | Disbursement Amount,المبلغ المسترد     | label   |
      | Comment,الملاحظه                        | h5      |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                               | isEditable | isRequired |
      | ejar.cancelbooking.bookingNo.field.read.byxpath          | false      | false      |
      | ejar.cancelbooking.creationDate.field.read.byxpath       | false      | false      |
      | ejar.cancelbooking.pickupDate.field.read.byxpath         | false      | false      |
      | ejar.cancelbooking.customerName.field.read.byxpath       | false      | false      |
      | ejar.cancelbooking.mobile.field.read.byxpath             | false      | false      |
      | ejar.cancelbooking.customerEmail.field.read.byxpath      | false      | false      |
      | ejar.cancelbooking.duration.field.read.byxpath           | false      | false      |
      | ejar.cancelbooking.vehicle.field.read.byxpath            | false      | false      |
      | ejar.cancelbooking.cancelReason.field.edit.byxpath       | true       | false      |
      | ejar.cancelbooking.netAmount.field.read.byxpath          | false      | false      |
      | ejar.cancelbooking.paidAmount.field.read.byxpath         | false      | false      |
      | ejar.cancelbooking.disbursementAmount.field.read.byxpath | false      | false      |
      | ejar.generic.cancel.action.byxpath                       | true       | false      |
      | ejar.generic.save.action.byxpath                         | false      | false      |
    And user select option by text in ejar kendo option field without typing: ejar.cancelbooking.reasonToCancel.droplist.byxpath option: Canceled By System,تم الإلغاء بواسطة النظام
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And click on link: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.cancelbooking.more.a.byxpath for period in seconds: 150
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And verify element present: ejar.cancelbooking.checkCancelled.td.byxpath


  @TestType-Smoke
  Scenario: Cancel existing individual booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/bookings
    And open page using url: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.cancelbooking.more.a.byxpath for period in seconds: 150
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.cancelbooking.more.a.byxpath for period in seconds: 150
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And wait for element present: ejar.cancelbooking.more.a.byxpath for period in seconds: 150
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.cancelbooking.more.a.byxpath
    And click on element: ejar.cancelbooking.cancel.a.byxpath
    And wait for element present: ejar.cancelbooking.reasonToCancel.droplist.byxpath for period in seconds: 100
    And verify form page labels and text:
      | Text                                   | TagType |
      | Booking,الحجز                          | h1      |
      | Cancel Booking,الغاء الحجز             | span    |
      | Number,الرقم                           | label   |
      | Created Date,تاريخ الإضافة              | label   |
      | Pick-up Date,وقت الخروج                | label   |
      | Customer Name,اسم العميل               | label   |
      | Mobile,الموبايل                        | label   |
      | Customer Email,البريد الالكتروني للعميل | label   |
      | Duration,المدة                         | label   |
      | Vehicle,المركبة                        | label   |
      | Cancel Reason,سبب الالغاء               | label   |
      | Net Amount,صافي القيمة                 | label   |
      | Paid Amount,المبلغ المدفوع             | label   |
      | Disbursement Amount,المبلغ المسترد     | label   |
      | Comment,الملاحظه                        | h5      |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                               | isEditable | isRequired |
      | ejar.cancelbooking.bookingNo.field.read.byxpath          | false      | false      |
      | ejar.cancelbooking.creationDate.field.read.byxpath       | false      | false      |
      | ejar.cancelbooking.pickupDate.field.read.byxpath         | false      | false      |
      | ejar.cancelbooking.customerName.field.read.byxpath       | false      | false      |
      | ejar.cancelbooking.mobile.field.read.byxpath             | false      | false      |
      | ejar.cancelbooking.customerEmail.field.read.byxpath      | false      | false      |
      | ejar.cancelbooking.duration.field.read.byxpath           | false      | false      |
      | ejar.cancelbooking.vehicle.field.read.byxpath            | false      | false      |
      | ejar.cancelbooking.cancelReason.field.edit.byxpath       | true       | false      |
      | ejar.cancelbooking.netAmount.field.read.byxpath          | false      | false      |
      | ejar.cancelbooking.paidAmount.field.read.byxpath         | false      | false      |
      | ejar.cancelbooking.disbursementAmount.field.read.byxpath | false      | false      |
      | ejar.generic.cancel.action.byxpath                       | true       | false      |
      | ejar.generic.save.action.byxpath                         | false      | false      |
    And user select option by text in ejar kendo option field without typing: ejar.cancelbooking.reasonToCancel.droplist.byxpath option: Canceled By System,تم الإلغاء بواسطة النظام
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And click on link: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.cancelbooking.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And verify element present: ejar.cancelbooking.checkCancelled.td.byxpath



  @TestType-Smoke
  Scenario: Cancel existing Broker Spot contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And change free minutes to cancel value in country setting to: 2147483645
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 150
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 60
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسطاء
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.cancelcontract.cancelContract.a.byxpath
    And fill e-check form
    And change zoom level: 0.2
    And user click on element using java script executor: ejar.cancelcontract.next1.button.byxpath
    And change zoom level: 1
    And verify form page labels and text:
      | Text                                   | TagType |
      | Contract,العقد                         | h1      |
      | Cancel Contract,الغاء العقد            | span    |
      | Rental Check,تشيك السيارة              | div     |
      | Cancel Details,بيانات الالغاء           | div     |
      | Payment Details,البيانات المالية       | div     |
      | Pick-up Branch,فرع الخروج              | label   |
      | Pick-up Date,وقت الخروج                | label   |
      | Odometer Out,كم الخروج                 | label   |
      | Drop-off Branch,فرع العودة             | label   |
      | Drop-off Date,وقت العودة               | label   |
      | Fuel-Out,وقود الخروج                   | label   |
      | Adopted membership,العضوية المعتمدة    | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                               | isEditable | isRequired |
      | ejar.cancelcontract.pickupBranch.field.read.byxpath      | false      | false      |
      | ejar.cancelcontract.pickupDate.field.read.byxpath        | false      | false      |
      | ejar.cancelcontract.odometerOut.field.read.byxpath       | false      | false      |
      | ejar.cancelcontract.dropOffBranch.field.read.byxpath     | false      | false      |
      | ejar.cancelcontract.dropOffDate.field.edit.byxpath       | true       | true       |
      | ejar.cancelcontract.fuelOut.field.read.byxpath           | false      | false      |
      | ejar.cancelcontract.adoptedMembership.field.edit.byxpath | true       | false      |
      | ejar.cancelcontract.next2.button.byxpath                 | true       | false      |
      | ejar.cancelcontract.back1.button.byxpath                 | true       | false      |
      | ejar.generic.save.action.byxpath                         | true       | false      |
      | ejar.generic.cancel.action.byxpath                       | true       | false      |
    And click on element: ejar.cancelcontract.next2.button.byxpath
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And wait for element present: ejar.generic.save.action.byxpath for period in seconds: 90
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
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.closecontract.type.field.read.byxpath             | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath  | false      | false      |
      | ejar.closecontract.date.field.read.byxpath             | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath             | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath        | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath   | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath  | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath     | false      | false      |
      | ejar.closecontract.summaryRentalRate.field.read.byxpath| false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath      | false      | false      |
      | ejar.closecontract.remaining.field.byxpath             | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath   | true       | false      |
      | ejar.generic.cancel.action.byxpath                     | true       | false      |
      | ejar.closecontract.save.button.byxpath                 | true       | false      |
      | ejar.cancelcontract.back2.button.byxpath               | true       | false      |
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 80
    And verify element present: ejar.assert.checkCancelled.field.byxpath
Feature:Close Execute Existing Data Verification


  @TestType-Smoke
  Scenario: Execute existing Individual Spot booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    And change free minutes to cancel value in country setting to: 0
#    And change ejar branch: ejar.secondBranch then navigate to:: /app/rental/bookings
    And open page using url: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 80
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 50
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 50
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.executeexistingbooking.executebooking.a.byxpath
    And wait for element present: ejar.executeexistingbooking.next1.button.byxpath for period in seconds: 100
    And wait for element not present: ejar.executeexistingbooking.next1Disabled.button.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Booking,الحجز                                                               |  h1     |
      | Execute Booking,تنفيذ الحجز                                                 |  span   |
      | Customer,العميل                                                             |  div    |
      | Vehicle,المركبة                                                             |  div    |
      | Contract Details,بيانات العقد                                               |  div    |
      | Offers,العروض الترويجية                                                     |  div    |
      | Extras,الاضافات                                                              |  div    |
      | Payment,الدفع                                                               |  div    |
      | Rental Check,تشيك السيارة                                                   |  div    |
      | Identity number,رقم الإثبات                                                  |  label  |
      | Phone number,رقم الجوال                                                     |  label  |
      | Customer Name,اسم العميل                                                    |  label  |
      | Customer Email,البريد الالكتروني للعميل                                      |  label  |
      | Membership number,رقم العضوية                                               |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.executeexistingbooking.customerIdentity.input.read.byxpath   | false      | false      |
      | ejar.executeexistingbooking.customerPhone.input.read.byxpath      | false      | false      |
      | ejar.executeexistingbooking.customerSearch.button.read.byxpath    | false      | false      |
      | ejar.executeexistingbooking.customerName.input.read.byxpath       | false      | false      |
      | ejar.executeexistingbooking.customerEmail.input.read.byxpath      | false      | false      |
      | ejar.executeexistingbooking.customerMembership.read.input.byxpath | false      | false      |
      | ejar.executeexistingbooking.customerNew.button.byxpath            | false      | false      |
      | ejar.executeexistingbooking.customerEdit.button.byxpath           | true       | false      |
      | ejar.executeexistingbooking.customerClear.button.byxpath          | false      | false      |
      | ejar.executeexistingbooking.next1.button.byxpath                  | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on element: ejar.executeexistingbooking.next1.button.byxpath
    And click on element if exist: ejar.executeexistingbooking.yakeen.button.byxpath with wait: 10
    And click on action if exist with wait: ejar.executeexistingbooking.skip.button.byxpath waiting number of seconds: 5
    And select available car card
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Plate No,رقم اللوحة                                                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.executeexistingbooking.plateNo.field.byxpath                 | false      | true       |
      | ejar.executeexistingbooking.back1.button.byxpath                  | true       | false      |
      | ejar.executeexistingbooking.next2.button.byxpath                  | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on element: ejar.executeexistingbooking.next2.button.byxpath
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.executeexistingbooking.applicableauthorizationtypes.field.byxpath option: Internal Authorization,تفويض داخلي
    And click on element: ejar.executeexistingbooking.skipAuthorization.checkbox.byxpath
    And store date dynamically from the attribute input in field: ejar.editbooking.dropOffDate.input.byxpath and add days: 0 with time: 23:59 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Pick-up Branch,فرع الخروج                                                   |  label  |
      | Drop-off Branch,فرع العودة                                                  |  label  |
      | Pick-up Date,وقت الخروج                                                     |  label  |
      | Drop-off Date,وقت العودة                                                    |  label  |
      | Adopted membership,العضوية المعتمدة                                         |  label  |
      | Driver Authorization,تفويض السائق                                           |  label  |
      | Skip Internal Authorization,تخطى التفويض الداخلي                            |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                | isEditable | isRequired |
      | ejar.executeexistingbooking.pickupBranch.dropdownlist.edit.byxpath        | false      | true       |
      | ejar.executeexistingbooking.dropOffBranch.dropdownlist.edit.byxpath       | true       | true       |
      | ejar.executeexistingbooking.pickupDate.datetime.edit.byxpath              | true       | true       |
      | ejar.executeexistingbooking.dropOffDate.datetime.edit.byxpath             | true       | true       |
      | ejar.executeexistingbooking.adoptedMembership.dropdownlist.edit.byxpath   | true       | true       |
      | ejar.executeexistingbooking.driverAuthorization.dropdownlist.edit.byxpath | true       | false      |
      | ejar.executeexistingbooking.driverAuthorization.input.edit.byxpath        | true       | false      |
      | ejar.executeexistingbooking.back2.button.byxpath                          | true       | false      |
      | ejar.executeexistingbooking.next3.button.byxpath                          | true       | false      |
      | ejar.generic.cancel.action.byxpath                                        | true       | false      |
      | ejar.generic.save.action.byxpath                                          | false      | false      |
    And click on element: ejar.executeexistingbooking.next3.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And wait for element present: ejar.executeexistingbooking.offers.section.byxpath for period in seconds: 30
    And ensure checkbox is enabled if checkbox exist: ejar.executeexistingbooking.offers.input.byxpath
    And click on element: ejar.executeexistingbooking.next4.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on element: ejar.executeexistingbooking.next5.button.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And click on action if exist: ejar.contract.insuranceDeposit.field.button.byxpath
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
      | Payment Type,طريقة الدفع                                                    | label   |
      | Amount,القيمة                                                               | label   |
      | Card Type,نوع البطاقة                                                       | label   |
      | Transaction No.,رقم العملية                                                 | label   |
      | Terminal No.,رقم نقطة البيع                                                 | label   |
      | Pay amount in cash,دفع المبلغ نقدا                                          | label   |
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
      | fieldXpath                                                                | isEditable | isRequired |
      | ejar.executeexistingbooking.paymentType.dropdownlist.byxpath              | true       | true       |
      | ejar.executeexistingbooking.amountCard.dropdownlist.byxpath               | true       | true       |
      | ejar.executeexistingbooking.cardType.dropdownlist.byxpath                 | true       | true       |
      | ejar.executeexistingbooking.transactionNo.input.byxpath                   | true       | true       |
      | ejar.executeexistingbooking.terminalNo.input.byxpath                      | true       | false      |
      | ejar.executeexistingbooking.amountCash.input.byxpath                      | true       | false      |
      | ejar.closecontract.type.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.date.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath                           | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath                      | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath                         | false      | false      |
      | ejar.closecontract.remaining.field.byxpath                                | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath                      | true       | false      |
      | ejar.executeexistingbooking.next6.button.byxpath                          | true       | false      |
      | ejar.executeexistingbooking.back5.button.byxpath                          | true       | false      |
      | ejar.generic.cancel.action.byxpath                                        | true       | false      |
      | ejar.generic.save.action.byxpath                                          | false      | false      |
    And click on element: ejar.executeexistingbooking.next6.button.byxpath
    And click on element if exist: ejar.executeexistingbooking.cameraAccess.button.byxpath with wait: 30
    And set minimum odometer value into field: ejar.closecontract.odometer.field.input.byxpath with wait for camera: 100
    And capture E-check Images if exist
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.executeexistingbooking.modal.field.byxpath for period in seconds: 60
    And click on action if exist: ejar.executeexistingbooking.ratingDialog.firstStar.byxpath
    And click on action if exist: ejar.executeexistingbooking.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.executeexistingbooking.cancelPrint.button.byxpath
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 120
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 80
    And verify element present: ejar.assert.checkOpen.field.byxpath


  @TestType-Smoke
  Scenario: Execute existing broker booking
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    #    And change ejar branch: ejar.secondBranch then navigate to:: /app/rental/bookings
    And open page using url: /app/rental/bookings
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 50
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسيط
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 50
    And store ejar element value: ejar.assert.bookingNo.a.byxpath and value name: bookingNo and keep number only: false
    And click on element: ejar.executeexistingbooking.executebooking.a.byxpath
    And complete lite customer from the execute booking form
    And wait for element present: ejar.executeexistingbooking.next1.button.byxpath for period in seconds: 100
    And wait for element not present: ejar.executeexistingbooking.next1Disabled.button.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Booking,الحجز                                                               |  h1     |
      | Execute Broker Booking,تنفيذ حجز الوسيط                                     |  span   |
      | Customer,العميل                                                             |  div    |
      | Vehicle,المركبة                                                             |  div    |
      | Contract Details,بيانات العقد                                               |  div    |
      | Extras,الاضافات                                                              |  div    |
      | Payment,الدفع                                                               |  div    |
      | Rental Check,تشيك السيارة                                                   |  div    |
      | Identity number,رقم الإثبات                                                  |  label  |
      | Phone number,رقم الجوال                                                     |  label  |
      | Customer Name,اسم العميل                                                    |  label  |
      | Customer Email,البريد الالكتروني للعميل                                      |  label  |
      | Membership number,رقم العضوية                                               |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.executeexistingbooking.customerIdentity.input.read.byxpath   | false      | false      |
      | ejar.executeexistingbooking.customerPhone.input.read.byxpath      | false      | false      |
      | ejar.executeexistingbooking.customerSearch.button.read.byxpath    | false      | false      |
      | ejar.executeexistingbooking.customerName.input.read.byxpath       | false      | false      |
      | ejar.executeexistingbooking.customerEmail.input.read.byxpath      | false      | false      |
      | ejar.executeexistingbooking.customerMembership.read.input.byxpath | false      | false      |
      | ejar.executeexistingbooking.customerNew.button.byxpath            | false      | false      |
      | ejar.executeexistingbooking.customerEdit.button.byxpath           | true       | false      |
      | ejar.executeexistingbooking.customerClear.button.byxpath          | false      | false      |
      | ejar.executeexistingbooking.next1.button.byxpath                  | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on element: ejar.executeexistingbooking.next1.button.byxpath
    And click on element if exist: ejar.executeexistingbooking.yakeen.button.byxpath with wait: 20
    And click on action if exist with wait: ejar.executeexistingbooking.skip.button.byxpath waiting number of seconds: 5
    And select last available car card
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Plate No,رقم اللوحة                                                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.executeexistingbooking.plateNo.field.byxpath                 | true       | true       |
      | ejar.executeexistingbooking.back1.button.byxpath                  | true       | false      |
      | ejar.executeexistingbooking.next2.button.byxpath                  | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on element: ejar.executeexistingbooking.next2.button.byxpath
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.executeexistingbooking.applicableauthorizationtypes.field.byxpath option: Internal Authorization,تفويض داخلي
    And click on element: ejar.executeexistingbooking.skipAuthorization.checkbox.byxpath
    And store date dynamically from the attribute input in field: ejar.executeexistingbooking.dropOffDate.input.byxpath and add days: 0 with time: 23:59 and variable name: expectedDate
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Pick-up Branch,فرع الخروج                                                   |  label  |
      | Drop-off Branch,فرع العودة                                                  |  label  |
      | Pick-up Date,وقت الخروج                                                     |  label  |
      | Drop-off Date,وقت العودة                                                    |  label  |
      | Adopted membership,العضوية المعتمدة                                         |  label  |
      | Driver Authorization,تفويض السائق                                           |  label  |
      | Skip Internal Authorization,تخطى التفويض الداخلي                            |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                | isEditable | isRequired |
      | ejar.executeexistingbooking.pickupBranch.dropdownlist.edit.byxpath        | false      | false      |
      | ejar.executeexistingbooking.dropOffBranch.dropdownlist.edit.byxpath       | true       | true       |
      | ejar.executeexistingbooking.pickupDate.datetime.edit.byxpath              | true       | true       |
      | ejar.executeexistingbooking.dropOffDate.datetime.edit.byxpath             | true       | true       |
      | ejar.executeexistingbooking.adoptedMembership.dropdownlist.edit.byxpath   | true       | true       |
      | ejar.executeexistingbooking.driverAuthorization.dropdownlist.edit.byxpath | true       | false      |
      | ejar.executeexistingbooking.driverAuthorization.input.edit.byxpath        | true       | false      |
      | ejar.executeexistingbooking.back2.button.byxpath                          | true       | false      |
      | ejar.executeexistingbooking.next3.button.byxpath                          | true       | false      |
      | ejar.generic.cancel.action.byxpath                                        | true       | false      |
      | ejar.generic.save.action.byxpath                                          | false      | false      |
    And click on element: ejar.executeexistingbooking.next3.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on element: ejar.executeexistingbooking.next4.button.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And click on action if exist: ejar.contract.insuranceDeposit.field.button.byxpath
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
      | Payment Type,طريقة الدفع                                                    | label   |
      | Amount,القيمة                                                               | label   |
      | Card Type,نوع البطاقة                                                       | label   |
      | Transaction No.,رقم العملية                                                 | label   |
      | Terminal No.,رقم نقطة البيع                                                 | label   |
      | Pay amount in cash,دفع المبلغ نقدا                                          | label   |
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
      | fieldXpath                                                                | isEditable | isRequired |
      | ejar.executeexistingbooking.paymentType.dropdownlist.byxpath              | true       | true       |
      | ejar.executeexistingbooking.amountCard.dropdownlist.byxpath               | true       | true       |
      | ejar.executeexistingbooking.cardType.dropdownlist.byxpath                 | true       | true       |
      | ejar.executeexistingbooking.transactionNo.input.byxpath                   | true       | true       |
      | ejar.executeexistingbooking.terminalNo.input.byxpath                      | true       | false      |
      | ejar.executeexistingbooking.amountCash.input.byxpath                      | true       | false      |
      | ejar.closecontract.type.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.transactionType.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.date.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.paid.field.read.byxpath                                | false      | false      |
      | ejar.closecontract.netAmount.field.read.byxpath                           | false      | false      |
      | ejar.closecontract.summaryEmail.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryPhone.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryPlateNo.field.read.byxpath                      | false      | false      |
      | ejar.closecontract.summaryCategory.field.read.byxpath                     | false      | false      |
      | ejar.closecontract.summaryModel.field.read.byxpath                        | false      | false      |
      | ejar.closecontract.summaryNetAmount.field.read.byxpath                    | false      | false      |
      | ejar.closecontract.summaryPaid.field.read.byxpath                         | false      | false      |
      | ejar.closecontract.remaining.field.byxpath                                | false      | false      |
      | ejar.closecontract.summaryComment.field.edit.byxpath                      | true       | false      |
      | ejar.executeexistingbooking.next5.button.byxpath                          | true       | false      |
      | ejar.executeexistingbooking.back4.button.byxpath                          | true       | false      |
      | ejar.generic.cancel.action.byxpath                                        | true       | false      |
      | ejar.generic.save.action.byxpath                                          | false      | false      |
    And click on element: ejar.executeexistingbooking.next5.button.byxpath
    And click on action if exist with wait: ejar.executeexistingbooking.cameraAccess.button.byxpath waiting number of seconds: 30
    And set minimum odometer value into field: ejar.closecontract.odometer.field.input.byxpath with wait for camera: 100
    And capture E-check Images if exist
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.executeexistingbooking.modal.field.byxpath for period in seconds: 60
    And click on action if exist: ejar.executeexistingbooking.ratingDialog.firstStar.byxpath
    And click on action if exist: ejar.executeexistingbooking.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.executeexistingbooking.cancelPrint.button.byxpath
    And wait for element present: ejar.executeexistingbooking.executebooking.a.byxpath for period in seconds: 50
    And open page using url: /app/rental/contracts
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 80
    And set value into field: ejar.assert.bookingNo.field.byxpath from stored variable: bookingNo
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 80
    And verify element present: ejar.assert.checkOpen.field.byxpath

  @TestType-Smoke
  Scenario: Close existing Broker Spot contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And change free minutes to cancel value in country setting to: 0
    #    And change ejar branch: ejar.secondBranch then navigate to:: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 50
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Broker,وسطاء
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 50
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.closecontract.closeContract.a.byxpath
    And handle separate echeck
    And click on element if exist: ejar.closecontract.continueComment.button.byxpath with wait: 5
    And fill e-check form
    And change zoom level: 0.2
    And user click on element using java script executor: ejar.closecontract.next1.button.byxpath
    And change zoom level: 1
    And wait for element present: ejar.closecontract.next2.button.byxpath for period in seconds: 20
    And verify form page labels and text:
      | Text                                  | TagType |
      | Contract,العقد                        | h1      |
      | Close Contract,اغلاق عقد               | span    |
      | Rental Check,تشيك السيارة             | div     |
      | Close Details,بيانات الإغلاق            | div     |
      | Extras,الاضافات                        | div     |
      | Payment Details,البيانات المالية      | div     |
      | Pick-up Branch,فرع الخروج             | label   |
      | Pick-up Date,وقت الخروج               | label   |
      | Odometer Out,كم الخروج                | label   |
      | Drop-off Branch,فرع العودة            | label   |
      | Drop-off Date,وقت العودة              | label   |
      | Fuel-Out,وقود الخروج                  | label   |
      | Adopted membership,العضوية المعتمدة   | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.closecontract.pickupBranch.label.read.byxpath     | false      | false      |
      | ejar.closecontract.pickupDate.label.read.byxpath       | false      | false      |
      | ejar.closecontract.odometerOut.label.read.byxpath      | false      | false      |
      | ejar.closecontract.dropOffBranch.label.read.byxpath    | false      | false      |
      | ejar.closecontract.dropOffDate.kendo.edit.byxpath      | true       | true       |
      | ejar.closecontract.fuelOut.label.read.byxpath          | false      | false      |
      | ejar.closecontract.membership.droplist.edit.byxpath    | true       | false      |
      | ejar.closecontract.next2.button.byxpath                | true       | false      |
    And store element from the attribute input in field: ejar.closecontract.dropOffDate.input.byxpath and variable name: dropOffDateInClose
    And click on element: ejar.closecontract.next2.button.byxpath
    And verify element present: ejar.closecontract.extras.form.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on element: ejar.closecontract.next3.button.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And click on action if exist: ejar.contract.insuranceDeposit.field.button.byxpath
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
      | ejar.closecontract.save.button.byxpath                 | true       | false      |
      | ejar.closecontract.back.button.edit.byxpath            | true       | false      |
    And click on element: ejar.closecontract.save.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.closecontract.modal.field.byxpath for period in seconds: 100
    And click on action if exist: ejar.contract.ratingDialog.firstStart.byxpath
    And click on action if exist: ejar.contract.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.closecontract.cancelPrint.button.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 80
    And verify element present: ejar.closecontract.checkClosed.field.byxpath

  @TestType-Smoke
  Scenario: Close existing Individual Spot contract
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And change free minutes to cancel value in country setting to: 0
#    And change ejar branch: ejar.secondBranch then navigate to: /app/rental/contracts
    And open page using url: /app/rental/contracts
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And filter view based on state column name: Type,النوع and enter value:Spot,عادي
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 60
    And filter view based on state column name: Customer Type,نوع العميل and enter value:Individual,أفراد
    And click on element: ejar.closecontract.more.a.byxpath
    And store ejar element value: ejar.assert.contractNo.a.byxpath and value name: contractNo and keep number only: false
    And click on element: ejar.closecontract.closeContract.a.byxpath
    And handle separate echeck
    And click on element if exist: ejar.closecontract.continueComment.button.byxpath with wait: 5
    And fill e-check form
    And change zoom level: 0.2
    And user click on element using java script executor: ejar.closecontract.next1.button.byxpath
    And change zoom level: 1
    And wait for element present: ejar.closecontract.next2.button.byxpath for period in seconds: 20
    And verify form page labels and text:
      | Text                                  | TagType |
      | Contract,العقد                        | h1      |
      | Close Contract,اغلاق عقد               | span    |
      | Rental Check,تشيك السيارة             | div     |
      | Close Details,بيانات الإغلاق            | div     |
      | Extras,الاضافات                        | div     |
      | Payment Details,البيانات المالية      | div     |
      | Pick-up Branch,فرع الخروج             | label   |
      | Pick-up Date,وقت الخروج               | label   |
      | Odometer Out,كم الخروج                | label   |
      | Drop-off Branch,فرع العودة            | label   |
      | Drop-off Date,وقت العودة              | label   |
      | Fuel-Out,وقود الخروج                  | label   |
      | Adopted membership,العضوية المعتمدة   | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.closecontract.pickupBranch.label.read.byxpath     | false      | false      |
      | ejar.closecontract.pickupDate.label.read.byxpath       | false      | false      |
      | ejar.closecontract.odometerOut.label.read.byxpath      | false      | false      |
      | ejar.closecontract.dropOffBranch.label.read.byxpath    | false      | false      |
      | ejar.closecontract.dropOffDate.kendo.edit.byxpath      | true       | true       |
      | ejar.closecontract.fuelOut.label.read.byxpath          | false      | false      |
      | ejar.closecontract.membership.droplist.edit.byxpath    | true       | false      |
      | ejar.closecontract.next2.button.byxpath                | true       | false      |
    And store element from the attribute input in field: ejar.closecontract.dropOffDate.input.byxpath and variable name: dropOffDateInClose
    And click on element: ejar.closecontract.next2.button.byxpath
    And verify element present: ejar.closecontract.extras.form.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on element: ejar.closecontract.next3.button.byxpath
#    And fill odometer pop-up if exist: ejar.closecontract.odometerPopUp.input.byxpath
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And click on action if exist: ejar.contract.insuranceDeposit.field.button.byxpath
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
      | ejar.closecontract.save.button.byxpath                 | true       | false      |
      | ejar.closecontract.back.button.edit.byxpath            | true       | false      |
    And click on element: ejar.closecontract.save.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.closecontract.modal.field.byxpath for period in seconds: 100
    And click on action if exist: ejar.contract.ratingDialog.firstStart.byxpath
    And click on action if exist: ejar.contract.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.closecontract.cancelPrint.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And ensure advanced search filters on the current branch
    And wait for element present: ejar.closecontract.more.a.byxpath for period in seconds: 100
    And set value into field: ejar.assert.contractNo.field.byxpath from stored variable: contractNo
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.assert.contractNo.a.byxpath for period in seconds: 80
    And verify element present: ejar.closecontract.checkClosed.field.byxpath


#    And fill odometer pop-up if exist: ejar.closecontract.odometerPopUp.input.byxpath
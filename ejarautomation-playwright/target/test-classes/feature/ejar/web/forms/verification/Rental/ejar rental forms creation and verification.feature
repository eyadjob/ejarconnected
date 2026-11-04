Feature: Ejar Rental Saving Forms Validation

  @TestType-Smoke
  Scenario: Create verify Contract Save it and validate offer
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url:  /app/rental/contracts
    And create offer on trip days with percentage: 25 and the store offer name in variable: offerName
    And create offer on trip days with percentage: 50 and the store offer name in variable: offerName2
    And open page using url: /app/rental/contracts
    And wait for element present: ejar.contract.createnew.byxpath for period in seconds: 100
    And click on menu link: ejar.contract.createnew.byxpath
    And search for customer in customer search field: ejar.contract.customername.field.byxpath with name: Eyad Automation then select record at random index
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Contract,العقد                                                              |  h1     |
      | Open Contract,فتح عقد                                                       |  span   |
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
      | ejar.executeexistingbooking.customerClear.button.byxpath          | true       | false      |
      | ejar.executeexistingbooking.additionalDriver.button.byxpath       | true       | false      |
      | ejar.contract.next.button.byxpath                                 | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on link: ejar.contract.next.button.byxpath
    And click on link: ejar.contract.ok.button.byxpath
    And click on element if exist: ejar.contract.skip.button.byxpath with wait: 5
    And select available car card
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Plate No,رقم اللوحة                                                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.executeexistingbooking.plateNo.field.byxpath                 | true       | true       |
      | ejar.executeexistingbooking.back1.button.byxpath                  | true       | false      |
      | ejar.contract.next1.button.byxpath                                | true       | false      |
      | ejar.generic.cancel.action.byxpath                                | true       | false      |
      | ejar.generic.save.action.byxpath                                  | false      | false      |
    And click on link: ejar.contract.next1.button.byxpath
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.contract.applicableauthorizationtypes.field.byxpath option: Internal Authorization,تفويض داخلي
    And click on link: ejar.contract.adoptedMembershipCombobox.skipAuthorization.checkbox.byxpath
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
    And click on link: ejar.contract.next2.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And verify element present: ejar.contract.offers.form.byxpath
    And click on link: ejar.contract.next3.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And verify element present: ejar.contract.extras.form.byxpath
    And click on link: ejar.contract.next4.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And get the value of the first row of the table: ejar.contract.paymentGrid.byxpath using the header: Discount %,خصم % then store in variable: discountOfferActivated
    And compare expected value: 25 with actual variable: discountOfferActivated
    And click on element: ejar.executeexistingbooking.back5.button.byxpath
    And click on element: ejar.executeexistingbooking.back4.button.byxpath
    And click on action with locator: ejar.contract.checkboxByName.byxpath with replacing variable with stored value: offerName2
    And click on link: ejar.contract.next3.button.byxpath
    And click on link: ejar.contract.next4.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And get the value of the first row of the table: ejar.contract.paymentGrid.byxpath using the header: Discount %,خصم % then store in variable: discountOffer2Activated
    And compare expected value: 50 with actual variable: discountOffer2Activated
    And pay if there is remaining amount when close contract with card type: Visa,فيزا
    And click on action if exist: ejar.contract.insurance.deposit.deducted.type.byxpath
    And store ejar element value: ejar.contract.summaryPlateNo.field.read.byxpath and value name: contractCarPlateNo and keep number only: false
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
    And click on link: ejar.contract.next5.button.byxpath
    And click on element if exist: ejar.contract.caneraAccess.button.byxpath with wait: 15
    And set minimum odometer value into field: ejar.closecontract.odometer.field.input.byxpath with wait for camera: 100
    And capture E-check Images if exist
    And click on element: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.contract.modal.field.byxpath for period in seconds: 100
    And click on action if exist: ejar.contract.ratingDialog.firstStart.byxpath
    And click on action if exist: ejar.contract.ratingDialog.save.action.byxpath
    And click on action if exist: ejar.contract.cancelPrint.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And wait for element present: ejar.contract.more.a.byxpath for period in seconds: 100
    And set value into field: ejar.contract.plateNo.input.byxpath from stored variable: contractCarPlateNo
    And user click on action with id: ejar.generic.search.action.byxpath
    And click on element: ejar.contract.firstContract.a.byxpath
    And wait for element present: ejar.generic.close.action.byxpath for period in seconds: 50
    And disable offer with the name stored in variable: offerName
    And disable offer with the name stored in variable: offerName2



  @TestType-Smoke
  Scenario: Create and verify Booking form Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    Then click on link: ejar.bookings.createnew.byxpath
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Booking,الحجز                                            | h1      |
      | Create Spot Booking,إضافة حجز عادي                       | span    |
      | Booking Details,تفاصيل الحجز                             | div     |
      | Vehicle,المركبة                                          | div     |
      | Extras,الاضافات                                           | div     |
      | Payment,الدفع                                            | div     |
      | Countries,الدول                                          | label   |
      | Pick-up & Return,الإستلام و التسليم                        | label   |
      | Return at pickup location,التسليم مكان الإستلام            | label   |
      | Pick-up Date,وقت الخروج                                  | label   |
      | Drop-off Date,وقت العودة                                 | label   |
      | Promo Code,الرمز الترويجي                                | label   |
      | External authorization,تفويض خارجي                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.bookings.country.field.edit.byxpath                              | true       | true       |
      | ejar.bookings.returnAtPickup.field.edit.byxpath                       | true       | false      |
      | ejar.bookings.pickupAndReturn.field.edit.byxpath                      | true       | true       |
      | ejar.bookings.pickupDate.field.edit.byxpath                           | true       | true       |
      | ejar.bookings.DropOffDate.field.edit.byxpath                          | true       | true       |
      | ejar.bookings.promoCode.field.edit.byxpath                            | true       | false      |
      | ejar.bookings.externalAuthorization.field.edit.byxpath                | true       | false      |
      | eja.bookings.next1.button.byxpath                                     | false      | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And click on element: ejar.bookings.pickupandreturntopickupcheckbox.field.label.byxpath
    And user select option by text in ejar kendo option field: eja.bookings.pickupbranchcombobox.field.byxpath option: Automation Branch,Automation Branch
    And user select option by text in ejar kendo option field: eja.bookings.dropoffbranchcombobox.field.byxpath option: Automation Branch,Automation Branch
    And user select date time in ejar calendar field: eja.bookings.pickupdatepicker.field.byxpath plus days: 1 and time: 10:00
    And user select date time in ejar calendar field: eja.bookings.dropoffdatepicker.field.byxpath plus days: 2 and time: 10:00
    And click on link: eja.bookings.next1.button.byxpath
    And wait for element not present: eja.bookings.spinner.div.byxpath
    And user select option by text in ejar kendo option field: eja.bookings.categories.field.byxpath option: Automation Small Sedan,Automation Small Sedan
    And user select option by text in ejar kendo option field: eja.bookings.models.field.byxpath option: Automation Accent,Automation Accent
    And user select option by text in ejar kendo option field: eja.bookings.years.field.byxpath option: 2020,2020
    And click on action if exist: ejar.bookings.no.rental.rate.ok.action.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
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
      | ejar.bookings.categories.field.edit.byxpath                           | true       | true       |
      | ejar.bookings.models.field.edit.byxpath                               | true       | true       |
      | ejar.bookings.years.field.edit.byxpath                                | true       | true       |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | eja.bookings.next2.button.byxpath                                     | true       | false      |
      | ejar.bookings.back1.button.edit.byxpath                               | true       | false      |
    And click on link: eja.bookings.next2.button.byxpath
    And verify form page labels and text:
      | Text                                          | TagType |
      | Identity number,رقم الإثبات                    |  label  |
      | Phone number,رقم الجوال                       |  label  |
      | Customer Name,اسم العميل                      |  label  |
      | Customer Email,البريد الالكتروني للعميل        |  label  |
      | Membership number,رقم العضوية                 |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.bookings.customerIdentity.input.edit.byxpath                     | true       | false      |
      | ejar.bookings.customerPhone.input.edit.byxpath                        | true       | false      |
      | ejar.bookings.customerSearch.button.read.byxpath                      | false      | false      |
      | ejar.bookings.customerName.input.edit.byxpath                         | true       | false      |
      | ejar.bookings.customerEmail.input.edit.byxpath                        | true       | false      |
      | ejar.bookings.customerMembership.edit.input.byxpath                   | true       | false      |
      | ejar.bookings.customerNew.button.byxpath                              | true       | false      |
      | ejar.bookings.customerEdit.button.byxpath                             | false      | false      |
      | ejar.bookings.customerClear.button.byxpath                            | true       | false      |
      | ejar.bookings.customerNext.button.byxpath                             | false      | false      |
      | ejar.bookings.back2.button.edit.byxpath                               | true       | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
    And search for customer in customer search field: ejar.bookings.customersearch.field.byxpath with name: Eyad Automation then select record at random index
    And click on element: eja.bookings.next5.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on action if exist with wait: ejar.generic.yes.action.byxpath waiting number of seconds: 3
    And click on action if exist with wait: eja.bookings.extras.popup.byxpath waiting number of seconds: 2
    And verify element present: ejar.bookings.extras.form.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And click on link: eja.bookings.next4.button.byxpath
    And wait for element not present: ejar.closecontract.formLoadingIcon.ngx-spinner.byxpath
    And store element value: ejar.bookings.customernamelabel.byxpath and value name: bookingCustomerName and keep number only: false
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
      | ejar.bookings.type.field.read.byxpath                                 | false      | false      |
      | ejar.bookings.transactionType.field.read.byxpath                      | false      | false      |
      | ejar.bookings.date.field.read.byxpath                                 | false      | false      |
      | ejar.bookings.paid.field.read.byxpath                                 | false      | false      |
      | ejar.bookings.netAmount.field.read.byxpath                            | false      | false      |
      | ejar.bookings.summaryName.field.read.byxpath                          | false      | false      |
      | ejar.bookings.summaryIdentity.field.read.byxpath                      | false      | false      |
      | ejar.bookings.summaryPhone.field.read.byxpath                         | false      | false      |
      | ejar.bookings.summaryCategory.field.read.byxpath                      | false      | false      |
      | ejar.bookings.summaryModel.field.read.byxpath                         | false      | false      |
      | ejar.bookings.summaryManufacturingYear.field.read.byxpath             | false      | false      |
      | ejar.bookings.summaryNetAmount.field.read.byxpath                     | false      | false      |
      | ejar.bookings.summaryPaid.field.read.byxpath                          | false      | false      |
      | ejar.bookings.remaining.field.byxpath                                 | false      | false      |
      | ejar.bookings.summaryComment.field.edit.byxpath                       | true       | false      |
      | ejar.bookings.back3.button.edit.byxpath                               | true       | false      |
      | ejar.bookings.paymentTable.kendo-grid.read.byxpath                    | false      | false      |
      | ejar.generic.save.action.byxpath                                      | true       | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And user click on action with id: ejar.generic.save.action.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And verify element present: ejar.bookings.createnew.byxpath
    And filter view on column name: Customer Name,اسم العميل and enter value stored in variable: bookingCustomerName
    And click on element: ejar.bookings.menu.byxpath
    And click on element: ejar.bookings.cancelBooking.button.byxpath
    And wait for element not present: ejar.bookings.cancelbookingloading.byxpath
    And select option in ejar kendo option field: ejar.bookings.cancelReason.field.byxpath by index: 1
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.bookings.createnew.byxpath for period in seconds: 20


  @TestType-Smoke
  Scenario: Open and verify Distribute Dialog Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url:  /app/rental/late-contracts
    And user click on action with id: ejar.latecontracts.createnew.byxpath
    And verify ejar fields label with soft assertion in form: distribute-contracts text: ejar.latecontracts.label.text
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Distribute,توزيع                                                            | span    |
      | Stage,المرحلة                                                               | label   |
      | From,من                                                                     | label   |
      | To,الى                                                                      | label   |
      | Contract No.,رقم العقد                                                      | span    |
      | Customer Name,اسم العميل                                                    | span    |
      | Stage entry date,تاريخ دخول المرحلة                                         | span    |
      | Expected Return Date,تاريخ العودة المتوقع                                   | span    |
      | Stage,المرحلة                                                               | span    |
      | Assigned Employee,الموظف المخصص                                             | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                           | isEditable | isRequired |
      | ejar.latecontracts.stage.fields.byxpath                              | true       | true       |
      | ejar.latecontracts.fromdate.fields.byxpath                           | true       | false      |
      | ejar.latecontracts.todate.fields.byxpath                             | true       | false      |
      | ejar.latecontracts.search.button.byxpath                             | true       | false      |
      | ejar.latecontracts.save.button.byxpath                               | false      | false      |
      | ejar.latecontracts.cancel.button.byxpath                             | true       | false      |
    And user click on action with id: ejar.latecontracts.search.button.byxpath
    And user click on action with id: ejar.latecontracts.cancel.button.byxpath

  @TestType-Regression
  Scenario: Create and verify Short Term Quotations Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/short-term-quotations
    And Create corporate with the name variable: automationCorporateName
    And approve corporate with name stored in variable: automationCorporateName
    And open page using url: /app/rental/corporates/short-term-quotations
    And user click on action with id: ejar.shorttermquotation.createnew.byxpath
    And clear field: ejar.shorttermquotation.corporate.field.byxpath
    And user select option by text in ejar kendo option field without click on empty field: ejar.shorttermquotation.corporate.field.byxpath with option value from stored variable: automationCorporateName
    And verify ejar fields label with soft assertion in form: quotationbasicinfo text: ejar.shorttermquotation.basicInfo.label.text
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Copy New Quotation,نسخ عرض أسعار                                            |  h1     |
      | Create New Quotation,إضافة عرض اسعار                                        |  span   |
      | Basic Information,المعلومات الاساسية                                         |  div    |
      | Filters,المحددات                                                            |  div    |
      | Price Details,تفاصيل الأسعار                                                 |  div    |
      | Corporate,الشركة                                                            |  label  |
      | Country,الدولة                                                              |  label  |
      | Booking Duration Based Calculation,الاحتساب على أساس مدة الحجز               |  span   |
      | Start Date,وقت البداية                                                      |  label  |
      | End Date,وقت النهاية                                                        |  label  |
      | Purchase Order,أمر الشراء                                                   |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.shorttermquotation.corporate.field.edit.byxpath           | true       | true       |
      | ejar.shorttermquotation.country.field.edit.byxpath             | true       | true       |
      | ejar.shorttermquotation.durationCalculation.field.edit.byxpath | true       | false      |
      | ejar.shorttermquotation.startdate.field.edit.byxpath           | true       | true       |
      | ejar.shorttermquotation.expirydate.field.edit.byxpath          | true       | false      |
      | ejar.shorttermquotation.purchaseorder.field.edit.byxpath       | true       | false      |
      | ejar.shorttermquotation.next1.button.byxpath                   | true       | false      |
      | ejar.generic.create.action.byxpath                             | false      | false      |
      | ejar.generic.cancel.action.byxpath                             | true       | false      |
    And user click on action with id: ejar.shorttermquotation.next1.button.byxpath
    And click on element: ejar.vehicleinformation.firstoption.field.byxpath
    And verify element present: ejar.shorttermquotation.filters.field.byxpath
    And user click on action with id: ejar.shorttermquotation.next2.button.byxpath
    And verify ejar fields label with soft assertion in form: quotation-benefits text: ejar.shorttermquotation.priceDetail.label.text
    And verify form page labels and text:
      | Text                                                                         | TagType |
      | Free KM,الكم المجاني                                                         | label   |
      | Free Hours,الساعات المجانية                                                  | label   |
      | Extra hour,ساعات اضافية                                                      | label   |
      | Transfer Cost Discount Percentage,نسبة خصم رسوم الشحن                        | label   |
      | Fuel Cost Discount Percentage,نسبة خصم تكلفة الوقود                          | label   |
      | Filling Fuel Fees Discount Percentage,نسبة خصم رسوم اعادة تعبئة الوقود       | label   |
      | Damage Cost Discount Percentage,خصم التلفيات                                 | label   |
      | Category,الفئة                                                               | div     |
      | Extra Km Cost,أجرة الكم الزائد                                               | label   |
      | Apply To All,تطبيق على الجميع                                                | label   |
      | Extras,الاضافات                                                               | div     |
      | Accident and theft policy,سياسة الحوادث والسرقة                              | div     |
      | Classification,التصنيف                                                       | span    |
      | Accident,الحادث                                                              | span    |
      | Theft,السرقة                                                                 | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                      | isEditable | isRequired |
      | ejar.shorttermquotation.freeKM.field.edit.byxpath               | true       | true       |
      | ejar.shorttermquotation.freeHours.field.edit.byxpath            | true       | true       |
      | ejar.shorttermquotation.extraHour.field.edit.byxpath            | true       | false      |
      | ejar.shorttermquotation.transferCostDiscount.field.edit.byxpath | true       | false      |
      | ejar.shorttermquotation.fuelCostDiscount.field.edit.byxpath     | true       | false      |
      | ejar.shorttermquotation.fillingFuelDiscount.field.edit.byxpath  | true       | false      |
      | ejar.shorttermquotation.damageCostDiscount.field.edit.byxpath   | true       | false      |
      | ejar.shorttermquotation.accidentAndTheft.field.read.byxpath     | false      | false      |
      | ejar.generic.create.action.byxpath                              | false      | false      |
      | ejar.generic.cancel.action.byxpath                              | true       | false      |
      | ejar.shorttermquotation.back2.button.byxpath                    | true       | false      |
    And user enter value : 180 in field : ejar.shorttermquotation.freeKM.field.byxpath
    And verify element present: ejar.shorttermquotation.categoryPriceDetails.field.byxpath
    And verify element present: ejar.shorttermquotation.extras.field.read.byxpath
    And user click on action with id: ejar.generic.create.action.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And verify element present: ejar.shorttermquotation.createnew.byxpath
    And filter view on column name: Corporate,الشركة and enter value stored in variable: automationCorporateName
    And user click on action with id: ejar.shorttermquotation.firstrow.button.byxpath
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Quotation Number,رقم العرض                                                  | h1      |
      | Corporate,الشركة                                                            | label   |
      | Country,الدولة                                                              | label   |
      | Booking Duration Based Calculation,الاحتساب على أساس مدة الحجز               | label   |
      | Free KM,الكم المجاني                                                        | label   |
      | Free Hours,الساعات المجانية                                                 | label   |
      | Extra hour,ساعات اضافية                                                     | label   |
      | Transfer Cost Discount Percentage,نسبة خصم رسوم الشحن                       | label   |
      | Fuel Cost Discount Percentage,نسبة خصم تكلفة الوقود                         | label   |
      | Filling Fuel Fees Discount Percentage,نسبة خصم رسوم اعادة تعبئة الوقود      | label   |
      | Damage Cost Discount Percentage,خصم التلفيات                                | label   |
      | Category,الفئة                                                              | div     |
      | Extra Km Cost,أجرة الكم الزائد                                              | label   |
      | Extras,الاضافات                                                              | div     |
      | Accident and theft policy,سياسة الحوادث والسرقة                             | div     |
      | Classification,التصنيف                                                      | span    |
      | Accident,الحادث                                                             | span    |
      | Theft,السرقة                                                                | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                      | isEditable | isRequired |
      | ejar.shorttermquotation.corporate.field.read.byxpath            | false      | true       |
      | ejar.shorttermquotation.country.field.read.byxpath              | false      | true       |
      | ejar.shorttermquotation.durationCalculation.field.read.byxpath  | false      | true       |
      | ejar.shorttermquotation.freeKM.field.read.byxpath               | false      | false      |
      | ejar.shorttermquotation.freeHours.field.edit.byxpath            | false      | true       |
      | ejar.shorttermquotation.extraHour.field.edit.byxpath            | false      | false      |
      | ejar.shorttermquotation.accidentAndTheft.field.read.byxpath     | false      | false      |
      | ejar.shorttermquotation.otheroperations.button.byxpath          | true       | false      |
      | ejar.generic.cancel.action.byxpath                              | true       | false      |
    And verify element present: ejar.shorttermquotation.extras.field.read.byxpath
    And user click on action with id: ejar.shorttermquotation.otheroperations.button.byxpath
    And wait for number of seconds: 0.5
    And user click on action with id: ejar.shorttermquotation.deactivate.button.byxpath
    And wait for element present: ejar.generic.yes.action.byxpath for period in seconds: 5
    And click on action if exist: ejar.generic.yes.action.byxpath
    And user click on action with id: ejar.shorttermquotation.cancelToClose.button.byxpath
    And verify element present: ejar.shorttermquotation.createnew.byxpath


  @TestType-Smoke
  Scenario: Create and verify brokers profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/brokers
    And click on link: ejar.brokers.create.button.byxpath
    And verify ejar fields label with soft assertion in form: broker-details text: ejar.brokers.alllabels.label.text
    And verify form page labels and text:
      | Text                                           | TagType |
      | Broker,وسيط                                    |  h1     |
      | Manage Broker,إدارة الوسيط                     |  span   |
      | Broker,وسيط                                    |  li     |
      | Basic information,المعلومات الأساسية            |  div    |
      | Country,الدولة                                 |  label  |
      | Name,الاسـم                                     |  label  |
      | City,المدينة                                   |  label  |
      | Phone number,رقم الجوال                        |  label  |
      | Area,المنطقة                                   |  label  |
      | Street Address,الشارع                          |  label  |
      | Building^^ floor...,المبنى / الطابق            |  label  |
      | Postal Code,الرمز البريدي                      |  label  |
      | More address details,تفاصيل العنوان الاضافية    |  label  |
      | Classification,التصنيف                         |  label  |
      | Sector,القطاع                                  |  label  |
      | Tax Number,الرقم الضريبي                       |  label  |
      | Account Manager,مندوب مبيعات                   |  label  |
      | Credit Limit,الحد الإئتماني                     |  label  |
      | Contact person information,بيانات الشخص المفوض |  div    |
      | Name,الاسـم                                     |  label  |
      | Email,البريد الإلكتروني                         |  label  |
      | Primary Phone,الهاتف الأساسي                    |  label  |
      | Secondary Phone,الهاتف الثاني                  |  label  |
      | Comment,ملاحظات                                 |  label  |
    And user select option by text in ejar kendo option field without typing: ejar.broker.country.field.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And set random text in variable and into element: ejar.brokers.name.field.input.byxpath with size: 10 and initial string: Automation UI Broker  and store value in variable: brokerName
    And set random text into element: ejar.brokers.area.field.edit.byxpath with size: 5 and initial string: UI Automation Area
    And set random text into element: ejar.brokers.streetAddress.field.edit.byxpath with size: 5 and initial string: UI Automation Street
    And set value into element : ejar.brokers.buildingFloor.field.edit.byxpath value: 21
    And set value into element : ejar.brokers.postalCode.field.edit.byxpath value: 28721
    And user select option by text in ejar kendo option field without typing: ejar.broker.city.field.byxpath option: Automation Riyadh,Automation Riyadh
    And select option in ejar kendo option field: ejar.broker.classification.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.broker.accountManger.field.byxpath by index: 1
    And user enter value : Automation Name in field : ejar.broker.contractName.field.byxpath
    And user enter value : 512224444 in field : ejar.broker.phoneNumber.field.byxpath
    And user enter value : 553336666 in field : ejar.broker.phoneNumber2.field.byxpath
    And user enter value : AutomationEmail@gmail.com in field : ejar.broker.email.field.byxpath
    And user enter value : 100 in field : ejar.broker.creditLimit.field.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.brokers.country.field.edit.byxpath                            | True       | True       |
      | ejar.brokers.name.field.edit.byxpath                               | True       | True       |
      | ejar.brokers.city.field.edit.byxpath                               | True       | True       |
      | ejar.brokers.brokerPhoneNumber.field.edit.byxpath                  | True       | True       |
      | ejar.brokers.area.field.edit.byxpath                               | True       | True       |
      | ejar.brokers.streetAddress.field.edit.byxpath                      | True       | True       |
      | ejar.brokers.buildingFloor.field.edit.byxpath                      | True       | True       |
      | ejar.brokers.postalCode.field.edit.byxpath                         | True       | True       |
      | ejar.brokers.moreAddress.field.edit.byxpath                        | True       | False      |
      | ejar.brokers.classification.field.edit.byxpath                     | True       | True       |
      | ejar.brokers.sector.field.edit.byxpath                             | True       | False      |
      | ejar.brokers.taxNumber.field.edit.byxpath                          | True       | False      |
      | ejar.brokers.accountManager.field.edit.byxpath                     | True       | True       |
      | ejar.brokers.creditLimit.field.edit.byxpath                        | True       | True       |
      | ejar.brokers.contacPersonName.field.edit.byxpath                   | True       | True       |
      | ejar.brokers.contactPersonEmail.field.edit.byxpath                 | True       | True       |
      | ejar.brokers.contactPersonPhone1.field.edit.byxpath                | True       | True       |
      | ejar.brokers.contactPersonPhone2.field.edit.byxpath                | True       | False      |
      | ejar.brokers.comment.field.edit.byxpath                            | True       | False      |
      | ejar.brokers.save.button.byxpath                                   | True       | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And user click on action with id: ejar.brokers.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: brokerName
    And click on element: ejar.brokers.firstRow.a.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.brokers.country.field.read.byxpath                            | False      | False      |
      | ejar.brokers.name.field.read.byxpath                               | False      | False      |
      | ejar.brokers.city.field.read.byxpath                               | False      | False      |
      | ejar.brokers.brokerPhoneNumber.field.read.byxpath                  | False      | False      |
      | ejar.brokers.address.field.read.byxpath                            | False      | False      |
      | ejar.brokers.classification.field.read.byxpath                     | False      | False      |
      | ejar.brokers.accountManager.field.read.byxpath                     | False      | False      |
      | ejar.brokers.contacPersonName.field.read.byxpath                   | False      | False      |
      | ejar.brokers.contactPersonEmail.field.read.byxpath                 | False      | False      |
      | ejar.brokers.contactPersonPhone1.field.read.byxpath                | False      | False      |
    And user click on action with id: ejar.broker.deactivate.button.byxpath
    And set random text into element: ejar.brokers.commentModal.field.textarea.byxpath with size: 10 and initial string: UI Automation comment
    And user click on action with id: ejar.broker.deactivateConfirmation.button.byxpath
    And wait for element present: ejar.brokers.create.button.byxpath for period in seconds: 120

  @TestType-Smoke
  Scenario: Create and verify Broker Short Term Quotation
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/brokers
    And Create broker with random name and store name in variable: brokerName
    And open page using url: /app/rental/brokers/short-term-quotations
    And wait for element present: ejar.brokerQuotation.createnew.quotation.byxpath for period in seconds: 80
    And click on element: ejar.brokerQuotation.createnew.quotation.byxpath
    And verify ejar fields label with soft assertion in form: quotationbasicinfo text: ejar.brokerShortQuotation.basicInfo.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Broker Short Term Quotations,عروض الأسعار القصيرة للوسطاء | h1      |
      | Create New Quotation,إضافة عرض اسعار                     | span    |
      | Basic Information,المعلومات الاساسية                      | div     |
      | Filters,المحددات                                         | div     |
      | Price Details,تفاصيل الأسعار                              | div     |
      | Corporate,الشركة                                         | label   |
      | Country,الدولة                                           | label   |
      | Product Code,رمز المنتج                                  | label   |
      | Start Date,وقت البداية                                   | label   |
      | End Date,وقت النهاية                                     | label   |
      | Purchase Order,أمر الشراء                                | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.brokerShortQuotation.corporate.field.byxpath      | true       | true       |
      | ejar.brokerShortQuotation.country.field.byxpath        | true       | true       |
      | ejar.brokerShortQuotation.productCode.field.byxpath    | true       | false      |
      | ejar.brokerShortQuotation.startDate.field.byxpath      | true       | true       |
      | ejar.brokerShortQuotation.endDate.field.byxpath        | true       | false      |
      | ejar.brokerShortQuotation.purchaseOrder.field.byxpath  | true       | false      |
      | ejar.brokerShortQuotation.next1.button.byxpath         | false      | false      |
      | ejar.brokerShortQuotation.create.button.byxpath        | false      | false      |
      | ejar.brokerShortQuotation.cancel.button.byxpath        | true       | false      |
    And user select option by text in ejar kendo option field without click on empty field: ejar.brokerShortQuotation.corporate.kendo.byxpath with option value from stored variable: brokerName
    And click on element: ejar.brokerShortQuotation.next1.button.byxpath
    And wait for element present: ejar.brokerShortQuotation.next2.button.byxpath for period in seconds: 100
    And verify form page labels and text:
      | Text                                          | TagType |
      | Fleet,الاسطول                                  | span    |
      | Extras,الاضافات                                | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.brokerShortQuotation.next2.button.byxpath         | false      | false      |
      | ejar.brokerShortQuotation.back.button.byxpath          | true       | false      |
      | ejar.brokerShortQuotation.allVehicles.button.byxpath   | true       | false      |
    And click on element: ejar.brokerShortQuotation.allVehicles.button.byxpath
    And click on element: ejar.brokerShortQuotation.next2.button.byxpath
    And verify ejar fields label with soft assertion in form: quotation-benefits text: ejar.brokerShortQuotation.priceDetails.labels.text
    And verify form page labels and text:
      | Text                                                                         | TagType |
      | Free KM,الكم المجاني                                                         | label   |
      | Free Hours,الساعات المجانية                                                  | label   |
      | Extra hour,ساعات اضافية                                                      | label   |
      | Transfer Cost Discount Percentage,نسبة خصم رسوم الشحن                        | label   |
      | Fuel Cost Discount Percentage,نسبة خصم تكلفة الوقود                          | label   |
      | Filling Fuel Fees Discount Percentage,نسبة خصم رسوم اعادة تعبئة الوقود       | label   |
      | Damage Cost Discount Percentage,خصم التلفيات                                 | label   |
      | Category,الفئة                                                               | div     |
      | Extra Km Cost,أجرة الكم الزائد                                               | label   |
      | Apply To All,تطبيق على الجميع                                                | label   |
      | Accident and theft policy,سياسة الحوادث والسرقة                              | div     |
      | Classification,التصنيف                                                       | span    |
      | Accident,الحادث                                                              | span    |
      | Theft,السرقة                                                                 | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.brokerShortQuotation.freeKM.field.byxpath                        | true       | true       |
      | ejar.brokerShortQuotation.freeHours.field.byxpath                     | true       | true       |
      | ejar.brokerShortQuotation.extraHour.field.byxpath                     | true       | false      |
      | ejar.brokerShortQuotation.transferCostDiscount.field.byxpath          | true       | false      |
      | ejar.brokerShortQuotation.fuelCostDiscount.field.byxpath              | true       | false      |
      | ejar.brokerShortQuotation.fuelFeesDiscount.field.byxpath              | true       | false      |
      | ejar.brokerShortQuotation.damageCostDiscount.field.byxpath            | true       | false      |
      | ejar.brokerShortQuotation.category.daily.field.byxpath                | true       | true       |
      | ejar.brokerShortQuotation.category.monthly.field.byxpath              | true       | false      |
      | ejar.brokerShortQuotation.category.extraKmCost.field.byxpath          | true       | false      |
      | ejar.brokerShortQuotation.category.applyToAll.field.byxpath           | true       | false      |
      | ejar.brokerShortQuotation.back2.button.byxpath                        | true       | false      |
      | ejar.brokerShortQuotation.create.button.byxpath                       | false      | false      |
      | ejar.brokerShortQuotation.cancel.button.byxpath                       | true       | false      |
      | ejar.brokerShortQuotation.category.weekly.field.byxpath               | true       | false      |
    And user enter value : 180 in field : ejar.brokerShortQuotation.freeKM.field.byxpath
    And user enter value : 10 in field : ejar.brokerShortQuotation.freeHours.field.byxpath
    And user enter value : 200 in field : ejar.brokerShortQuotation.category.daily.field.byxpath
    And user enter value : 210 in field : ejar.brokerShortQuotation.category.weekly.field.byxpath
    And user enter value : 220 in field : ejar.brokerShortQuotation.category.monthly.field.byxpath
    And user click on action with id: ejar.generic.create.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.brokerQuotation.createnew.quotation.byxpath
    And filter view on column name: Broker Name,اسم الوسيط and enter value stored in variable: brokerName
    And user click on action with id: ejar.brokers.firstrow.button.byxpath
    And verify form page labels and text:
      | Text                                                                         | TagType |
      | Quotation Number,رقم العرض                                                   | h1      |
      | Country,الدولة                                                               | label   |
      | Start Date,وقت البداية                                                       | label   |
      | Free KM,الكم المجاني                                                         | label   |
      | Free Hours,الساعات المجانية                                                  | label   |
      | Extra hour,ساعات اضافية                                                      | label   |
      | Transfer Cost Discount Percentage,نسبة خصم رسوم الشحن                        | label   |
      | Fuel Cost Discount Percentage,نسبة خصم تكلفة الوقود                          | label   |
      | Filling Fuel Fees Discount Percentage,نسبة خصم رسوم اعادة تعبئة الوقود       | label   |
      | Damage Cost Discount Percentage,خصم التلفيات                                 | label   |
      | Category,الفئة                                                               | div     |
      | Extras,الاضافات                                                               | div     |
      | Accident and theft policy,سياسة الحوادث والسرقة                              | div     |
      | Classification,التصنيف                                                       | span    |
      | Accident,الحادث                                                              | span    |
      | Theft,السرقة                                                                 | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.brokerShortQuotation.name.field.read.byxpath                     | false      | false      |
      | ejar.brokerShortQuotation.country.field.read.byxpath                  | false      | false      |
      | ejar.brokerShortQuotation.startDate.field.read.byxpath                | false      | false      |
      | ejar.brokerShortQuotation.freeKM.field.byxpath                        | false      | false      |
      | ejar.brokerShortQuotation.freeHours.field.byxpath                     | false      | false      |
      | ejar.brokerShortQuotation.transferCostDiscount.field.byxpath          | false      | false      |
      | ejar.brokerShortQuotation.fuelCostDiscount.field.byxpath              | false      | false      |
      | ejar.brokerShortQuotation.fuelFeesDiscount.field.byxpath              | false      | false      |
      | ejar.brokerShortQuotation.damageCostDiscount.field.byxpath            | false      | false      |
      | ejar.brokerShortQuotation.category.daily.field.byxpath                | false      | false      |
      | ejar.brokerShortQuotation.category.weekly.field.byxpath               | false      | false      |
      | ejar.brokerShortQuotation.category.monthly.field.byxpath              | false      | false      |
      | ejar.brokerShortQuotation.category.extraKmCost.field.byxpath          | false      | false      |
      | ejar.brokerShortQuotation.classification.field.read.byxpath           | false      | false      |
      | ejar.brokerShortQuotation.accident.field.read.byxpath                 | false      | false      |
      | ejar.brokerShortQuotation.theft.field.read.byxpath                    | false      | false      |
    And user click on action with id: ejar.broker.otheroperations.byxpath
    And user click on action with id: ejar.brokershorttermquotation.deactivate.button.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And open page using url: /app/crm/brokers
    And filter view on column name: Name,الاسم and enter value stored in variable: brokerName
    And user click on action with id: ejar.brokers.firstrow.button.byxpath
    And click on element: ejar.broker.deactivate.button.byxpath
    And set random text into element: ejar.brokers.commentModal.field.textarea.byxpath with size: 10 and initial string: UI Automation Comment
    And user click on action with id: ejar.broker.deactivateConfirmation.button.byxpath
    And verify element present: ejar.brokers.create.button.byxpath


  @TestType-Smoke
  Scenario: Create and verify Offer Form then Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/offers
    And click on link: ejar.offers.createnew.byxpath
    And verify ejar fields label with soft assertion in form: add-offer-basic-info text: ejar.offers.labels.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Offers,العروض الترويجية                               |  h1     |
      | Create New Offer,إضافة عرض                            |  span   |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Offer Filters,محددات العرض                            |  div    |
      | Offer Benefits,فوائد العرض                            |  div    |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Name [en],الاسـم [en]                                  |  label  |
      | Name [ar],الاسـم [ar]                                  |  label  |
      | Exposed,معروض                                         |  label  |
      | Accumulative Offer,عرض يُجمع                           |  label  |
      | Created Contracts From,العقود المنشأه من              |  label  |
      | To,الى                                                |  label  |
      | Description,الوصف                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.name1.field.byxpath                                    | True       | True       |
      | ejar.offers.name2.field.byxpath                                    | True       | True       |
      | ejar.offers.accumulativeOffer.field.byxpath                        | True       | false      |
      | ejar.offers.exposed.field.byxpath                                  | True       | false      |
      | ejar.offers.CreatedContractsStartDate.field.byxpath                | True       | True       |
      | ejar.offers.to.field.byxpath                                       | True       | false      |
      | ejar.offers.description.field.byxpath                              | True       | false      |
    And set random text in variable and into element: ejar.offers.name1.field.byxpath with size: 10 and initial string: UI Automation Offer and store value in variable: offerVariable
    And set value into field: ejar.offers.name2.field.byxpath from stored variable: offerVariable
    And user select date time in ejar calendar field: ejar.offers.createdcontracts.field.byxpath plus days: 1 and plus hours: 1
    And click on link: ejar.offers.next1.button.byxpath
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Fleet,الاسطول                                          |  span   |
      | Vehicle Information,معلومات المركبة                   |  div    |
      | Location,الموقع الجغرافي                              |  span   |
      | Customer,العميل                                       |  span   |
      | Incoming Bookings,الحجوزات المستقبلية                 |  span   |
      | Promo Code,الرمز الترويجي                             |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.firstoption.field.byxpath                              | True       | False      |
    And click on link: ejar.offers.firstoption.field.byxpath
    And click on link: ejar.offers.location.link.byxpath
    And verify ejar fields label with soft assertion in form: offer-location-filters text: ejar.offers.location.label.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Location Information,معلومات المنطقة الجغرافية        |  div    |
      | Include All These Locations,ضم جميع الفروع            |  label  |
      | Exclude All These Locations, استبعاد جميع الفروع      |  label  |
      | Branches,الفروع                                       |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.include.field.byxpath                                  | True       | False      |
      | ejar.offers.exclude.field.byxpath                                  | True       | False      |
    And click on action if exist with wait: ejar.offers.allBranchesIfNotSelected.label.byxpath waiting number of seconds: 1
    And click on link: ejar.offers.customer.link.byxpath
    And click on link: ejar.offers.contracthistory.link.byxpath
    And verify ejar fields label with soft assertion in form: form[@name="contractFilterForm"] text: ejar.offers.contractFilterForm.labels.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Contract History (Old),سجل العقود (القديمة)           |  span   |
      | Pick-up Date,وقت الخروج                               |  label  |
      | Number Of Contracts,عدد العقود                        |  label  |
      | No Accident,لا يوجد حادث                               |  span   |
      | No Indebt,لا يوجد مطالبة                               |  span   |
      | From,من                                               |  label  |
      | To,الى                                                |  label  |
      | >=,>=                                                 |  label  |
      | and <,و <                                             |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.ispickupdateenabled.field.byxpath                      | True       | False      |
      | ejar.offers.isnumberofcontractsEnabled.field.byxpath               | True       | False      |
      | ejar.offers.noaccident.field.byxpath                               | True       | False      |
      | ejar.offers.noindebt.field.byxpath                                 | True       | False      |
      | ejar.offers.datetimename1.field.byxpath                            | False      | False      |
      | ejar.offers.datetimename2.field.byxpath                            | False      | False      |
      | ejar.offers.numberofcontractsfrom.field.byxpath                    | False      | False      |
      | ejar.offers.numberofcontractsto.field.byxpath                      | False      | False      |
    And click on element: ejar.offers.ispickupdateenabled.field.byxpath
    And user select date time in ejar calendar field: ejar.offers.pickupdatepicker.field.byxpath plus days: 0 and time: 00:00
    And click on link: ejar.offers.others.link.byxpath
    And verify ejar fields label with soft assertion in form: offer-others-filter text: ejar.offers.others.label.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | No BlackList,غير مدرج في القائمة السوداء              |  span   |
      | From,من                                               |  label  |
      | To,الى                                                |  label  |
      | Nationality,الجنسية                                   |  span   |
      | Gender,الجنس                                          |  span   |
      | Age,العمر                                             |  span   |
      | >=,>=                                                 |  label  |
      | and <,و <                                             |  label  |
      | Membership,العضويات                                   |  div    |
      | External Loyalties,العضويات الخارجية                  |  span   |
      | Corporate,الشركة                                      |  div    |
      | Organization,جهة العمل                                |  label  |
      | VIP,كبار العملاء                                       |  div    |
      | Customer,العميل                                       |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.isblacklistenabled.field.byxpath                       | True       | False      |
      | ejar.offers.datecontainerfrom1.field.byxpath                       | False      | False      |
      | ejar.offers.datecontainerto1.field.byxpath                         | False      | False      |
      | ejar.offers.isnationality.field.byxpath                            | True       | False      |
      | ejar.offers.isnationality.field.read.byxpath                       | False      | False      |
      | ejar.offers.isgenderenabled.field.byxpath                          | True       | False      |
      | ejar.offers.genderdropdownlist.field.byxpath                       | False      | False      |
      | ejar.offers.isagecheckbox.field.byxpath                            | True       | False      |
      | ejar.offers.agefrom.field.byxpath                                  | False      | False      |
      | ejar.offers.ageTo.field.byxpath                                    | False      | False      |
      | ejar.offers.organizationselect.field.byxpath                       | True       | False      |
      | ejar.offers.customerselect.field.byxpath                           | True       | False      |
    And click on link: ejar.offers.incomingbookings.link.byxpath
    And verify ejar fields label with soft assertion in form: offer-booking-filter text: ejar.offers.bookingFilterForm.labels.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Full Paid,مدفوع بالكامل                               |  span   |
      | Booking Date,وقت الحجز                                |  span   |
      | From,من                                               |  label  |
      | To,الى                                                |  label  |
      | Pick-up Date,وقت الخروج                               |  span   |
      | From,من                                               |  label  |
      | To,الى                                                |  label  |
      | Duration (Days),الفترة (ايام)                         |  span   |
      | >=,>=                                                 |  label  |
      | and <,و <                                             |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.fullpaid.field.byxpath                                 | True       | False      |
      | ejar.offers.isbookingdateenabled.field.byxpath                     | True       | False      |
      | ejar.offers.datefrom1.field.byxpath                                | False      | False      |
      | ejar.offers.dateto1.field.byxpath                                  | False      | False      |
      | ejar.offers.ispickupdateenabledbookings.field.byxpath              | True       | False      |
      | ejar.offers.datefrom2.field.byxpath                                | False      | False      |
      | ejar.offers.dateto2.field.byxpath                                  | False      | False      |
      | ejar.offers.isdurationenabled.field.byxpath                        | True       | False      |
      | ejar.offers.durationFrom.field.byxpath                             | False      | False      |
      | ejar.offers.durationTo.field.byxpath                               | False      | False      |
    And click on element: ejar.offers.fullpaid.field.byxpath
    And click on element: ejar.offers.promocode.link.byxpath
    And verify ejar fields label with soft assertion in form: app-offer-coupon-filters text: ejar.offers.promocode.label.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Coupon Type,نوع الرمز الترويجي                        |  div    |
      | Single Coupon,كوبون واحد                              |  label  |
      | Multi-Coupon,كوبونات متعددة                           |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.offers.singleCoupon.checkbox.byxpath                          | True       | False      |
      | ejar.offers.singleCoupon.field.byxpath                             | False      | False      |
      | ejar.offers.multiCoupon.checkbox.byxpath                           | True       | False      |
      | ejar.offers.generateQRCode.button.byxpath                          | False      | False      |
      | ejar.offers.generatePromoCode.button.byxpath                       | True       | False      |
      | ejar.offers.back1.button.byxpath                                   | True       | False      |
    And click on link: ejar.offers.next2.button.byxpath
    And verify ejar fields label with soft assertion in form: form[@name="offerBenefitsForm"] text: ejar.offers.itemstable.labels.text
    And verify form page labels and text:
      | Text                                                            | TagType |
      | Contracts Calculation Items,بنود حساب العقود                    |  div    |
      | Define Discount on Contract Items,تحديد الخصومات على بنود العقد |  div    |
      | Items,سجل                                                       |  h6     |
      | Title,العنوان                                                   |  th     |
      | Discount %,خصم %                                                |  th     |
      | Extra Free KM,الكم الزائد المجاني                                |  label  |
      | Extra Free Hours,الساعات الزائدة المجانية                       |  label  |
      | Extra Redemption Points,نقاط المكافأة الزائدة                   |  div    |
      | Free Redemption Points Details,تفاصيل نقاط العضوية المجانية     |  div    |
      | Membership,العضويات                                             |  label  |
      | Amount,القيمة                                                   |  label  |
      | Percentage,النسبة                                               |  label  |
      | Voucher,سند إضافي                                               |  div    |
      | Voucher,سند إضافي                                               |  div    |
      | Voucher Amount,قيمة السند                                       |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.definediscount.button.byxpath                                 | True       | False      |
      | ejar.offers.extrafreeKm.field.byxpath                              | True       | False      |
      | ejar.offers.extrafreehours.field.byxpath                           | True       | False      |
      | ejar.offers.membership.field.byxpath                               | True       | False      |
      | ejar.offers.membershipisamount.field.byxpath                       | False      | False      |
      | ejar.offers.membershipispercentage.field.byxpath                   | False      | False      |
      | ejar.offers.membershipamount.field.byxpath                         | False      | False      |
      | ejar.offers.back2.button.byxpath                                   | True       | False      |
      | ejar.offers.cancel.button.byxpath                                  | True       | False      |
      | ejar.offers.save.button.byxpath                                    | True       | False      |
    And user set in field: ejar.offers.extraKM.field.byxpath value: 100
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And click on action if exist: ejar.offers.confirmDuplicationOfferSave.button.byxpath
    And wait for element present: ejar.offers.createnew.byxpath for period in seconds: 100
    And disable offer with the name stored in variable: offerVariable


  @TestType-Smoke
  Scenario: Create and verify Dynamic Rates Form Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/utilizationRates
    And click on link: ejar.dynamicRates.createnew.byxpath
    And verify ejar fields label with soft assertion in form: utilization-rate-basic-info-step text: eja.utilizationoffers.labels.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Dynamic Rates,الاسعار الدينامكية               |   h1    |
      | Add New Dynamic Rate,إضافة سعر ديناميكي       |  span   |
      | Basic Information,المعلومات الاساسية           |   li    |
      | Discounts,الخصومات                            |   li    |
      | Name,الاسم                                     |  label  |
      | Country,الدولة                                |  label  |
      | Branch,الفرع                                  |  label  |
      | Start Date,وقت البداية                        |  label  |
      | End Date,وقت النهاية                          |  label  |
      | Category,الفئة                                |  span   |
      | Model,الموديل                                 |  span   |
      | Manufacture Year,سنة الصنع                    |  span   |
      | Utilization %,نسبة التشغيل %                  |  span   |
      | Discount %,خصم %                              |  span   |
      | Minimum Limit,الحد الأدنى للتشغيل              |  span   |
      | Actions,إجراءات                               |  span   |
      | Save,حفظ                                      | button  |
      | Cancel,الغاء                                  | button  |
      | Add,اضافه                                     | button  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.utilizationoffers.name.field.edit.byxpath                     | True       | True       |
      | ejar.utilizationoffers.country.field.edit.byxpath                  | True       | True       |
      | ejar.utilizationoffers.branches.field.edit.byxpath                 | True       | False      |
      | ejar.utilizationoffers.startdate.field.edit.byxpath                | True       | True       |
      | ejar.utilizationoffers.enddate.field.edit.byxpath                  | True       | False      |
      | ejar.utilizationoffers.grid.add.button.edit.byxpath                | True       | False      |
      | ejar.utilizationoffers.grid.cancel.button.edit.byxpath             | True       | False      |
      | ejar.utilizationoffers.grid.save.button.edit.byxpath               | True       | False      |
      | ejar.utilizationoffers.grid.category.field.edit.byxpath            | True       | True       |
      | ejar.utilizationoffers.grid.model.field.edit.byxpath               | True       | False      |
      | ejar.utilizationoffers.grid.manufactureYear.field.edit.byxpath     | True       | False      |
      | ejar.utilizationoffers.grid.utilization.field.edit.byxpath         | True       | True       |
      | ejar.utilizationoffers.grid.discount.field.edit.byxpath            | True       | True       |
      | ejar.utilizationoffers.grid.minimumLimit.field.edit.byxpath        | True       | False      |
      | ejar.utilizationoffers.cancel.button.byxpath                       | True       | False      |
      | ejar.utilizationoffers.save.button.byxpath                         | False      | False      |
    And set random text in variable and into element: ejar.dynamicRates.name.field.byxpath with size: 5 and initial string: Eyad Automation UI and store value in variable: dynamicRateName
    And user select value in drop down field: ejar.dynamicRates.category.field.byxpath by option text: Automation Small Sedan,Automation Small Sedan
    And user enter value : 1 in field : ejar.dynamicRates.discount.field.byxpath
    And user enter value : 5 in field : ejar.dynamicRates.utilization.field.byxpath
    And user click on action with id: ejar.dynamicRates.saveDiscount.action.byxpath
    And user click on action with id: ejar.generic.create.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: dynamicRateName
    And click on element: ejar.dynamicRates.firstrow.button.byxpath
    And verify form page labels and text:
      | Text                                          | TagType |
      | Dynamic Rates,الاسعار الدينامكية               |   h1    |
      | Basic Information,المعلومات الاساسية           |   li    |
      | Discounts,الخصومات                            |   li    |
      | Name,الاسم                                     |  label  |
      | Country,الدولة                                |  label  |
      | Branch,الفرع                                  |  label  |
      | Start Date,وقت البداية                        |  label  |
      | End Date,وقت النهاية                          |  label  |
      | Discounts,الخصومات                            |  li     |
      | Category,الفئة                                |  span   |
      | Model,الموديل                                 |  span   |
      | Manufacture Year,سنة الصنع                    |  span   |
      | Utilization %,نسبة التشغيل %                  |  span   |
      | Discount %,خصم %                              |  span   |
      | Minimum Limit,الحد الأدنى للتشغيل              |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.utilizationoffers.name.field.read.byxpath                     | false      | false      |
      | ejar.utilizationoffers.country.field.read.byxpath                  | false      | false      |
      | ejar.utilizationoffers.startDate.field.read.byxpath                | false      | false      |
      | ejar.utilizationoffers.grid.field.read.byxpath                     | false      | false      |
      | ejar.utilizationoffers.copy.button.byxpath                         | true       | false      |
      | ejar.generic.close.action.byxpath                                  | true       | false      |
      | ejar.utilizationoffers.stopOffer.button.byxpath                    | true       | false      |
    And click on element: ejar.utilizationoffers.stopOffer.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.dynamicRates.createnew.byxpath for period in seconds: 60



  @TestType-Smoke
  Scenario: Create and verify Rental Rates Form then Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/rental-rate
    And wait for element present: ejar.rentalrate.createnewdailyrate.byxpath for period in seconds: 100
    And click on link: ejar.rentalrate.createnewdailyrate.byxpath
    And verify ejar fields label with soft assertion in form: app-basic-information text: ejar.rentalrate.labels.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Rental Rates,أسعار التأجير                    |  h1     |
      | Create Daily Rate,إضافة تسعير يومي            |  span   |
      | Basic Information,المعلومات الاساسية           |  div    |
      | Rates Information,معلومات الاسعار              |  div    |
      | Start Date,تاريخ البداية                      |  label  |
      | End Date,تاريخ النهاية                        |  label  |
      | Country,الدولة                                |  label  |
      | Branch,الفرع                                  |  label  |
      | Category,الفئة                                |  label  |
      | Manufacturer,الشركة المصنعة                   |  label  |
      | Model,الموديل                                 |  label  |
      | Manufacture Year,سنة الصنع                    |  label  |
      | Trim,مستوى المواصفات                          |  label  |
      | Engine Size (CC),سعة المحرك (CC)              |  label  |
      | Daily Free Km,الكم المجاني                    |  label  |
      | Extra Km Cost,أجرة الكم الزائد                |  label  |
      | Is Active,فعال                                |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.rentalrate.startdatetime.field.edit.byxpath                   | True       | True       |
      | ejar.rentalrate.enddatetime.field.edit.byxpath                     | True       | False      |
      | ejar.rentalrate.countries.field.edit.byxpath                       | True       | True       |
      | ejar.rentalrate.branches.field.edit.byxpath                        | True       | True       |
      | ejar.rentalrate.categories.field.edit.byxpath                      | True       | True       |
      | ejar.rentalrate.manufacturers.field.edit.byxpath                   | True       | True       |
      | ejar.rentalrate.models.field.edit.byxpath                          | True       | True       |
      | ejar.rentalrate.years.field.edit.byxpath                           | False      | True       |
      | ejar.rentalrate.enginesize.field.edit.byxpath                      | True       | False      |
      | ejar..dailyfreeKm.field.edit.byxpath                               | True       | False      |
      | ejar.rentrentalratealrate.extrakmcost.field.edit.byxpath           | True       | False      |
      | ejar.rentrentalratealrate.isActive.field.edit.byxpath              | False      | False      |
      | ejar.rentalrate.next.button.byxpath                                | False      | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And user select value in drop down field: ejar.rentalrate.branches.field.byxpath by option text: Automation Branch,Automation Branch
    And user select value in drop down field: ejar.rentalrate.categories.field.byxpath by option text: Automation Small Sedan Two,Automation Small Sedan Two
    And user select value in drop down field: ejar.rentalrate.manufacturers.field.byxpath by option text: Automation Hyundai,Automation Hyundai
    And user select value in drop down field: ejar.rentalrate.models.field.byxpath by option text: Automation Accent Two,Automation Accent Two
    And click on link: ejar.rentalrate.next.button.byxpath
    And verify form page labels and text:
      | Text                                          | TagType |
      | Period Name,اسم الفترة                        |  td     |
      | Rental Rate,سعر تأجير                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.ratesinformation.table.daily.field.byxpath                    | True       | True       |
      | ejar.ratesinformation.table.weekly.field.byxpath                   | True       | True       |
      | ejar.ratesinformation.table.monthly.field.byxpath                  | True       | True       |
    And user set in field: ejar.ratesinformation.table.daily.field.byxpath value: 100.1
    And user set in field: ejar.ratesinformation.table.weekly.field.byxpath value: 200.2
    And user set in field: ejar.ratesinformation.table.monthly.field.byxpath value: 300.3
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And click on action if exist with wait: ejar.generic.confirmYes.action.byxpath waiting number of seconds: 5
    And filter view on column name: Category,الفئة and enter value:Automation Small Sedan Two,Automation Small Sedan Two
    And wait for element present: ejar.rentalrates.cancel.a.byxpath for period in seconds: 50
    And click on element: ejar.rentalrates.cancel.a.byxpath
    And click on element: ejar.generic.yes.action.byxpath

  @TestType-Smoke
  Scenario: Create and verify OPL Request Form then Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/opl-requests
    And wait for element present: ejar.opl.createnew.byxpath for period in seconds: 100
    And click on link: ejar.opl.createnew.byxpath
    And verify ejar fields label with soft assertion in form: opl-request-details text: ejar.opl.basicinformation.field.label.text
    And verify form page labels and text:
      | Text                                              | TagType |
      | OPL Request,طلب عقد الافراد السنوي                 |  h1     |
      | Create New OPL Request,اضافة طلب عقد سنوي للافراد  |  span   |
      | Basic Information,المعلومات الاساسية               |  div    |
      | Identity number,رقم الإثبات                        |  label  |
      | Phone number,رقم الجوال                           |  label  |
      | Customer Name,اسم العميل                          |  label  |
      | Customer Email,البريد الالكتروني للعميل            |  label  |
      | Membership number,رقم العضوية                     |  label  |
      | Employee,موظف                                     |  span   |
      | Salary,الراتب                                     |  label  |
      | Company Name,اسم الشركة                           |  label  |
      | City,المدينه                                      |  label  |
      | Category,الفئة                                    |  label  |
      | Model,الموديل                                     |  label  |
      | Manufacture Year,سنة الصنع                        |  label  |
      | Rental Period,فترة الايجار                         |  label  |
      | Special Rate,سعر خاص                              |  label  |
      | Name,الاسم                                         |  span   |
      | Actions,إجراءات                                   |  span   |
      | Comment,الملاحظه                                   |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.opl.identityNumber.field.edit.byxpath                         | True       | False      |
      | ejar.opl.phonenumber.field.edit.byxpath                            | True       | False      |
      | ejar.opl.search.button.byxpath                                     | False      | False      |
      | ejar.opl.customername.field.edit.byxpath                           | True       | False      |
      | ejar.opl.customerEmail.field.edit.byxpath                          | True       | False      |
      | ejar.opl.membershipNo.field.edit.byxpath                           | True       | False      |
      | ejar.opl.new.button.byxpath                                        | True       | False      |
      | ejar.opl.edit.button.byxpath                                       | False      | False      |
      | ejar.opl.clear.button.byxpath                                      | True       | False      |
      | ejar.opl.salary.field.read.byxpath                                 | False      | False      |
      | ejar.opl.companyname.field.read.byxpath                            | False      | False      |
      | ejar.opl.city.field.edit.byxpath                                   | True       | True       |
      | ejar.opl.category.field.edit.byxpath                               | True       | True       |
      | ejar.opl.model.field.edit.byxpath                                  | True       | True       |
      | ejar.opl.rates.manufacturers.field.edit.byxpath                    | True       | True       |
      | ejar.opl.rentalRate.field.edit.byxpath                             | True       | True       |
      | ejar.opl.specialRate.field.edit.byxpath                            | True       | False      |
      | ejar.opl.add.field.edit.byxpath                                    | True       | False      |
      | ejar.opl.comment.field.edit.byxpath                                | True       | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And search for customer in customer search field: ejar.contract.customername.field.byxpath with name: Eyad Automation then select record at index: 0
    And store element from the attribute input in field: ejar.contract.customername.field.byxpath and variable name: customerName
    And select option in ejar kendo option field: ejar.opl.city.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.opl.category.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.opl.model.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.opl.yearSource.field.byxpath by index: 0
    And select option in ejar kendo option field: ejar.opl.rentalRate.field.byxpath by index: 1
    And click on element: ejar.opl.add.field.edit.byxpath
    And verify form page labels and text:
      | Text                                              | TagType |
      | Create New Attachment,إضافة مرفق                  |  span   |
      | Name,الاسم                                         |  label  |
      | Image,صورة                                        |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.opl.attachmentName.field.edit.byxpath                         | True       | True       |
      | ejar.opl.attachmentUpload.field.edit.byxpath                       | True       | False      |
      | ejar.opl.attachmentSave.field.edit.byxpath                         | False      | False      |
      | ejar.opl.attachmentCancel.field.edit.byxpath                       | True       | False      |
    And click on element: ejar.opl.attachmentCancel.field.edit.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.opl.reqNo.button.i.byxpath for period in seconds: 120
    And filter view on column name: Customer Name,اسم العميل and enter value stored in variable: customerName
    And wait for element present: ejar.opl.reqNo.button.i.byxpath for period in seconds: 60
    And click on element: ejar.opl.reqNo.button.i.byxpath
    And wait for element present: ejar.opl.identityNumber.field.edit.byxpath for period in seconds: 100
    And verify form page labels and text:
      | Text                                                  | TagType |
      | OPL Request,طلب عقد الافراد السنوي                     |  h1     |
      | OPL Request View,عرض طلبات عقود الأفراد السنوية        |  span   |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Identity number,رقم الإثبات                            |  label  |
      | Phone number,رقم الجوال                               |  label  |
      | Customer Name,اسم العميل                              |  label  |
      | Customer Email,البريد الالكتروني للعميل                |  label  |
      | Membership number,رقم العضوية                         |  label  |
      | Employee,موظف                                         |  label  |
      | Salary,الراتب                                         |  label  |
      | Company Name,اسم الشركة                               |  label  |
      | City,المدينه                                          |  label  |
      | Category,الفئة                                        |  label  |
      | Model,الموديل                                         |  label  |
      | Manufacture Year,سنة الصنع                            |  label  |
      | Rental Period,فترة الايجار                             |  label  |
      | Special Rate,سعر خاص                                  |  label  |
      | Name,الاسم                                             |  span   |
      | Actions,إجراءات                                       |  span   |
      | Comment,الملاحظه                                       |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.opl.identityNumber.field.edit.byxpath                         | False      | False      |
      | ejar.opl.phonenumber.field.read.byxpath                            | False      | False      |
      | ejar.opl.customername.field.edit.byxpath                           | False      | False      |
      | ejar.opl.customerEmail.field.edit.byxpath                          | False      | False      |
      | ejar.opl.membershipNo.field.edit.byxpath                           | False      | False      |
      | ejar.opl.new.button.byxpath                                        | False      | False      |
      | ejar.opl.edit.button.byxpath                                       | False      | False      |
      | ejar.opl.clear.button.byxpath                                      | False      | False      |
      | ejar.opl.isEmployee.field.read.byxpath                             | False      | False      |
      | ejar.opl.city.field.read.byxpath                                   | False      | False      |
      | ejar.opl.category.field.read.byxpath                               | False      | False      |
      | ejar.opl.model.field.read.byxpath                                  | False      | False      |
      | ejar.opl.manufactureYear.field.read.byxpath                        | False      | False      |
      | ejar.opl.rentalPeriod.field.read.byxpath                           | False      | False      |
      | ejar.opl.cancelReq.button.i.byxpath                                | True       | False      |
      | ejar.opl.editOpl.button.byxpath                                    | True       | False      |
      | ejar.opl.followRequest.button.byxpath                              | True       | False      |
      | ejar.opl.close.button.byxpath                                      | True       | False      |
    And click on element: ejar.opl.cancelReq.button.i.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.opl.createnew.byxpath for period in seconds: 50


  @TestType-Smoke
  Scenario: Create and verify Booking Availability Form Save It Then Deactivate it
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/booking-availabilities
    And click on link: ejar.bookingavailability.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-booking-availability text: ejar.bookingavailability.labels.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Booking Availability,إتاحة حجز                |  h1     |
      | Add booking availability,إضافة إتاحة حجز      |  span   |
      | Name,الاسم                                     |  label  |
      | Start Date,وقت البداية                        |  label  |
      | End Date,وقت النهاية                          |  label  |
      | Country,الدولة                                |  label  |
      | Applied on,مطبق على                           |  label  |
      | Is Active,فعال                                |  span   |
      | Branches,الفروع                               |  li     |
      | Vehicle,المركبة                               |  li     |
      | Category,الفئة                                |  span   |
      | Model,الموديل                                 |  span   |
      | Manufacture Year,سنة الصنع                    |  span   |
      | Ready %,جاهزة %                               |  span   |
      | Maintenance %,الصيانة %                       |  span   |
      | Preventive Maintenance%,الصيانة الوقائية%     |  span   |
      | Vehicle Expected To Return %,المتوقع عودتها % |  span   |
      | Late Hours,ساعات التأخير                      |  span   |
      | Actions,إجراءات                               |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.bookingavailability.name.field.edit.byxpath                   | True       | True       |
      | ejar.bookingavailability.startdate.field.edit.byxpath              | True       | True       |
      | ejar.bookingavailability.enddate.field.edit.byxpath                | True       | False      |
      | ejar.bookingavailability.country.field.edit.byxpath                | True       | True       |
      | ejar.bookingavailability.appliedOn.field.edit.byxpath              | True       | True       |
    And verify table header: ejar.bookingavailability.tableheaders.label.byxpath with text: ejar.bookingavailability.tableheaders.field.label.text
    And set random text into element: ejar.bookingavailability.name.field.byxpath and store name: yes
    And set random text in variable and into element: ejar.bookingavailability.name.field.byxpath with size: 10 and initial string: UI Automation Availability and store value in variable: bookingAvailabilityVariable
    And select option in ejar kendo option field: ejar.bookingavailability.appliedOn.field.byxpath by index: 1
    And user select value in drop down field: ejar.bookingavailability.country.field.byxpath by option text: Saudi Arabia,المملكة العربية السعودية
    And user click on action with id: ejar.bookingavailability.add.button.byxpath
    And user click on action with id: ejar.bookingavailability.saveCarCategory.button.byxpath
    And user click on action with id: ejar.bookingavailability.branch.expandTwisty.byxpath
    And user click on action with id: ejar.bookingavailability.branch.Checkbox.byxpath
    And click on element: ejar.bookingavailability.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: bookingAvailabilityVariable
    And user click on view action: Edit,تعديل  related to record with text stored in variable: bookingAvailabilityVariable then select record at index: 1
    And user click on action with id: ejar.bookingavailability.isactive.field.byxpath
    And click on element: ejar.bookingavailability.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.bookingavailability.createnew.byxpath

  @TestType-Smoke
  Scenario: Create and verify Extra Save It Then Deactivate it
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/extras
    And click on link: ejar.extras.createnew.byxpath
    And verify ejar fields label with soft assertion in form: extra-definition-default text: ejar.extras.alllabels.label.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Add New Extra,إضافة                           |  h1     |
      | Standard Definition,التعريف القياسي           |  a      |
      | Country's Definition,تخصيص حسب الدولة         |  a      |
      | General,عــام                                 |  a      |
      | Extra Type,نوع الإضافة                         |  label  |
      | Not Intersect With,لا يتقاطع مع                |  label  |
      | Active,مفعل                                   |  span   |
      | Name [en],الاسـم [en]                          |  label  |
      | Name [ar],الاسـم [ar]                          |  label  |
      | Applied on,مطبق على                           |  label  |
      | Short Description [en],الوصف الفصير [en]      |  label  |
      | Icon,الرمز                                    |  label  |
      | Short Description [ar],الوصف الفصير [ar]      |  label  |
      | Long Description [en],الوصف الطويل [en]       |  label  |
      | Long Description [ar],الوصف الطويل [ar]       |  label  |
      | Terms And Conditions [en],الشروط والاحكام [en] |  label  |
      | Terms And Conditions [ar],الشروط والاحكام [ar] |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.extras.extraTypeCombobox.field.edit.byxpath                   | True       | True       |
      | ejar.extras.standardDefinition.field.edit.byxpath                  | True       | False      |
      | ejar.extras.countryDefinition.field.edit.byxpath                   | False      | False      |
      | ejar.extras.general.field.edit.byxpath                             | True       | False      |
      | ejar.extras.notIntersectWithMultiSelect.field.edit.byxpath         | True       | False      |
      | ejar.extras.isActive.field.input.edit.byxpath                      | True       | False      |
      | ejar.extras.name_en.field.edit.byxpath                             | True       | True       |
      | ejar.extras.name_ar.field.edit.byxpath                             | True       | True       |
      | ejar.extras.appliedOn.field.edit.byxpath                           | True       | True       |
      | ejar.extras.ShortDescription_en.field.edit.byxpath                 | True       | False      |
      | ejar.extras.ShortDescription_ar.field.edit.byxpath                 | True       | False      |
      | ejar.extras.icon.field.byxpath                                     | True       | False      |
      | ejar.extras.LongDescription_en.field.edit.byxpath                  | True       | False      |
      | ejar.extras.LongDescription_ar.field.edit.byxpath                  | True       | False      |
      | ejar.extras.termsEN.field.byxpath                                  | True       | False      |
      | ejar.extras.termsAR.field.byxpath                                  | True       | False      |
    And user select value in drop down field: ejar.extras.extraType.field.byxpath by option text: Snow Chains,سلاسل الثلج
    And user select option by text in ejar kendo option field: ejar.extras.appliedOn.field.byxpath option: Broker,الوسيط
    And set random text in variable and into element: ejar.extras.nameEnglish.field.byxpath with size: 10 and initial string: UI Automation Extra and store value in variable: extraVariable
    And set value into field: ejar.extras.nameArabic.field.byxpath from stored variable: extraVariable
    And user click on action with id: ejar.extras.next.button.byxpath
    And user click on action with id: ejar.extras.next.button.byxpath
    And verify form page labels and text:
      | Text                                                                 | TagType |
      | Price Category,فئة التسعير                                           |  label  |
      | Price Dependency,اعتمادية التسعير                                    |  label  |
      | When to Add,وقت الإضافة                                               |  label  |
      | Contract Types,انواع العقود                                          |  label  |
      | Max Repetition,اقصي تعدد                                             |  label  |
      | Automatically Added When Total Discount,تضاف تلقائياً عند الخصم الكلي |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.extras.priceCategory.field.edit.byxpath                       | True       | True       |
      | ejar.extras.priceDependency.field.edit.byxpath                     | True       | True       |
      | ejar.extras.whenToAdd.field.edit.byxpath                           | True       | True       |
      | ejar.extras.contractTypes.field.edit.byxpath                       | True       | True       |
      | ejar.extras.maxRepetition.field.edit.byxpath                       | True       | True       |
      | ejar.extras.back.field.edit.byxpath                                | False      | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
    And user select value in drop down field: ejar.extras.pricecategory.field.byxpath by option text: Variable By Duration, متغير حسب المدة
    And user select value in drop down field: ejar.extras.pricedependency.field.byxpath by option text: Category, الفئة
    And select option in ejar kendo option field: ejar.extras.whentoadd.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.extras.contracttypes.field.byxpath by index: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.extras.createnew.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: extraVariable
    And user click on view action: Edit,تعديل  related to record with text stored in variable: extraVariable then select record at index: 1
    And user click on action with id: ejar.extras.isActive.checkbox.field.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.extras.createnew.byxpath

  @TestType-Smoke
  Scenario: Create and verify Accident Rental Restriction save it Then Deactivate it
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/rental-restrictions
    And wait for element present: ejar.accidentrestriction.createnew.byxpath for period in seconds: 100
    And click on link: ejar.accidentrestriction.createnew.byxpath
    And click on element: ejar.accidentrestriction.rentWithException.field.byxpath
    And verify ejar fields label with soft assertion in form: restriction-basic-info text: ejar.accidentrestriction.basicInfo.labels.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Rental Restrictions,موانع التأجير                     |  h1     |
      | Add Accident Restriction,إضافة موانع الحوادث          |  span   |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Restriction Filter,محددات المانع                      |  div    |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Name,الاسم                                             |  label  |
      | Start Date,تاريخ البداية                              |  label  |
      | End Date,تاريخ النهاية                                |  label  |
      | Rent with exceptions,يُؤجر بإستثناءات                  |  label  |
      | Not to be rented,لا يٌؤجر                               |  label  |
      | Rental Restriction Exceptions,استثناءات قيود التأجير  |  label  |
      | Insurance deposit ratio %,دفعة التأمين معدله %        |  label  |
      | Accident Policy ratio %,بوليصة التحمل معدله %         |  label  |
      | Advanced Payment Ratio %,دفعة المقدم المعدله %        |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.accidentrestriction.name.field.byxpath                        | True       | True       |
      | ejar.accidentrestriction.startDate.field.byxpath                   | True       | True       |
      | ejar.accidentrestriction.endDate.field.byxpath                     | True       | False      |
      | ejar.accidentrestriction.rentWithException.field.byxpath           | True       | False      |
      | ejar.accidentrestriction.notToBeRented.field.byxpath               | True       | False      |
      | ejar.accidentrestriction.exceptions.field.byxpath                  | True       | True       |
      | ejar.accidentrestriction.insuranceRatio.field.byxpath              | True       | True       |
      | ejar.accidentrestriction.accidentRatio.field.byxpath               | True       | True       |
      | ejar.accidentrestriction.advancedRatio.field.byxpath               | True       | False      |
      | ejar.accidentrestriction.next.field.byxpath                        | False      | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And click on element: ejar.accidentrestriction.notToBeRented.field.byxpath
    And set random text in variable and into element: ejar.rntalrestrictions.name.field.byxpath with size: 10 and initial string: UI Automation Rental Restriction and store value in variable: restrictionVariable
    And user click on action with id: ejar.rntalrestrictions.next1.button.byxpath
    And verify ejar fields label with soft assertion in form: accident-restriction-filter-info text: ejar.accidentrestriction.restrictionFilter.labels.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Restriction Filter,محددات المانع                      |  div    |
      | Accident with percentage > 0,حوادث بنسبة تحمل > 0     |  label  |
      | Solid object,جسم صلب                                  |  label  |
      | Escape without information,هروب بدون معلومات          |  label  |
      | Without insurance,لا يشلمه التأمين                     |  label  |
      | The period of the accident,فترة وقوع الحادث           |  label  |
      | The period of the accident,فترة وقوع الحادث           |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.accidentrestriction.accidentPercentage.field.byxpath          | True       | True       |
      | ejar.accidentrestriction.solidObject.field.byxpath                 | True       | False      |
      | ejar.accidentrestriction.escapeWithoutInfo.field.byxpath           | True       | False      |
      | ejar.accidentrestriction.noInsurance.field.byxpath                 | True       | False      |
      | ejar.accidentrestriction.periodOfAccident.field.byxpath            | True       | True       |
      | ejar.accidentrestriction.back.field.byxpath                        | True       | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And set value into element : ejar.accidentrestriction.accidentPercentage.input.byxpath value: 1
    And set value into element : ejar.accidentrestriction.periodOfAccident.input.byxpath value: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.rntalrestrictions.createnew.byxpath
    And user scroll to the top of the page
    And filter view on column name: Name,الاسم and enter value stored in variable: restrictionVariable
    And click on element: ejar.accidentrestriction.firstRow.button.byxpath
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Rental Restrictions,موانع التأجير                     |   h1    |
      | View Accident Accident Restriction,عرض مانع الحوادث   |  span   |
      | Basic Information,المعلومات الاساسية                   |  div    |
      | Name,الاسم                                             | label   |
      | Start Date,تاريخ البداية                              | label   |
      | End Date,تاريخ النهاية                                | label   |
      | Rent with exceptions,يُؤجر بإستثناءات                  | label   |
      | Not to be rented,لا يٌؤجر                               | label   |
      | Restriction Filter,محددات المانع                      |  div    |
      | Accident with percentage > 0,حوادث بنسبة تحمل > 0     | label   |
      | Escape without information,هروب بدون معلومات          | label   |
      | The period of the accident,فترة وقوع الحادث           | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.accidentrestriction.name.field.read.byxpath                   | False      | False      |
      | ejar.accidentrestriction.startDate.field.read.byxpath              | False      | False      |
      | ejar.accidentrestriction.notToBeRented.field.read.byxpath          | False      | False      |
      | ejar.accidentrestriction.accidentWithPercentage.field.read.byxpath | False      | False      |
      | ejar.generic.close.action.byxpath                                  | True       | False      |
      | ejar.accidentrestriction.edit.button.byxpath                       | True       | False      |
      | ejar.accidentrestriction.deactivate.input.byxpath                  | True       | False      |
    And click on element: ejar.accidentrestriction.deactivate.input.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for number of seconds: 1

  @TestType-Smoke
  Scenario: Create and verify Bulk Leasing Contract
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/contracts
    And click on element: ejar.bulkleasing.create.byxpath
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Add Bulk Leasing Contracts,تحميل عقود سنوية              |  h4     |
      | Attachment,المرفق                                        |  label  |
      | Drag files here to upload,اسحب الملفات هنا للتحميل       |  div    |
      | Continue In Case Of Error,المواصلة في حالة حدوث خطأ      |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.bulkleasing.downloadTemplate.byxpath                          | True       | False      |
      | ejar.bulkleasing.cancel.button.byxpath                             | True       | False      |
      | ejar.bulkleasing.save.byxpath                                      | False      | False      |
      | ejar.bulkleasing.continueInCaseOfErrorCheckbox.byxpath             | True       | False      |
      | ejar.bulkleasing.upload.div.byxpath                                | True       | False      |
    And upload file to element: ejar.bulkleasing.upload.byxpath with path: //uploadFiles//LeasingContractsTemplate.rar
    And click on element: ejar.bulkleasing.continueInCaseOfErrorCheckbox.byxpath
    And click on element: ejar.bulkleasing.save.byxpath
    And click on element: ejar.generic.yes.action.byxpath

  @TestType-Smoke
  Scenario: Create and verify Individual Historical Contract
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/contracts
    And click on element: ejar.individualhistorical.create.byxpath
    And verify ejar fields label with soft assertion in form: app-contract-information text: ejar.individualhistorical.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Contract,العقد                                           |  h1     |
      | Add Individual Historical Contract,إضافة عقد افراد مغلق  |  span   |
      | Contract Information,معلومات العقد                       |  div    |
      | Extras,الاضافات                                           |  div    |
      | Payment-Open,الدفع-فتح                                   |  div    |
      | Rental Check-Open,تشيك السيارة-فتح                       |  div    |
      | Rental Check-Close,تشيك السيارة-اغلاق                     |  div    |
      | Payment-Close,الدفع-اغلاق                                 |  div    |
      | Customer Identity Number,رقم إثبات العميل                |  label  |
      | Pick-up Branch,فرع الخروج                                |  label  |
      | Drop-off Branch,فرع العودة                               |  label  |
      | Pick-up Date,وقت الخروج                                  |  label  |
      | Drop-off Date,وقت العودة                                 |  label  |
      | Plate Number,رقم اللوحة                                  |  label  |
      | Contract No.,رقم العقد                                   |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.individualhistorical.identity.field.byxpath                   | True       | True       |
      | ejar.individualhistorical.pickUpBranch.field.byxpath               | False      | False      |
      | ejar.individualhistorical.dropOffBranch.field.byxpath              | True       | True       |
      | ejar.individualhistorical.pickUpDate.field.byxpath                 | True       | True       |
      | ejar.individualhistorical.dropOffDate.field.byxpath                | True       | True       |
      | ejar.individualhistorical.plateNumber.field.byxpath                | False      | False      |
      | ejar.individualhistorical.contractNo.field.byxpath                 | True       | False      |
      | ejar.individualhistorical.next1.button.byxpath                     | False      | False      |
      | ejar.individualhistorical.save.button.byxpath                      | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And click on element: ejar.individualhistorical.next1.button.byxpath


  @TestType-Smoke
  Scenario: Create and verify Leasing Request form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/leasing-requests
    And Create corporate with the name variable: automationCorporateName
    And approve corporate with name stored in variable: automationCorporateName
    And create leasing quotation for the corporate name stored in variable: automationCorporateName
    And create corporate agreement with name stored in variable: automationCorporateName
    And open page using url: /app/rental/corporates/leasing-requests
    And click on link: ejar.leasingrequst.createnew.byxpath
    And verify ejar fields label with soft assertion in form: leasing-request-creation text: ejar.leasingrequst.labels.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Create New Request,إضافة تعميد                |  span   |
      | Corporate,الشركة                              |  label  |
      | Corporates Quotations,عروض اسعار الشركات      |  label  |
      | Select,إختيار                                 |  span   |
      | Category,الفئة                                |  span   |
      | Model,الموديل                                 |  span   |
      | Year,السنه                                    |  span   |
      | Duration in months,مدة الإيجار بالأشهر          |  span   |
      | Monthly rate,سعر الإيجار الشهرى                |  span   |
      | Number of vehicles,عدد المركبات               |  span   |
      | Number Of Free Vehicles,عدد المركبات المجانية |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.leasingrequst.corporate.field.byxpath                         | True       | False      |
      | ejar.leasingrequst.corporateQuotation.field.byxpath                | False      | False      |
      | ejar.leasingrequst.search.button.byxpath                           | False      | False      |
      | ejar.leasingrequst.save.button.byxpath                             | False      | False      |
      | ejar.leasingrequst.cancel.button.byxpath                           | True       | False      |
    And user select option by text in ejar kendo option field without click on empty field: ejar.leasingrequst.corporate.input.byxpath with option value from stored variable: automationCorporateName
    And click on element: ejar.leasingrequst.corporatesquotations.field.byxpath
    And click on element: ejar.leasingrequst.corporatesquotationsFirstOption.field.byxpath
    And click on element: ejar.leasingrequst.search.button.byxpath
    And click on element: ejar.leasingrequst.firstRowRequest.button.byxpath
    And click on element: ejar.leasingrequst.save.button.byxpath



  @TestType-Smoke
  Scenario: Create and verify Leasing Quotation form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/corporates/leasing-quotations
    And Create corporate with the name variable: automationCorporateName
    And approve corporate with name stored in variable: automationCorporateName
    And open page using url: /app/rental/corporates/leasing-quotations
    And click on link: ejar.leasingquotation.createnew.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.leasingquotation.corporate.field.edit.byxpath     | true       | true       |
      | ejar.leasingquotation.country.field.edit.byxpath       | true       | true       |
      | ejar.leasingquotation.expirydate.field.edit.byxpath    | true       | true       |
      | ejar.leasingquotation.purchaseorder.field.edit.byxpath | true       | false      |
    And verify form page labels and text:
      | Text                                   | TagType |
      | Leasing Quotations,عروض الأسعار السنوية | h1      |
      | Create New Quotation,إضافة عرض اسعار   | span    |
      | Corporate,الشركة                       | label   |
      | Country,الدولة                         | label   |
      | Purchase Order,أمر الشراء              | label   |
      | Expiry Date,تاريخ الانتهاء              | label   |
    And verify element text present: ejar.leasingquotation.basicinformation.label.byxpath with text: ejar.leasingquotation.basicinformation.label.text
    And wait for action to be clickable: ejar.leasingquotation.corporate.field.byxpath
    And user select option by text in ejar kendo option field without click on empty field: ejar.leasingquotation.corporate.field.byxpath with option value from stored variable: automationCorporateName
    And click on link: ejar.leasingquotation.next1.button.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                               | isEditable | isRequired |
      | eja.leasingquotation.category.field.edit.byxpath         | true       | true       |
      | eja.leasingquotation.model.field.edit.byxpath            | true       | true       |
      | eja.leasingquotation.years.field.edit.byxpath            | true       | true       |
      | eja.leasingquotation.numberofvehicles.field.edit.byxpath | true       | false      |
      | eja.leasingquotation.duration.field.edit.byxpath         | true       | true       |
      | eja.leasingquotation.monthlyratee.field.read.byxpath     | false      | true       |
    And verify form page labels and text:
      | Text                                 | TagType |
      | Category,الفئة                       | span    |
      | Model,الموديل                        | span    |
      | Manufacture Year,سنة الصنع           | span    |
      | Number of vehicles,عدد المركبات      | span    |
      | Duration in months,مدة الإيجار بالأشهر | span    |
      | Monthly rate,سعر الإيجار الشهرى       | span    |
    And verify element text present: ejar.leasingquotation.vehicle.label.byxpath with text: ejar.leasingquotation.vehicle.label.text
    And verify table header: ejar.leasingquotation.tableheaders.label.byxpath with text: ejar.leasingquotation.tableheaders.label.text
    And user select option by text in ejar kendo option field: eja.leasingquotation.category.field.byxpath option: Automation Small Sedan,Automation Small Sedan
    And user select option by text in ejar kendo option field: eja.leasingquotation.model.field.byxpath option: Automation Accent,Automation Accent
    And user select value in drop down field: eja.leasingquotation.years.field.byxpath by option text: 2020,2020
    And user set in field: eja.leasingquotation.numberofvehicles.field.byxpath value: 1
    And user select option by text in ejar kendo option field: eja.leasingquotation.duration.field.byxpath option: 12,12
    And click on link: eja.leasingquotation.customization.button.byxpath
    And wait for element present: ejar.leasingquotation.vehicleprice.field.edit.byxpath for period in seconds: 60
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.leasingquotation.vehicleprice.field.edit.byxpath             | true       | true       |
      | ejar.leasingquotation.maintenance.field.edit.byxpath              | true       | true       |
      | ejar.leasingquotation.profit.field.edit.byxpath                   | true       | true       |
      | ejar.leasingquotation.sellingafterperiod.field.edit.byxpath       | true       | true       |
      | ejar.leasingquotation.insurance.field.edit.byxpath                | true       | true       |
      | ejar.leasingquotation.replacementvehicle.field.edit.byxpath       | true       | true       |
      | ejar.leasingquotation.salariesexpenses.field.edit.byxpath         | true       | true       |
      | ejar.leasingquotation.administrativeexpenses.field.edit.byxpath   | true       | true       |
      | ejar.leasingquotation.finaldiscount.field.edit.byxpath            | true       | true       |
      | ejar.leasingquotation.annualcommission.field.edit.byxpath         | true       | true       |
      | ejar.leasingquotation.depreciation.field.read.byxpath             | false      | true       |
      | ejar.leasingquotation.maxDailyrate.field.edit.byxpath             | true       | true       |
      | ejar.leasingquotation.monthlyratee.field.edit.byxpath             | true       | false      |
    And verify form page labels and text:
      | Text                                  | TagType |
      | Category,الفئة                        | label   |
      | Model,الموديل                         | label   |
      | Manufacture Year,سنة الصنع            | label   |
      | Duration,المدة                        | label   |
      | Vehicle Price,سعر السيارة             | label   |
      | Maintenance, الصيانة                  | label   |
      | Profit,الربح                          | label   |
      | Selling After Period,البيع بعد مدة    | label   |
      | Insurance,التأمين                     | label   |
      | Replacement Vehicle,تبديل المركبة     | label   |
      | Salaries Expenses,مصاريف رواتب        | label   |
      | Administrative Expenses,مصاريف إدارية | label   |
      | Final Discount,الخصم النهائى          | label   |
      | Annual Commission,العمولة السنوية     | label   |
      | Depreciation,نسبة الإهلاك               | label   |
      | Max Daily Rate,أعلى معدل تأجير يومى   | label   |
      | Monthly rate,سعر الإيجار الشهرى        | label   |
    And verify element present: eja.leasingquotation.calculate.button.byxpath
    And verify element present: eja.leasingquotation.save1.button.byxpath
    And verify element present: eja.leasingquotation.close.button.byxpath
    And click on link: eja.leasingquotation.cancel1.button.byxpath
    And click on link: eja.leasingquotation.calculator.button.byxpath
    And verify element present: eja.leasingquotation.back1.button.byxpath
    And verify element present: eja.leasingquotation.cancel.button.byxpath
    And click on link: eja.leasingquotation.save.button.byxpath
    And click on link: eja.leasingquotation.next2.field.byxpath
    And verify form page labels and text:
      | Text                    | TagType |
      | Classification,التصنيف  | span    |
      | Accident,الحادث         | span    |
    And verify element text present: ejar.leasingquotation.headers.accidentpolicy.label.byxpath with text: ejar.leasingquotation.headers.accidentpolicy.label.text
    And verify element present: eja.leasingquotation.back2.button.byxpath
    And verify element present: ejar.generic.cancel.action.byxpath
    And verify element present: eja.leasingquotation.addform.button.byxpath
    And user click on action with id: eja.leasingquotation.addform.button.byxpath
    And user click on action with id: ejar.createsparepart.yes.confirm.button.byxpath
    And verify element present: ejar.leasingquotation.createnew.byxpath
    And filter view on column name: Corporate,الشركة and enter value stored in variable: automationCorporateName
    And user click on action with xpath: (//kendo-grid-list//td//a[@class='quotationNo'])[1]
    And verify form page labels and text:
      | Text                                 | TagType |
      | Corporate,الشركة                     | label   |
      | Country,الدولة                       | label   |
      | Expiry Date,تاريخ الانتهاء            | label   |
      | Category,الفئة                       | span    |
      | Model,الموديل                        | span    |
      | Manufacture Year,سنة الصنع           | span    |
      | Number of vehicles,عدد المركبات      | span    |
      | Duration in months,مدة الإيجار بالأشهر | span    |
      | Monthly rate,سعر الإيجار الشهرى       | span    |
      | Classification,التصنيف               | span    |
      | Accident,الحادث                      | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.leasingquotation.corporate.field.read.byxpath                | false       | false     |
      | ejar.leasingquotation.country.field.read.byxpath                  | false       | false     |
      | ejar.leasingquotation.expirydate.field.read.byxpath               | false       | false     |
      | eja.leasingquotation.category.field.read.byxpath                  | false       | false     |
      | eja.leasingquotation.model.field.read.byxpath                     | false       | false     |
      | eja.leasingquotation.years.field.read.byxpath                     | false       | false     |
      | eja.leasingquotation.numberofvehicles.field.read.byxpath          | false       | false     |
      | eja.leasingquotation.duration.field.read.byxpath                  | false       | false     |
      | eja.leasingquotation.monthlyrate.field.read.byxpath               | false       | false     |
      | ejar.leasingquotation.classification.field.read.byxpath           | false       | false     |
      | ejar.leasingquotation.accident.field.read.byxpath                 | false       | false     |
    And user click on action with id: eja.leasingquotation.pricedetails.button.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.leasingquotation.vehicleprice.field.read.byxpath             | false       | true      |
      | ejar.leasingquotation.maintenance.field.read.byxpath              | false       | true      |
      | ejar.leasingquotation.profit.field.read.byxpath                   | false       | true      |
      | ejar.leasingquotation.sellingafterperiod.field.read.byxpath       | false       | true      |
      | ejar.leasingquotation.insurance.field.read.byxpath                | false       | true      |
      | ejar.leasingquotation.replacementvehicle.field.read.byxpath       | false       | true      |
      | ejar.leasingquotation.salariesexpenses.field.read.byxpath         | false       | true      |
      | ejar.leasingquotation.administrativeexpenses.field.read.byxpath   | false       | true      |
      | ejar.leasingquotation.finaldiscount.field.read.byxpath            | false       | true      |
      | ejar.leasingquotation.annualcommission.field.read.byxpath         | false       | true      |
      | ejar.leasingquotation.depreciation.field.read.byxpath             | false       | true      |
      | ejar.leasingquotation.maxDailyrate.field.edit.byxpath             | true        | true      |
      | ejar.leasingquotation.monthlyratee.field.read.byxpath             | false       | false     |




  @TestType-Smoke
  Scenario: Create and verify Corporate Historical Contract
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/contracts
    And click on element: ejar.corporatehistorical.create.byxpath
    And verify ejar fields label with soft assertion in form: app-corporate-contract-information text: ejar.corporatehistorical.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Contract,العقد                                           |  h1     |
      | Add Corporate Historical Contract,إضافة عقد شركات مغلق   |  span   |
      | Contract Information,معلومات العقد                       |  div    |
      | Rental Check-Open,تشيك السيارة-فتح                       |  div    |
      | Rental Check-Close,تشيك السيارة-اغلاق                     |  div    |
      | Booking Number,رقم الحجز                                 |  label  |
      | Customer Identity Number,رقم إثبات العميل                |  label  |
      | Pick-up Branch,فرع الخروج                                |  label  |
      | Drop-off Branch,فرع العودة                               |  label  |
      | Pick-up Date,وقت الخروج                                  |  label  |
      | Drop-off Date,وقت العودة                                 |  label  |
      | Plate Number,رقم اللوحة                                  |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.corporatehistorical.booking.field.byxpath                     | True       | True       |
      | ejar.corporatehistorical.identity.field.byxpath                    | False      | False      |
      | ejar.corporatehistorical.pickUpBranch.field.byxpath                | False      | False      |
      | ejar.corporatehistorical.dropOffBranch.field.byxpath               | False      | False      |
      | ejar.corporatehistorical.pickUpDate.field.byxpath                  | False      | False      |
      | ejar.corporatehistorical.dropOffDate.field.byxpath                 | False      | False      |
      | ejar.corporatehistorical.plateNumber.field.byxpath                 | True       | True       |
      | ejar.corporatehistorical.next1.button.byxpath                      | False      | False      |
      | ejar.corporatehistorical.save.button.byxpath                       | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |

  @TestType-Smoke
  Scenario: Create and Verify OPL Rates
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/opl-rental-rate
    And click on link: ejar.oplrates.createNew.byxpath
    And verify ejar fields label with soft assertion in form: fieldset text: ejar.oplrates.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | OPL Rates,اسعار الافراد السنويه                           | h1      |
      | Create New OPL Rate,اضافة سعر افراد سنوي                 | span    |
      | Basic Information,المعلومات الاساسية                      | li      |
      | Country,الدولة                                           | label   |
      | Category,الفئة                                           | label   |
      | Manufacturer,الشركة المصنعة                              | label   |
      | Model,الموديل                                            | label   |
      | Manufacture Year,سنة الصنع                               | label   |
      | Free KM,الكم المجاني                                     | label   |
      | Extra Km Cost,أجرة الكم الزائد                           | label   |
      | OPL Rental Rates Periods,فترات اسعار الافراد السنوية      | li      |
      | Period Name,اسم الفترة                                   | label   |
      | Rental Rate,سعر تأجير                                    | label   |
      | 12 months,12 شهر                                         | label   |
      | 24 months,24 شهر                                         | label   |
      | 36 months,36 شهر                                         | label   |
      | 48 months,48 شهر                                         | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.oplrates.country.field.byxpath                                   | true       | true       |
      | ejar.oplrates.categories.field.byxpath                                | true       | true       |
      | ejar.oplrates.manufacturers.field.byxpath                             | true       | true       |
      | ejar.oplrates.models.field.byxpath                                    | true       | true       |
      | ejar.oplrates.years.field.byxpath                                     | true       | true       |
      | ejar.oplrates.freeKm.field.byxpath                                    | true       | true       |
      | ejar.oplrates.extraKmCost.field.byxpath                               | true       | true       |
      | ejar.oplrates.rate12Month.field.byxpath                               | true       | false      |
      | ejar.oplrates.rate24Month.field.byxpath                               | true       | false      |
      | ejar.oplrates.rate36Month.field.byxpath                               | true       | false      |
      | ejar.oplrates.rate48Month.field.byxpath                               | true       | false      |
      | ejar.generic.save.action.byxpath                                      | false      | false      |
      | ejar.generic.cancel.action.byxpath                                    | true       | false      |
    And user select value in drop down field: ejar.oplrates.categories.field.byxpath by option text: Automation Small Sedan,Automation Small Sedan
    And user select value in drop down field: ejar.oplrates.manufacturers.field.byxpath by option text: Automation Hyundai,Automation Hyundai
    And user select value in drop down field: ejar.oplrates.models.field.byxpath by option text: Automation Accent,Automation Accent
    And user select value in drop down field: ejar.oplrates.years.field.byxpath by option text: 2020,2020
    And user set in field: ejar.oplrates.freeKm.field.byxpath value: 170
    And user set in field: ejar.oplrates.extraKmCost.field.byxpath value: 1
    And user set in field: ejar.oplrates.rate12Month.field.byxpath value: 100
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And user click on action if enabled with id: ejar.oplrates.areyousure.field.byxpath
    And click on action if exist with wait: ejar.generic.confirmYes.action.byxpath waiting number of seconds: 5
    And verify element present: ejar.oplrates.createNew.byxpath

  @TestType-Regression
  Scenario: Create and verify Monthly Rental Rate Verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/rental-rate
    And wait for element present: ejar.monthlyrate.createMonthlyRate.byxpath for period in seconds: 120
    And click on element: ejar.monthlyrate.createMonthlyRate.byxpath
    And verify ejar fields label with soft assertion in form: app-basic-information text: ejar.monthlyrate.basicInfo.labels.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Rental Rates,أسعار التأجير                    |  h1     |
      | Create Monthly Rate,إضافة تسعير شهري          |  span   |
      | Basic Information,المعلومات الاساسية           |  div    |
      | Rates Information,معلومات الاسعار              |  div    |
      | Start Date,تاريخ البداية                      |  label  |
      | End Date,تاريخ النهاية                        |  label  |
      | Country,الدولة                                |  label  |
      | Branch,الفرع                                  |  label  |
      | Category,الفئة                                |  label  |
      | Manufacturer,الشركة المصنعة                   |  label  |
      | Model,الموديل                                 |  label  |
      | Manufacture Year,سنة الصنع                    |  label  |
      | Trim,مستوى المواصفات                          |  label  |
      | Engine Size (CC),سعة المحرك (CC)              |  label  |
      | Monthly Free Km,الكم المجاني الشهري           |  label  |
      | Extra Km Cost,أجرة الكم الزائد                |  label  |
      | Is Active,فعال                                |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.monthlyrate.startDate.field.byxpath                              | true       | true       |
      | ejar.monthlyrate.endDate.field.byxpath                                | true       | false      |
      | ejar.monthlyrate.country.field.byxpath                                | true       | true       |
      | ejar.monthlyrate.branch.field.byxpath                                 | true       | true       |
      | ejar.monthlyrate.category.field.byxpath                               | true       | true       |
      | ejar.monthlyrate.manufacturer.field.byxpath                           | true       | true       |
      | ejar.monthlyrate.model.field.byxpath                                  | true       | true       |
      | ejar.monthlyrate.manufactureYear.field.byxpath                        | false      | true       |
      | ejar.monthlyrate.trim.field.byxpath                                   | true       | true       |
      | ejar.monthlyrate.engineSize.field.byxpath                             | true       | false      |
      | ejar.monthlyrate.monthlyFreeKm.field.byxpath                          | true       | false      |
      | ejar.monthlyrate.extraKmCost.field.byxpath                            | true       | false      |
      | ejar.monthlyrate.isActive.field.byxpath                               | false      | false      |
      | ejar.monthlyrate.next1.button.byxpath                                 | false      | false      |
      | ejar.monthlyrate.save.button.byxpath                                  | false      | false      |
      | ejar.monthlyrate.cancel.button.byxpath                                | true       | false      |
    And user select value in drop down field: ejar.monthlyrate.branch.field.byxpath by option text: Automation Branch,Automation Branch
    And user select value in drop down field: ejar.monthlyrate.category.field.byxpath by option text: Automation Small Sedan, Automation Small Sedan
    And user select value in drop down field: ejar.monthlyrate.manufacturer.field.byxpath by option text: Automation Hyundai, Automation Hyundai
    And user select value in drop down field: ejar.monthlyrate.model.field.byxpath by option text: Automation Accent,Automation Accent
    And click on element: ejar.monthlyrate.next1.button.byxpath
    And verify form page labels and text:
      | Text                                          | TagType |
      | Period Name,اسم الفترة                        |  td     |
      | Rental Rate,سعر تأجير                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.monthlyrate.oneMonth.field.byxpath                               | true       | true       |
      | ejar.monthlyrate.threeMonths.field.byxpath                            | true       | true       |
      | ejar.monthlyrate.sixMonths.field.byxpath                              | true       | true       |
      | ejar.monthlyrate.nineMonths.field.byxpath                             | true       | true       |
      | ejar.monthlyrate.twelveMonths.field.byxpath                           | true       | true       |
      | ejar.monthlyrate.save.button.byxpath                                  | false      | false      |
      | ejar.monthlyrate.cancel.button.byxpath                                | true       | false      |
      | ejar.monthlyrate.back.button.byxpath                                  | true       | false      |
    And set value into element : ejar.monthlyrate.oneMonth.field.byxpath value: 100
    And set value into element : ejar.monthlyrate.threeMonths.field.byxpath value: 200
    And set value into element : ejar.monthlyrate.sixMonths.field.byxpath value: 300
    And set value into element : ejar.monthlyrate.nineMonths.field.byxpath value: 400
    And set value into element : ejar.monthlyrate.twelveMonths.field.byxpath value: 500
    And click on element: ejar.monthlyrate.save.button.byxpath



  Scenario: Create and verify Monthly booking
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/bookings
    And change setting in the country: Saudi Arabia,المملكة العربية السعودية with the name: Maximum number of active Un-paid bookings for the customer!,الحد الاعلى لعدد الحجوزات الفعالة غير المدفوعة للعميل and the text field value: 11
    And open page using url: /app/rental/bookings
    And wait for element present: ejar.monthlybookings.create.button.byxpath for period in seconds: 100
    And click on element: ejar.monthlybookings.create.button.byxpath
    And click on element: ejar.monthlybookings.returnAtPickup.button.byxpath
    And verify ejar fields label with soft assertion in form: monthlybookingdetails text: ejar.monthlybookings.bookingDetails.labels.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Booking,الحجز                                   | h1      |
      | Create Monthly Booking,إضافة حجز شهري           | span    |
      | Booking Details,تفاصيل الحجز                    | div     |
      | Vehicle,المركبة                                 | div     |
      | Customer,العميل                                 | div     |
      | Extras,الاضافات                                  | div     |
      | Payment,الدفع                                   | div     |
      | Countries,الدول                                 | label   |
      | Pick-up Branch,فرع الخروج                       | label   |
      | Drop-off Branch,فرع العودة                      | label   |
      | Pick-up Date,وقت الخروج                         | label   |
      | Contract Length,مدة العقد                       | label   |
      | Drop-off Date,وقت العودة                        | label   |
      | Driver Information,معلومات السائق               | span    |
      | Name:,الاسم:                                     | label   |
      | Identity number:,رقم الإثبات:                    | label   |
      | Phone number:,رقم الجوال:                       | label   |
      | Vehicle,المركبة                                 | span    |
      | Category:,الفئة:                                | label   |
      | Model:,الموديل:                                 | label   |
      | Manufacturing Year:,سنة الصنع:                  | label   |
      | Financial,المالية                               | span    |
      | Net Amount:,صافي القيمة:                        | label   |
      | Paid:,المدفوع:                                  | label   |
      | Remaining:,المتبقي:                             | label   |
      | Voucher Amount:,قيمة السند:                     | label   |
      | Comment,الملاحظه                                 | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.monthlybookings.countries.field.byxpath                      | true       | true       |
      | ejar.monthlybookings.pickupBranch.field.byxpath                   | true       | true       |
      | ejar.monthlybookings.dropOffBranch.field.byxpath                  | true       | true       |
      | ejar.monthlybookings.pickupDate.field.byxpath                     | true       | true       |
      | ejar.monthlybookings.contractLength.field.byxpath                 | true       | true       |
      | ejar.monthlybookings.dropOffDate.field.byxpath                    | false      | true       |
      | ejar.monthlybookings.next1.field.byxpath                          | false      | false      |
      | ejar.monthlybookings.save.field.byxpath                           | false      | false      |
      | ejar.monthlybookings.cancel.field.byxpath                         | true       | false      |
    And user select option by text in ejar kendo option field: ejar.monthlybookings.pickupBranch.field.byxpath option: Automation Branch,Automation Branch
    And user select option by text in ejar kendo option field: ejar.monthlybookings.dropOffBranch.field.byxpath option: Automation Branch,Automation Branch
    And user select date time in ejar calendar field: ejar.monthlybookings.pickupDate.input.byxpath plus days: 1 and time: 10:00
    And user set in field: ejar.monthlybookings.contractLength.field.byxpath value: 3
    And click on element: ejar.monthlybookings.next1.field.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.monthlybookings.category.dropdownlist.byxpath                | true       | true       |
      | ejar.monthlybookings.carModels.dropdownlist.byxpath               | true       | true       |
      | ejar.monthlybookings.carManufactureYear.dropdownlist.byxpath      | true       | true       |
      | ejar.monthlybookings.next2.button.byxpath                         | false      | false      |
      | ejar.monthlybookings.save.field.byxpath                           | false      | false      |
      | ejar.monthlybookings.cancel.field.byxpath                         | true       | false      |
    And wait for element not present: eja.bookings.spinner.div.byxpath
    And verify ejar fields label with soft assertion in form: bookingvehicle text: ejar.monthlybookings.bookingvehicle.labels.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Categories,الفئات                               | label   |
      | Models,الموديلات                                 | label   |
      | Years,السنوات                                   | label   |
    And user select option by text in ejar kendo option field: ejar.monthlybookings.category.dropdownlist.byxpath option: Automation Small Sedan,Automation Small Sedan
    And user select option by text in ejar kendo option field: ejar.monthlybookings.carModels.dropdownlist.byxpath option: Automation Accent,Automation Accent
    And user select option by text in ejar kendo option field: ejar.monthlybookings.carManufactureYear.dropdownlist.byxpath option: 2020,2020
    And wait for element not present: ejar.monthlybookings.load.div.byxpath
    And click on element: ejar.monthlybookings.next2.button.byxpath
    And verify ejar fields label with soft assertion in form: customer text: ejar.monthlybookings.customerinfo.labels.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Identity number,رقم الإثبات                      | label   |
      | Phone number,رقم الجوال                         | label   |
      | Customer Name,اسم العميل                        | label   |
      | Customer Email,البريد الالكتروني للعميل          | label   |
      | Membership number,رقم العضوية                   | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.monthlybookings.customerIdentity.field.byxpath               | true       | false      |
      | ejar.monthlybookings.phoneNumber.field.byxpath                    | true       | false      |
      | ejar.monthlybookings.search.button.byxpath                        | false      | false      |
      | ejar.monthlybookings.customerName.field.byxpath                   | true       | false      |
      | ejar.monthlybookings.customerEmail.field.byxpath                  | true       | false      |
      | ejar.monthlybookings.customerMembership.field.byxpath             | true       | false      |
      | ejar.monthlybookings.newCustomer.button.byxpath                   | true       | false      |
      | ejar.monthlybookings.editCustomer.button.byxpath                  | false      | false      |
      | ejar.monthlybookings.clearCustomer.button.byxpath                 | true       | false      |
      | ejar.monthlybookings.next3.button.byxpath                         | false      | false      |
      | ejar.monthlybookings.save.field.byxpath                           | false      | false      |
      | ejar.monthlybookings.cancel.field.byxpath                         | true       | false      |
    And search for customer in customer search field: ejar.monthlybookings.customerName.field.byxpath with name: Eyad Automation then select record at random index
    And click on element: ejar.monthlybookings.next3.button.byxpath
    And click on action if exist with wait: ejar.monthlybookings.rentalRestrictionWarning.button.byxpath waiting number of seconds: 5
    And click on action if exist with wait: ejar.monthlybookings.extrasWarning.button.byxpath waiting number of seconds: 5
    And click on element: ejar.monthlybookings.next4.button.byxpath
    And store element value: ejar.monthlybookings.customernamelabel.byxpath and value name: bookingCustomerName and keep number only: false
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
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.monthlybookings.comment.byxpath                              | true       | false      |
      | ejar.monthlybookings.save.field.byxpath                           | true       | false      |
      | ejar.monthlybookings.cancel.field.byxpath                         | true       | false      |
    And click on element: ejar.monthlybookings.save.field.byxpath
    And click on element: ejar.monthlybookings.savedialog.button.byxpath
    And wait for element present: ejar.monthlybookings.create.button.byxpath for period in seconds: 5
    And filter view on column name: Customer Name,اسم العميل and enter value stored in variable: bookingCustomerName
    And user click on action with xpath: (//grid-action-buttons//a[@id='dropdownMenuLink']//i)[1]
    And user click on action with xpath: (//bookings//grid-action-buttons//i[contains(@title,'Cancel Booking') or contains(@title,'الغاء الحجز')])[1]
    And wait for element present: ejar.cancelmonthlybooking.cancelReason.field.byxpath for period in seconds: 100
    And verify form page labels and text:
      | Text                                                                        | TagType |
      | Booking,الحجز                                                               | h1      |
      | Cancel Booking,الغاء الحجز                                                  | span    |
      | Number,الرقم                                                                | label   |
      | Created Date,تاريخ الإضافة                                                   | label   |
      | Pick-up Date,وقت الخروج                                                     | label   |
      | Customer Name,اسم العميل                                                    | label   |
      | Mobile,الموبايل                                                             | label   |
      | Customer Email,البريد الالكتروني للعميل                                      | label   |
      | Duration,المدة                                                              | label   |
      | Vehicle,المركبة                                                             | label   |
      | Cancel Reason,سبب الالغاء                                                    | label   |
      | Net Amount,صافي القيمة                                                      | label   |
      | Paid Amount,المبلغ المدفوع                                                  | label   |
      | Disbursement Amount,المبلغ المسترد                                          | label   |
      | Comment,الملاحظه                                                             | h5      |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                        | isEditable | isRequired |
      | ejar.cancelmonthlybooking.number.field.byxpath                    | false       | false      |
      | ejar.cancelmonthlybooking.createdDate.field.byxpath               | false       | false      |
      | ejar.cancelmonthlybooking.pickupDate.field.byxpath                | false       | false      |
      | ejar.cancelmonthlybooking.customer.field.byxpath                  | false       | false      |
      | ejar.cancelmonthlybooking.customermobile.field.byxpath            | false       | false      |
      | ejar.cancelmonthlybooking.customerEmail.field.byxpath             | false       | false      |
      | ejar.cancelmonthlybooking.duration.field.byxpath                  | false       | false      |
      | ejar.cancelmonthlybooking.vehicle.field.byxpath                   | false       | false      |
      | ejar.cancelmonthlybooking.cancelReason.field.byxpath              | True        | True       |
      | ejar.cancelmonthlybooking.netAmount.field.byxpath                 | false       | false      |
      | ejar.cancelmonthlybooking.paidAmount.field.byxpath                | false       | false      |
      | ejar.cancelmonthlybooking.AmountdisbursementAmount.field.byxpath  | false       | false      |
      | ejar.cancelmonthlybooking.comment.field.byxpath                   | True        | false      |
      | ejar.monthlybookings.cancelBookingSave.button.byxpath             | false       | false      |
      | ejar.monthlybookings.cancelBookingCancel.button.byxpath           | True        | false      |
    And select option in ejar kendo option field: ejar.monthlybookings.cancelReason.field.byxpath by index: 1
    And wait for element not present: ejar.editbooking.loading.div.byxpath
    And wait for number of seconds: 1
    And click on element: ejar.monthlybookings.cancelBookingSaveNotdisabled.button.byxpath
    And click on action if exist with wait: ejar.monthlybookings.cancelBookingSaveDialog.field.byxpath waiting number of seconds: 6
    And wait for element present: ejar.monthlybookings.create.button.byxpath for period in seconds: 100
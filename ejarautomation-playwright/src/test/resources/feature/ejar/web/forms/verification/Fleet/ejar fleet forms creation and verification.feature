Feature: Ejar Fleet Saving Forms Validation

  @TestType-Smoke
  Scenario: Create And Verify Vehicle Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles
    And click on link: ejar.vehicles.createnew.byxpath
    And verify ejar fields label with soft assertion in form: vehicle-base-data text: ejar.vehiclesformfields.text
    And verify form page labels and text:
      | Text                                                  | TagType |
      | Vehicles,المركبات                                     |  h1     |
      | Create New Vehicles,إضافة مركبات                      |  span   |
      | Basic Information,البيانات الاساسيه                    |  div    |
      | External Vehicle,مركبة خارجية                         |  label  |
      | Country,الدولة                                        |  label  |
      | Vendor,المورد                                         |  label  |
      | Category,الفئة                                        |  label  |
      | Manufacturer,الشركة المصنعة                           |  label  |
      | Model,الموديل                                         |  label  |
      | Year,سنة الصنع                                        |  label  |
      | Trim level,مستوى المواصفات                            |  label  |
      | Purchase Price,سعر الشراء                             |  label  |
      | Purchase Date,تاريخ الشراء                            |  label  |
      | Trim level,مستوى المواصفات                            |  label  |
      | Fuel Type,نوع الوقود                                  |  label  |
      | Fuel Tank Size,سعة خزان المركبة                       |  label  |
      | Engine Size (CC),سعه المحرك (CC)                      |  label  |
      | License Type,نوع التسجيل                              |  label  |
      | Usage Type,نوع الاستخدام                               |  label  |
      | License Expiry Date,تاريخ إنتهاء الرخصة               |  label  |
      | Insurance Companies,شركات التأمين                     |  label  |
      | Policy Number,رقم البوليصة                            |  label  |
      | Insurance End Date,تاريخ انتهاء التأمين               |  label  |
      | Attachment,المرفق                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.vehiclesformfields.country.field.edit.byxpath                 | True       | True       |
      | ejar.vehiclesformfields.vendor.field.edit.byxpath                  | True       | False      |
      | ejar.vehiclesformfields.category.field.edit.byxpath                | True       | True       |
      | ejar.vehiclesformfields.manufacturer.field.edit.byxpath            | True       | True       |
      | ejar.vehiclesformfields.model.field.edit.byxpath                   | True       | True       |
      | ejar.vehiclesformfields.year.field.edit.byxpath                    | True       | True       |
      | ejar.vehiclesformfields.purchasePrice.field.edit.byxpath           | True       | False      |
      | ejar.vehiclesformfields.purchaseDate.field.edit.byxpath            | True       | True       |
      | ejar.vehiclesformfields.trimLevel.field.edit.byxpath               | True       | True       |
      | ejar.vehiclesformfields.fuelType.field.edit.byxpath                | True       | True       |
      | ejar.vehiclesformfields.fuelTankSize.field.edit.byxpath            | True       | True       |
      | ejar.vehiclesformfields.engineSize.field.edit.byxpath              | True       | False      |
      | ejar.vehiclesformfields.licenseType.field.edit.byxpath             | True       | True       |
      | ejar.vehiclesformfields.usageType.field.edit.byxpath               | True       | True       |
      | ejar.vehiclesformfields.licenseExpiryDate.field.edit.byxpath       | True       | False      |
      | ejar.vehiclesformfields.insuranceCompanies.field.edit.byxpath      | True       | True       |
      | ejar.vehiclesformfields.policyNumber.field.edit.byxpath            | True       | True       |
      | ejar.vehiclesformfields.insuranceEndDate.field.read.byxpath        | False      | False      |
      | ejar.vehicles.save.button.byxpath                                  | False      | False      |
      | ejar.vehicles.cancel.button.byxpath                                | True       | False      |
    And wait for element present: ejar.createvehicle.country.field.byxpath for period in seconds: 20
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.country.field.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.category.field.byxpath option: Automation Small Sedan,Automation Small Sedan
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.manufacturer.field.byxpath option: Automation Hyundai,Automation Hyundai
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.model.field.byxpath option: Automation Accent,Automation Accent
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.manufactureryear.field.byxpath option: 2020,2020
    And user select date in ejar calendar field: ejar.createvehicle.purchasedate.field.byxpath plus days: -1
    And user select option by index in ejar kendo option field without typing: ejar.createvehicle.trimlevel.field.byxpath index: 1
    And user select option by index in ejar kendo option field without typing: ejar.createvehicle.fueltype.field.byxpath index: 1
    And user set in field: ejar.createvehicle.fueltanksize.field.byxpath value: 60
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.licensetype.field.byxpath option: Private,خصوصي
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.usagetype.field.byxpath option: Rental,تأجير
    And user select option by text in ejar kendo option field without typing: ejar.createvehicle.insurancecompanies.field.byxpath option: Automation organization,Automation organization
    And click on element: ejar.vehicles.continueOnError.byxpath
    And select option in ejar kendo option field: ejar.createvehicle.policyNumber.field.byxpath by index: 0
    And upload file to element: ejar.vehicles.upload.byxpath with path: //uploadFiles//LeasingContractsTemplate.rar
    And user click on action with id: ejar.vehicles.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And click on action if exist with wait: ejar.vehicles.cancel.byxpath waiting number of seconds: 1
    And verify element present: ejar.vehicles.createnew.byxpath

#no need to combine scenarios, because verification is for editing the traffic violation
  @TestType-Smoke
  Scenario: Create Upload Traffic Violations Form Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/traffic-violations
    And click on link: ejar.CreateTrafficViolations.action.byxpath
    And upload file to element: ejar.CreateTrafficViolations.upload.button.byxpath with path: \uploadFiles\TrafficViolation.xlsx
    And user click on action with id: ejar.CreateTrafficViolations.Cancel.button.byxpath
    And verify element present: ejar.CreateTrafficViolations.action.byxpath


  @TestType-Smoke
  Scenario: Create And Verify Vehicle Accident Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles
    And get plate number of a vehicle with status: Rented,مؤجرة
    And open page using url: /app/fleet-management/accidents
    And click on link: ejar.vehicleAccident.createNewVehicleAccident.byxpath
    Then verify ejar fields label with soft assertion in form: accident-details text: ejar.accident.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                              | TagType |
      | Accident,حادث                                                     |  h1     |
      | Fill-up accident announcement information,ادخال بيانات بلاغ الحادث |  span   |
      | Accident Details,تفاصيل الحادث                                    |  div    |
      | Accident,حادث                                                     |  li     |
      | Basic Information,البيانات الاساسيه                                |  div    |
      | Plate No,رقم اللوحة                                               |  label  |
      | Accident Administration Information,معلومات الحادث                |  div    |
      | Country,الدولة                                                    |  label  |
      | City,المدينه                                                      |  label  |
      | Report Source,مصدر التقرير                                        |  label  |
      | Accident Date,تاريخ الحادث                                        |  label  |
      | Announcement Date,تاريخ البلاغ                                     |  label  |
      | Comment,ملاحظات                                                    |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.accident.paltenumber.fields.edit.byxpath                    | True       | True       |
      | ejar.accident.country.fields.edit.byxpath                        | True       | True       |
      | ejar.accident.city.fields.edit.byxpath                           | True       | True       |
      | ejar.accident.accidentreportsource.fields.edit.byxpath           | True       | True       |
      | ejar.accident.accidentdate.fields.edit.byxpath                   | False      | True       |
      | ejar.accident.announcementdate.fields.edit.byxpath               | False      | True       |
      | ejar.accident.commentinput.fields.read.byxpath                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                               | True       | False      |
      | ejar.generic.save.action.byxpath                                 | False      | False      |
    And user set the stored plate number value in field: ejar.vehicleAccident.vehiclePlateNumber.field.byxpath
    And click on element: ejar.accident.plateNo.firstOption.byxpath
    And click on action if exist: ejar.generic.noConfirm.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.vehicleAccident.city.field.byxpath option: Automation Riyadh,Automation Riyadh
    And user select option by index in ejar kendo option field without typing: ejar.vehicleAccident.reportSource.field.byxpath index: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.vehicleAccident.createNewVehicleAccident.byxpath for period in seconds: 30
    And filter view on column name: Plate No,رقم اللوحة and enter value stored in variable: vehiclePlateNumber
    And wait for element present: ejar.vehicleAccident.firstRow.a.byxpath for period in seconds: 15
    And user click on element using java script executor: ejar.vehicleAccident.firstRow.a.byxpath
    And verify form page labels and text:
      | Text                                                              | TagType |
      | Accident,حادث                                                     |  h1     |
      | Accident Profile,بيانات الحادث                                    |  span   |
      | Announcement Data,بيانات البلاغ                                    |  a      |
      | Accident Report Data,بيانات تقرير الحادث                          |  a      |
      | Attachments,المرفقات                                              |  a      |
      | Accident Estimations Data,بيانات تقديرات الحادث                   |  a      |
      | Accident Payments,سندات الحادث                                    |  a      |
      | Announcement Data,بيانات البلاغ                                    |  li     |
      | Plate No,رقم اللوحة                                               |  label  |
      | Model,الموديل                                                     |  label  |
      | Year,سنة الصنع                                                    |  label  |
      | Status,الحالة                                                     |  label  |
      | Accident Amount,قيمة الحادث                                       |  label  |
      | Accident Policy,بوليصة تحمل                                       |  label  |
      | Country,الدولة                                                    |  label  |
      | City,المدينه                                                      |  label  |
      | Report Source,مصدر التقرير                                        |  label  |
      | Announcement Date,تاريخ البلاغ                                     |  label  |
      | Comment,ملاحظات                                                    |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                        | isEditable | isRequired |
      | ejar.accident.announcementData.a.byxpath          | True       | False      |
      | ejar.accident.reportData.a.byxpath                | True       | False      |
      | ejar.accident.attachments.a.byxpath               | True       | False      |
      | ejar.accident.estimationsData.a.byxpath           | True       | False      |
      | ejar.accident.payments.a.byxpath                  | True       | False      |
      | ejar.accident.plateNo.field.read.byxpath          | False      | False      |
      | ejar.accident.model.field.read.byxpath            | False      | False      |
      | ejar.accident.year.field.read.byxpath             | False      | False      |
      | ejar.accident.status.field.read.byxpath           | False      | False      |
      | ejar.accident.accidentPolicy.field.read.byxpath   | False      | False      |
      | ejar.accident.country.field.read.byxpath          | False      | False      |
      | ejar.accident.city.field.read.byxpath             | False      | False      |
      | ejar.accident.reportSource.field.read.byxpath     | False      | False      |
      | ejar.accident.announcementDate.field.read.byxpath | False      | False      |
      | ejar.accident.cancelAccident.button.byxpath       | True       | False      |
      | ejar.accident.cancel.button.byxpath               | True       | False      |
    And click on element: ejar.accident.cancelAccident.button.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.accident.cancelReason.field.byxpath option: Automation Accident Cancel Reason,Automation Accident Cancel Reason
    And click on element: ejar.accident.saveModal.button.byxpath
    And click on action if exist: ejar.generic.popupok.action.byxpath
    And click on action if exist: ejar.generic.cancel.action.byxpath
    And wait for element present: ejar.vehicleAccident.createNewVehicleAccident.byxpath for period in seconds: 20


  @TestType-Smoke
  Scenario: Verify Existing Authorization Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/authorizations-list
    And get plate number of a vehicle with status: Rented,مؤجرة
    And open page using url: /app/fleet-management/authorizations-list
    And click on link: ejar.addexistingauthorization.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-add-authorization-manually//fieldset text: ejar.addexistingauthorization.fieldset.label.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Authorizations,التفويضات                      |  h1     |
      | Add existing authorization,إضافة تفويض موجود  |  span   |
      | Search,بحث                                    |  legend |
      | Contract number,رقم العقد                     |  label  |
      | Plate Number,رقم اللوحة                       |  label  |
      | Authorization information,معلومات التفويض     |  legend |
      | Authorization No.,رقم التفويض                 |  label  |
      | From,من                                       |  label  |
      | To,الى                                        |  label  |
      | Driver Authorization Type,نوع التفويض للسائق  |  label  |
      | Customer information,معلومات العميل           |  legend |
      | Customer,العميل                               |  label  |
      | Identity No.,رقم الهوية                       |  label  |
      | Phone No.,الهاتف                              |  label  |
      | Contract information,معلومات العقد            |  legend |
      | Contract number,رقم العقد                     |  label  |
      | Plate Number,رقم اللوحة                       |  label  |
      | Creation branch,الفرع المنشئ                  |  label  |
      | Pickup date,وقت الخروج                        |  label  |
      | Dropoff date,وقت العودة                       |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.addexistingauthorization.contractnumber.field.edit.byxpath    | True       | True       |
      | ejar.addexistingauthorization.platenumber.field.edit.byxpath       | True       | True       |
      | ejar.addexistingauthorization.search.button.byxpath                | False      | False      |
      | ejar.addexistingauthorization.clear.button.byxpath                 | True       | False      |
      | ejar.addexistingauthorization.authorizationNo.field.edit.byxpath   | True       | True       |
      | ejar.addexistingauthorization.from.field.edit.byxpath              | True       | True       |
      | ejar.addexistingauthorization.to.field.edit.byxpath                | True       | True       |
      | ejar.addexistingauthorization.authorizationType.field.edit.byxpath | True       | True       |
      | ejar.addexistingauthorization.customer.field.edit.byxpath          | False      | True       |
      | ejar.addexistingauthorization.identityNo.field.edit.byxpath        | False      | True       |
      | ejar.addexistingauthorization.phoneNo.field.edit.byxpath           | False      | True       |
      | ejar.addexistingauthorization.contractNo.field.read.byxpath        | False      | True       |
      | ejar.addexistingauthorization.plateNo.field.read.byxpath           | False      | True       |
      | ejar.addexistingauthorization.branch.field.read.byxpath            | False      | True       |
      | ejar.addexistingauthorization.pickUp.field.read.byxpath            | False      | True       |
      | ejar.addexistingauthorization.dropOff.field.read.byxpath           | False      | True       |
      | ejar.addexistingauthorization.create.button.byxpath                | False      | True       |
      | ejar.addexistingauthorization.cancel.button.byxpath                | True       | False      |
    And user set the stored plate number value in field: ejar.addexistingauthorization.plateno.field.byxpath
    And user click on action with id: ejar.addexistingauthorization.search.button.byxpath
    And wait for element not present: ejar.addexistingauthorization.loadingIcon.div.byxpath
    And set random number into element: ejar.addexistingauthorization.authorizationno.field.byxpath of size: 10
    And user select option by text in ejar kendo option field without typing: ejar.addexistingauthorization.driverauthorizationtypecombobox.field.byxpath option: Internal Authorization,تفويض داخلي
    And user select date time in ejar calendar field: ejar.addexistingauthorization.authorizationtodate.field.byxpath plus days: 3 and plus hours: 10
    And user click on action with id: ejar.generic.create.action.byxpath


  @TestType-Smoke
  Scenario: Verify manual authorization profile
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/authorizations-list
    And get plate number of a vehicle with status: Rented,مؤجرة
    And open page using url: /app/fleet-management/authorizations-list
    And click on link: ejar.addmanualauthorization.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-add-authorization-manually//fieldset text: ejar.addmanualauthorization.fieldset.label.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | Authorizations,التفويضات                      | h1      |
      | Add manual authorization,إضافة تفويض يدوي     | span    |
      | Search,بحث                                    | legend  |
      | Contract number,رقم العقد                     | label   |
      | Plate Number,رقم اللوحة                       | label   |
      | Authorization information,معلومات التفويض     | legend  |
      | From,من                                       | label   |
      | To,الى                                        | label   |
      | Driver Authorization Type,نوع التفويض للسائق  | label   |
      | Customer information,معلومات العميل           | legend  |
      | Customer,العميل                               | label   |
      | Identity No.,رقم الهوية                       | label   |
      | Phone No.,الهاتف                              | label   |
      | Contract information,معلومات العقد            | legend  |
      | Contract number,رقم العقد                     | label   |
      | Plate Number,رقم اللوحة                       | label   |
      | Creation branch,الفرع المنشئ                  | label   |
      | Pickup date,وقت الخروج                        | label   |
      | Dropoff date,وقت العودة                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                     | isEditable | isRequired |
      | ejar.addmanualauthorization.contractnumber.field.edit.byxpath                  | True       | True       |
      | ejar.addmanualauthorization.platenumber.field.edit.byxpath                     | True       | True       |
      | ejar.addmanualauthorization.authorizationfromdate.field.edit.byxpath           | False      | True       |
      | ejar.addmanualauthorization.authorizationtodate.field.edit.byxpath             | True       | True       |
      | ejar.addmanualauthorization.driverauthorizationtypecombobox.field.edit.byxpath | False      | False      |
      | ejar.addmanualauthorization.customername.field.read.byxpath                    | False      | True       |
      | ejar.addmanualauthorization.identityno.field.read.byxpath                      | False      | True       |
      | ejar.addmanualauthorization.phoneno.field.read.byxpath                         | False      | True       |
      | ejar.addmanualauthorization.contractno.field.read.byxpath                      | False      | True       |
      | ejar.addmanualauthorization.createdbranch.field.read.byxpath                   | False      | True       |
      | ejar.addmanualauthorization.pickupdate.field.read.byxpath                      | False      | True       |
      | ejar.addmanualauthorization.dropoffdate.field.read.byxpath                     | False      | True       |
      | ejar.addmanualauthorization.search.button.byxpath                              | False      | True       |
      | ejar.addmanualauthorization.clear.button.byxpath                               | True       | False      |
      | ejar.addmanualauthorization.create.button.byxpath                              | False      | False      |
      | ejar.addmanualauthorization.cancel.button.byxpath                              | True       | False      |
    And user select date time in ejar calendar field: ejar.addmanualauthorization.authorizationtodate.field.edit.byxpath plus days: 6 and plus hours: 10
    And user set the stored plate number value in field: ejar.addmanualauthorization.platenumber.field.edit.byxpath
    And click on element: ejar.addmanualauthorization.search.button.byxpath
    And remove attribute for element: ejar.addmanualauthorization.create.button.byxpath attribute: disabled
    And click on element: ejar.addmanualauthorization.create.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath


  @TestType-Smoke
  Scenario: Create And Verify External Driver Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/external-drivers
    And wait for element present: ejar.externaldriver.createnew.byxpath for period in seconds: 100
    And click on link: ejar.externaldriver.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-edit-external-driver text: ejar.externaldriver.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                          | TagType |
      | External Driver,سائق خارجي                    | h1      |
      | Create New External Driver,إضافة سائق خارجي   | span    |
      | Basic Information,البيانات الاساسيه            | li      |
      | First name,الاسم الاول                          | label   |
      | Second name,الاسم الثاني                       | label   |
      | Third name,الاسم الثالث                        | label   |
      | Fourth name,الاسم الرابع                       | label   |
      | Family name,اسم العائلة                       | label   |
      | Nationality,الجنسية                           | label   |
      | Gender,الجنس                                  | label   |
      | Working Country,دولة العمل                    | label   |
      | Contact information,معلومات الاتصال            | div     |
      | Mobile,الموبايل                               | label   |
      | Email,البريد الإلكتروني                        | label   |
      | Documents,مستندات                             | li      |
      | Identity Document,وثيقة اثبات                 | div     |
      | Document type,نوع الاثبات                      | label   |
      | Number,الرقم                                  | label   |
      | Issue Country,دولة الاصدار                     | label   |
      | Expiry Date,تاريخ الانتهاء                     | label   |
      | Notes,ملاحظات                                  | li      |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.externaldriver.firstname.fields.edit.byxpath                  | True       | True       |
      | ejar.externaldriver.secondname.fields.edit.byxpath                 | True       | True       |
      | ejar.externaldriver.thirdname.fields.edit.byxpath                  | True       | False      |
      | ejar.externaldriver.fourthname.fields.edit.byxpath                 | True       | False      |
      | ejar.externaldriver.familyname.fields.edit.byxpath                 | True       | True       |
      | ejar.externaldriver.nationality.fields.edit.byxpath                | True       | True       |
      | ejar.externaldriver.gender.fields.edit.byxpath                     | True       | True       |
      | ejar.externaldriver.operationcountry.fields.edit.byxpath           | True       | True       |
      | ejar.externaldriver.phonenumber.fields.edit.byxpath                | True       | True       |
      | ejar.externaldriver.email.fields.edit.byxpath                      | True       | False      |
      | ejar.externaldriver.documenttypes.fields.edit.byxpath              | True       | True       |
      | ejar.externaldriver.documentNumber.fields.edit.byxpath             | False      | True       |
      | ejar.externaldriver.documentissuecountry.fields.edit.byxpath       | True       | True       |
      | ejar.externaldriver.documentexpirydate.fields.edit.byxpath         | False      | False      |
      | ejar.externaldriver.notes.fields.edit.byxpath                      | True       | False      |
    And user set in field: ejar.externaldriver.firstname.fields.byxpath value: Eyad UI Automation
    And user set in field: ejar.externaldriver.secondname.fields.byxpath value: Second Name
    And user set in field: ejar.externaldriver.familyname.fields.byxpath value: Family Name
    And user select option by text in ejar kendo option field without typing: ejar.externaldriver.nationality.fields.byxpath option: Saudi,سعودي
    And user select option by text in ejar kendo option field without typing: ejar.externaldriver.gender.fields.byxpath option: Male,ذكر
    And user select option by text in ejar kendo option field without typing: ejar.externaldriver.operationcountry.fields.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And user set in field: ejar.externaldriver.phonenumber.fields.byxpath value: 554442222
    And user select option by text in ejar kendo option field without typing: ejar.externaldriver.documenttypes.fields.byxpath option: Identity,الهوية
    And set random number into element: ejar.externaldriver.documentNumber.fields.byxpath with size: 10 and store value in variable: identityNo
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Identity Number,رقم الهوية and enter value stored in variable: identityNo
    And click on element: ejar.externaldriver.firstRow.a.byxpath
    And verify form page labels and text:
      | Text                                                 | TagType |
      | External Drivers,سائقين خارجيين                      | h1      |
      | External Driver Management,ادارة السائقين الخارجيين  | span    |
      | Basic Information,البيانات الاساسيه                   | li      |
      | First name,الاسم الاول                                 | label   |
      | Second name,الاسم الثاني                              | label   |
      | Third name,الاسم الثالث                               | label   |
      | Fourth name,الاسم الرابع                              | label   |
      | Family name,اسم العائلة                              | label   |
      | Nationality,الجنسية                                  | label   |
      | Gender,الجنس                                         | label   |
      | Working Country,دولة العمل                           | label   |
      | Contact information,معلومات الاتصال                   | div     |
      | Mobile,الموبايل                                      | label   |
      | Email,البريد الإلكتروني                               | label   |
      | Documents,مستندات                                    | li      |
      | Identity Document,وثيقة اثبات                        | div     |
      | Document type,نوع الاثبات                             | label   |
      | Number,الرقم                                         | label   |
      | Issue Country,دولة الاصدار                            | label   |
      | Expiry Date,تاريخ الانتهاء                            | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                            | isEditable | isRequired |
      | ejar.externaldriver.firstname.field.read.byxpath      | False      | False      |
      | ejar.externaldriver.secondname.field.read.byxpath     | False      | False      |
      | ejar.externaldriver.familyname.field.read.byxpath     | False      | False      |
      | ejar.externaldriver.nationality.field.read.byxpath    | False      | False      |
      | ejar.externaldriver.gender.field.read.byxpath         | False      | False      |
      | ejar.externaldriver.workingCountry.field.read.byxpath | False      | False      |
      | ejar.externaldriver.mobile.field.read.byxpath         | False      | False      |
      | ejar.externaldriver.docType.field.read.byxpath        | False      | False      |
      | ejar.externaldriver.number.field.read.byxpath         | False      | False      |
      | ejar.externaldriver.issueCountry.field.read.byxpath   | False      | False      |
      | ejar.generic.close.action.byxpath                     | True       | False      |
      | ejar.externaldriver.deactivate.button.byxpath         | True       | False      |
      | ejar.externaldriver.edit.button.byxpath               | True       | False      |
    And click on element: ejar.externaldriver.deactivate.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And verify element present: ejar.externaldriver.createnew.byxpath

  @TestType-Smoke
  Scenario: Create And Verify New Vendor Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vendors
    And Create organization with random name and store name in variable: automationOrganizationName
    And open page using url: /app/fleet-management/vendors
    And wait for element present: ejar.vendors.createnew.byxpath for period in seconds: 100
    And click on link: ejar.vendors.createnew.byxpath
    And verify ejar fields label with soft assertion in form: createoreditcompanymodal text: ejar.vendors.labels.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Create New Vendor,إضافة مورد                    |  span   |
      | Country,الدولة                                  |  label  |
      | Name,الاسم                                       |  label  |
      | City,المدينه                                    |  label  |
      | Phone No.,الهاتف                                |  label  |
      | Area,المنطقة                                    |  label  |
      | Street Address,الشارع                           |  label  |
      | Building^^ floor...,المبنى / الطابق             |  label  |
      | Postal Code,الرمز البريدي                       |  label  |
      | Contact Person,الموظف المسؤول - الاسم            |  label  |
      | Contact Mobile,الموظف المسؤول - هاتف            |  label  |
      | Contact Email,الموظف المسؤول - البريد الالكتروني |  label  |
      | Comment,ملاحظات                                  |  label  |
      | Is Active,فعال                                  |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.vendors.countries.field.edit.byxpath                          | True       | True       |
      | ejar.vendors.name.field.read.byxpath                               | False      | True       |
      | ejar.vendors.cities.field.edit.byxpath                             | True       | False      |
      | ejar.vendors.phone1.field.edit.byxpath                             | True       | True       |
      | ejar.vendors.area.field.edit.byxpath                               | True       | True       |
      | ejar.vendors.streetaddress.field.edit.byxpath                      | True       | True       |
      | ejar.vendors.BuildingOrFloor.fields.edit.byxpath                   | True       | True       |
      | ejar.vendors.PostalCode.fields.edit.byxpath                        | True       | True       |
      | ejar.vendors.contactperson.field.edit.byxpath                      | True       | True       |
      | ejar.vendors.phone2.field.edit.byxpath                             | True       | True       |
      | ejar.vendors.contactemail.field.edit.byxpath                       | True       | False      |
      | ejar.vendors.comment.field.edit.byxpath                            | True       | False      |
      | ejar.vendors.isActive.field.byxpath                                | True       | False      |
      | ejar.vendors.save.button.byxpath                                   | False      | False      |
      | ejar.vendors.cancel.button.byxpath                                 | True       | False      |
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.vendors.countries.field.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And search for value in search field: ejar.vendors.name.field.byxpath with value in variable: automationOrganizationName then select record at index: 0
    And user set in field: ejar.vendors.phone1.field.byxpath value: 518887777
    And user set in field: ejar.vendors.contactperson.field.byxpath value: UI Automation Vendor Contract Person
    And user set in field: ejar.vendors.phone2.field.byxpath value: 518887777
    And user click on action with id: ejar.vendors.save.button.byxpath
    And click on action if exist: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: automationOrganizationName
    And user click on view action: Edit,تعديل  related to record with text stored in variable: automationOrganizationName then select record at index: 1
    And click on element: ejar.vendors.isActive.field.byxpath
    And user click on action with id: ejar.vendors.save.button.byxpath
    And verify element present: ejar.vendors.createnew.byxpath
    And open page using url: /app/crm/organizations
    And wait for element present: ejar.organizations.createnew.byxpath for period in seconds: 100
    And filter view on column name: Name,الاسم and enter value stored in variable: automationOrganizationName
    And user click on view action: Edit,تعديل  related to record with text stored in variable: automationOrganizationName then select record at index: 1
    And user click on action with id: ejar.organizations.isactive.fields.byxpath
    And user click on action with id: ejar.organizations.save.button.byxpath

  @TestType-Smoke
  Scenario: Create And Verify Transport Company Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/transport-companies
    And Create organization with random name and store name in variable: automationOrganizationName
    And open page using url: /app/fleet-management/transport-companies
    And click on link: ejar.createnewtransportcompany.createnew.byxpath
    And verify ejar fields label with soft assertion in form: createoreditcompanymodal text: ejar.createnewtransportcompany.labels.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Create New Transport Company,إضافة شركة نقل     |  span   |
      | Country,الدولة                                  |  label  |
      | Name,الاسم                                       |  label  |
      | City,المدينه                                    |  label  |
      | Phone No.,الهاتف                                |  label  |
      | Area,المنطقة                                    |  label  |
      | Street Address,الشارع                           |  label  |
      | Building^^ floor... ,المبنى / الطابق            |  label  |
      | Postal Code,الرمز البريدي                       |  label  |
      | Contact Person,الموظف المسؤول - الاسم            |  label  |
      | Contact Mobile,الموظف المسؤول - هاتف            |  label  |
      | Contact Email,الموظف المسؤول - البريد الالكتروني |  label  |
      | Comment,ملاحظات                                  |  label  |
      | Is Active,فعال                                  |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewtransportcompany.countries.field.edit.byxpath        | True       | True       |
      | ejar.createnewtransportcompany.name.field.edit.byxpath             | False      | True       |
      | ejar.createnewtransportcompany.cities.field.edit.byxpath           | True       | False      |
      | ejar.createnewtransportcompany.phone1.field.edit.byxpath           | True       | True       |
      | ejar.createnewtransportcompany.area.field.edit.byxpath             | True       | True       |
      | ejar.createnewtransportcompany.streetaddress.field.edit.byxpath    | True       | True       |
      | ejar.createnewtransportcompany.BuildingOrFloor.fields.edit.byxpath | True       | True       |
      | ejar.createnewtransportcompany.PostalCode.fields.edit.byxpath      | True       | True       |
      | ejar.createnewtransportcompany.contactperson.field.edit.byxpath    | True       | True       |
      | ejar.createnewtransportcompany.phone2.field.edit.byxpath           | True       | True       |
      | ejar.createnewtransportcompany.contactemail.field.edit.byxpath     | True       | False      |
      | ejar.createnewtransportcompany.comment.field.edit.byxpath          | True       | False      |
      | ejar.createnewtransportcompany.isActive.field.byxpath              | True       | False      |
      | ejar.createnewtransportcompany.save.button.byxpath                 | False      | False      |
      | ejar.createnewtransportcompany.cancel.button.byxpath               | True       | False      |
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.createnewtransportcompany.countries.field.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And search for value in search field: ejar.createnewtransportcompany.name.field.byxpath with value in variable: automationOrganizationName then select record at index: 0
    And user set in field: ejar.createnewtransportcompany.phone1.field.byxpath value: 518887777
    And user set in field: ejar.createnewtransportcompany.contactperson.field.byxpath value: UI Automation Insurance Company Contract Person
    And user set in field: ejar.createnewtransportcompany.phone2.field.byxpath value: 518887777
    And user click on action with id: ejar.createnewtransportcompany.save.button.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: automationOrganizationName
    And user click on view action: Edit,تعديل  related to record with text stored in variable: automationOrganizationName then select record at index: 1
    And user click on action with id: ejar.createnewtransportcompany.isActive.field.byxpath
    And user click on action with id: ejar.createnewtransportcompany.save.button.byxpath
    And verify element present: ejar.createnewtransportcompany.createnew.byxpath
    And open page using url: /app/crm/organizations
    And wait for element present: ejar.organizations.createnew.byxpath for period in seconds: 100
    And wait for element not present: ejar.generic.gridload.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: automationOrganizationName
    And user click on view action: Edit,تعديل  related to record with text stored in variable: automationOrganizationName then select record at index: 1
    And user click on action with id: ejar.organizations.isactive.fields.byxpath
    And user click on action with id: ejar.organizations.save.button.byxpath


#needs defined expense category from system lookups
  @TestType-Smoke
  Scenario: Create And Verify Expenses Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles
    And filter view on column name: Status,الحالة and select dropdown list value: Rented,مؤجرة
    And store the value of column: Plate Number,رقم اللوحة when there is no value in column: Additional Statuses,الحالات الاضافية in the variable: plateNo on page: /app/fleet-management/vehicles
    And open page using url: /app/fleet-management/expenses
    And click on element: ejar.expenses.view.addExpenses.button.byxpath
    And verify ejar fields label with soft assertion in form: expense-modal text: ejar.createexpense.label.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Add Expense,إضافة مصاريف                        |  span   |
      | Plate Number,رقم اللوحة                         |  label  |
      | Category,الفئة                                  |  label  |
      | Date,التاريخ                                    |  label  |
      | Amount,قيمة                                     |  label  |
      | Notes,ملاحظات                                    |  label  |
      | Receipt,الإيصال                                  |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createexpense.plateNo.field.byxpath                           | True       | True       |
      | ejar.createexpense.category.field.byxpath                          | True       | True       |
      | ejar.createexpense.date.field.byxpath                              | True       | True       |
      | ejar.createexpense.amount.field.byxpath                            | True       | True       |
      | ejar.createexpense.notes.field.byxpath                             | True       | False      |
      | ejar.createexpense.receipt.field.byxpath                           | True       | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.expenses.view.cancelModal.button.byxpath                      | True       | False      |
    And user select option by text in ejar kendo option field without click on empty field: ejar.createexpense.plateNo.input.byxpath with option value from stored variable: plateNo
    And user select value in drop down field: ejar.createexpense.category.field.byxpath by index: 1
    And set random number into element: ejar.createexpense.amount.field.byxpath of size: 4
    And set random text into element: ejar.createexpense.notes.field.byxpath with size: 5 and initial string: UI Automation Note
    And upload file to element: ejar.createexpense.receipt.field.byxpath with path: //uploadFiles//logo_high.png
    And click on element: ejar.generic.save.action.byxpath
    And set value into field: ejar.expenses.view.plateNumber.select.byxpath from stored variable: plateNo
#    And click on element: ejar.expenses.view.search.button.byxpath
    And click on element: ejar.createexpense.firstRowView.a.byxpath
    And verify form page labels and text:
      | Text                                            | TagType |
      | View Expense,عرض المصاريف                       |  span   |
      | Vehicle,مركبة                                   |  label  |
      | Category,الفئة                                  |  label  |
      | Date,التاريخ                                    |  label  |
      | Amount,قيمة                                     |  label  |
      | Notes,ملاحظات                                    |  label  |
      | Receipt,الإيصال                                  |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createexpense.plateNo.field.read.byxpath                      | False      | False      |
      | ejar.createexpense.category.field.read.byxpath                     | False      | False      |
      | ejar.createexpense.date.field.read.byxpath                         | False      | False      |
      | ejar.createexpense.amount.field.read.byxpath                       | False      | False      |
      | ejar.createexpense.notes.field.read.byxpath                        | False      | False      |
      | ejar.expenses.view.cancelModal.button.byxpath                      | True       | False      |
    And click on element: ejar.expenses.view.cancelModal.button.byxpath
    And click on element: ejar.createexpense.firstRowDeactivate.a.byxpath
    And click on element: ejar.generic.yes.action.byxpath





  @TestType-Smoke
  Scenario: Create And Verify Rented vehicles vendors Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/external-company
    And Create organization with random name and store name in variable: automationOrganizationName
    And open page using url: /app/fleet-management/external-company
    And click on link: ejar.createnewrentalcompany.createnew.byxpath
    And verify ejar fields label with soft assertion in form: create-or-edit-external-company text: ejar.createnewrentalcompany.labels.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                              | TagType |
      | Rented vehicles vendors,موردين المركبات المستأجرة                 | h1      |
      | Manage Rented vehicles vendors,ادارة موردين المركبات المستأجرة    | span    |
      | Rented vehicles vendors,موردين المركبات المستأجرة                 | li      |
      | Basic Information,المعلومات الاساسية                               | div     |
      | Country,الدولة                                                    | label   |
      | Name,الاسـم                                                        | label   |
      | City,المدينة                                                      | label   |
      | Phone number,رقم الجوال                                           | label   |
      | Area,المنطقة                                                      | label   |
      | Street Address,الشارع                                             | label   |
      | Building^^ floor...,المبنى / الطابق                               | label   |
      | Postal Code,الرمز البريدي                                         | label   |
      | More address details,تفاصيل العنوان الاضافية                       | label   |
      | Contact person information,بيانات الشخص المفوض                    | div     |
      | Name,الاسـم                                                        | label   |
      | Email,البريد الإلكتروني                                            | label   |
      | Primary Phone,الهاتف الأساسي                                       | label   |
      | Secondary Phone,الهاتف الثاني                                     | label   |
      | Portal Access Enabled, اتاحة الوصول إلى نظام الشركات              | label   |
      | Comment,ملاحظات                                                    | label   |
      | SLA - Preventive Maintenance,اتفاقية الخدمة - الصيانة الوقائية    | div     |
      | Maintenance Duration (in days),فترة الصيانة (بالأيام)              | label   |
      | SLA - Maintenance Levels,اتفاقية الخدمة - درجات الصيانة           | li      |
      | Type,النوع                                                        | span    |
      | Level,المستوى                                                     | span    |
      | Maintenance Duration (in days),فترة الصيانة (بالأيام)              | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewrentalcompany.country.field.edit.byxpath             |   True     |    True    |
      | ejar.createnewrentalcompany.name.field.edit.byxpath                |   True     |    True    |
      | ejar.createnewrentalcompany.cities.field.edit.byxpath              |   False    |    True    |
      | ejar.createnewrentalcompany.phone1.field.edit.byxpath              |   True     |    True    |
      | ejar.createnewrentalcompany.area.field.read.byxpath                |   False    |    True    |
      | ejar.createnewrentalcompany.streetaddress.field.read.byxpath       |   False    |    True    |
      | ejar.createnewrentalcompany.BuildingOrFloor.fields.read.byxpath    |   False    |    True    |
      | ejar.createnewrentalcompany.PostalCode.fields.read.byxpath         |   False    |    True    |
      | ejar.createnewrentalcompany.moreAddressDetails.fields.edit.byxpath |   False    |    False   |
      | ejar.createnewrentalcompany.contactname.field.read.byxpath         |   False    |    True    |
      | ejar.createnewrentalcompany.email.field.byxpath                    |   False    |    True    |
      | ejar.createnewrentalcompany.phone2.field.byxpath                   |   False    |    True    |
      | ejar.createnewrentalcompany.comment.field.edit.byxpath             |   False    |    True    |
      | ejar.createnewrentalcompany.maintenance.field.byxpath              |   True     |    False   |
      | ejar.createnewrentalcompany.isportalaccessenabled.field.byxpath    |   True     |    False   |
      | ejar.createnewrentalcompany.add.action.byxpath                     |   True     |    False   |
      | ejar.generic.cancel.action.byxpath                                 |   True     |    False   |
      | ejar.generic.save.action.byxpath                                   |   False    |    False   |
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.createnewrentalcompany.countries.field.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And search for value in search field: ejar.createnewrentalcompany.name.field.byxpath with value in variable: automationOrganizationName then select record at index: 0
    And click on action if exist: ejar.generic.yes.action.byxpath
    And select option in ejar kendo option field: ejar.createnewrentalcompany.cities.field.byxpath by index: 1
    And set random number into element: ejar.createnewrentalcompany.area.field.byxpath of size: 10
    And user set in field: ejar.createnewrentalcompany.streetaddress.field.byxpath value: asdasd
    And user set in field: ejar.createnewrentalcompany.BuildingOrFloor.fields.byxpath value: 61
    And user set in field: ejar.createnewrentalcompany.PostalCode.fields.byxpath value: 1121
    And user set in field: ejar.createnewrentalcompany.contact.field.byxpath value: UI Automation Contact Person
    And user set in field: ejar.createnewrentalcompany.phone1.field.byxpath value: 518887777
    And user set in field: ejar.createnewrentalcompany.phone2.field.byxpath value: 518886666
    And set random email into element: ejar.createnewrentalcompany.email.field.byxpath
#    And set random number into element: ejar.rentedvehiclesvendor.identity.field.byxpath of size: 10
#    And set random number into element: ejar.rentedvehiclesvendor.copies.field.byxpath of size: 1
    And set value into element : ejar.rentedvehiclesvendor.SLAMaintenanceDuration.field.byxpath value: 5
    And user click on element using java script executor: ejar.rentedvehiclesvendor.SLAAdd.button.byxpath
    And user select value in drop down field: ejar.rentedvehiclesvendor.SLAType.field.byxpath by option text: Mechanical Maintenance,الصيانة الميكانيكية
    And user select value in drop down field: ejar.rentedvehiclesvendor.SLALevel.field.byxpath by option text: Automation Maintenance level,Automation Maintenance level
    And set value into element : ejar.rentedvehiclesvendor.SLADays.field.byxpath value: 5
    And click on element: ejar.rentedvehiclesvendor.SLASave.button.byxpath
    And user click on action with id: ejar.createnewrentalcompany.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.createnewrentalcompany.createnew.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: automationOrganizationName
    And click on element: ejar.rentedvehiclesvendor.firstRow.button.byxpath
    And user click on element using java script executor: ejar.createnewrentalcompany.deactivate.button.byxpath
    And user click on element using java script executor: ejar.generic.yes.action.byxpath
    And verify element present: ejar.createnewrentalcompany.createnew.byxpath
    Then inactivate organization with name stored in variable: automationOrganizationName

  @TestType-Smoke
  Scenario: Create and verify Road Assistance Requests Form And Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/road-assistance
    And check the checkbox of the element: ejar.roadAssistance.provideAssistanceSetting.checkbox.byxpath in the settings of the country: Saudi Arabia,المملكة العربية السعودية
    And create new assistance issue with initial string: UI Automation Assistance Issue  and store in variable: issueName
    And get plate number of a vehicle with status: Rented,مؤجرة
    And open page using url: /app/fleet-management/road-assistance
    And click on link: ejar.roadAssistance.createnew.byxpath
    And verify ejar fields label with soft assertion in form: fieldset text: ejar.roadAssistance.labels.edit.text
    And verify form page labels and text:
      | Text                                                            | TagType |
      | Road Assistance Request,طلب المساعدة على الطريق                 | h1      |
      | Road Assistance Request Details,تفاصيل طلب المساعدة على الطريق  | span    |
      | Road Assistance Request,طلب المساعدة على الطريق                 | li      |
      | Request Assistance Info,طلب معلومات المساعدة                    | label   |
      | Plate No,رقم اللوحة                                             | label   |
      | Assistance Types,أنواع المساعدة                                 | label   |
      | Description,الوصف                                               | label   |
      | Location,الموقع                                                 | li      |
      | Latitude,خط العرض                                               | label   |
      | Longitude,خط الطول                                              | label   |
      | Map,الخريطة                                                     | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.roadAssistance.plateno.field.byxpath            |   True     |   True     |
      | ejar.AssistanceTypes.field.byxpath                   |   True     |   True     |
      | ejar.roadAssistance.description.field.byxpath        |   True     |   False    |
      | ejar.roadAssistance.lat.field.byxpath                |   True     |   True     |
      | ejar.roadAssistance.lang.field.byxpath               |   True     |   True     |
      | ejar.roadAssistance.map.field.byxpath                |   False    |   False    |
      | ejar.roadAssistance.map.field.byxpath                |   False    |   False    |
    And user set the stored plate number value in field: ejar.roadAssistance.plateno.byxpath
    And click on element: ejar.roadAssistance.plateno.byxpath
    And user click on action with id: ejar.roadAssistance.description.field.byxpath
    And user select option by text in ejar kendo option field without click on empty field: ejar.AssistanceTypes.input.byxpath with option value from stored variable: issueName
    And user set in field: ejar.roadAssistance.lang.field.byxpath value: 48.58893
    And user set in field: ejar.roadAssistance.lat.field.byxpath value: 22.017286
    And user click on action with id: ejar.generic.create.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Plate Number,رقم اللوحة and enter value stored in variable: vehiclePlateNumber
    And click on view first record cell under column name: Request Number,رقم الطلب
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.roadAssistance.labels.read.text
    And verify form page labels and text:
      | Text                                                            | TagType |
      | Road Assistance Request,طلب المساعدة على الطريق                 | h1      |
      | Request Assistance Details,طلب عطل طريق                         | span    |
      | Road Assistance Request,طلب المساعدة على الطريق                 | li      |
      | Request Assistance Info,طلب معلومات المساعدة                    | label   |
      | Reference No.:,رقم المرجع:                                      | label   |
      | Ref. Type:,نوع المرجع:                                          | label   |
      | Plate Number:,رقم اللوحة:                                       | label   |
      | Request Number:,رقم الطلب:                                      | label   |
      | Request Status:,حالة الطلب:                                     | label   |
      | Creation Date:,تاريخ الإنشاء:                                    | label   |
      | City:,المدينه:                                                  | label   |
      | Requested Assistance Types,نوع المساعدة المطلوبة                | label   |
      | Urgency:,الاهمية:                                                | label   |
      | Description:,الوصف:                                             | label   |
      | Location,الموقع                                                 | label   |
      | Latitude:,خط العرض:                                             | label   |
      | Longitude:,خط الطول:                                            | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.roadAssistance.refNo.field.read.byxpath         |   False    |   False    |
      | ejar.roadAssistance.refType.field.read.byxpath       |   False    |   False    |
      | ejar.roadAssistance.palteNo.field.read.byxpath       |   False    |   False    |
      | ejar.roadAssistance.reqNo.field.read.byxpath         |   False    |   False    |
      | ejar.roadAssistance.reqStatus.field.read.byxpath     |   False    |   False    |
      | ejar.roadAssistance.creationDate.field.read.byxpath  |   False    |   False    |
      | ejar.roadAssistance.city.field.read.byxpath          |   False    |   False    |
      | ejar.roadAssistance.assistanceType.field.read.byxpath|   False    |   False    |
      | ejar.roadAssistance.urgency.field.read.byxpath       |   False    |   False    |
      | ejar.roadAssistance.lat.field.read.byxpath           |   False    |   False    |
      | ejar.roadAssistance.long.field.read.byxpath          |   False    |   False    |
      | ejar.roadAssistance.close.action.byxpath             |   True     |   False    |
      | ejar.roadAssistance.assignRequest.action.byxpath     |   True     |   False    |
      | ejar.roadAssistance.closeRequest.action.field.byxpath|   True     |   False    |
    And user click on action with id: ejar.roadAssistance.closeRequest.action.field.byxpath
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.ReasonToClose.list.field.byxpath option: Issue Fixed,تم حل المشكلة
    And user click on action with id: ejar.ReasonToClose.Save.action.byxpath
    And deactivate assistance issue with the name stored in variable: issueName

  @TestType-Smoke
  Scenario: Create And Verify Car Category Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/car-categories
    And click on link: ejar.category.createnew.byxpath
    And verify ejar fields label with soft assertion in form: createoreditcarcategorymodal text: ejar.category.label.text
    And verify form page labels and text:
      | Text                                      | TagType |
      | Create New Car Category,إضافة فئة مركبة   | span    |
      | Active,فعال                               | label   |
      | Name [en],الاسـم [en]                      | label   |
      | Name [ar],الاسـم [ar]                      | label   |
      | Classification,التصنيف                    | label   |
      | Successors,الفئات الرديفة                 | label   |
      | Number Of Doors,عدد الابواب                | label   |
      | Number Of Seats,عدد المقاعد               | label   |
      | Number Of Luggages,عدد الامتعة             | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.category.isActive.field.byxpath                               | True       | False      |
      | ejar.category.name_en.field.edit.byxpath                           | True       | True       |
      | ejar.category.name_ar.field.edit.byxpath                           | True       | True       |
      | ejar.category.classification.field.edit.byxpath                    | True       | True       |
      | ejar.category.successors.field.edit.byxpath                        | True       | True       |
      | ejar.category.doorsnumber.field.edit.byxpath                       | True       | True       |
      | ejar.category.seatsnumber.field.edit.byxpath                       | True       | True       |
      | ejar.category.luggagenumber.field.edit.byxpath                     | True       | True       |
      | ejar.category.cancel.button.byxpath                                | True       | False      |
      | ejar.category.save.button.byxpath                                  | False      | False      |
    And set random text in variable and into element: ejar.category.name_en.field.byxpath with size: 10 and initial string: UI Automation Category and store value in variable: categoryVariable
    And set value into field: ejar.category.name_ar.field.byxpath from stored variable: categoryVariable
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.category.classification.field.byxpath option: Automation Classification,Automation Classification
    And user enter value : 4 in field : ejar.category.doorsnumber.field.byxpath
    And user enter value : 4 in field : ejar.category.seatsnumber.field.byxpath
    And user enter value : 2 in field : ejar.category.luggagenumber.field.byxpath
    And user click on action with id: ejar.category.save.button.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: categoryVariable
    And user click on view action: Edit,تعديل  related to record with text stored in variable: categoryVariable then select record at index: 1
    And user click on action with id: ejar.category.isActive.field.byxpath
    And user click on action with id: ejar.category.save.button.byxpath
    And wait for element present: ejar.category.modalHidden.button.byxpath for period in seconds: 5
    And wait for element not present: ejar.category.modalHidden.button.byxpath



  @TestType-Smoke
  Scenario: Create And Verify Working Hours Templates Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    And Create branch with random name and store name in variable: uiAutomationRandomBranchName
    And open page using url: /app/rental/administration/working-hours-templates
    And click on link: ejar.workinghourstemplates.createnew.byxpath
    And verify ejar fields label with soft assertion in form: tab[1] text: ejar.workinghourstemplates.detailsLabels.text
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Working Hours Templates,نماذج ساعات العمل                 | h1      |
      | Create New Working Hours Template,إضافة نموذج ساعات عمل   | span    |
      | Details,التفاصيل                                          |   a     |
      | Branches,الفروع                                           |   a     |
      | Name,الاسم                                                 | label   |
      | Start Date,وقت البداية                                    | label   |
      | End Date,وقت النهاية                                      | label   |
      | Is Active,فعال                                            | label   |
      | Periods,الفترات                                           | legend  |
      | Days,أيام                                                 | span    |
      | Working Hours,ساعات الدوام                                | span    |
      | Actions,إجراءات                                           | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.workinghourstemplates.name.field.byxpath                      | True       | True       |
      | ejar.workinghourstemplates.startDate.field.edit.byxpath            | True       | True       |
      | ejar.workinghourstemplates.endDate.field.edit.byxpath              | True       | False      |
      | ejar.workinghourstemplates.isActive.field.byxpath                  | True       | False      |
      | ejar.workinghourstemplates.addperiod.filed.byxpath                 | True       | False      |
      | ejar.workinghourstemplates.back.field.edit.byxpath                 | True       | False      |
      | ejar.workinghourstemplates.cancel.field.edit.byxpath               | True       | False      |
      | ejar.workinghourstemplates.save1.button.byxpath                    | False      | False      |
    And set random text in variable and into element: ejar.workinghourstemplates.name.field.byxpath with size: 10 and initial string: UI Working Hours Template and store value in variable: workingHoursTemplateVariable
    And user click on action with id: ejar.workinghourstemplates.addperiod.filed.byxpath
    And verify ejar fields label with soft assertion in form: create-or-edit-template-period-modal text: ejar.workinghourstemplates.periodLabels.text
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Period,فترة                                               | span    |
      | Days,أيام                                                 | label   |
      | Is 24Hours?,24 ساعة؟                                      | label   |
      | Start Time,وقت البداية                                    | label   |
      | End Time,وقت النهاية                                      | label   |
      | Start Time,وقت البداية                                    | span    |
      | End Time,وقت النهاية                                      | span    |
      | Actions,إجراءات                                           | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.workinghourstemplates.days.field.byxpath                      | True       | False      |
      | ejar.workinghourstemplates.24h.input.byxpath                       | True       | False      |
      | ejar.workinghourstemplates.starttime.field.byxpath                 | True       | True       |
      | ejar.workinghourstemplates.endtime.field.byxpath                   | True       | True       |
      | ejar.workinghourstemplates.addTime.field.edit.byxpath              | False      | False      |
      | ejar.workinghourstemplates.cancel.field.byxpath                    | True       | False      |
      | ejar.workinghourstemplates.save.field.byxpath                      | False      | False      |
    And user click on action with id: ejar.workinghourstemplates.24h.input.byxpath
    And user select option by text in ejar kendo option field: ejar.workinghourstemplates.days.field.byxpath option is: Saturday,السبت then click on specific field: ejar.workinghourstemplates.daySpan.field.byxpath
    And user click on action with id: ejar.workinghourstemplates.save.field.byxpath
    And user click on action with id: ejar.workinghourstemplates.branches.tab.byxpath
    And verify ejar fields label with soft assertion in form: tab[2] text: ejar.workinghourstemplates.branchesLabel.text
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Country,الدولة                                            | label   |
      | Branch,الفرع                                              | label   |
      | Branch,الفرع                                              | span    |
      | Actions,إجراءات                                           | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.workinghourstemplates.country.field.byxpath                   | True       | False      |
      | ejar.workinghourstemplates.branch.field.byxpath                    | True       | False      |
      | ejar.workinghourstemplates.add.button.byxpath                      | False      | False      |
      | ejar.workinghourstemplates.back.field.edit.byxpath                 | True       | False      |
      | ejar.workinghourstemplates.cancel.field.edit.byxpath               | True       | False      |
      | ejar.workinghourstemplates.save1.button.byxpath                    | False      | False      |
    And user select value in drop down field: ejar.workinghourstemplates.country.field.byxpath by option text: Saudi Arabia, المملكة العربية السعودية
    And wait for element present: ejar.workinghourstemplates.branch.field.byxpath for period in seconds: 20
    And user select value in drop down field: ejar.workinghourstemplates.branch.field.byxpath by option text stored in variable: uiAutomationRandomBranchName
    And user click on action with id: ejar.workinghourstemplates.add.button.byxpath
    And user click on action with id: ejar.workinghourstemplates.save1.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And user select option in dropdown tree view mutiliselect field: ejar.generic.view.branches.dropdowntreeviewmutiliselect.byxpath option stored in variable: uiAutomationRandomBranchName
    And filter view on column name: Name,الاسم and enter value: UI Working Hours Template
    And user click on view action: Edit,تعديل  related to record with text: UI Working Hours Template then select record at index: 1
    And click on element: ejar.workinghourstemplates.isActive.field.byxpath
    And user click on action with id: ejar.workinghourstemplates.save1.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.workinghourstemplates.createnew.byxpath
    And open page using url: /app/fleet-management/branches
    And filter view on column name: Name,الاسم and enter value stored in variable: uiAutomationRandomBranchName
    And user click on view action: Edit,تعديل related to record with text stored in variable: uiAutomationRandomBranchName then select record at index: 1
    And user click on action with id: ejar.branches.isactive.field.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.branches.createnew.byxpath for period in seconds: 100


  @TestType-Smoke
  Scenario: Create And Verify Car Model Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/car-models
    And wait for element present: ejar.model.createnew.byxpath for period in seconds: 120
    And click on link: ejar.model.createnew.byxpath
    And verify ejar fields label with soft assertion in form: create-car-model text: ejar.model.labels.text
    And verify form page labels and text:
      | Text                                              | TagType |
      | Create Car Model,إضافة موديل                      |  h1     |
      | Create,إضافة                                      |  span   |
      | Basic Information,البيانات الاساسيه                |  li     |
      | Is Active,فعال                                    |  label  |
      | Name [en],الاسـم [en]                              |  label  |
      | Name [ar],الاسـم [ar]                              |  label  |
      | Manufacture,الصانع                                |  label  |
      | Category,الفئة                                    |  label  |
      | Available For Online Booking,متاح لحجوزات الأونلاين |  label  |
      | Image,صورة                                        |  label  |
      | Specifications,المواصفات                          |  li     |
      | Specifications,المواصفات                          |  div    |
      | Number Of Doors,عدد الابواب                        |  label  |
      | Number Of Seats,عدد المقاعد                       |  label  |
      | Number Of Luggages,عدد الامتعة                     |  label  |
      | Transmission Type,نوع ناقل الحركة                 |  label  |
      | Fuel Tank Size,سعة خزان المركبة                   |  label  |
      | Engine Size (CC),سعه المحرك (CC)                  |  label  |
      | Available For Online Booking,متاح لحجوزات الأونلاين |  label  |
      | Acriss Code,كود التمييز                           |  li     |
      | Acriss Code,كود التمييز                           |  div    |
      | Category,الفئة                                    |  label  |
      | Type,النوع                                        |  label  |
      | Transmission / Drive,نوع ناقل الحركة              |  label  |
      | Fuel / Air Cond,نوع الوقود / التكييف              |  label  |
      | Images,الصور                                      |  li     |
      | Year,سنة الصنع                                    |  span   |
      | Image,الصورة                                      |  span   |
      | Actions,إجراءات                                   |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.model.isactive.field.byxpath                                  | True       | False      |
      | ejar.model.name_en.field.edit.byxpath                              | True       | True       |
      | ejar.model.name_ar.field.edit.byxpath                              | True       | True       |
      | ejar.model.manufacture.field.edit.byxpath                          | True       | True       |
      | ejar.model.category.field.edit.byxpath                             | True       | True       |
      | ejar.model.availableforonlinebooking.field.byxpath                 | True       | False      |
      | ejar.model.upload.button.byxpath                                   | True       | False      |
      | ejar.model.doorsnumber.field.edit.byxpath                          | True       | True       |
      | ejar.model.seatsnumber.field.edit.byxpath                          | True       | True       |
      | ejar.model.luggagenumber.field.edit.byxpath                        | True       | True       |
      | ejar.model.transmissiontypes.field.edit.byxpath                    | True       | True       |
      | ejar.model.tanksize.field.edit.byxpath                             | True       | True       |
      | ejar.model.enginesize.field.edit.byxpath                           | True       | True       |
      | ejar.model.specificationsavailableforonline.field.byxpath          | True       | False      |
      | ejar.model.acrissCode.category.field.edit.byxpath                  | True       | True       |
      | ejar.model.acrissCode.type.field.edit.byxpath                      | True       | True       |
      | ejar.model.acrissCode.Transmission.field.edit.byxpath              | True       | True       |
      | ejar.model.acrissCode.Fuel.field.edit.byxpath                      | True       | True       |
      | ejar.model.add.button.byxpath                                      | False      | False      |
      | ejar.generic.save.action.byxpath                                   | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And set random text in variable and into element: ejar.model.name_en.field.byxpath with size: 10 and initial string: UI Model and store value in variable: modelVariable
    And set value into field: ejar.model.name_ar.field.byxpath from stored variable: modelVariable
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.model.manufacture.field.byxpath option: Hyundai,هيونداي
    And select option in ejar kendo option field: ejar.model.category.field.byxpath by index: 1
    And user set in field: ejar.model.tanksize.field.byxpath value: 60
    And user set in field: ejar.model.enginesize.field.byxpath value: 1600
    And select option in ejar kendo option field: ejar.model.acrissCode.category.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.model.acrissCode.type.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.model.acrissCode.Transmission.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.model.acrissCode.Fuel.field.byxpath by index: 1
    And upload file to element: ejar.model.upload.button.byxpath with path: \uploadFiles\Yelo_logo.jpg
    And remove attribute for element: ejar.generic.save.action.byxpath attribute: disabled
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: modelVariable
    And user click on view action: Edit,تعديل  related to record with text stored in variable: modelVariable then select record at index: 1
    And user click on action with id: ejar.model.isactive.field.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.model.createnew.byxpath


#Apologies, On Road Assistance service is not provided at your current location
  @TestType-Smoke
  Scenario: Create and verify Assistance Issues Form And Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/assistance-issues-list
    And click on link: ejar.AssistanceIssues.createnew.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.AssistanceIssues.labels.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Assistance Issue,عطل طريق                                               | h1      |
      | Request Assistance Details,طلب عطل طريق                                 | span    |
      | Assistance Issue,عطل طريق                                               | li      |
      | Assistance Issue Info,معلومات عطل طريق                                  | label   |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Urgency,الاهمية                                                          | label   |
      | Is Supported By On Road Assistance,عطل طريق يدعم من المساعدة على الطريق | span    |
      | Termination Message [en],رسالة منع الاستمرار [en]                        | label   |
      | Termination Message [ar],رسالة منع الاستمرار [ar]                        | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.AssistanceIssues.name.english.field.byxpath               |   True     |   True     |
      | ejar.AssistanceIssues.name.arabic.field.byxpath                |   True     |   True     |
      | ejar.AssistanceIssues.urgency.field.byxpath                    |   True     |   True     |
      | ejar.AssistanceIssues.isSupportedBy.field.byxpath              |   True     |   False    |
      | ejar.AssistanceIssues.terminationMessage.english.field.byxpath |   True     |   True     |
      | ejar.AssistanceIssues.terminationMessage.arabic.field.byxpath  |   True     |   True     |
      | ejar.generic.close.action.byxpath                              |   True     |   False    |
      | ejar.generic.save.action.byxpath                               |   False    |   False    |
    And set random text in variable and into element: ejar.AssistanceIssues.name.english.field.byxpath with size: 10 and initial string: UI Automation Assistance Issues and store value in variable: AssistanceVariable
    And set value into field: ejar.AssistanceIssues.name.arabic.field.byxpath from stored variable: AssistanceVariable
    And select option in ejar kendo option field: ejar.AssistanceIssues.urgency.input.byxpath by index: 1
    And  set random text into element: ejar.AssistanceIssues.terminationMessage.english.input.byxpath with size: 20 and initial string: UI Automation Termination Message English
    And  set random text into element: ejar.AssistanceIssues.terminationMessage.arabic.input.byxpath with size: 20 and initial string: UI Automation Termination Message Arabic
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: AssistanceVariable
    And user click on view action: Deactivate,الغاء تفعيل  related to record with text stored in variable: AssistanceVariable then select record at index: 1
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.AssistanceIssues.createnew.byxpath


  @TestType-Smoke
  Scenario: Click on Set Out Of Service And Confirm
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles-out-of-service
    And click on link: ejar.outofservice.createnew.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with xpath: (//td[@role='gridcell']//input[@type='checkbox'])[1]
    And user click on action with id: ejar.outofservice.setOutOfService.Action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath



#Add dynamic car plate number,but it needs to add vehicle damage first.
  @TestType-Smoke
  Scenario: Create and verify Maintenance Cards Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/maintenance-cards/cards-list
    And get plate number of a vehicle with waiting for damages estimation status and store in variable: plateNo
    And store ejar element value: ejar.maintenanceCard.selectedVehicleBranch.td.byxpath and value name: vehicleBranch and keep number only: false
    And change ejar branch from stored variable: vehicleBranch then navigate to: /app/fleet-management/maintenance-cards/cards-list
    And wait for element present: ejar.CreateMaintenanceCard.byxpath for period in seconds: 100
    And click on link: ejar.CreateMaintenanceCard.byxpath
    And verify ejar fields label with soft assertion in form: manage-maintenance-card text: ejar.maintenanceCard.labels.text
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Maintenance Card,بطاقة الصيانة                       | h1      |
      | Create Maintenance Card,انشاء بطاقة صيانة            | span    |
      | Plate Number,رقم اللوحة                              | label   |
      | Maintenance Card Details,تفاصيل بطاقة الصيانة        | li      |
      | Vehicle Information,معلومات المركبة                  | legend  |
      | Plate Number,رقم اللوحة                              | label   |
      | Model,الموديل                                        | label   |
      | Vendor,المورد                                        | label   |
      | Repair Tasks,مهام الاصلاح                              | legend  |
      | Actions,إجراءات                                      | span    |
      | Status,الحالة                                        | span    |
      | Name,الاسم                                            | span    |
      | Cost,التكلفة                                         | span    |
      | Description,الوصف                                    | span    |
      | Accident Number,رقم الحادث                           | span    |
      | Images,الصور                                         | span    |
      | Block Vehicle ?,حجز المركبة ؟                        | label   |
      | On Prem?,في موقع الشركة؟                             | label   |
      | Attachments,المرفقات                                 | li      |
      | Creation Date,تاريخ الإنشاء                           | span    |
      | File,ملف                                             | span    |
      | Comment,ملاحظات                                       | label   |
    And set value into field: ejar.maintenanceCard.plateNumber.field.byxpath from stored variable: plateNo
    And user click on action with id: ejar.maintenanceCard.search.action.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.maintenanceCard.plateNumber.field.byxpath       |   True     |   True     |
      | ejar.maintenanceCard.search.action.byxpath           |   True     |   False    |
      | ejar.maintenanceCard.addRepairTask.action.byxpath    |   True     |   False    |
      | ejar.maintenanceCard.onPrem.button.byxpath           |   True     |   False    |
      | ejar.maintenanceCard.blockVehicle.button.byxpath     |   True     |   False    |
      | ejar.maintenanceCard.attachDocument.button.byxpath   |   True     |   False    |
      | ejar.maintenanceCard.comment.field.byxpath           |   True     |   False    |
      | ejar.maintenanceCard.save.button.byxpath             |   False    |   False    |
      | ejar.maintenanceCard.saveAsDraft.button.byxpath      |   False    |   False    |
      | ejar.maintenanceCard.close.button.byxpath            |   True     |   False    |
    And user click on action with id: ejar.maintenanceCard.onPrem.button.byxpath
    And user click on action with id: ejar.maintenanceCard.blockVehicle.button.byxpath
    And user click on action with id: ejar.maintenanceCard.addRepairTask.action.byxpath
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Add Repair Tasks,أضف مهام الإصلاح                      | h4      |
      | Check Type,نوع التفقد                                | span    |
      | Date,التاريخ                                         | span    |
      | User name,اسم المستخدم                               | span    |
      | Accident Number,رقم الحادث                           | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                      | isEditable | isRequired |
      | ejar.maintenanceCard.addRepairTask.save.button.byxpath          |   False    |   False    |
      | ejar.maintenanceCard.addRepairTask.cancel.button.byxpath        |   True     |   False    |
      | ejar.maintenanceCard.addRepairTask.expandDetails.button.byxpath |   True     |   False    |
    And user click on action with id: ejar.maintenanceCard.addRepairTask.expandDetails.button.byxpath
    And user click on action with id: ejar.maintenanceCard.addRepairTask.selectAll.field.byxpath
    And user click on action with id: ejar.maintenanceCard.addRepairTask.save.button.byxpath
    And user click on action with id: ejar.maintenanceCard.attachDocument.button.byxpath
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Create New Attachment,إضافة مرفق                     | h4      |
      | Description,الوصف                                    | label   |
      | Image,صورة                                           | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                      | isEditable | isRequired |
      | ejar.maintenanceCard.attachment.description.field.byxpath       |   True     |   True     |
      | ejar.maintenanceCard.attachment.save.field.byxpath              |   False    |   False    |
      | ejar.maintenanceCard.attachment.cancel.field.byxpath            |   True     |   False    |
    And set value into element : ejar.maintenanceCard.attachment.description.field.byxpath value: UI Automation Attachment
    And upload file to element: ejar.maintenanceCard.attachment.selectFile.field.byxpath with path: //uploadFiles//logo_high.png
    And click on element: ejar.maintenanceCard.attachment.save.field.byxpath
    And click on element: ejar.maintenanceCard.save.field.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And set value into field: ejar.maintenanceCard.searchPlateNo.input.byxpath from stored variable: plateNo
    And select all branches by unselecting the current branch from the field: ejar.maintenanceCard.branches.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And user click on action with xpath: (//a[child::i[@title='View' or @title='مشاهدة']]/i)[1]
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Maintenance Card,بطاقة الصيانة                       | h1      |
      | Maintenance Card,بطاقة الصيانة                       | span    |
      | Plate Number,رقم اللوحة                              | label   |
      | Maintenance Card Details,تفاصيل بطاقة الصيانة        | li      |
      | Vehicle Information,معلومات المركبة                  | legend  |
      | Plate Number,رقم اللوحة                              | label   |
      | Model,الموديل                                        | label   |
      | Vendor,المورد                                        | label   |
      | Creation Date,تاريخ الإنشاء                           | label   |
      | Fix Date,تاريخ الإصلاح                                 | label   |
      | Close Date,تاريخ الإغلاق                               | label   |
      | Repair Tasks,مهام الاصلاح                              | legend  |
      | Status,الحالة                                        | span    |
      | Name,الاسم                                            | span    |
      | Cost,التكلفة                                         | span    |
      | Description,الوصف                                    | span    |
      | Accident Number,رقم الحادث                           | span    |
      | Images,الصور                                         | span    |
      | Block Vehicle ?,حجز المركبة ؟                        | label   |
      | On Prem?,في موقع الشركة؟                             | label   |
      | Attachments,المرفقات                                 | li      |
      | Description,الوصف                                    | span    |
      | Creation Date,تاريخ الإنشاء                           | span    |
      | File,ملف                                             | span    |
      | Comments,ملاحظات                                      | legend  |
      | Comment,ملاحظات                                       | span    |
      | Creation Date,تاريخ الإنشاء                           | span    |
      | Username,اسم المستخدم                                | span    |
      | Operation,العملية                                    | span    |
      | Operation,العملية                                    | span    |
      | Comment,ملاحظات                                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                      | isEditable | isRequired |
      | ejar.maintenanceCard.status.field.read.byxpath                  |   False    |   False    |
      | ejar.maintenanceCard.name.field.read.byxpath                    |   False    |   False    |
      | ejar.maintenanceCard.cost.field.read.byxpath                    |   False    |   False    |
      | ejar.maintenanceCard.description.field.read.byxpath             |   False    |   False    |
      | ejar.maintenanceCard.accidentNumber.field.read.byxpath          |   False    |   False    |
      | ejar.maintenanceCard.images.field.read.byxpath                  |   False    |   False    |
      | ejar.maintenanceCard.blockVehicle.field.read.byxpath            |   False    |   False    |
      | ejar.maintenanceCard.onPrem.field.read.byxpath                  |   False    |   False    |
      | ejar.maintenanceCard.attachDocument.field.read.byxpath          |   False    |   False    |
      | ejar.maintenanceCard.attachmentDescription.field.read.byxpath   |   False    |   False    |
      | ejar.maintenanceCard.attachmentCreationDate.field.read.byxpath  |   False    |   False    |
      | ejar.maintenanceCard.attachmentFile.field.read.byxpath          |   False    |   False    |
      | ejar.maintenanceCard.comment.field.byxpath                      |   True     |   False    |
      | ejar.maintenanceCard.commentAdd.button.byxpath                  |   False    |   False    |
      | ejar.generic.close.action.byxpath                               |   True     |   False    |
    And click on element: ejar.generic.close.action.byxpath
    And set value into field: ejar.maintenanceCard.searchPlateNo.input.byxpath from stored variable: plateNo
    And select all branches by unselecting the current branch from the field: ejar.maintenanceCard.branches.button.byxpath
    And click on element: ejar.generic.search.action.byxpath
    And click on action if exist with wait: ejar.maintenanceCard.More.button.byxpath waiting number of seconds: 3
    And user click on action with xpath: //a[child::i[@title='Cancel Maintenance Card' or @title='الغاء بطاقة صيانة']]/i
    And user click on action with id: ejar.generic.yes.action.byxpath


  @TestType-Smoke
  Scenario: Create and verify Insurance Company
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/insurance-companies
    And Create organization with random name and store name in variable: organizationName
    And open page using url: /app/fleet-management/insurance-companies
    Then click on link: ejar.createnewinsurancecompany.createnew.byxpath
    And verify element text present: ejar.createnewinsurancecompany.title.label.byxpath with text: ejar.createnewinsurancecompany.title.label.text
    And verify ejar fields label with soft assertion in form: app-insurance-company text: ejar.createnewinsurancecompany.labels.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Create New Insurance Company,إضافة شركة تأمين   | span    |
      | Country,الدولة                                  | label   |
      | Name,الاسم                                       | label   |
      | City,المدينه                                    | label   |
      | Phone No.,الهاتف                                | label   |
      | Area,المنطقة                                    | label   |
      | Street Address,الشارع                           | label   |
      | Building^^ floor...,المبنى / الطابق             | label   |
      | Postal Code,الرمز البريدي                       | label   |
      | Contact Person,الموظف المسؤول - الاسم            | label   |
      | Contact Mobile,الموظف المسؤول - هاتف            | label   |
      | Contact Email,الموظف المسؤول - البريد الالكتروني | label   |
      | Comment,ملاحظات                                  | label   |
      | Is Active,فعال                                  | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewinsurancecompany.countries.field.edit.byxpath        | True       | True       |
      | ejar.createnewinsurancecompany.name.field.edit.byxpath             | False      | True       |
      | ejar.createnewinsurancecompany.cities.field.edit.byxpath           | True       | False      |
      | ejar.createnewinsurancecompany.phone1.field.edit.byxpath           | True       | True       |
      | ejar.createnewinsurancecompany.area.field.edit.byxpath             | True       | True       |
      | ejar.createnewinsurancecompany.streetaddress.field.byxpath         | True       | True       |
      | ejar.createnewinsurancecompany.BuildingOrFloor.fields.edit.byxpath | True       | True       |
      | ejar.createnewinsurancecompany.PostalCode.fields.edit.byxpath      | True       | True       |
      | ejar.createnewinsurancecompany.contactperson.field.edit.byxpath    | True       | True       |
      | ejar.createnewinsurancecompany.phone2.field.edit.byxpath           | True       | True       |
      | ejar.createnewinsurancecompany.contactemail.field.edit.byxpath     | True       | False      |
      | ejar.createnewinsurancecompany.comment.field.edit.byxpath          | True       | False      |
      | ejar.createnewinsurancecompany.isActive.field.edit.byxpath         | True       | False      |
      | ejar.createnewinsurancecompany.save.button.byxpath                 | False      | False      |
      | ejar.createnewinsurancecompany.cancel.button.byxpath               | True       | False      |
    And click on element: ejar.createnewinsurancecompany.countries.field.byxpath
    And click on element: ejar.createnewinsurancecompany.countries.li.byxpath
    And user select option by text in ejar kendo option field without click on empty field: ejar.createnewinsurancecompany.name.field.byxpath with option value from stored variable: organizationName
    And set value into element : ejar.createnewinsurancecompany.phone1.field.byxpath value: 566753951
    And set random text into element: ejar.createnewinsurancecompany.area.field.byxpath with size: 8 and initial string: UI Area
    And set random text into element: ejar.createnewinsurancecompany.streetaddress.field.byxpath with size: 8 and initial string: UI Street
    And set value into element : ejar.createnewinsurancecompany.BuildingOrFloor.fields.byxpath value: 23
    And set value into element : ejar.createnewinsurancecompany.PostalCode.fields.byxpath value: 123456
    And set random text into element: ejar.createnewinsurancecompany.contactperson.field.byxpath with size: 10 and initial string: UI Contact Person
    And set value into element : ejar.createnewinsurancecompany.phone2.field.byxpath value: 566791951
    And click on element: ejar.createnewinsurancecompany.save.button.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: organizationName
    And user click on view action: Edit,تعديل  related to record with text stored in variable: organizationName then select record at index: 1
    And user click on action with id: ejar.createnewinsurancecompany.isActive.field.edit.byxpath
    And user click on action with id: ejar.createnewinsurancecompany.save.button.byxpath
    And wait for number of seconds: 1
    And inactivate organization with name stored in variable: organizationName


  @TestType-Smoke
  Scenario: Create and verify shift
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles
    And filter view on column name: Status,الحالة and select dropdown list value: Ready,جاهزة
    And change vehicle usage type to: Internal Use,استعمال داخلي and store variable: plateNo on page: /app/fleet-management/vehicles
    And open page using url: /app/fleet-management/shifts/shifts-list
    Then wait for element present: ejar.shifts.startShift.button.byxpath for period in seconds: 120
    And click on element: ejar.shifts.startShift.button.byxpath
    And verify ejar fields label with soft assertion in form: shift-details text: ejar.shifts.shiftDetails.labels.text
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Start Shift,بدء وردية                                | h1      |
      | Shift Details,بيانات الوردية                         | div     |
      | Vehicle,المركبه                                      | div     |
      | Vehicle Check,تشيك المركبة                           | div     |
      | Start Location,موقع البداية                          | label   |
      | Start Date,وقت البداية                               | label   |
      | Employee number,الرقم الوظيفي                        | label   |
      | Phone number,رقم الجوال                              | label   |
      | Employee,الموظف                                      | label   |
      | Name,الاسـم                                           | span    |
      | Employee Information,معلومات الموظف                  | span    |
      | Email:,البريد الإلكتروني:                             | label   |
      | Phone:,الهاتف:                                       | label   |
      | Vehicle,المركبه                                      | span    |
      | Plate Number:,رقم اللوحة:                            | label   |
      | Category:,الفئة:                                     | label   |
      | Model:,الموديل:                                      | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.shifts.startLocation.field.byxpath              |   False    |   False    |
      | ejar.shifts.startDate.field.byxpath                  |   True     |   True     |
      | ejar.shifts.employeeNum.field.byxpath                |   True     |   False    |
      | ejar.shifts.phoneNum.field.byxpath                   |   True     |   False    |
      | ejar.shifts.search.button.byxpath                    |   True     |   False    |
      | ejar.shifts.employee.field.byxpath                   |   True     |   True     |
      | ejar.shifts.clear.button.byxpath                     |   True     |   False    |
      | ejar.shifts.next1.button.byxpath                     |   False    |   False    |
      | ejar.generic.cancel.action.byxpath                   |   True     |   False    |
      | ejar.shifts.start.button.byxpath                     |   False    |   False    |
    And search for customer in customer search field: ejar.shifts.employee.input.byxpath with name: Eyad Automation then select record at random index
    And click on element: ejar.shifts.next1.button.byxpath
    And store element value: ejar.shifts.employeeName.span.byxpath and value name: employeeName and keep number only: false
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Plate No,رقم اللوحة                                  | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.shifts.plateNo.field.byxpath                    |   True     |   True     |
      | ejar.shifts.next2.button.byxpath                     |   False    |   False    |
      | ejar.shifts.back1.button.byxpath                     |   True     |   False    |
      | ejar.generic.cancel.action.byxpath                   |   True     |   False    |
      | ejar.shifts.start.button.byxpath                     |   False    |   False    |
    And click on car card with title: Automation Small Sedan,Automation Small Sedan
    And click on car card with title: Automation Accent,Automation Accent
    And select latest car in contract page
    And click on element: ejar.shifts.next2.button.byxpath
    And click on action if exist: ejar.generic.popupok.action.byxpath
    And capture E-check Images if exist
    And click on action if exist: ejar.shifts.checkList1.input.byxpath
    And click on action if exist: ejar.shifts.checkList2.input.byxpath
    And click on element: ejar.shifts.start.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And filter view on column name: Driver's Name,اسم السائق and enter value stored in variable: employeeName
    And click on element: ejar.shifts.endShift.button.byxpath
    And click on element if exist: ejar.contract.caneraAccess.button.byxpath with wait: 5
    And set minimum odometer value into field: ejar.shifts.odometer.field.byxpath with wait for camera: 100
    And user click on element using java script executor: ejar.shifts.next1.button.byxpath
    And remove attribute for element: ejar.generic.save.action.byxpath attribute: disabled
    And verify form page labels and text:
      | Text                                                 | TagType |
      | End Shift,انهاء وردية                                | h1      |
      | Start Date,وقت البداية                               | label   |
      | End Location,موقع النهاية                            | label   |
      | End Date,وقت النهاية                                 | label   |
      | Start Location,موقع البداية                          | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.shifts.endDate.field.edit.byxpath               |   True     |   True     |
      | ejar.generic.save.action.byxpath                     |   True     |   False    |
      | ejar.shifts.back1.button.byxpath                     |   True     |   False    |
      | ejar.generic.cancel.action.byxpath                   |   True     |   False    |
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    Then wait for element present: ejar.shifts.startShift.button.byxpath for period in seconds: 20
    And wait for number of seconds: 1



  @TestType-Smoke
  Scenario: Create and verify theft report
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/theft-requests
    And get plate number of a vehicle with status: Rented,مؤجرة
    And open page using url: /app/fleet-management/theft-requests
    And wait for element present: ejar.thefreport.createnew.button.byxpath for period in seconds: 120
    And click on element: ejar.thefreport.createnew.button.byxpath
    And verify ejar fields label with soft assertion in form: create-theft-request text: ejar.theftreport.labels.text
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Theft Report,تقرير سرقة                              | h1      |
      | Create New Theft Report,اضافة تقرير سرقة مركبة       | span    |
      | Theft Report,تقرير سرقة                              | li      |
      | Basic Information,البيانات الاساسيه                   | div     |
      | Plate No,رقم اللوحة                                  | label   |
      | Theft Report Details,معلومات تقرير السرقة            | div     |
      | Country,الدولة                                       | label   |
      | City,المدينه                                         | label   |
      | Police Station,مخفر الشرطة                           | label   |
      | Theft Date,تاريخ السرقة                              | label   |
      | Report Document,مرفق التقرير                         | label   |
      | Comment,ملاحظات                                       | label   |
    And user set the stored plate number value in field: ejar.thefreport.plateNo.input.byxpath
    And click on element: ejar.thefreport.plateNo.firstOption.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.thefreport.plateNo.field.byxpath                |   True     |   True     |
      | ejar.thefreport.country.field.byxpath                |   False    |   False    |
      | ejar.thefreport.city.field.byxpath                   |   True     |   True     |
      | ejar.thefreport.policeStation.field.byxpath          |   True     |   True     |
      | ejar.thefreport.theftDate.field.byxpath              |   True     |   True     |
      | ejar.thefreport.comment.field.byxpath                |   True     |   False    |
      | ejar.generic.cancel.action.byxpath                   |   True     |   False    |
      | ejar.generic.save.action.byxpath                     |   False    |   False    |
    And user select option by text in ejar kendo option field without typing: ejar.thefreport.city.list.byxpath option: Automation Riyadh,Automation Riyadh
    And set random text into element: ejar.thefreport.policeStation.field.byxpath with size: 10 and initial string: UI Automation Police Station
    And upload file to element: ejar.thefreport.upload.byxpath with path: //uploadFiles//logo_high.png
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.theftreports.view.status.byxpath for period in seconds: 80
    And user select option by text in ejar kendo option field without typing: ejar.theftreports.view.status.byxpath option: Not assigned,غير محدد
    And filter view on column name: Plate Number,رقم اللوحة and enter value stored in variable: vehiclePlateNumber
    And user click on action with id: ejar.generic.search.action.byxpath
    And click on view first record cell under column name: Report Number,رقم الطلب
    And verify form page labels and text:
      | Text                                                            | TagType |
      | Theft Report,تقرير سرقة                                         | h1      |
      | Theft Report Details,معلومات تقرير السرقة                       | span    |
      | Theft Report Details,معلومات تقرير السرقة                       | li      |
      | Reference No.:,رقم المرجع:                                      | span    |
      | Status,الحالة                                                   | span    |
      | Plate Number,رقم اللوحة                                         | label   |
      | Vehicle,المركبه                                                 | label   |
      | Customer Name,اسم العميل                                        | label   |
      | Customer Phone,هاتف العميل                                      | label   |
      | City,المدينه                                                    | label   |
      | Theft Date,تاريخ السرقة                                         | label   |
      | Police Station,مخفر الشرطة                                      | label   |
      | Attachment,المرفق                                               | label   |
      | Description,الوصف                                               | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.thefreport.refNo.field.read.byxpath             |   False    |   False    |
      | ejar.thefreport.status.field.read.byxpath            |   False    |   False    |
      | ejar.thefreport.plateNo.field.read.byxpath           |   False    |   False    |
      | ejar.thefreport.vehicle.field.read.byxpath           |   False    |   False    |
      | ejar.thefreport.customerName.field.read.byxpath      |   False    |   False    |
      | ejar.thefreport.customerPhone.field.read.byxpath     |   False    |   False    |
      | ejar.thefreport.city.field.read.byxpath              |   False    |   False    |
      | ejar.thefreport.theftDate.field.read.byxpath         |   False    |   False    |
      | ejar.thefreport.policeStation.field.read.byxpath     |   False    |   False    |
      | ejar.thefreport.attachment.field.read.byxpath        |   False    |   False    |
      | ejar.thefreport.reject.button.byxpath                |   False    |   False    |
      | ejar.thefreport.convertToStolen.button.byxpath       |   False    |   False    |
      | ejar.generic.close.action.byxpath                    |   True     |   False    |
    And click on element: ejar.generic.close.action.byxpath

  @TestType-Smoke
  Scenario: Out of service and extend form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles-out-of-service
    And wait for element present: ejar.outofservice.createnew.byxpath for period in seconds: 120
    And click on link: ejar.outofservice.createnew.byxpath
    And filter view on column name: Status,الحالة and select dropdown list value: Ready,جاهزة
    And store the value of column: Plate Number,رقم اللوحة when there is no value in column: Additional Statuses,الحالات الاضافية in the variable: plateNo on page: /app/fleet-management/customize-vehicle-period-of-service
    And user click on action with id: ejar.generic.search.action.byxpath
    And store ejar element value: ejar.outofservice.vehiclePlateNo.byxpath and value name: plateNo and keep number only: false
    And filter view on column name: Plate Number,رقم اللوحة and enter value stored in variable: plateNo
    And click on element: ejar.outofservice.selectAll.input.byxpath
    And click on element: ejar.outofservice.setOutOfService.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And filter view on column name: Plate Number,رقم اللوحة and enter value stored in variable: plateNo
    And click on element: ejar.outofservice.selectAll.input.byxpath
    And click on element: ejar.outofservice.extend.button.byxpath
    And verify form page labels and text:
      | Text                                          | TagType |
      | Extend Vehicles,تمديد فترة الخدمة             | span    |
      | Extension Date,تاريخ التمديد                  | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                     | isEditable | isRequired |
      | ejar.outofservice.extensionDatePicker.fields.byxpath                           | True       | True       |
      | ejar.outofservice.extendSave.button.byxpath                                    | True       | False      |
      | ejar.outofservice.cancel.button.byxpath                                        | True       | False      |
    And click on element: ejar.outofservice.extendSave.button.byxpath


#no need to combine scenarios, because verification is for editing the traffic violation
  @TestType-Smoke
  Scenario: Traffic Violations edit form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/traffic-violations
    And wait for element present: ejar.generic.search.action.byxpath for period in seconds: 120
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.trafficviolations.edit.byxpath
    And wait for element present: ejar.trafficviolations.editModal.div.byxpath for period in seconds: 100
    And verify ejar fields label with soft assertion in form: create-or-edit-traffic-violation-modal text: ejar.trafficviolations.label.text
    And verify form page labels and text:
      | Text                                                 | TagType |
      | Edit Traffic Violation,تعديل مخالفة                  | span    |
      | Ref. Type,نوع المرجع                                 | label   |
      | Reference No.,رقم المرجع                             | label   |
      | Traffic Violation Number,رقم المخالفة                | label   |
      | Traffic Violation Date,تاريخ المخالفة                | label   |
      | Plate No,رقم اللوحة                                  | label   |
      | Traffic Violation Amount,قيمة المخالفة               | label   |
      | Note,ملاحظات                                          | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                           | isEditable | isRequired |
      | ejar.trafficviolations.referencetype.fields.byxpath  |   False    |   False    |
      | ejar.trafficviolations.referencename.fields.byxpath  |   False    |   False    |
      | ejar.trafficviolations.trafficnumber.fields.byxpath  |   True     |   True     |
      | ejar.trafficviolations.trafficdate.fields.byxpath    |   True     |   True     |
      | ejar.trafficviolations.platenumber.fields.byxpath    |   False    |   False    |
      | ejar.trafficviolations.valueinput.fields.byxpath     |   True     |   True     |
      | ejar.trafficviolations.trafficnote.fields.byxpath    |   True     |   True     |
      | ejar.trafficviolations.save.button.byxpath           |   False    |   False    |
      | ejar.trafficviolations.cancel.button.byxpath         |   True     |   False    |
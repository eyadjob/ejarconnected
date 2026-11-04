Feature: Ejar Customer Forms Saving Validation

  @TestType-verification
  Scenario: customer profile dialogs verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customers
    And click on element: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.customers.createnew.byxpath
    And user click on action with id: ejar.customers.skip.CustomerProvidersIntegration.byxpath
    And click on element if exist: ejar.customers.skip.CustomerProvidersSecondIntegration.byxpath with wait: 10
    And verify ejar fields label with soft assertion in form: create-or-edit-customer text: ejar.customers.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Customers,العملاء                                                      |  h1     |
      | Customers Management,إدارة العملاء                                     |  span   |
      | Basic information,المعلومات الأساسية                                   |  li     |
      | First Name,الاسم الاول                                                  |  label  |
      | Second Name,الاسم الثاني                                               |  label  |
      | Third Name,الاسم الثالث                                                |  label  |
      | Fourth name,الاسم الرابع                                               |  label  |
      | Family name,اسم العائلة                                               |  label  |
      | Nationality,الجنسية                                                   |  label  |
      | Gender,النوع                                                          |  label  |
      | Birth Date,تاريخ الميلاد                                               |  label  |
      | Marital status,الحالة الاجتماعية                                       |  label  |
      | Number of dependencies,عدد التابعين                                   |  label  |
      | VIP,كبار العملاء                                                       |  label  |
      | Contact information,معلومات الاتصال                                    |  div    |
      | Primary Phone,الهاتف الأساسي                                           |  label  |
      | Secondary Phone,الهاتف الثانوي                                        |  label  |
      | E-Mail,البريد الإلكتروني                                               |  label  |
      | Terms & Conditions,الشروط والأحكام                                     |  span   |
      | Marketing Materials,المواد التسويقية                                  |  span   |
      | Professional information,معلومات العمل                                |  div    |
      | Organization,جهة العمل                                                |  label  |
      | Occupation,الوظيفة                                                    |  label  |
      | Addresses,العناوين                                                    |  li     |
      | Country,الدولة                                                        |  label  |
      | City,المدينة                                                          |  label  |
      | Details,التفاصيل                                                      |  label  |
      | Secondary address,العنوان الثانوي                                     |  div    |
      | Country,الدولة                                                        |  label  |
      | City,المدينة                                                          |  label  |
      | Details,التفاصيل                                                      |  label  |
      | Documents,الوثائق                                                     |  li     |
      | Type,النوع                                                            |  span   |
      | Number,الرقم                                                          |  span   |
      | Issue Date,تاريخ الاصدار                                               |  span   |
      | Expiry Date,تاريخ الانتهاء                                             |  span   |
      | Issue Country,دولة الاصدار                                             |  span   |
      | External Loyalties,العضويات الخارجية                                  |  li     |
      | Membership Name,اسم العضوية                                           |  span   |
      | Level,المستوى                                                         |  span   |
      | Number,الرقم                                                          |  span   |
      | Is Active,فعال                                                        |  span   |
      | Emergency contacts,المعرفين                                           |  li     |
      | Reference name,الاسم                                                   |  span   |
      | Phone number,رقم الهاتف                                               |  span   |
      | Relative level,صلة القرابة                                            |  span   |
      | Notes,ملاحظات                                                          |  li     |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.createcustomer.firstname.field.byxpath                      | True       | True       |
      | ejar.createcustomer.secondName.field.byxpath                     | True       | False      |
      | ejar.createcustomer.thirdName.field.byxpath                      | True       | False      |
      | ejar.createcustomer.fourthName.field.byxpath                     | True       | False      |
      | ejar.createcustomer.familyName.field.byxpath                     | True       | True       |
      | ejar.createcustomer.nationality.field.byxpath                    | True       | True       |
      | ejar.createcustomer.gender.field.byxpath                         | True       | True       |
      | ejar.createcustomer.dateOfBirth.field.edit.byxpath               | True       | True       |
      | ejar.createcustomer.maritalStatus.field.byxpath                  | True       | False      |
      | ejar.createcustomer.noOfDependencies.field.byxpath               | True       | False      |
      | ejar.createcustomer.vip.field.byxpath                            | True       | False      |
      | ejar.createcustomer.primaryphone.field.byxpath                   | True       | False      |
      | ejar.createcustomer.secondaryphone.field.byxpath                 | True       | False      |
      | ejar.createcustomer.email.field.byxpath                          | True       | False      |
      | ejar.createcustomer.organization.field.edit.byxpath              | True       | False      |
      | ejar.createcustomer.organization.button.edit.byxpath             | True       | False      |
      | ejar.createcustomer.occupation.field.edit.byxpath                | True       | False      |
      | ejar.createcustomer.country.field.byxpath                        | True       | False      |
      | ejar.createcustomer.city.field.byxpath                           | True       | False      |
      | ejar.createcustomer.details.field.byxpath                        | True       | False      |
      | ejar.createcustomer.country.secondaryaddress.field.byxpath       | True       | False      |
      | ejar.createcustomer.city.secondaryaddress.field.byxpath          | True       | False      |
      | ejar.createcustomer.details.secondaryaddress.field.byxpath       | True       | False      |
      | ejar.createcustomer.documents.adddocuments.byxpath               | True       | False      |
      | ejar.createcustomer.addexternalloyalty.button.byxpath            | True       | False      |
      | ejar.createcustomer.emergencycontacts.addemergencycontact.byxpath| True       | False      |
      | ejar.createcustomer.notes.field.byxpath                          | True       | False      |
      | ejar.createcustomer.createbutton.byxpath                         | False      | False      |
      | ejar.createcustomer.cancelbutton.addemergencycontact.byxpath     | True       | False      |
    And set random text in variable and into element: ejar.createcustomer.firstname.field.byxpath with size: 10 and initial string: UI Automation Customer and store value in variable: customerNameVariable
    And set value into field: ejar.createcustomer.familyName.field.byxpath from stored variable: customerNameVariable
    And user select value in drop down field: ejar.createcustomer.nationality.field.byxpath by option text: Saudi,سعودي
    And user select value in drop down field: ejar.createcustomer.gender.field.byxpath by option text: Male,ذكر
    And user select date in ejar calendar field with arrow: ejar.createcustomer.dateOfBirth.input.byxpath plus days: -7570
    And user set in field: ejar.createcustomer.primaryphone.field.byxpath value: 515552222
    And set random email into element: ejar.createcustomer.email.field.byxpath
    And user click on action with id: ejar.createcustomer.documents.adddocuments.byxpath
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Create New Document,اضافة اثبات جديد                                  |  span   |
      | Type,نوع                                                              |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.createcustomer.document.documenttype.field.byxpath          | True       | True       |
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Identity ,الهوية
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.createcustomer.documents.identity.label.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Copy Number,رقم النسخة                                                |  label  |
      | Issue Country,دولة الاصدار                                             |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | True       |
      | ejar.identity.field.options.copynumber.byxpath                   | True       | False      |
      | ejar.identity.field.options.issuecountry.byxpath                 | False      | False      |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | True       |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And set random number into element: ejar.identity.field.options.number.byxpath of size: 10
    And user select date in ejar calendar field with arrow: ejar.identity.field.expirydate.input.byxpath plus days: 399
    And remove attribute for element: ejar.createcustomer.document.documenttype.addButton.field.byxpath attribute: disabled
    And upload file to element: ejar.identity.field.options.attachment.byxpath with path: //uploadFiles//logo_high.png
    And user click on action with id: ejar.createcustomer.document.documenttype.add.field.byxpath
    And click on element: ejar.createcustomer.documents.adddocuments.byxpath
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Passport, جواز السفر
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.customers.document.passport.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Issue Country,دولة الاصدار                                             |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | Visa Number,رقم الفيزا                                                |  label  |
      | Border ID,رقم الحدود                                                  |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | True       |
      | ejar.identity.field.options.issuecountry.byxpath                 | False      | False      |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | True       |
      | ejar.identity.field.options.visaNumber.byxpath                   | True       | False      |
      | ejar.identity.field.options.borderID.byxpath                     | True       | False      |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Work Card,بطاقة عمل
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.customers.document.workCard.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | Organization,جهة العمل                                                |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | False      |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | False      |
      | ejar.identity.field.options.organization.byxpath                 | True       | True       |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Driver License,رخصة قيادة
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.customers.document.driverLicense.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Issue Country,دولة الاصدار                                             |  label  |
      | Issue Date,تاريخ الاصدار                                               |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | License Category,فئة الرخصة                                           |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | True       |
      | ejar.identity.field.options.issuecountry.byxpath                 | True       | True       |
      | ejar.identity.field.options.issueDate.byxpath                    | True       | False      |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | False      |
      | ejar.identity.field.options.licenseCategories.byxpath            | True       | False      |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And set random number into element: ejar.identity.field.options.number.byxpath of size: 10
    And user select date in ejar calendar field with arrow: ejar.identity.field.options.expirydate.input.byxpath plus days: 399
    And remove attribute for element: ejar.createcustomer.document.documenttype.addButton.field.byxpath attribute: disabled
    And upload file to element: ejar.identity.field.options.attachment.byxpath with path: //uploadFiles//logo_high.png
    And user click on action with id: ejar.createcustomer.document.documenttype.add.field.byxpath
    And click on element: ejar.createcustomer.documents.adddocuments.byxpath
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Residence, اقامة
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.customers.document.residence.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Copy Number,رقم النسخة                                                |  label  |
      | Issue Country,دولة الاصدار                                             |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | True       |
      | ejar.identity.field.options.copynumber.byxpath                   | True       | False      |
      | ejar.identity.field.options.issuecountry.byxpath                 | True       | True       |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | True       |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And user select value in drop down field: ejar.createcustomer.document.documenttype.field.byxpath by option text: Selfie, الصورة الشخصية
    And verify ejar fields label with soft assertion in form: createoreditcustomerdocumentmodal text: ejar.customers.document.selfie.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Number,الرقم                                                          |  label  |
      | Issue Country,دولة الاصدار                                             |  label  |
      | Expiry Date,تاريخ الانتهاء                                             |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.identity.field.options.number.byxpath                       | True       | True       |
      | ejar.identity.field.options.issuecountry.byxpath                 | True       | True       |
      | ejar.identity.field.options.expirydate.byxpath                   | True       | True       |
      | ejar.identity.field.options.attachment.byxpath                   | True       | False      |
      | ejar.createcustomer.document.documenttype.cancel.field.byxpath   | True       | False      |
      | ejar.createcustomer.document.documenttype.add.field.byxpath      | False      | False      |
    And click on element: ejar.createcustomer.document.documenttype.cancel.field.byxpath
    And user scroll to element: ejar.createcustomer.customerexternalloyalty.addexternalloyalty.byxpath
    And click on link: ejar.createcustomer.customerexternalloyalty.addexternalloyalty.byxpath
    And verify ejar fields label with soft assertion in form: customerexternalloyalty text: ejar.customers.externalLoyalty.fields.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Create New External Loyalty,اضافة عضوية خارجية                        |  span   |
      | Name,الاسم                                                             |  label  |
      | Active,فعال                                                           |  label  |
      | Attachment,المرفق                                                     |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                    | isEditable | isRequired |
      | ejar.createcustomer.creatnewcustomerexternalloyalty.name.field.byxpath        | True       | True       |
      | ejar.createcustomer.creatnewcustomerexternalloyalty.active.field.byxpath      | True       | False      |
      | ejar.createcustomer.creatnewcustomerexternalloyalty.attachment.field.byxpath  | True       | False      |
      | ejar.createcustomer.cancel.field.byxpath                                      | True       | False      |
      | ejar.createcustomer.save.field.byxpath                                        | False      | False      |
    And click on link: ejar.createcustomer.cancel.field.byxpath
    And click on link: ejar.createcustomer.emergencycontacts.addemergencycontact.byxpath
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.createcustomer.emergencycontacts.name.field.byxpath            | True       | False      |
      | ejar.createcustomer.emergencycontacts.phone.field.byxpath           | True       | False      |
      | ejar.createcustomer.emergencycontacts.relativelevel.field.byxpath   | True       | False      |
      | ejar.createcustomer.emergencycontacts.add.button.byxpath            | True       | False      |
      | ejar.createcustomer.emergencycontacts.cancel.button.byxpath         | True       | False      |
      | ejar.createcustomer.notes.field.byxpath                             | True       | False      |
    And click on element: ejar.createcustomer.emergencycontacts.cancel.button.byxpath
    And user click on action with id: ejar.createcustomer.createbutton.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.customers.createnew.byxpath for period in seconds: 120

  @TestType-Smoke
  Scenario: Create Organization Form And Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/organizations
    And user click on action with id: ejar.organizations.createnew.byxpath
    And verify ejar fields label with soft assertion in form: createoreditorganizationsmodal text: ejar.organizations.label.text
    And verify form page labels and text:
      | Text                                              | TagType |
      | Create New Organization,إنشاء منظمة جديدة         |  span   |
      | Country ,الدولة                                   |  label  |
      | Name,الاسـم                                        |  label  |
      | City,المدينة                                      |  label  |
      | Classification,التصنيف                            |  label  |
      | Sector,القطاع                                     |  label  |
      | Fax No.,الفاكس                                    |  label  |
      | Area,المنطقة                                      |  label  |
      | Street Address,الشارع                             |  label  |
      | Building^^ floor... ,المبنى / الطابق              |  label  |
      | Postal Code,الرمز البريدي                         |  label  |
      | More address details,تفاصيل العنوان الاضافية       |  label  |
      | Phone No.,الهاتف                                  |  label  |
      | Comment,ملاحظات                                    |  label  |
      | Active,فعال                                       |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.organizations.countries.fields.edit.byxpath                 | True       | True       |
      | ejar.organizations.name.fields.read.byxpath                      | False      | True       |
      | ejar.organizations.city.fields.edit.byxpath                      | True       | False      |
      | ejar.organizations.classification.fields.edit.byxpath            | True       | True       |
      | ejar.organizations.sector.fields.edit.byxpath                    | True       | False      |
      | ejar.organizations.faxNo.fields.edit.byxpath                     | True       | False      |
      | ejar.organizations.area.fields.edit.byxpath                      | True       | True       |
      | ejar.organizations.streetAddress.fields.edit.byxpath             | True       | True       |
      | ejar.organizations.buildingFloor.fields.edit.byxpath             | True       | True       |
      | ejar.organizations.postalCode.fields.edit.byxpath                | True       | True       |
      | ejar.organizations.moreAddress.fields.edit.byxpath               | True       | False      |
      | ejar.organizations.mobileNo.fields.edit.byxpath                  | True       | False      |
      | ejar.organizations.comment.fields.edit.byxpath                   | True       | False      |
      | ejar.organizations.isActive.fields.edit.byxpath                  | True       | False      |
      | ejar.organizations.save.button.byxpath                           | False      | False      |
      | ejar.organizations.cancel.button.byxpath                         | True       | False      |
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.organizations.countries.fields.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And set random text in variable and into element: ejar.organizations.name.fields.byxpath with size: 10 and initial string: UI Automation Organization and store value in variable: organizationName
    And set random text into element: ejar.organizations.area.fields.byxpath with size: 10 and initial string: UI
    And set random text into element: ejar.organizations.street.fields.byxpath with size: 10 and initial string: UI
    And set random text into element: ejar.organizations.BuildingOrFloor.fields.byxpath with size: 10 and initial string: UI
    And set random text into element: ejar.organizations.area.fields.byxpath with size: 10 and initial string: UI
    And set random text into element: ejar.organizations.PostalCode.fields.byxpath with size: 3 and initial string: UI
    And select option in ejar kendo option field: ejar.organizations.classifications.fields.byxpath by index: 1
    And user click on action with id: ejar.organizations.save.button.byxpath
    And wait for element not present: ejar.organizations.modalVisible.div.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: organizationName
    And user click on view action: Edit,تعديل  related to record with text: UI Automation Organization then select record at index: 1
    And user click on action with id: ejar.organizations.isactive.fields.byxpath
    And user click on action with id: ejar.organizations.save.button.byxpath

  @TestType-Smoke
  Scenario: Create and verify Corporates Form then Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/corporates
    And wait for element present: ejar.corporate.createnew.byxpath for period in seconds: 150
    And user click on action with id: ejar.corporate.createnew.byxpath
    And verify ejar fields label with soft assertion in form: corporate-details text: ejar.createcorporate.labels.text
    And verify form page labels and text:
      | Text                                                                                      | TagType |
      | Corporate,شركة                                                                            |  h1     |
      | Manage Corporate,إدارة الشركة                                                             |  span   |
      | Parent Corporate,شركة أم                                                                  |  label  |
      | Owned Corporate,شركة مملوكة                                                               |  label  |
      | Corporate,شركة                                                                            |  li     |
      | Basic information,المعلومات الأساسية                                                       |  div    |
      | Country,الدولة                                                                            |  label  |
      | Name,الاسـم                                                                                |  label  |
      | City,المدينة                                                                              |  label  |
      | Phone number,رقم الجوال                                                                   |  label  |
      | Parent Corporate,الشركة الأم                                                               |  label  |
      | Area,المنطقة                                                                              |  label  |
      | Street Address,الشارع                                                                     |  label  |
      | Building^^ floor... ,المبنى / الطابق                                                      |  label  |
      | Postal Code,الرمز البريدي                                                                 |  label  |
      | More address details,تفاصيل العنوان الاضافية                                               |  label  |
      | Classification,التصنيف                                                                    |  label  |
      | Sector,القطاع                                                                             |  label  |
      | Tax Number,الرقم الضريبي                                                                  |  label  |
      | Tax Identification Number,الرقم الضريبي المميز                                            |  label  |
      | Account Manager,مندوب مبيعات                                                              |  label  |
      | Credit Limit,الحد الإئتماني                                                                |  label  |
      | Contact person information,بيانات الشخص المفوض                                            |  div    |
      | Name,الاسـم                                                                                |  label  |
      | Email,البريد الإلكتروني                                                                    |  label  |
      | Primary Phone,الهاتف الأساسي                                                               |  label  |
      | Secondary Phone,الهاتف الثاني                                                             |  label  |
      | Portal Access Enabled,اتاحة الوصول إلى نظام الشركات                                       |  label  |
      | Portal Access Two Factor Verification Enabled,اتاحة التحقق الإضافي للوصول إلى نظام الشركات |  label  |
      | Centralized Tax Number and Contact person information for parent corporate and subsidiaries,توحيد الرقم الضريبي وبيانات الشخص المفوض للشركة الام والشركات التابعة لها |  label  |
      | Comment,ملاحظات                                                                            |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.createcorporate.country.field.edit.byxpath                  | True       | True       |
      | ejar.createcorporate.name.field.edit.byxpath                     | True       | True       |
      | ejar.createcorporate.city.field.read.byxpath                     | False      | True       |
      | ejar.createcorporate.corporatephone.field.edit.byxpath           | True       | True       |
      | ejar.createcorporate.parentCorporate.field.edit.byxpath          | True       | False      |
      | ejar.createcorporate.area.field.read.byxpath                     | False      | True       |
      | ejar.createcorporate.street.field.read.byxpath                   | False      | True       |
      | ejar.createcorporate.buildingOrFloor.field.read.byxpath          | False      | True       |
      | ejar.createcorporate.postalCode.field.read.byxpath               | False      | True       |
      | ejar.createcorporate.moreAddressDetails.field.read.byxpath       | False      | False      |
      | ejar.createcorporate.classification.field.read.byxpath           | False      | True       |
      | ejar.createcorporate.sector.field.read.byxpath                   | False      | False      |
      | ejar.createcorporate.taxNumber.field.read.byxpath                | False      | True       |
      | ejar.createcorporate.taxIdentityNumber.field.read.byxpath        | False      | False      |
      | ejar.createcorporate.accountManager.field.read.byxpath           | False      | True       |
      | ejar.createcorporate.creditLimit.field.read.byxpath              | False      | False      |
      | ejar.createcorporate.contact.name.field.read.byxpath             | False      | True       |
      | ejar.createcorporate.contact.email.field.read.byxpath            | False      | False      |
      | ejar.createcorporate.contact.primaryPhone.field.read.byxpath     | False      | True       |
      | ejar.createcorporate.contact.secondPhone.field.read.byxpath      | False      | False      |
      | ejar.createcorporate.contact.portalaccess.field.edit.byxpath     | True       | False      |
      | ejar.createcorporate.contact.portalaccessAuth.field.read.byxpath | False      | False      |
      | ejar.createcorporate.comment.field.read.byxpath                  | False      | False      |
      | ejar.createcorporate.centralizedTaxNumber.field.read.byxpath     | False      | False      |
      | ejar.createcorporate.cancel.button.byxpath                       | True       | False      |
      | ejar.createcorporate.save.button.byxpath                         | False      | False      |
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.createcorporate.country.field.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And set random text in variable and into element: ejar.createcorporate.name.field.byxpath with size: 10 and initial string: Automation UI Corporate  and store value in variable: corporateName
    And click on action if exist: ejar.generic.yes.action.byxpath
    And set value into element : ejar.createcorporate.corporatephone.field.edit.byxpath value: 554336777
    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.createcorporate.city.field.byxpath option: Automation Riyadh,Automation Riyadh
    And set random text into element: ejar.createcorporate.area.field.read.byxpath with size: 5 and initial string: UI Automation Area
    And set random text into element: ejar.createcorporate.street.field.read.byxpath with size: 5 and initial string: UI Automation Street
    And set value into element : ejar.createcorporate.buildingOrFloor.field.read.byxpath value: 21
    And set value into element : ejar.createcorporate.postalCode.field.read.byxpath value: 28721
    And select option in ejar kendo option field: ejar.createcorporate.classification.field.byxpath by index: 1
    And select option in ejar kendo option field: ejar.createcorporate.accountmanager.field.byxpath by index: 1
    And set random text into element: ejar.createcorporate.contactpersoninformation.name.field.byxpath with size: 10 and initial string: UI Automation Contact
    And set random email into element: ejar.createcorporate.contactpersoninformation.email.field.byxpath
    And user set in field: ejar.createcorporate.contactpersoninformation.corporatephone.field.byxpath value: 554446666
    And user set in field: ejar.createcorporate.contactpersoninformation.primaryphone.field.byxpath value: 553336666
    And user click on action with id: ejar.createcorporate.contactpersoninformation.email.field.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: corporateName
    And click on element: ejar.createcorporate.firstRecord.a.field.byxpath
    And user click on element using java script executor: ejar.createcorporate.deactivate.button.byxpath
    And user click on action with xpath: (//view-corporate//button[contains(.,'Deactivate') or contains(.,'الغاء تفعيل') or contains(.,'إلغاء تفعيل')])[2]
    And inactivate organization with name stored in variable: corporateName

  @TestType-Smoke
  Scenario: Create And Verify Customer Loyalty Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customerloyalitylist
    And click on element: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.customerloyalty.createnew.byxpath
    And verify ejar fields label with soft assertion in form: add-manual-loyality text: ejar.customerloyalty.label.text
    And verify form page labels and text:
      | Text                                                    | TagType |
      | Create New,اضافة العضوية يدوياً                          |  span   |
      | Identity number,رقم الإثبات                              |  label  |
      | Phone number,رقم الجوال                                 |  label  |
      | Customer Name,اسم العميل                                |  label  |
      | Phone number,رقم الجوال                                 |  label  |
      | Name,الاسم                                               |  label  |
      | Current Loyalty Level,مستوى العضويه الحالي              |  label  |
      | Loyalty Level,مستوى العضوية                             |  label  |
      | Reason,السبب                                            |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.customerloyalty.identitynumber.fields.edit.byxpath          | True       | False      |
      | ejar.customerloyalty.phone.fields.edit.byxpath                   | True       | False      |
      | ejar.customerloyalty.customername.fields.edit.byxpath            | True       | False      |
      | ejar.customerloyalty.fullname.fields.read.byxpath                | False      | True       |
      | ejar.customerloyalty.currentloyalitylevel.fields.read.byxpath    | False      | False      |
      | ejar.customerloyalty.membershiplevel.fields.edit.byxpath         | True       | True       |
      | ejar.customerloyalty.reason.fields.edit.byxpath                  | True       | True       |
      | ejar.customerloyalty.search.button.byxpath                       | False      | False      |
      | ejar.customerloyalty.clear.button.byxpath                        | True       | False      |
      | ejar.customerloyalty.cancel.button.byxpath                       | True       | False      |
      | ejar.customerloyalty.save.button.byxpath                         | False      | False      |
    And search for value in search field: ejar.customerloyalty.customername.fields.byxpath with name: Eyad Automation,Eyad Automation then select record at index: 0
    And user select value in drop down field: ejar.customerloyalty.membershiplevel.fields.byxpath by index: 1
    And set random text into element: ejar.customerloyalty.reason.fields.byxpath with size: 10 and initial string: UI Automation Customer Loyalty Reason
    And click on action if exist: ejar.generic.yes.action.byxpath
    And user click on action with id: ejar.customerloyalty.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.customerloyalty.createnew.byxpath

#internal error bug appears
  @TestType-Smoke
  Scenario: View And Verify External Loyalty Configuration Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/external-loyalties-configurations
    And wait for element present: ejar.externalloyaltyconfiguration.createnew.button.byxpath for period in seconds: 120
    And user click on action with id: ejar.externalloyaltyconfiguration.createnew.button.byxpath
    And click on element if exist: ejar.externalloyaltyconfiguration.error.button.byxpath with wait: 5
    And verify ejar fields label with soft assertion in form: createoreditexternalloyaltyconfiguration text: ejar.externalloyaltyconfiguration.label.text
    And verify form page labels and text:
      | Text                                                                 | TagType |
      | Create New External Loyalty Configuration,اضافة اعدادات عضوية خارجية |  h1     |
      | Create New External Loyalty Configuration,اضافة اعدادات عضوية خارجية |  span   |
      | Basic information,المعلومات الأساسية                                  |  div    |
      | Operational Countries,الدول التشغيلية                                |  label  |
      | Name [en],الاسـم [en]                                                 |  label  |
      | Name [ar],الاسـم [ar]                                                 |  label  |
      | Loyalty Type,نوع العضوية                                             |  label  |
      | Currency,العملة                                                      |  label  |
      | Active,فعال                                                          |  label  |
      | Levels,المستويات                                                     |  li     |
      | Name,الاسم                                                            |  span   |
      | Exchange Factor,معامل التحول                                         |  span   |
      | Actions,إجراءات                                                      |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                 | isEditable | isRequired |
      | ejar.externalloyaltyconfiguration.operationalCountries.fields.edit.byxpath | True       | True       |
      | ejar.externalloyaltyconfiguration.nameEN.fields.edit.byxpath               | True       | True       |
      | ejar.externalloyaltyconfiguration.nameAR.fields.edit.byxpath               | True       | True       |
      | ejar.externalloyaltyconfiguration.loyaltyType.fields.edit.byxpath          | True       | True       |
      | ejar.externalloyaltyconfiguration.currency.fields.read.byxpath             | False      | True       |
      | ejar.externalloyaltyconfiguration.isActive.fields.edit.byxpath             | True       | False      |
      | ejar.generic.save.action.byxpath                                           | False      | False      |
      | ejar.externalloyaltyconfiguration.cancel1.button.byxpath                   | True       | False      |
      | ejar.externalloyaltyconfiguration.createnewlevel.button.byxpath            | True       | False      |
    And click on link: ejar.externalloyaltyconfiguration.createnewlevel.button.byxpath
    And verify ejar fields label with soft assertion in form: createoreditexternalloyaltyconfigurationlevelmodal text: ejar.externalloyaltyconfigurationdialog.label.text
    And verify form page labels and text:
      | Text                                                         | TagType |
      | Create New Level,اضافة مستوى                                 |  span   |
      | Name [en],الاسـم [en]                                         |  label  |
      | Name [ar],الاسـم [ar]                                         |  label  |
      | Exchange factor,معامل التحول                                 |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                                 | isEditable | isRequired |
      | ejar.externalloyaltyconfiguration.Name_en2.fields.byxpath                  | True       | True       |
      | ejar.externalloyaltyconfiguration.Name_ar2.fields.byxpath                  | True       | True       |
      | ejar.externalloyaltyconfiguration.cancellevel.button.byxpath               | True       | False      |
      | ejar.externalloyaltyconfiguration.saveleval.button.byxpath                 | False      | False      |
    And click on element if exist: login.internal.temp.byxpath with wait: 5
#    And set random text in variable and into element: ejar.externalloyaltyconfiguration.Name_en.fields.byxpath with size: 10 and initial string: UI Automation External Loyalty  and store value in variable: loayltyRandomName
#    And set value into field: ejar.externalloyaltyconfiguration.Name_ar.fields.byxpath from stored variable: loayltyRandomName
#    And user select value in drop down field: ejar.externalloyaltyconfiguration.integratedLoyalties.fields.byxpath by option text: Fursan,فرسان
#    And user click on action with id: ejar.externalloyaltyconfiguration.createnewlevel.button.byxpath
#    And user set in field: ejar.externalloyaltyconfiguration.Name_en2.fields.byxpath value: UI Automation First Level
#    And user set in field: ejar.externalloyaltyconfiguration.Name_ar2.fields.byxpath value: UI Automation First Level
#    And user set in field: ejar.externalloyaltyconfiguration.redemptionFactor.fields.byxpath value: 0.5
#    And user click on action with id: ejar.externalloyaltyconfiguration.saveleval.button.byxpath
#    And user click on action with id: ejar.externalloyaltyconfiguration.save.button.byxpath
#    And click on action if exist: ejar.generic.yes.action.byxpath
#    And click on action if exist: ejar.generic.save.action.byxpath
    And click on action if exist: ejar.externalloyaltyconfiguration.cancellevel.button.byxpath
#    And verify element present: ejar.externalloyaltyconfiguration.createnew.button.byxpath

    #if the loyalty levels are full comment add loyalty level and uncomment edit and ejar.loyaltyprograms.addSave.button.byxpath is editable
  @TestType-Smoke
  Scenario: Open And Verify Loyalties Management Form Then Save It
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/loyalty
    And wait for element present: ejar.loyaltyprograms.Name_en.fields.edit.byxpath for period in seconds: 100
    And verify ejar fields label with soft assertion in form: app-create-or-edit-loyality text: ejar.loyaltyprograms.label.text
    And verify table header: ejar.reqularevaluation.tableheaders.label.byxpath with text: ejar.reqularevaluation.tableheaders.label.text
    And verify form page labels and text:
      | Text                                                                                     | TagType |
      | Loyalty,العضويات                                                                         |  h1     |
      | Loyalties Management,ادارة العضويات                                                      |  span   |
      | Name [en],الاسـم [en]                                                                     |  label  |
      | Name [ar],الاسـم [ar]                                                                     |  label  |
      | Tier Points Factor,معامل نقاط العضوية                                                    |  label  |
      | Redemption Points Factor,معامل نقاط المكافئة                                             |  label  |
      | Factor of Convert Redemption Points to Amount,معامل تحويل نقاط المكافأة إلى قيمة مكافأة  |  label  |
      | Redemption Points Validity in Months,صلاحية نقاط المكافأه بالاشهر                          |  label  |
      | Contract Items,بنود العقد                                                                |  label  |
      | Active,فعال                                                                              |  label  |
      | Reqular evaluation on,يتم اعادة التقييم في                                               |  label  |
      | Evaluation Start Date,تاريخ بداية التقييم                                                |  label  |
      | Level,المستوى                                                                            |  span   |
      | Min Contracts,الحد الأدنى لعدد الرحلات                                                     |  span   |
      | Min Points,الحد الأدنى لعدد النقاط                                                        |  span   |
      | Tier Points Factor,معامل نقاط العضوية                                                    |  span   |
      | Redemption Points Factor,معامل نقاط المكافئة                                             |  span   |
      | Logo,الرمز                                                                               |  span   |
      | Actions,إجراءات                                                                          |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.loyaltyprograms.Name_en.fields.edit.byxpath                 | True       | True       |
      | ejar.loyaltyprograms.Name_ar.fields.edit.byxpath                 | True       | True       |
      | ejar.loyaltyprograms.tierPointsFactor.fields.edit.byxpath        | True       | True       |
      | ejar.loyaltyprograms.redemptionPointsFactor.fields.edit.byxpath  | True       | True       |
      | ejar.loyaltyprograms.factorRedemptionToAmount.fields.edit.byxpath| True       | True       |
      | ejar.loyaltyprograms.redemptionPointsValidity.fields.edit.byxpath| True       | True       |
      | ejar.loyaltyprograms.contractItems.fields.edit.byxpath           | True       | True       |
      | ejar.loyaltyprograms.partnerIcon.fields.edit.byxpath             | True       | False      |
      | ejar.loyaltyprograms.isActive.fields.edit.byxpath                | True       | False      |
      | ejar.loyaltyprograms.evaluationDay.fields.edit.byxpath           | True       | True       |
      | ejar.loyaltyprograms.evaluationMonth.fields.edit.byxpath         | True       | True       |
      | ejar.loyaltyprograms.evaluationYear.fields.edit.byxpath          | True       | True       |
      | ejar.loyaltyprograms.evaluationStartDate.fields.edit.byxpath     | True       | True       |
    And click on element: ejar.loyaltyprograms.addLoyaltyLevel.button.byxpath
#    And click on element: ejar.loyaltyprograms.editLoyalty.button.byxpath
    And verify form page labels and text:
      | Text                                                                                     | TagType |
      | Name [en],الاسـم [en]                                                                     |  label  |
      | Name [ar],الاسـم [ar]                                                                     |  label  |
      | Minimum Tier Points,الحد الادنى لنقاط العضوية                                             |  label  |
      | Min Contracts,الحد الأدنى لعدد الرحلات                                                     |  label  |
      | Tier Points Factor,معامل نقاط العضوية                                                    |  label  |
      | Redemption Points Factor,معامل نقاط المكافئة                                             |  label  |
      | Attach,ارفاق                                                                             |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                              | isEditable | isRequired |
      | ejar.loyaltyprograms.addLevelNameEN.fields.edit.byxpath                 | True       | True       |
      | ejar.loyaltyprograms.addLevelNameAR.fields.edit.byxpath                 | True       | True       |
      | ejar.loyaltyprograms.addLevelMinPoints.fields.edit.byxpath              | True       | True       |
      | ejar.loyaltyprograms.addLevelMinContracts.fields.edit.byxpath           | True       | True       |
      | ejar.loyaltyprograms.addLevelTierPointsFactor.fields.edit.byxpath       | True       | True       |
      | ejar.loyaltyprograms.addLevelRedemptionPointsFactor.fields.edit.byxpath | True       | True       |
      | ejar.loyaltyprograms.addLevelAttach.fields.edit.byxpath                 | True       | False      |
      | ejar.loyaltyprograms.addCancel.button.byxpath                           | True       | False      |
    And click on element: ejar.loyaltyprograms.addCancel.button.byxpath
    And click on element if exist: ejar.generic.popupok.action.byxpath with wait: 3
#    And user click on action with id: ejar.generic.save.action.byxpath

#  needs a customer with loyalty
    @TestType-Smoke
  Scenario: Open And Verify Shared Loyalty Requests Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/shared-loyalty-requests
    And user click on action with id: ejar.sharedloyaltyrequests.settings.button.byxpath
    And verify ejar fields label with soft assertion in form: form[@name='requestForm'] text: ejar.sharedloyaltyrequests.alllabels.label.text
    And verify form page labels and text:
      | Text                                            | TagType |
      | Shared Loyalty Requests,طلبات العضويات المشتركة |  span   |
      | Master Customer,العميل الرئيسي                  |  label  |
      | Dependent Customer,العميل المتنفع               |  label  |
      | Dependent Identity No,رقم العميل المنتفع        |  label  |
      | Dependent Name,اسم المنتفع                      |  label  |
      | Dependent Mobile No,رقم جوال المنتفع            |  label  |
      | Dependent Email,البريد الالكتروني للعميل         |  label  |
      | Relationship Type,نوع العلاقة                    |  label  |
      | Attachment,المرفق                               |  label  |
      | Comments,الملاحظات                               |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.sharedloyaltyrequests.mastercustomer.field.edit.byxpath       | True       | True       |
      | ejar.sharedloyaltyrequests.dependentcustomer.field.edit.byxpath    | True       | True       |
      | ejar.sharedloyaltyrequests.dependentidentity.field.edit.byxpath    | True       | True       |
      | ejar.sharedloyaltyrequests.dependentname.field.edit.byxpath        | True       | True       |
      | ejar.sharedloyaltyrequests.phonenumber.field.edit.byxpath          | True       | True       |
      | ejar.sharedloyaltyrequests.dependentemail.field.edit.byxpath       | True       | True       |
      | ejar.sharedloyaltyrequests.relationtype.field.edit.byxpath         | True       | True       |
      | ejar.sharedloyaltyrequests.comments.field.edit.byxpath             | True       | False      |
      | ejar.sharedloyaltyrequests.kendoUpload.field.byxpath               | True       | False      |
      | ejar.sharedloyaltyrequests.cancel.button.byxpath                   | True       | False      |
      | ejar.sharedloyaltyrequests.save.button.byxpath                     | False      | False      |
    And click on element: ejar.sharedloyaltyrequests.mastercustomer.field.byxpath
    And search for value in search field: ejar.sharedloyaltyrequests.mastercustomer.field.byxpath with name: Eyad Automation,Eyad Automation then select record at index: 0
    And user set in field: ejar.sharedloyaltyrequests.dependentidentity.field.byxpath value: 1
    And user select value in drop down field: ejar.sharedloyaltyrequests.relationtype.field.byxpath by index: 1
    And upload file to element: ejar.sharedloyaltyrequests.kendoUpload.field.byxpath with path: \uploadFiles\logo_high.png
    And user click on action with id: ejar.sharedloyaltyrequests.save.button.byxpath

    @TestType-Smoke
  Scenario: Create And Verify Inquiry And Complaint Category Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/complaint-categories
    And user click on action with id: ejar.InquiriesAndComplains.createnew.button.byxpath
    And user click on action with id: ejar.InquiriesAndComplains.informativeMessage.field.byxpath
    And set random text into element: ejar.InquiriesAndComplains.messageEnglish.field.byxpath with size: 10 and initial string: UI Automation English Message
    And set random text into element: ejar.InquiriesAndComplains.messageArabic.field.byxpath with size: 10 and initial string: UI Automation Arabic Message
    And verify ejar fields label with soft assertion in form: create-or-edit-complaint-category text: ejar.InquiriesAndComplains.labels.text
    And verify form page labels and text:
      | Text                                                                     | TagType |
      | Create New Inquiry And Complaint Category,إنشاء فئة استفسار وشكاوي جديدة |  span   |
      | Name [en],الاسـم [en]                                                     |  label  |
      | Name [ar],الاسـم [ar]                                                     |  label  |
      | Parent,الأب                                                               |  label  |
      | Type,نوع                                                                 |  label  |
      | Branch,الفرع                                                             |  label  |
      | City,المدينة                                                             |  label  |
      | Grouped Properties,الخصائص المجمعة                                       |  legend |
      | Booking Number,رقم الحجز                                                 |  label  |
      | Contract Number,رقم العقد                                                |  label  |
      | New Customer,مستخدم جديد                                                 |  span   |
      | Informative Message,رسالة للمستخدم                                       |  span   |
      | Message [en],الرسالة [en]                                                |  label  |
      | Message [ar],الرسالة [ar]                                                |  label  |
      | Active,فعال                                                              |  label  |
      And verify form page fields, field editable and required statuses:
        | fieldXpath                                                         | isEditable | isRequired |
        | ejar.InquiriesAndComplains.nameEnglish.field.byxpath               | True       | True       |
        | ejar.InquiriesAndComplains.nameArabic.field.byxpath                | True       | True       |
        | ejar.InquiriesAndComplains.parent.field.byxpath                    | True       | False      |
        | ejar.InquiriesAndComplains.type.field.byxpath                      | True       | True       |
        | ejar.InquiriesAndComplains.Branch.field.byxpath                    | True       | True       |
        | ejar.InquiriesAndComplains.City.field.byxpath                      | True       | True       |
        | ejar.InquiriesAndComplains.BookingNumber.field.byxpath             | True       | True       |
        | ejar.InquiriesAndComplains.ContractNumber.field.byxpath            | True       | True       |
        | ejar.InquiriesAndComplains.NewCustomer.field.byxpath               | True       | False      |
        | ejar.InquiriesAndComplains.informativeMessage.field.byxpath        | True       | False      |
        | ejar.InquiriesAndComplains.messageEnglish.field.byxpath            | True       | True       |
        | ejar.InquiriesAndComplains.messageArabic.field.byxpath             | True       | True       |
        | ejar.InquiriesAndComplains.isAcive.field.byxpath                   | True       | False      |
        | ejar.InquiriesAndComplains.cancel.button.byxpath                   | True       | False      |
        | ejar.InquiriesAndComplains.save.button.byxpath                     | False      | False      |
    And set random text in variable and into element: ejar.InquiriesAndComplains.nameEnglish.field.byxpath with size: 10 and initial string: UI Inquiry And Complaint Category and store value in variable: complaintCategoryRandomName
    And set value into field: ejar.InquiriesAndComplains.nameArabic.field.byxpath from stored variable: complaintCategoryRandomName
    And user select value in drop down field: ejar.InquiriesAndComplains.type.field.byxpath by option text: Complaint,شكوى
    And user select value in drop down field: ejar.InquiriesAndComplains.BookingNumber.field.byxpath by option text: Optional,إختياري
    And user select value in drop down field: ejar.InquiriesAndComplains.ContractNumber.field.byxpath by option text: Not Available ,غير متاح
    And user select value in drop down field: ejar.InquiriesAndComplains.Branch.field.byxpath by option text: Optional,إختياري
    And user select value in drop down field: ejar.InquiriesAndComplains.City.field.byxpath by option text: Optional,إختياري
    And user click on action with id: ejar.InquiriesAndComplains.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And verify element present: ejar.InquiriesAndComplains.createnew.button.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: complaintCategoryRandomName
    And click on element: ejar.InquiriesAndComplains.edit.button.byxpath

    And click on element: ejar.InquiriesAndComplains.isAcive.field.byxpath
    And click on element: ejar.InquiriesAndComplains.save.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath

  @TestType-Smoke
  Scenario: Create and Verify customer merge saving form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/customers
    And click on link: ejar.customermerge.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-merge-customers text: ejar.customerMerge.labels.text
    And verify form page labels and text:
      | Text                                                                  | TagType |
      | Merge Customers,دمج العملاء                                            |  h1     |
      | Merge Customers,دمج العملاء                                            |  span   |
      | Primary Customer,العميل الرئيسي                                       |  li     |
      | Secondary Customer,العميل الثانوي                                     |  li     |
      | Identity number,رقم الإثبات                                            |  label  |
      | Phone number,رقم الجوال                                               |  label  |
      | Customer Name,اسم العميل                                              |  label  |
      | Identity number,رقم الإثبات                                            |  label  |
      | Phone number,رقم الجوال                                               |  label  |
      | Customer Name,اسم العميل                                              |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      | ejar.customermerge.identitynumber1.fields.edit.byxpath           | True       | False      |
      | ejar.customermerge.identitynumber2.fields.edit.byxpath           | True       | False      |
      | ejar.customermerge.phoneNumberctrl1.fields.edit.byxpath          | True       | False      |
      | ejar.customermerge.phoneNumberctrl2.fields.edit.byxpath          | True       | False      |
      | ejar.customermerge.name1.fields.edit.byxpath                     | True       | False      |
      | ejar.customermerge.name2.fields.edit.byxpath                     | True       | False      |
      | ejar.customermerge.kendo-combobox1.fields.edit.byxpath           | True       | False      |
      | ejar.customermerge.kendo-combobox2.fields.edit.byxpath           | True       | False      |
      | ejar.customermerge.newCustomer1.fields.byxpath                   | True       | False      |
      | ejar.customermerge.newCustomer2.fields.byxpath                   | True       | False      |
      | ejar.customermerge.edit1.fields.byxpath                          | False      | False      |
      | ejar.customermerge.edit2.fields.byxpath                          | False      | False      |
      | ejar.customermerge.clear1.fields.byxpath                         | True       | False      |
      | ejar.customermerge.clear2.fields.byxpath                         | True       | False      |
      | ejar.customermerge.search1.fields.byxpath                        | False      | False      |
      | ejar.customermerge.search2.fields.byxpath                        | False      | False      |
      | ejar.customermerge.save.button.byxpath                           | False      | False      |
      | ejar.customermerge.cancel.button.byxpath                         | True       | False      |
    And search for customer in customer search field: ejar.customermerge.name2.fields.edit.byxpath with name: Eyad Automation then select record at random index
    And search for customer in customer search field: ejar.customermerge.name1.fields.edit.byxpath with name: Eyad Automation then select record at random index
    And click on element: ejar.customermerge.save.button.byxpath
    And click on action if exist with wait: ejar.generic.yes.action.byxpath waiting number of seconds: 1
    And click on action if exist with wait: ejar.generic.yes.action.byxpath waiting number of seconds: 1

#error details were not sent
  @TestType-Smoke
  Scenario: Inquiry Requests creation and verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/crm/administration/complaint-categories
    And create new inquiry if it doesn't exist with the name: Branch,الفرع
    And open page using url: /app/crm/inquiries
    And wait for element present: ejar.feedback.settings.button.byxpath for period in seconds: 120
    And remove attribute for element: ejar.feedback.settings.button.byxpath attribute: disabled
    And click on link: ejar.feedback.settings.button.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template[descendant::customer] text: ejar.feedback.alllabels.label.text
    And verify form page labels and text:
      | Text                                                          | TagType |
      | Inquiry,استفسار أو شكوى                                       |  h1     |
      | Fill-up inquiry information,إدخال بيانات الاستفسار أو الشكوى   |  span   |
      | Inquiry Information,معلومات الاستفسار أو الشكوى                |  li     |
      | Identity number,رقم الإثبات                                    |  label  |
      | Phone number,رقم الجوال                                       |  label  |
      | Customer Name,اسم العميل                                      |  label  |
      | Customer Email,البريد الالكتروني للعميل                        |  label  |
      | Membership number,رقم العضوية                                 |  label  |
      | Type,النوع                                                    |  label  |
      | Category,تصنيف رئيسي                                          |  label  |
      | Sub Category,تصنيف فرعي                                       |  label  |
      | Sub Sub Category,تصنيف فرعي فرعي                              |  label  |
      | Media,وسائل التواصل                                           |  label  |
      | Comment,التعليق                                               |  label  |
      | Lite Customer Information,بيانات العميل المختصر               |  span   |
      | Email:,البريد الإلكتروني:                                      |  label  |
      | Phone:,الهاتف:                                                |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.feedback.identitynumber.field.edit.byxpath                    | True       | False      |
      | ejar.feedback.phonenumber.field.edit.byxpath                       | True       | False      |
      | ejar.feedback.customer.field.edit.byxpath                          | True       | False      |
      | ejar.feedback.customerEmail.field.edit.byxpath                     | True       | False      |
      | ejar.feedback.membershipNumber.field.edit.byxpath                  | True       | False      |
      | ejar.feedback.feedbacktype.field.read.byxpath                      | False      | False      |
      | ejar.feedback.category.field.read.byxpath                          | False      | False      |
      | ejar.feedback.subcategory.field.read.byxpath                       | False      | False      |
      | ejar.feedback.subsubcategory.field.read.byxpath                    | False      | False      |
      | ejar.feedback.media.field.read.byxpath                             | False      | False      |
      | ejar.feedback.comment.field.edit.byxpath                           | True       | True       |
      | ejar.feedback.customerimg.header.byxpath                           | False      | False      |
      | ejar.feedback.save.button.byxpath                                  | False      | False      |
      | ejar.feedback.saveandaddnew.button.byxpath                         | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And search for customer in customer search field: ejar.contract.customername.field.byxpath with name: Eyad Automation then select record at random index
    And store ejar element value: ejar.feedback.phoneNo.label.byxpath and value name: mobileNo and keep number only: false
    And user select option by text in ejar kendo option field without typing: ejar.feedback.feedbacktype.field.button.byxpath option: Suggestion,اقتراح
    And user select option by text in ejar kendo option field without typing: ejar.feedback.category.field.read.byxpath option: Branch,الفرع
    And set random text into element: ejar.feedback.comment.field.edit.byxpath with size: 5 and initial string: UI Automation Comment
    And click on element: ejar.feedback.save.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And click on element if exist: ejar.feedback.cancelModal.button.byxpath with wait: 5
    And set value into field: ejar.feedback.customerPhoneNo.input.byxpath from stored variable: mobileNo
    And click on element: ejar.generic.search.action.byxpath
    And click on element: ejar.feedback.firstRow.a.byxpath
    And verify form page labels and text:
      | Text                                                          | TagType |
      | Inquiry,استفسار أو شكوى                                       |  h1     |
      | Inquiry Information,معلومات الاستفسار أو الشكوى                |  li     |
      | Type,النوع                                                    |  label  |
      | Category,التصنيف                                              |  label  |
      | Sub Category,التصنيف الجزئي                                   |  label  |
      | Sub Sub Category,التصنيف الجزئي الجزئي                        |  label  |
      | Media,وسائل التواصل                                           |  label  |
      | Comment,التعليق                                               |  label  |
      | Loyalty:,العضويات:                                            |  label  |
      | Organization:,الشركة:                                         |  label  |
      | Email:,البريد الإلكتروني:                                      |  label  |
      | Phone:,الهاتف:                                                |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.feedback.type.label.read.byxpath                              | False      | False      |
      | ejar.feedback.category.label.read.byxpath                          | False      | False      |
      | ejar.feedback.comment.label.read.byxpath                           | False      | False      |
      | ejar.feedback.edit.button.byxpath                                  | True       | False      |
      | ejar.feedback.cancel.button.byxpath                                | True       | False      |
    And click on element: ejar.feedback.edit.button.byxpath
    And wait for element not present: ejar.feedback.load.div.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.feedback.state.button.byxpath option: Close,مغلق
    And click on element: ejar.feedback.save.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.feedback.settings.button.byxpath for period in seconds: 120

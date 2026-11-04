Feature: Branches Verification

  @TestType-Smoke
  Scenario: Create And Verify Branch Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    And click on link: ejar.branches.createnew.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.branches.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                | TagType |
      | Branches,الفروع                     |  h1     |
      | Create New Branch,اضافة فرع         |  span   |
      | Basic Information,البيانات الاساسيه  |  li     |
      | Name [en],الاسـم [en]                |  label  |
      | Name [ar],الاسـم [ar]                |  label  |
      | Name [de],الاسـم [de]                |  label  |
      | Name [fr],الاسـم [fr]                |  label  |
      | Country,المدينه                     |  label  |
      | License Number,رقم ترخيص الفرع      |  label  |
      | Full Address,العنوان                |  label  |
      | Longitude,خط الطول                  |  label  |
      | Latitude,خط العرض                   |  label  |
      | Code,رمز                            |  label  |
      | Primary Phone,الهاتف الأساسي         |  label  |
      | Secondary Phone,الهاتف الثاني       |  label  |
      | Active,فعال                         |  span   |
      | Airport,مطار                        |  span   |
      | Execute at Location,تنفيذ في الموقع |  span   |
      | View Description,عرض الوصف          |  span   |
      | Description [en],الوصف [en]         |  label  |
      | Description [ar],الوصف [ar]         |  label  |
      | Description [de],الوصف [de]         |  label  |
      | Description [fr],الوصف [fr]         |  label  |
      | Map,الخريطة                         |  li     |
      | Border,الحدود                       |  label  |
      | Locations,المواقع                   |  li     |
      | Actions,إجراءات                     |  span   |
      | Name,الاسم                           |  span   |
      | Longitude,خط الطول                  |  span   |
      | Latitude,خط العرض                   |  span   |
      | Status,الحالة                       |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.branches.name_en.field.edit.byxpath                           | True       | True       |
      | ejar.branches.name_ar.field.edit.byxpath                           | True       | True       |
      | ejar.branches.countries.field.edit.byxpath                         | True       | True       |
      | ejar.branches.cities.field.edit.byxpath                            | True       | True       |
      | ejar.branches.licenseNumber.field.edit.byxpath                     | True       | True       |
      | ejar.branches.address.field.edit.byxpath                           | True       | False      |
      | ejar.branches.longitude.field.edit.byxpath                         | True       | True       |
      | ejar.branches.latitude.field.edit.byxpath                          | True       | True       |
      | ejar.branches.code.field.edit.byxpath                              | True       | True       |
      | ejar.branches.phonenumber1.field.edit.byxpath                      | True       | False      |
      | ejar.branches.phonenumber2.field.edit.byxpath                      | True       | False      |
      | ejar.branches.isactive.field.byxpath                               | True       | False      |
      | ejar.branches.isairport.field.byxpath                              | True       | False      |
      | ejar.branches.executeAtLocation.field.byxpath                      | True       | False      |
      | ejar.branches.viewDescription.field.byxpath                        | True       | False      |
      | ejar.branches.descriptionEN.field.edit.byxpath                     | True       | False      |
      | ejar.branches.descriptionAR.field.edit.byxpath                     | True       | False      |
      | ejar.branches.addlocation.button.byxpath                           | False      | False      |
      | ejar.branches.create.button.byxpath                                | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And set random text in variable and into element: ejar.branches.name_en.field.byxpath with size: 10 and initial string: UI Automation Branch and store value in variable: branchVariable
    And set value into field: ejar.branches.name_ar.field.byxpath from stored variable: branchVariable
    And user select option by text in ejar kendo option field without typing: ejar.branches.countries.field.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And user select option by text in ejar kendo option field without typing: ejar.branches.cities.field.byxpath option: Automation Riyadh,Automation Riyadh
    And click on element: ejar.branches.addlocation.button.byxpath
    And verify ejar fields label with soft assertion in form: createoreditlocationmodal text: ejar.branches.fieldset.label.text
    And verify form page labels and text:
      | Text                                | TagType |
      | Create New Location,اضافة موقع      |  span   |
      | Name [en],الاسـم [en]                |  label  |
      | Name [ar],الاسـم [ar]                |  label  |
      | Mobile,الموبايل                     |  label  |
      | Phone,الهاتف                        |  label  |
      | Longitude,خط الطول                  |  label  |
      | Latitude,خط العرض                   |  label  |
      | Full Address,العنوان                |  label  |
      | Active,فعال                         |  label  |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.branches.locNameEN.input.byxpath                              | True       | True       |
      | ejar.branches.locNameAR.input.byxpath                              | True       | True       |
      | ejar.branches.locMobile.input.byxpath                              | True       | False      |
      | ejar.branches.locPhone.input.byxpath                               | True       | False      |
      | ejar.branches.locLongitude.input.byxpath                           | True       | True       |
      | ejar.branches.locLatitude.input.byxpath                            | True       | True       |
      | ejar.branches.locAddress.input.byxpath                             | True       | False      |
      | ejar.branches.locIsActive.input.byxpath                            | True       | False      |
      | ejar.branches.locSave.input.byxpath                                | False      | False      |
      | ejar.branches.locCancel.input.byxpath                              | True       | False      |
    And click on element: ejar.branches.locCancel.input.byxpath
    And set random number into element: ejar.branches.licenseNumber.field.byxpath of size: 10
    And user set in field: ejar.branches.longitude.field.byxpath value: 46.07824318091255
    And user set in field: ejar.branches.latitude.field.byxpath value: 24.77736761599228
    And set random number into element: ejar.branches.code.field.byxpath of size: 10
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: branchVariable
    And user click on view action: Edit,تعديل  related to record with text stored in variable: branchVariable then select record at index: 1
    And user click on action with id: ejar.branches.isactive.field.byxpath
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.branches.createnew.byxpath for period in seconds: 120


  @TestType-Smoke
  Scenario: Create And Verify New Parking Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    Then click on link: ejar.createnewparking.createnew.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.createnewparking.labels.text
    And verify form page labels and text:
      | Text                                | TagType |
      | Parking,المستودع                    |  h1     |
      | Create New Parking,إضافة مستودع     |  span   |
      | Basic Information,البيانات الاساسيه  |  li     |
      | Name [en],الاسـم [en]                |  label  |
      | Name [ar],الاسـم [ar]                |  label  |
      | Name [de],الاسـم [de]                |  label  |
      | Name [fr],الاسـم [fr]                |  label  |
      | Country,الدولة                      |  label  |
      | City ,المدينه                       |  label  |
      | License Number,رقم ترخيص الفرع      |  label  |
      | Full Address,العنوان                |  label  |
      | Longitude,خط الطول                  |  label  |
      | Latitude,خط العرض                   |  label  |
      | Code,رمز                            |  label  |
      | Primary Phone,الهاتف الأساسي         |  label  |
      | Secondary Phone,الهاتف الثاني       |  label  |
      | Active,فعال                         |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewparking.name_en.field.edit.byxpath                   | True       | True       |
      | ejar.createnewparking.name_ar.field.edit.byxpath                   | True       | True       |
      | ejar.createnewparking.countries.field.edit.byxpath                 | True       | True       |
      | ejar.createnewparking.cities.field.edit.byxpath                    | True       | True       |
      | ejar.createnewparking.license.field.edit.byxpath                   | True       | True       |
      | ejar.createnewparking.address.field.edit.byxpath                   | True       | False      |
      | ejar.createnewparking.longitude.field.edit.byxpath                 | True       | True       |
      | ejar.createnewparking.latitude.field.edit.byxpath                  | True       | True       |
      | ejar.createnewparking.code.field.edit.byxpath                      | True       | True       |
      | ejar.createnewparking.phonenumber1.field.byxpath                   | True       | False      |
      | ejar.createnewparking.phonenumber2.field.byxpath                   | True       | False      |
      | ejar.createnewparking.isActive.field.input.byxpath                 | True       | False      |
      | ejar.createnewparking.create.button.byxpath                        | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And set random text in variable and into element: ejar.createnewparking.name_en.field.edit.byxpath with size: 5 and initial string: UI Automation Parking  and store value in variable: parkingName
    And user select option by text in ejar kendo option field without typing: ejar.createnewparking.countries.field.button.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And set value into field: ejar.createnewparking.name_ar.field.edit.byxpath from stored variable: parkingName
    And user select option by text in ejar kendo option field without typing: ejar.createnewparking.cities.field.button.byxpath option: Automation Riyadh,Automation Riyadh
    And set random number into element: ejar.createnewparking.license.field.edit.byxpath of size: 10
    And set value into element : ejar.createnewparking.longitude.field.edit.byxpath value: 48.58892
    And set value into element : ejar.createnewparking.latitude.field.edit.byxpath value: 22.017285
    And set random number into element: ejar.createnewparking.code.field.edit.byxpath of size: 5
    And click on element: ejar.createnewparking.create.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Parking,مستودع
    And wait for element present: ejar.createnewparking.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: parkingName
    And click on element: ejar.createnewparking.view.i.byxpath
    And verify form page labels and text:
      | Text                                | TagType |
      | Parking,المستودع                    |  h1     |
      | Edit Parking,تعديل مستودع           |  span   |
      | Basic Information,البيانات الاساسيه  |  li     |
      | Name [en],الاسـم [en]                |  label  |
      | Name [ar],الاسـم [ar]                |  label  |
      | Country,الدولة                      |  label  |
      | City ,المدينه                       |  label  |
      | License Number,رقم ترخيص الفرع      |  label  |
      | Full Address,العنوان                |  label  |
      | Longitude,خط الطول                  |  label  |
      | Latitude,خط العرض                   |  label  |
      | Code,رمز                            |  label  |
      | Primary Phone,الهاتف الأساسي         |  label  |
      | Secondary Phone,الهاتف الثاني       |  label  |
      | Active,فعال                         |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewparking.name_en.field.edit.byxpath                   | False      | False      |
      | ejar.createnewparking.name_ar.field.edit.byxpath                   | False      | False      |
      | ejar.createnewparking.countries.field.read.byxpath                 | False      | False      |
      | ejar.createnewparking.cities.field.read.byxpath                    | False      | False      |
      | ejar.createnewparking.license.field.edit.byxpath                   | False      | False      |
      | ejar.createnewparking.address.field.edit.byxpath                   | False      | False      |
      | ejar.createnewparking.longitude.field.edit.byxpath                 | False      | False      |
      | ejar.createnewparking.latitude.field.edit.byxpath                  | False      | False      |
      | ejar.createnewparking.code.field.edit.byxpath                      | False      | False      |
      | ejar.createnewparking.phonenumber1.field.byxpath                   | False      | False      |
      | ejar.createnewparking.phonenumber2.field.byxpath                   | False      | False      |
      | ejar.createnewparking.isActive.field.input.byxpath                 | False      | False      |
      | ejar.generic.cancel.action.byxpath                                 | True       | False      |
    And click on element: ejar.generic.cancel.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Parking,مستودع
    And wait for element present: ejar.createnewparking.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: parkingName
    And click on element: ejar.createnewparking.firstRow.field.i.byxpath
    And click on element: ejar.createnewparking.isActive.field.input.byxpath
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.createnewparking.createnew.byxpath for period in seconds: 120


  @TestType-Smoke
  Scenario: Create And Verify WorkShop Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    Then click on link: ejar.createnewworkShop.createnew.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.createnewworkShop.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                  | TagType |
      | Workshop,مركز صيانة                   |  h1     |
      | Create New WorkShop,إضافة مركز صيانة  |  span   |
      | Basic Information,البيانات الاساسيه    |  li     |
      | Name [en],الاسـم [en]                  |  label  |
      | Name [ar],الاسـم [ar]                  |  label  |
      | Name [de],الاسـم [de]                  |  label  |
      | Name [fr],الاسـم [fr]                  |  label  |
      | Country,المدينه                       |  label  |
      | License Number,رقم ترخيص الفرع        |  label  |
      | Full Address,العنوان                  |  label  |
      | Longitude,خط الطول                    |  label  |
      | Latitude,خط العرض                     |  label  |
      | Code,رمز                              |  label  |
      | Primary Phone,الهاتف الأساسي           |  label  |
      | Secondary Phone,الهاتف الثاني         |  label  |
      | Active,فعال                           |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewworkShop.name_en.field.edit.byxpath                   | True       | True       |
      | ejar.createnewworkShop.name_ar.field.edit.byxpath                   | True       | True       |
      | ejar.createnewworkShop.countries.field.edit.byxpath                 | True       | True       |
      | ejar.createnewworkShop.cities.field.edit.byxpath                    | True       | True       |
      | ejar.createnewworkShop.license.field.edit.byxpath                   | True       | True       |
      | ejar.createnewworkShop.address.field.edit.byxpath                   | True       | False      |
      | ejar.createnewworkShop.longitude.field.edit.byxpath                 | True       | True       |
      | ejar.createnewworkShop.latitude.field.edit.byxpath                  | True       | True       |
      | ejar.createnewworkShop.code.field.edit.byxpath                      | True       | True       |
      | ejar.createnewworkShop.phonenumber1.field.byxpath                   | True       | False      |
      | ejar.createnewworkShop.phonenumber2.field.byxpath                   | True       | False      |
      | ejar.createnewworkShop.isActive.field.input.byxpath                 | True       | False      |
      | ejar.generic.cancel.action.byxpath                                  | True       | False      |
      | ejar.generic.save.action.byxpath                                    | False      | False      |
    And set random text in variable and into element: ejar.createnewworkShop.name_en.field.edit.byxpath with size: 5 and initial string: UI Automation Parking  and store value in variable: workshopName
    And user select option by text in ejar kendo option field without typing: ejar.createnewworkShop.countries.field.button.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And set value into field: ejar.createnewworkShop.name_ar.field.edit.byxpath from stored variable: workshopName
    And user select option by text in ejar kendo option field without typing: ejar.createnewworkShop.cities.field.button.byxpath option: Automation Riyadh,Automation Riyadh
    And set random number into element: ejar.createnewworkShop.license.field.edit.byxpath of size: 10
    And set value into element : ejar.createnewworkShop.longitude.field.edit.byxpath value: 48.58899
    And set value into element : ejar.createnewworkShop.latitude.field.edit.byxpath value: 22.017288
    And set random number into element: ejar.createnewworkShop.code.field.edit.byxpath of size: 5
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Workshop,مركز صيانة
    And wait for element present: ejar.createnewworkShop.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: workshopName
    And click on element: ejar.createnewworkShop.view.i.byxpath
    And verify form page labels and text:
      | Text                                  | TagType |
      | Workshop,مركز صيانة                   |  h1     |
      | Edit Workshop,تعديل مركز صيانة        |  span   |
      | Basic Information,البيانات الاساسيه    |  li     |
      | Name [en],الاسـم [en]                  |  label  |
      | Name [ar],الاسـم [ar]                  |  label  |
      | Country,المدينه                       |  label  |
      | License Number,رقم ترخيص الفرع        |  label  |
      | Full Address,العنوان                  |  label  |
      | Longitude,خط الطول                    |  label  |
      | Latitude,خط العرض                     |  label  |
      | Code,رمز                              |  label  |
      | Primary Phone,الهاتف الأساسي           |  label  |
      | Secondary Phone,الهاتف الثاني         |  label  |
      | Active,فعال                           |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                         | isEditable | isRequired |
      | ejar.createnewworkShop.name_en.field.edit.byxpath                   | False      | False      |
      | ejar.createnewworkShop.name_ar.field.edit.byxpath                   | False      | False      |
      | ejar.createnewworkShop.countries.field.read.byxpath                 | False      | False      |
      | ejar.createnewworkShop.cities.field.read.byxpath                    | False      | False      |
      | ejar.createnewworkShop.license.field.edit.byxpath                   | False      | False      |
      | ejar.createnewworkShop.address.field.edit.byxpath                   | False      | False      |
      | ejar.createnewworkShop.longitude.field.edit.byxpath                 | False      | False      |
      | ejar.createnewworkShop.latitude.field.edit.byxpath                  | False      | False      |
      | ejar.createnewworkShop.code.field.edit.byxpath                      | False      | False      |
      | ejar.createnewworkShop.phonenumber1.field.byxpath                   | False      | False      |
      | ejar.createnewworkShop.phonenumber2.field.byxpath                   | False      | False      |
      | ejar.createnewworkShop.isActive.field.input.byxpath                 | False      | False      |
      | ejar.generic.cancel.action.byxpath                                  | True       | False      |
    And click on element: ejar.generic.cancel.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Workshop,مركز صيانة
    And wait for element present: ejar.createnewworkShop.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: workshopName
    And click on element: ejar.createnewworkShop.firstRow.field.i.byxpath
    And click on element: ejar.createnewworkShop.isActive.field.input.byxpath
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.createnewworkShop.createnew.byxpath for period in seconds: 120


  @TestType-Smoke
  Scenario: Create And Verify Sell Center Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    Then click on link: ejar.createnewsellcenter.createnew.byxpath
    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.createnewsellcenter.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                   | TagType |
      | Sell Center,مركز بيع                   |  h1     |
      | Create New Sell Center,إضافة مركز بيع  |  span   |
      | Basic Information,البيانات الاساسيه     |  li     |
      | Name [en],الاسـم [en]                   |  label  |
      | Name [ar],الاسـم [ar]                   |  label  |
      | Name [de],الاسـم [de]                   |  label  |
      | Name [fr],الاسـم [fr]                   |  label  |
      | Country,المدينه                        |  label  |
      | License Number,رقم ترخيص الفرع         |  label  |
      | Full Address,العنوان                   |  label  |
      | Longitude,خط الطول                     |  label  |
      | Latitude,خط العرض                      |  label  |
      | Code,رمز                               |  label  |
      | Primary Phone,الهاتف الأساسي            |  label  |
      | Secondary Phone,الهاتف الثاني          |  label  |
      | Active,فعال                            |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.createnewsellcenter.name_en.field.edit.byxpath                   | True       | True       |
      | ejar.createnewsellcenter.name_ar.field.edit.byxpath                   | True       | True       |
      | ejar.createnewsellcenter.countries.field.edit.byxpath                 | True       | True       |
      | ejar.createnewsellcenter.cities.field.edit.byxpath                    | True       | True       |
      | ejar.createnewsellcenter.license.field.edit.byxpath                   | True       | True       |
      | ejar.createnewsellcenter.address.field.edit.byxpath                   | True       | False      |
      | ejar.createnewsellcenter.longitude.field.edit.byxpath                 | True       | True       |
      | ejar.createnewsellcenter.latitude.field.edit.byxpath                  | True       | True       |
      | ejar.createnewsellcenter.code.field.edit.byxpath                      | True       | True       |
      | ejar.createnewsellcenter.phonenumber1.field.edit.byxpath              | True       | False      |
      | ejar.createnewsellcenter.phonenumber2.field.edit.byxpath              | True       | False      |
      | ejar.createnewsellcenter.isActive.field.input.byxpath                 | True       | False      |
      | ejar.generic.cancel.action.byxpath                                    | True       | False      |
      | ejar.generic.save.action.byxpath                                      | False      | False      |
    And set random text in variable and into element: ejar.createnewsellcenter.name_en.field.edit.byxpath with size: 5 and initial string: UI Automation Parking  and store value in variable: centerName
    And user select option by text in ejar kendo option field without typing: ejar.createnewsellcenter.countries.field.button.byxpath option: Saudi Arabia,المملكة العربية السعودية
    And set value into field: ejar.createnewsellcenter.name_ar.field.edit.byxpath from stored variable: centerName
    And user select option by text in ejar kendo option field without typing: ejar.createnewsellcenter.cities.field.button.byxpath option: Automation Riyadh,Automation Riyadh
    And set random number into element: ejar.createnewsellcenter.license.field.edit.byxpath of size: 10
    And set value into element : ejar.createnewsellcenter.longitude.field.edit.byxpath value: 48.58880
    And set value into element : ejar.createnewsellcenter.latitude.field.edit.byxpath value: 22.017279
    And set random number into element: ejar.createnewsellcenter.code.field.edit.byxpath of size: 5
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Sell Center,مركز بيع
    And wait for element present: ejar.createnewsellcenter.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: centerName
    And click on element: ejar.createnewsellcenter.view.i.byxpath
    And wait for element present: ejar.subtitle.view.span.byxpath for period in seconds: 150
    And verify form page labels and text:
      | Text                                   | TagType |
      | Sell Center,مركز بيع                   |  h1     |
      | Edit Sell Center,تعديل مركز بيع        |  span   |
      | Basic Information,البيانات الاساسيه     |  li     |
      | Name [en],الاسـم [en]                   |  label  |
      | Name [ar],الاسـم [ar]                   |  label  |
      | Country,المدينه                        |  label  |
      | License Number,رقم ترخيص الفرع         |  label  |
      | Full Address,العنوان                   |  label  |
      | Longitude,خط الطول                     |  label  |
      | Latitude,خط العرض                      |  label  |
      | Code,رمز                               |  label  |
      | Primary Phone,الهاتف الأساسي            |  label  |
      | Secondary Phone,الهاتف الثاني          |  label  |
      | Active,فعال                            |  span   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                            | isEditable | isRequired |
      | ejar.createnewsellcenter.name_en.field.edit.byxpath                   | False      | False      |
      | ejar.createnewsellcenter.name_ar.field.edit.byxpath                   | False      | False      |
      | ejar.createnewsellcenter.countries.field.read.byxpath                 | False      | False      |
      | ejar.createnewsellcenter.cities.field.read.byxpath                    | False      | False      |
      | ejar.createnewsellcenter.license.field.edit.byxpath                   | False      | False      |
      | ejar.createnewsellcenter.address.field.edit.byxpath                   | False      | False      |
      | ejar.createnewsellcenter.longitude.field.edit.byxpath                 | False      | False      |
      | ejar.createnewsellcenter.latitude.field.edit.byxpath                  | False      | False      |
      | ejar.createnewsellcenter.code.field.edit.byxpath                      | False      | False      |
      | ejar.createnewsellcenter.phonenumber1.field.edit.byxpath              | False      | False      |
      | ejar.createnewsellcenter.phonenumber2.field.edit.byxpath              | False      | False      |
      | ejar.createnewsellcenter.isActive.field.input.byxpath                 | False      | False      |
      | ejar.generic.cancel.action.byxpath                                    | True       | False      |
    And click on element: ejar.generic.cancel.action.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.branches.type.select.byxpath option: Sell Center,مركز بيع
    And wait for element present: ejar.createnewsellcenter.firstRow.field.i.byxpath for period in seconds: 50
    And filter view on column name: Name,الاسم and enter value stored in variable: centerName
    And click on element: ejar.createnewsellcenter.firstRow.field.i.byxpath
    And click on element: ejar.createnewsellcenter.isActive.field.input.byxpath
    And click on element: ejar.generic.save.action.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.createnewsellcenter.createnew.byxpath for period in seconds: 120
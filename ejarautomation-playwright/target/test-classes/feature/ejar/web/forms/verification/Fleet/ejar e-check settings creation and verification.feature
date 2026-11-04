Feature: E-Check Settings Profile Creation and Verification

  @TestType-Smoke
  Scenario: Create and verify check items profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/check-items
    And click on link: ejar.checkitem.createnew.byxpath
    And verify ejar fields label with soft assertion in form: create-or-update-check-item text: ejar.checkitem.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Check Item,عنصر تفقد                                                    | h1      |
      | Check Item,عنصر تفقد                                                    | span    |
      | Check Item,عنصر تفقد                                                    | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Type,نوع الخيارات                                                       | label   |
      | Pass Options,خيارات القبول                                              | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.checkitem.name_en.field.byxpath                           |   True     |   True     |
      | ejar.checkitem.name_ar.field.byxpath                           |   True     |   True     |
      | ejar.checkitem.type.field.byxpath                              |   True     |   True     |
      | ejar.checkitem.passoptions.field.edit.byxpath                  |   True     |   True     |
      | ejar.generic.save.action.byxpath                               |   False    |   False    |
      | ejar.checkitem.cancel.button.byxpath                           |   True     |   False    |
    And set random text in variable and into element: ejar.checkitem.name_en.field.byxpath with size: 10 and initial string: UI Automation Check Item and store value in variable: checkItemVariable
    And set value into field: ejar.checkitem.name_ar.field.byxpath from stored variable: checkItemVariable
    And user select value in drop down field: ejar.checkitem.type.field.byxpath by option text: Check Item Choices Acceptance Status,قائمة حالات القبول
    And select option in ejar kendo option field: ejar.checkitem.passoptions.field.byxpath by index: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: checkItemVariable
    And click on view record that contains text stored in variable: checkItemVariable
    And verify ejar fields label with soft assertion in form: create-or-update-check-item text: ejar.checkitem.fieldsetmain.label.read.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Check Item,عنصر تفقد                                                    | h1      |
      | Check Item,عنصر تفقد                                                    | span    |
      | Check Item,عنصر تفقد                                                    | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Type,نوع الخيارات                                                       | label   |
      | Pass Options,خيارات القبول                                              | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.checkitem.name_en.field.read.byxpath                      |   False    |   False    |
      | ejar.checkitem.name_ar.field.read.byxpath                      |   False    |   False    |
      | ejar.checkitem.type.field.read.byxpath                         |   False    |   False    |
      | ejar.checkitem.passOptions.field.read.byxpath                  |   False    |   False    |
      | ejar.checkitem.cancel.button.byxpath                           |   True     |   False    |
      | ejar.checkitem.edit.button.byxpath                             |   True     |   False    |
      | ejar.checkitem.deactivate.button.byxpath                       |   True     |   False    |
    And user click on element using java script executor: ejar.checkitem.deactivate.button.byxpath
    And user click on element using java script executor: ejar.generic.yes.action.byxpath
    And user click on action with id: ejar.checkitem.cancel.button.byxpath
    And wait for element present: ejar.checkitem.createnew.byxpath for period in seconds: 7

  @TestType-Smoke
  Scenario: Create and verify check lists profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/check-lists
    And click on element: ejar.checklist.createnew.byxpath
    And verify ejar fields label with soft assertion in form: create-or-update-checklist text: ejar.checklist.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Checklist,قائمة تفقد                                                    | h1      |
      | Checklist,قائمة تفقد                                                    | span    |
      | Checklist,قائمة تفقد                                                    | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Name [fr],الاسـم [fr]                                                    | label   |
      | Name [de],الاسـم [de]                                                    | label   |
      | Vehicles,المركبات                                                       | label   |
      | All Vehicles,جميع المركبات                                              | span    |
      | Check Items,عناصر التفقد                                                | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.checklist.name_en.field.byxpath                           |   True     |   True     |
      | ejar.checklist.name_ar.field.byxpath                           |   True     |   True     |
      | ejar.checklist.vehicles.field.byxpath                          |   True     |   True     |
      | ejar.checklist.checkitems.field.edit.byxpath                   |   True     |   True     |
      | ejar.generic.save.action.byxpath                               |   False    |   False    |
      | ejar.checklist.cancel.button.byxpath                           |   True     |   False    |
    And set random text in variable and into element: ejar.checklist.name_en.field.byxpath with size: 10 and initial string: UI Automation Check List and store value in variable: checklistVariable
    And set value into field: ejar.checklist.name_ar.field.byxpath from stored variable: checklistVariable
    And click on element: ejar.checklist.allVehicles.field.byxpath
    And user select option by index in ejar kendo option field without typing: ejar.checklist.checkitems.field.byxpath index: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: checklistVariable
    And click on view first record cell under column name: Name,الاسم
    And verify ejar fields label with soft assertion in form: create-or-update-checklist text: ejar.checklist.fieldsetmain.label.read.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Checklist,قائمة تفقد                                                    | h1      |
      | Checklist,قائمة تفقد                                                    | span    |
      | Checklist,قائمة تفقد                                                    | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Name [fr],الاسـم [fr]                                                    | label   |
      | Name [de],الاسـم [de]                                                    | label   |
      | Vehicles,المركبات                                                       | label   |
      | All Vehicles,جميع المركبات                                              | span    |
      | Check Items,عناصر التفقد                                                | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.checklist.name_en.field.read.byxpath                      |   False    |   False    |
      | ejar.checklist.name_ar.field.read.byxpath                      |   False    |   False    |
      | ejar.checklist.vehicles.field.read.byxpath                     |   False    |   False    |
      | ejar.checklist.checkItems.field.read.byxpath                   |   False    |   False    |
      | ejar.checklist.deactivate.button.byxpath                       |   True     |   False    |
      | ejar.checklist.edit.button.byxpath                             |   True     |   False    |
      | ejar.generic.cancel.action.byxpath                             |   True     |   False    |
    And user click on element using java script executor: ejar.checklist.deactivate.button.byxpath
    And user click on element using java script executor: ejar.generic.yes.action.byxpath
    And user click on action with id: ejar.checklist.cancel.button.byxpath
    And wait for element present: ejar.checklist.createnew.byxpath for period in seconds: 7

  @TestType-Smoke
  Scenario: Create and verify spare parts profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/spare-parts
    And click on link: ejar.createsparepart.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-spare-part text: ejar.createsparepart.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Spare Part,قطعة غيار                                                    | h1      |
      | Basic Information,البيانات الاساسيه                                      | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Description,الوصف                                                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                     | isEditable | isRequired |
      | ejar.createsparepart.name_en.field.byxpath                     |   True     |   True     |
      | ejar.createsparepart.name_ar.field.byxpath                     |   True     |   True     |
      | ejar.createsparepart.description.field.byxpath                 |   True     |   False    |
      | ejar.createsparepart.save.button.byxpath                       |   False    |   False    |
      | ejar.createsparepart.cancel.button.byxpath                     |   True     |   False    |
    And set random text in variable and into element: ejar.createsparepart.name_en.field.byxpath with size: 10 and initial string: UI Automation Spare Part and store value in variable: sparePartVariable
    And set value into field: ejar.createsparepart.name_ar.field.byxpath from stored variable: sparePartVariable
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: sparePartVariable
    And click on element: ejar.checkcreatesparepartlist.firstrow.button.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-spare-part text: ejar.createsparepart.fieldsetmain.label.read.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Spare Part,قطعة غيار                                                    | h1      |
      | Basic Information,البيانات الاساسيه                                      | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Description,الوصف                                                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.createsparepart.name_en.field.read.byxpath                     |   False    |   False    |
      | ejar.createsparepart.name_ar.field.read.byxpath                     |   False    |   False    |
      | ejar.checkcreatesparepartlist.deactivate.button.byxpath             |   True     |   False    |
      | ejar.createsparepart.cancel.button.byxpath                          |   True     |   False    |
      | ejar.createsparepart.edit.button.byxpath                            |   True     |   False    |
#      | ejar.createsparepart.description.field.read.byxpath                 |   False    |   False    |
    And user click on element using java script executor: ejar.checkcreatesparepartlist.deactivate.button.byxpath
    And user click on element using java script executor: ejar.createsparepart.yes.confirm.button.byxpath
    And user click on action with id: ejar.createsparepart.cancel.button.byxpath
    And verify element present: ejar.createsparepart.createnew.byxpath

  @TestType-Smoke
  Scenario: Create and verify spare part cost profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/spare-parts
    And create spare part cost with random name and store in the variable: sparePartName
    And open page using url: /app/fleet-management/e-check/spare-parts-Tariff
    And click on element: ejar.sparepartcost.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-spare-part-tariff text: ejar.sparepartcost.labels.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Spare Part Cost,تكلفة قطعة غيار                                         | h1      |
      | Spare Part Cost,تكلفة قطعة غيار                                         | span    |
      | Spare Part Cost,تكلفة قطعة غيار                                         | li      |
      | Spare Part,قطعة غيار                                                    | label   |
      | Valid From,صالح من                                                      | label   |
      | Cost,التكلفة                                                            | label   |
      | Vehicles,المركبات                                                       | label   |
      | All Vehicles,جميع المركبات                                              | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.sparepartcost.sparepart.field.edit.byxpath                     |   True     |   True     |
      | ejar.sparepartcost.countries.field.edit.byxpath                     |   True     |   True     |
      | ejar.sparepartcost.validfrom.field.edit.byxpath                     |   True     |   True     |
      | ejar.sparepartcost.cost.field.byxpath                               |   True     |   True     |
      | ejar.sparepartcost.vehicles.field.byxpath                           |   True     |   True     |
      | ejar.sparepartcost.save.button.byxpath                              |   False    |   False    |
      | ejar.sparepartcost.cancel.button.byxpath                            |   True     |   False    |
    And user select option by text in ejar kendo option field without click on empty field: ejar.sparepartcost.sparepart.field.byxpath with option value from stored variable: sparePartName
    And user select option by text in ejar kendo option field: ejar.sparepartcost.countries.field.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And set random number into element: ejar.sparepartcost.cost.field.byxpath of size: 3
    And user click on action with xpath: (//ejar-content-template//kendo-checkbox[following-sibling::span[contains(.,'Automation')]]//preceding-sibling::span/span)[1]
    And user click on action with xpath: //ejar-content-template//kendo-checkbox[following-sibling::span[contains(.,'Automation Accent')]]//input
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Spare Part,الاسم and enter value stored in variable: sparePartName
    And click on view first record cell under column name: Spare Part,الاسم
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Spare Part Cost,تكلفة قطعة غيار                                         | h1      |
      | Spare Part Cost,تكلفة قطعة غيار                                         | span    |
      | Spare Part Cost,تكلفة قطعة غيار                                         | li      |
      | Spare Part,قطعة غيار                                                    | label   |
      | Country,الدولة                                                          | label   |
      | Valid From,صالح من                                                      | label   |
      | Cost:,التكلفة:                                                          | label   |
      | Vehicles,المركبات                                                       | label   |
      | All Vehicles,جميع المركبات                                              | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.sparepartcost.sparepart.field.read.byxpath                     |   False    |   False    |
      | ejar.sparepartcost.country.field.read.byxpath                       |   False    |   False    |
      | ejar.sparepartcost.validFrom.field.read.byxpath                     |   False    |   False    |
      | ejar.sparepartcost.cost.field.read.byxpath                          |   False    |   False    |
      | ejar.sparepartcost.vehicles.field.read.byxpath                      |   False    |   False    |
      | ejar.generic.cancel.action.byxpath                                  |   True     |   False    |
      | ejar.sparepartcost.deactivate.button.byxpath                        |   True     |   False    |
      | ejar.sparepartcost.edit.button.byxpath                              |   True     |   False    |
    And user click on element using java script executor: ejar.sparepartcost.deactivate.button.byxpath
    And user click on action with id: ejar.sparepartcost.yes.confirm.button.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And wait for element present: ejar.sparepartcost.createnew.byxpath for period in seconds: 7
    And deactivate spare part with the name stored in the variable: sparePartName


  @TestType-Smoke
  Scenario: Create and verify wage profile form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/wages
    And click on element: ejar.wage.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-wage text: ejar.wage.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Wage,الأجر                                                               | h1      |
      | Basic Information,البيانات الاساسيه                                      | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Description,الوصف                                                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.wage.name_en.field.byxpath                                     |   True     |   True     |
      | ejar.wage.name_ar.field.byxpath                                     |   True     |   True     |
      | ejar.wage.description.field.byxpath                                 |   True     |   False    |
      | ejar.wage.create.button.byxpath                                     |   False    |   False    |
      | ejar.wage.cancel.button.byxpath                                     |   True     |   False    |
    And set random text in variable and into element: ejar.wage.name_en.field.byxpath with size: 10 and initial string: UI Automation Wage and store value in variable: wageVariable
    And set value into field: ejar.wage.name_ar.field.byxpath from stored variable: wageVariable
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: wageVariable
    And click on element: ejar.wage.firstRow.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-wage text: ejar.wage.fieldsetmain.label.text
    And verify form page labels and text:
      | Text                                                                    | TagType |
      | Wage,الأجر                                                               | h1      |
      | Basic Information,البيانات الاساسيه                                      | li      |
      | Name [en],الاسـم [en]                                                    | label   |
      | Name [ar],الاسـم [ar]                                                    | label   |
      | Description,الوصف                                                       | label   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                          | isEditable | isRequired |
      | ejar.wage.name_en.field.read.byxpath                                |   False    |   False    |
      | ejar.wage.name_ar.field.read.byxpath                                |   False    |   False    |
      | ejar.wage.cancel.button.byxpath                                     |   True     |   False    |
      | ejar.wage.edit.button.byxpath                                       |   True     |   False    |
      | ejar.wage.deactivate.button.byxpath                                 |   True     |   False    |
    And user click on action with id: ejar.wage.deactivate.button.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.wage.cancel.button.byxpath for period in seconds: 7


  @TestType-Smoke
  Scenario: Create and verify Wage Cost Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/wages
    And create new wage with random name and store in the variable: wageName
    And open page using url: /app/fleet-management/e-check/wageTariffs
    And click on link: ejar.wageCost.createnew.byxpath
    And verify ejar fields label with soft assertion in form: app-create-or-update-wage-tariff text: ejar.wageCost.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Wage Cost,تكلفة الاجر                                     | h1      |
      | Basic Information,البيانات الاساسيه                       | li      |
      | Wage,الأجر                                                | label   |
      | Country,الدولة                                           | label   |
      | Valid From,صالح من                                       | label   |
      | Cost,التكلفة                                             | label   |
      | Apply On,مطبق على                                        | label   |
      | All Vehicles,جميع المركبات                               | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.wageCost.wage.search.field.byxpath                | true       | true       |
      | ejar.wageCost.countries.combobox.field.byxpath         | true       | true       |
      | ejar.wageCost.validFrom.field.byxpath                  | true       | true       |
      | ejar.wageCost.cost.field.byxpath                       | true       | true       |
      | ejar.wageCost.vehicleTree.field.byxpath                | true       | true       |
      | ejar.generic.save.action.byxpath                       | false      | false      |
      | ejar.wageCost.cancel.button.byxpath                    | true       | false      |
    And user select option by text in ejar kendo option field without click on empty field: ejar.wageCost.wage.search.button.byxpath with option value from stored variable: wageName
    And user select option by text in ejar kendo option field: ejar.wageCost.countries.combobox.input.byxpath option: Saudi Arabia, المملكة العربية السعودية
    And set random number into element: ejar.wageCost.cost.field.byxpath of size: 3
    And user click on action with xpath: (//ejar-content-template//kendo-checkbox[following-sibling::span[contains(.,'Automation')]])[1]
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Wage,الأجر and enter value stored in variable: wageName
    And click on element: ejar.wageCost.firstRow.byxpath
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Wage Cost,تكلفة الاجر                                     | h1      |
      | Basic Information,البيانات الاساسيه                       | li      |
      | Wage,الأجر                                                | label   |
      | Country,الدولة                                           | label   |
      | Valid From,صالح من                                       | label   |
      | Cost:,التكلفة:                                           | label   |
      | Apply On,مطبق على                                        | label   |
      | All Vehicles,جميع المركبات                               | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.wageCost.wage.field.read.byxpath                  | false      | false      |
      | ejar.wageCost.country.field.read.byxpath               | false      | false      |
      | ejar.wageCost.validFrom.field.read.byxpath             | false      | false      |
      | ejar.wageCost.cost.field.read.byxpath                  | false      | false      |
      | ejar.wageCost.applyOn.field.read.byxpath               | false      | false      |
      | ejar.wageCost.deactivate.button.byxpath                | true       | false      |
      | ejar.wageCost.cancel.button.byxpath                    | true       | false      |
      | ejar.wageCost.edit.button.byxpath                      | true       | false      |
    And click on element: ejar.wageCost.deactivate.button.byxpath
    And click on element: ejar.wageCost.yes.confirm.button.byxpath
    And click on element: ejar.wageCost.cancel.button.byxpath
    And verify element present: ejar.wageCost.createnew.byxpath
    And deactivate wage with the name stored in the variable: wageName


  @TestType-Smoke
  Scenario: Create and verify Repair Task Form
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/repair-tasks
    And click on link: ejar.createRepairTask.createnew.byxpath
    And verify ejar fields label with soft assertion in form: create-or-update-repair-task text: ejar.repairTask.labels.text
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Repair Task,مهمة الاصلاح                                   | h1      |
      | Repair Task,مهمة الاصلاح                                   | span    |
      | Repair Task,مهمة الاصلاح                                   | li      |
      | Name [en],الاسـم [en]                                     | label   |
      | Name [ar],الاسـم [ar]                                     | label   |
      | Spare Parts,قطع الغيار                                   | label   |
      | Wages,الأجور                                              | label   |
      | Is Repeated,يتم تكراره                                   | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.repairTask.name_en.field.byxpath                  | true       | true       |
      | ejar.repairTask.name_ar.field.byxpath                  | true       | true       |
      | ejar.repairTask.spareparts.search.field.byxpath        | true       | false      |
      | ejar.repairTask.wages.field.byxpath                    | true       | true       |
      | ejar.repairTask.isRepeated.byxpath                     | true       | false      |
      | ejar.generic.cancel.action.byxpath                     | true       | false      |
      | ejar.generic.save.action.byxpath                       | false      | false      |
    And set random text in variable and into element: ejar.repairTask.name_en.field.byxpath with size: 10 and initial string: UI Automation Repair Task and store value in variable: repairTaskVariableName
    And set value into field: ejar.repairTask.name_ar.field.byxpath from stored variable: repairTaskVariableName
    And user select option by index in ejar kendo option field without typing: ejar.repairTask.spareparts.search.field.byxpath index: 1
    And user select option by index in ejar kendo option field without typing: ejar.repairTask.wages.search.field.byxpath index: 1
    And user click on action with id: ejar.generic.save.action.byxpath
    And user click on action with id: ejar.generic.yes.action.byxpath
    And filter view on column name: Name,الاسم and enter value stored in variable: repairTaskVariableName
    And click on element: ejar.repairTask.firstRow.a.byxpath
    And verify ejar fields label with soft assertion in form: create-or-update-repair-task text: ejar.repairTask.labels.text.read
    And verify form page labels and text:
      | Text                                                     | TagType |
      | Repair Task,مهمة الاصلاح                                   | h1      |
      | Repair Task,مهمة الاصلاح                                   | span    |
      | Repair Task,مهمة الاصلاح                                   | li      |
      | Name [en],الاسـم [en]                                     | label   |
      | Name [ar],الاسـم [ar]                                     | label   |
      | Spare Parts,قطع الغيار                                   | label   |
      | Wages,الأجور                                              | label   |
      | Is Repeated,يتم تكراره                                   | span    |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                             | isEditable | isRequired |
      | ejar.repairTask.name_en.field.read.byxpath             | false      | false      |
      | ejar.repairTask.name_ar.field.read.byxpath             | false      | false      |
      | ejar.repairTask.spare.field.read.byxpath               | false      | false      |
      | ejar.repairTask.wages.field.read.byxpath               | false      | false      |
      | ejar.repairTask.isRepeated.byxpath                     | false      | false      |
      | ejar.repairTask.cancel.button.byxpath                  | true       | false      |
      | ejar.repairTask.edit.button.byxpath                    | true       | false      |
      | ejar.repairTask.deactivate.button.byxpath              | true       | false      |
    And user click on element using java script executor: ejar.repairTask.deactivate.button.byxpath
    And user click on element using java script executor: ejar.repairTask.yes.confirm.button.byxpath
    And user click on action with id: ejar.repairTask.cancel.button.byxpath
    And verify element present: ejar.createRepairTask.createnew.byxpath


#Scenarios no longer valid (cannot create new using the form )
#  1-url: /app/fleet-management/e-check/skeleton
#  2-url: /app/fleet-management/e-check/damage-types
#  3-url: /app/fleet-management/e-check/skeleton-bodies
#  4-url: /app/fleet-management/e-check/check-types
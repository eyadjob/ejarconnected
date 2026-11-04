#Feature: Ejar Administration Saving Forms Validation
#
#  @TestType-Smoke
#  Scenario: Save logging Quotes Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/loggingQuotes
#    And wait for element present: ejar.generic.save.action.byxpath for period in seconds: 160
#    And verify ejar fields label with soft assertion in form: logging-quotes text: ejar.loginquotes.labels.text
#    And verify form page labels and text:
#      | Text                                                                  | TagType |
#      | Login Quotes,الاقتباس لصفحة الدخول                                     |  h1     |
#      | Quote Text [en],نص الاقتباس [en]                                       |  label  |
#      | Quote Text [ar],نص الاقتباس [ar]                                       |  label  |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.loginquotes.quoteEN.field.byxpath                           | True       | True       |
#      | ejar.loginquotes.quoteAR.field.byxpath                           | True       | True       |
#      | ejar.generic.save.action.byxpath                                 | True       | False      |
#      | ejar.generic.cancel.action.byxpath                               | True       | False      |
#    And user click on action with id: ejar.generic.save.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Help Video form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/help-videos
#    And user click on action with id: ejar.createHelpVideos.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: app-create-or-edit-helpvideo text: ejar.helpVideos.labels.text
#    And verify form page labels and text:
#      | Text                                                                  | TagType |
#      | Help Videos,فيديوهات المساعدة                                         |  h1     |
#      | Create Help Video,إنشاء فيديو المساعدة                                |  span   |
#      | Basic information,المعلومات الأساسية                                   |  li     |
#      | Name [en],الاسـم [en]                                                  |  label  |
#      | Name [ar],الاسـم [ar]                                                  |  label  |
#      | Parent,الأب                                                            |  label  |
#      | Is Active,فعال                                                        |  label  |
#      | Video URL,رابط فيديو المساعدة                                         |  label  |
#      | Order,الترتيب                                                         |  label  |
#      | Video Description [en],وصف الفيديو [en]                               |  label  |
#      | Video Description [ar],وصف الفيديو [ar]                               |  label  |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.helpVideos.nameEnglish.field.byxpath                        | True       | True       |
#      | ejar.helpVideos.nameArabic.field.byxpath                         | True       | True       |
#      | ejar.helpVideos.parent.field.byxpath                             | True       | False      |
#      | ejar.helpVideos.isActive.field.byxpath                           | True       | False      |
#      | ejar.generic.save.action.byxpath                                 | False      | False      |
#      | ejar.generic.cancel.action.byxpath                               | True       | False      |
#    And set random text in variable and into element: ejar.helpVideos.nameEnglish.field.byxpath with size: 10 and initial string: UI Automation Help Video and store value in variable: helpVideo
#    And set value into field: ejar.helpVideos.nameArabic.field.byxpath from stored variable: helpVideo
#    And user click on action with id: ejar.generic.save.action.byxpath
#    And user click on action with id: ejar.generic.yes.action.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: helpVideo
#    And user click on view action: Edit Help Video,تعديل فيديو المساعدة  related to record with text: UI Automation Help Video,UI Automation Help Video then select record at index: 1
#    And click on element: ejar.helpVideos.isActive.field.byxpath
#    And user click on action with id: ejar.generic.save.action.byxpath
#    And user click on action with id: ejar.generic.yes.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Employee Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/employees
#    And user click on action with id: ejar.employees.createnew.button.byxpath
#    And verify ejar fields label with soft assertion in form: employeebasicinformation/parent::div text: ejar.employees.labels.text
#    And verify form page labels and text:
#      | Text                                                    | TagType |
#      | Employees,الموظفين                                      |   h1    |
#      | Create new employee,إضافة موظف                          | span    |
#      | Basic information,المعلومات الأساسية                     |  li     |
#      | First name,الاسم الاول                                    | label   |
#      | Second name,الاسم الثاني                                 | label   |
#      | Third name,الاسم الثالث                                  | label   |
#      | Fourth name,الاسم الرابع                                 | label   |
#      | Family name,اسم العائلة                                 | label   |
#      | Nationality,الجنسية                                     | label   |
#      | Gender,الجنس                                            | label   |
#      | Birth Date,تاريخ الميلاد                                 | label   |
#      | Working Country,دولة العمل                              | label   |
#      | Contact information,معلومات الاتصال                      |  div    |
#      | Primary Phone,الهاتف الأساسي                             | label   |
#      | Email,البريد الإلكتروني                                  | label   |
#      | Professional information,معلومات العمل                  |  li     |
#      | Employee number,الرقم الوظيفي                           | label   |
#      | Roles,الوظائف                                           | label   |
#      | Work start date,تاريخ التعيين                           | label   |
#      | Work end date,تاريخ انتهاء الخدمة                       | label   |
#      | Documents,مستندات                                       |  li     |
#      | Document type,نوع الاثبات                                | label   |
#      | Number,الرقم                                            | label   |
#      | Issue Country,دولة الاصدار                               | label   |
#      | Expiry Date,تاريخ الانتهاء                               | label   |
#      | Driver's License Expiry Date,تاريخ انتهاء رخصة القيادة  | label   |
#      | Notes,ملاحظات                                            |  li     |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.employees.firstName.field.edit.byxpath                      | True       | True       |
#      | ejar.employees.secondName.field.edit.byxpath                     | True       | True       |
#      | ejar.employees.thirdName.field.edit.byxpath                      | True       | False      |
#      | ejar.employees.fourthName.field.edit.byxpath                     | True       | False      |
#      | ejar.employees.familyName.field.edit.byxpath                     | True       | True       |
#      | ejar.employees.nationalityCombobox.field.edit.byxpath            | True       | True       |
#      | ejar.employees.genderCombobox.field.edit.byxpath                 | True       | True       |
#      | ejar.employees.birthDate.field.edit.byxpath                      | True       | False      |
#      | ejar.employees.workingCountryCombobox.field.edit.byxpath         | True       | True       |
#      | ejar.employees.employeeNumber.field.edit.byxpath                 | True       | True       |
#      | ejar.employees.professionsComboBox.field.edit.byxpath            | True       | False      |
#      | ejar.employees.workStartDateDatePicker.field.edit.byxpath        | True       | True       |
#      | ejar.employees.workEndDateDatePicker.field.edit.byxpath          | True       | False      |
#      | ejar.employees.documentTypes.field.edit.byxpath                  | True       | False      |
#      | ejar.employees.documentNumber.field.read.byxpath                 | False      | True       |
#      | ejar.employees.documentIssueCountry.field.read.byxpath           | False      | True       |
#      | ejar.employees.documentExpiryDate.field.edit.byxpath             | False      | False      |
#      | ejar.employees.licenseExpiryDate.field.edit.byxpath              | True       | False      |
#      | ejar.employees.notes.field.edit.byxpath                          | True       | False      |
#      | ejar.employees.save.button.byxpath                               | False      | False      |
#      | ejar.employees.cancel.button.byxpath                             | True       | False      |
#    And set random text into element: ejar.employees.firstName.field.byxpath with size: 5 and initial string: UI Employee
#    And set random text into element: ejar.employees.secondName.field.byxpath with size: 5 and initial string: UI Employee
#    And set random text into element: ejar.employees.familyName.field.byxpath with size: 5 and initial string: UI Employee
#    And user select value in drop down field: ejar.employees.nationalityCombobox.field.byxpath by option text: Saudi,سعودي
#    And user select value in drop down field: ejar.employees.genderCombobox.field.byxpath by option text: Male,ذكر
#    And user select value in drop down field: ejar.employees.workingCountryCombobox.field.byxpath by option text: Saudi Arabia, المملكة العربية السعودية
#    And set random number into element: ejar.employees.employeeNumber.field.byxpath of size: 10
#    And user click on action with id: ejar.employees.save.button.byxpath
#    And user click on action with id: ejar.generic.yes.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Role form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/roles
#    And user click on action with id: ejar.roles.createnew.button.byxpath
#    And wait for element present: ejar.roles.roleModal.field.byxpath for period in seconds: 90
#    And verify ejar fields label with soft assertion in form: createoreditrolemodal//tab[1] text: ejar.roles.tab1.labels.text
#    And verify form page labels and text:
#      | Text                                                                            | TagType |
#      | Create new role,إضافة دور                                                       |  span   |
#      | Role name,اسم الدور                                                             |  span   |
#      | Permissions,إذونات                                                              |  span   |
#      | Notification settings,إعدادات الإخطارات                                          |  span   |
#      | Role name *,اسم الدور *                                                         |  label  |
#      | Default Assign to new users as default.,افتراضي تعيين للمستخدمين الجدد كإفتراضي |  span   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.roles.isDefault.field.byxpath                               | True       | False      |
#      | ejar.roles.name.field.byxpath                                    | True       | True       |
#      | ejar.roles.roleNameTab.a.byxpath                                 | True       | False      |
#      | ejar.roles.permissionsTab.a.byxpath                              | True       | False      |
#      | ejar.roles.notificationSettingsTab.a.byxpath                     | True       | False      |
#      | ejar.roles.cancel.button.byxpath                                 | True       | False      |
#      | ejar.roles.save.button.byxpath                                   | False      | False      |
#    And click on element: ejar.roles.permissionsTab.a.byxpath
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.roles.searchPermission.input.byxpath                        | True       | False      |
#      | ejar.roles.permissionTree.div.byxpath                            | True       | False      |
#      | ejar.roles.roleNameTab.a.byxpath                                 | True       | False      |
#      | ejar.roles.permissionsTab.a.byxpath                              | True       | False      |
#      | ejar.roles.notificationSettingsTab.a.byxpath                     | True       | False      |
#      | ejar.roles.cancel.button.byxpath                                 | True       | False      |
#      | ejar.roles.save.button.byxpath                                   | False      | False      |
#    And click on element: ejar.roles.notificationSettingsTab.a.byxpath
#    And verify form page labels and text:
#      | Text                                                            | TagType |
#      | Notification Types,أنواع الإخطارات                               |  h4     |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.roles.notificationsCheckboxes.div.byxpath                   | True       | False      |
#      | ejar.roles.roleNameTab.a.byxpath                                 | True       | False      |
#      | ejar.roles.permissionsTab.a.byxpath                              | True       | False      |
#      | ejar.roles.notificationSettingsTab.a.byxpath                     | True       | False      |
#      | ejar.roles.cancel.button.byxpath                                 | True       | False      |
#      | ejar.roles.save.button.byxpath                                   | False      | False      |
#    And click on element: ejar.roles.roleNameTab.a.byxpath
#    And set random text in variable and into element: ejar.roles.name.field.byxpath with size: 10 and initial string: UI Role Name and store value in variable: automationRoleName
#    And user click on action with id: ejar.roles.save.button.byxpath
#    And wait for element not present: ejar.roles.rolesForm.form.byxpath
#    And change zoom level: 0.2
#    And click on action with xpath: //span[contains(text(),'${DynamicVariable}')]//parent::td//preceding-sibling::td//button with replacing variable with stored value: automationRoleName
#    And user click on element using java script executor: ejar.roles.delete.button.byxpath
#    And change zoom level: 1
#    And click on element: ejar.generic.yes.action.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Create And Verify User Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/employees
#    And create employee with random name and store name in variable: employeeNameVariable
#    And wait for element present: ejar.employees.createnew.button.byxpath for period in seconds: 30
#    And filter view on column name: Name,الاسـم and enter value stored in variable: employeeNameVariable
#    And filter view on column name: Name,الاسـم and enter value stored in variable: employeeNameVariable
#    And click on element: ejar.user.moreOptions.i.byxpath
#    And click on element: ejar.user.createNewUser.i.byxpath
#    And click on element: ejar.user.randomPassword.field.input.byxpath
#    And verify ejar fields label with soft assertion in form: tab[1] text: ejar.user.userInfoLabels.text
#    And verify form page labels and text:
#      | Text                                                                                 | TagType |
#      | Create new user,اضافة مستخدم                                                         |  span   |
#      | User informations,تفاصيل المستخدم                                                    |  span   |
#      | Roles,الأدوار                                                                         |  span   |
#      | Organization Units,الوحدات التنظيمية                                                 |  span   |
#      | Name,الاسـم                                                                           |  label  |
#      | Surname *,الإسم الأخير *                                                               |  label  |
#      | Email address *,البريد الإلكتروني *                                                   |  label  |
#      | Phone number,رقم الجوال                                                              |  label  |
#      | User name *,اسم المستخدم *                                                           |  label  |
#      | Set random password.,تعيين كلمة مرور عشوائية.                                        |  label  |
#      | Should change password on next login.,يجب تغيير كلمة المرور عند تسجيل الدخول المقبل. |  label  |
#      | Send activation email.,إرسال رسالة تفعيل البريد الإلكتروني.                           |  label  |
#      | Active,فعال                                                                          |  label  |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.user.Name.field.byxpath                                     | True       | True       |
#      | ejar.user.Surname.field.byxpath                                  | True       | True       |
#      | ejar.user.Email.field.byxpath                                    | True       | True       |
#      | ejar.user.phoneNumber.field.input.byxpath                        | True       | False      |
#      | ejar.user.UserName.field.byxpath                                 | True       | True       |
#      | ejar.user.randomPassword.field.input.byxpath                     | True       | False      |
#      | ejar.user.password.field.byxpath                                 | True       | True       |
#      | ejar.user.PasswordRepeat.field.byxpath                           | True       | True       |
#      | ejar.user.sendActivationEmail.field.input.byxpath                | False      | False      |
#      | ejar.user.isActive.field.byxpath                                 | True       | False      |
#      | ejar.user.userInfoTab.a.byxpath                                  | True       | False      |
#      | ejar.user.rolesTab.a.byxpath                                     | True       | False      |
#      | ejar.user.organizationUnitTab.a.byxpath                          | True       | False      |
#      | ejar.user.save.button.byxpath                                    | False      | False      |
#      | ejar.user.cancel.button.byxpath                                  | True       | False      |
#    And click on element: ejar.user.rolesTab.a.byxpath
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.user.rolesTab.field.input.byxpath                           | True       | False      |
#      | ejar.user.userInfoTab.a.byxpath                                  | True       | False      |
#      | ejar.user.rolesTab.a.byxpath                                     | True       | False      |
#      | ejar.user.organizationUnitTab.a.byxpath                          | True       | False      |
#      | ejar.user.save.button.byxpath                                    | False      | False      |
#      | ejar.user.cancel.button.byxpath                                  | True       | False      |
#    And click on element: ejar.user.organizationUnitTab.a.byxpath
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.user.organizationUnitSearch.field.input.byxpath             | True       | False      |
#      | ejar.user.userInfoTab.a.byxpath                                  | True       | False      |
#      | ejar.user.rolesTab.a.byxpath                                     | True       | False      |
#      | ejar.user.organizationUnitTab.a.byxpath                          | True       | False      |
#      | ejar.user.save.button.byxpath                                    | False      | False      |
#      | ejar.user.cancel.button.byxpath                                  | True       | False      |
#    And click on element: ejar.user.userInfoTab.a.byxpath
#    And set value into field: ejar.user.Name.field.byxpath from stored variable: employeeNameVariable
#    And set random text into element: ejar.user.Surname.field.byxpath with size: 8 and initial string: Eyad
#    And set random email into element: ejar.user.Email.field.byxpath
#    And set random text into element: ejar.user.UserName.field.byxpath with size: 8 and initial string: UI Username
#    And user set in field: ejar.user.password.field.byxpath value: Eyad123456$
#    And user set in field: ejar.user.PasswordRepeat.field.byxpath value: Eyad123456$
#    And user click on action with xpath: //input[@name='SendActivationEmail']
#    And click on element: ejar.user.rolesTab.button.byxpath
#    And click on element: ejar.user.adminRole.button.byxpath
#    And user click on action with id: ejar.user.save.button.byxpath
#    And wait for element not present: ejar.user.createUserForm.form.byxpath
#    And open page using url: /app/admin/users
#    And wait for element present: ejar.user.view.search.field.byxpath for period in seconds: 100
#    And set value into field: ejar.user.view.search.field.byxpath from stored variable: employeeNameVariable
#    And user click on action with id: ejar.user.view.search.button.byxpath
#    And wait for element present: ejar.user.view.actions.button.byxpath for period in seconds: 100
#    And user click on action with id: ejar.user.view.actions.button.byxpath
#    And user click on action with id: ejar.user.view.edit.button.byxpath
#    And click on element: ejar.user.isActive.field.byxpath
#    And user click on action with id: ejar.user.save.button.byxpath
#    And wait for element not present: ejar.user.save.button.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify City Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/cities
#    And user click on action with id: ejar.cities.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: createoreditcitymodal text: ejar.cities.label.text
#    And verify form page labels and text:
#      | Text                           | TagType |
#      | Create new city,إضافة مدينة    |  h4     |
#      | Name [en],الاسـم [en]           | label   |
#      | Name [ar],الاسـم [ar]           | label   |
#      | Country,الدولة                 | label   |
#      | Region,المنطقة                 | label   |
#      | Is Active,فعال                 | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                | isEditable | isRequired |
#      | ejar.cities.name_en.fields.edit.byxpath   | True       | True       |
#      | ejar.cities.name_ar.fields.edit.byxpath   | True       | True       |
#      | ejar.cities.country.fields.edit.byxpath   | True       | True       |
#      | ejar.cities.region.fields.edit.byxpath    | True       | False      |
#      | ejar.cities.isActive.fields.edit.byxpath  | True       | False      |
#      | ejar.cities.save.button.read.byxpath      | False      | False      |
#      | ejar.cities.cancel.button.edit.byxpath    | True       | False      |
#    And set random text in variable and into element: ejar.cities.name_en.fields.byxpath with size: 10 and initial string: UI Automation City and store value in variable: cityNameVariable
#    And set value into field: ejar.cities.name_ar.fields.byxpath from stored variable: cityNameVariable
#    And user select option by text in ejar kendo option field without click on empty element and without typing: ejar.cities.country.fields.byxpath option: Saudi Arabia, المملكة العربية السعودية
#    And user click on action with id: ejar.cities.save.button.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: cityNameVariable
#    And user click on view action: Edit,تعديل related to record with text stored in variable: cityNameVariable then select record at index: 1
#    And user click on action with id: ejar.cities.isActive.fields.byxpath
#    And user click on action with id: ejar.cities.save.button.byxpath
#    And verify element present: ejar.cities.createnew.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Currency Exchange Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/currencies-exchange-rates
#    And user click on action with id: ejar.currencyexchange.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: create-or-edit-currency-exchange-rate text: ejar.currencyexchange.label.text
#    And verify form page labels and text:
#      | Text                                            | TagType |
#      | Create New Currency Exchange Rate,إضافة سعر صرف | span    |
#      | Amount,قيمة                                     | label   |
#      | From,من                                         | label   |
#      | To,الى                                          | label   |
#      | Currency Exchange Rate,سعر صرف العملة           | label   |
#      | Is Active,فعال                                  | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.currencyexchange.amount.fields.read.byxpath                 | False      | False      |
#      | ejar.currencyexchange.firstCurrencyCombobox.fields.edit.byxpath  | True       | True       |
#      | ejar.currencyexchange.secondCurrencyCombobox.fields.edit.byxpath | True       | True       |
#      | ejar.currencyexchange.firstToSecondRate.fields.edit.byxpath      | True       | True       |
#      | ejar.currencyexchange.reversedTo.fields.read.byxpath             | False      | False      |
#      | ejar.currencyexchange.reversedFrom.fields.read.byxpath           | False      | False      |
#      | ejar.currencyexchange.secondToFirstRate.fields.edit.byxpath      | True       | True       |
#      | ejar.currencyexchange.isActive.fields.byxpath                    | True       | False      |
#      | ejar.currencyexchange.save.button.byxpath                        | False      | False      |
#      | ejar.currencyexchange.cancel.button.byxpath                      | True       | False      |
#    And user select value in drop down field: ejar.currencyexchange.firstCurrencyCombobox.fields.byxpath by option text: AMD,AMD
#    And user select value in drop down field: ejar.currencyexchange.secondCurrencyCombobox.fields.byxpath by option text: AOA,AOA
#    And user set in field: ejar.currencyexchange.firstToSecondRate.fields.byxpath value: 1.2
#    And user set in field: ejar.currencyexchange.secondToFirstRate.fields.byxpath value: 0.8
#    And user click on action with id: ejar.currencyexchange.save.button.byxpath
#    And click on action if exist: ejar.generic.yes.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify System Lookup Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/lookups
#    And user select value in drop down field: ejar.systemLookups.type.field.byxpath by option text: Occupation level ,درجة وظيفة
#    And user click on action with id: ejar.systemLookups.create.action.byxpath
#    And verify ejar fields label with soft assertion in form: createoreditlookupmodal text: ejar.lookups.label.text
#    And verify form page labels and text:
#      | Text                       | TagType |
#      | Name [en],الاسـم [en]       | label   |
#      | Name [ar],الاسـم [ar]       | label   |
#      | Value,القيمة               | label   |
#      | Sequence,التسلسل           | label   |
#      | Is Active,فعال             | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.lookups.name_en.fields.edit.byxpath                         | True       | True       |
#      | ejar.lookups.name_ar.fields.edit.byxpath                         | True       | True       |
#      | ejar.lookups.value.fields.edit.byxpath                           | True       | False      |
#      | ejar.lookups.inputSequence.fields.edit.byxpath                   | True       | True       |
#      | ejar.lookups.isActive.fields.edit.byxpath                        | True       | False      |
#      | ejar.lookups.save.button.byxpath                                 | False      | False      |
#      | ejar.lookups.cancel.button.byxpath                               | True       | False      |
#    And set random text in variable and into element: ejar.systemLookups.english.name.field.byxpath with size: 10 and initial string: Automation UI Occupation Level and store value in variable: OccupationNameVariable
#    And set value into field: ejar.systemLookups.arabic.name.field.byxpath from stored variable: OccupationNameVariable
#    And user set in field: ejar.systemLookups.InputSequence.field.byxpath value: 1
#    And user click on action with id: ejar.systemLookups.save.action.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: OccupationNameVariable
#    And user click on view action: Edit,تعديل related to record with text stored in variable: OccupationNameVariable then select record at index: 1
#    And user click on action with id: ejar.systemLookups.isActive.checkbox.byxpath
#    And user click on action with id: ejar.systemLookups.save.action.byxpath
#    And verify element present: ejar.systemLookups.create.action.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Save Operational Country Setting Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.operationalCountry.openSetting.action.byxpath
#    And user click on action with id: ejar.generic.cancel.action.byxpath
#    And user click on action with id: ejar.operationalCountry.branchSetting.action.byxpath
#    And user click on action with id: ejar.generic.cancel.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Fuel Type Setting Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.operationalCountry.fuelTypes.action.byxpath
#    And user click on action with id: ejar.fuel_types.createNew.byxpath
#    And verify ejar fields label with soft assertion in form: create-or-edit-fuel-type-modal text: ejar.fuelTypes.labels.text
#    And verify form page labels and text:
#      | Text                                    | TagType |
#      | Create New Fuel Type,إضافة نوع وقود     | span    |
#      | Name [en],الاسـم [en]                    | label   |
#      | Name [ar],الاسـم [ar]                    | label   |
#      | Country,الدولة                          | label   |
#      | Liter Cost,تكلفة اللتر                  | label   |
#      | Is Active,فعال                          | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                | isEditable | isRequired |
#      | ejar.fuel.nameEN.field.edit.byxpath       | True       | True       |
#      | ejar.fuel.nameAR.field.edit.byxpath       | True       | True       |
#      | ejar.fuel.country.field.read.byxpath      | False      | False      |
#      | ejar.fuel.literCost.field.edit.byxpath    | True       | False      |
#      | ejar.fuel_types.save.button.byxpath       | False      | False      |
#      | ejar.fuel_types.cancel.button.byxpath     | True       | False      |
#    And set random text into element: ejar.fuel_types.nameEnglish.field.button.byxpath with size: 4 and initial string: Automation Fuel
#    And set random text into element: ejar.fuel_types.nameArabic.field.button.byxpath with size: 4 and initial string: Automation Fuel
#    And user click on action with id: ejar.fuel_types.save.button.byxpath
#    And filter view on column name: Name,الاسـم and enter value: Automation Fuel ,Automation Fuel
#    And user click on view action: Edit,تعديل  related to record with text: Automation Fuel ,Automation Fuel then select record at index: 1
#    And user click on action with id: ejar.fuel-Type.isActive.field.byxpath
#    And user click on action with id: ejar.fuel_types.save.button.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Create And Verify Accident Policy Setting Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.operationalCountry.accidentPolicy.action.byxpath
#    And user click on action with id: ejar.accident_policies.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: form[@name='accidentPolicyFrom'] text: ejar.accident_policies.field.label.text
#    And verify form page labels and text:
#      | Text                                       | TagType |
#      | Create Accident Policy,إضافة بوليصة تحمل   |   h1    |
#      | Basic information,المعلومات الأساسية        |   a     |
#      | Daily Policy,البوليصة اليومية              |   a     |
#      | Monthly Policy,البوليصة الشهرية            |   a     |
#      | Country,الدولة                             | label   |
#      | Policy Number,رقم البوليصة                 | label   |
#      | Insurance Company,شركة التأمين             | label   |
#      | Liability Clause,شرط التحمل                | label   |
#      | Start Date,وقت البداية                     | label   |
#      | End Date,وقت النهاية                       | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                 | isEditable | isRequired |
#      | ejar.accident_policies.country.field.read.byxpath          | False      | True       |
#      | ejar.accident_policies.policyNumber.field.edit.byxpath     | True       | True       |
#      | ejar.accident_policies.insuranceCompany.field.edit.byxpath | True       | True       |
#      | ejar.accident_policies.liabilityClause.field.edit.byxpath  | True       | True       |
#      | ejar.accident_policies.startDate.field.edit.byxpath        | True       | True       |
#      | ejar.accident_policies.endDate.field.edit.byxpath          | True       | True       |
#      | ejar.accident_policies.basicInfo.i.field.byxpath           | True       | False      |
#      | ejar.accident_policies.dailyPolicy.i.field.byxpath         | True       | False      |
#      | ejar.accident_policies.monthlyPolicy.i.field.byxpath       | True       | False      |
#      | ejar.accident_policies.create.button.byxpath               | False      | False      |
#      | ejar.accident_policies.cancel.button.byxpath               | True       | False      |
#    And click on element: ejar.accident_policies.basicInfo.i.field.byxpath
#    And click on element: ejar.accident_policies.dailyPolicy.i.field.byxpath
#    And click on element: ejar.accident_policies.monthlyPolicy.i.field.byxpath
#    And user click on action with id: ejar.accident_policies.cancel.button.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Preventive Maintenance Setting Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.operationalCountry.preventive_maintenance.action.byxpath
#    And user click on action with id: ejar.preventive_maintenance.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: app-create-or-update-maintnance-configuration text: ejar.preventive_maintenancenotactive.label.text
#    And verify form page labels and text:
#      | Text                                              | TagType |
#      | Create preventive maintenance,إضافة صيانة وقائية  | span    |
#      | Name [en],الاسـم [en]                              | label   |
#      | Name [ar],الاسـم [ar]                              | label   |
#      | Country,الدولة                                    | label   |
#      | Category,الفئة                                    | label   |
#      | Manufacturer,الشركة المصنعة                       | label   |
#      | Kilometer,كيلومتر                                 | label   |
#      | Months,الأشهر                                      | label   |
#      | Repair Tasks,مهام الاصلاح                           | label   |
#      | Is Active,فعال                                    | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.preventive_maintenance.nameEnglish.field.edit.byxpath       | True       | True       |
#      | ejar.preventive_maintenance.nameArabic.field.edit.byxpath        | True       | True       |
#      | ejar.preventive_maintenance.country.field.read.byxpath           | False      | False      |
#      | ejar.preventive_maintenance.category.field.edit.byxpath          | True       | False      |
#      | ejar.preventive_maintenance.manufacturer.field.edit.byxpath      | True       | False      |
#      | ejar.preventive_maintenance.kilometer.field.edit.byxpath         | True       | False      |
#      | ejar.preventive_maintenance.months.field.edit.byxpath            | True       | False      |
#      | ejar.preventive_maintenance.repair.field.edit.byxpath            | True       | False      |
#      | ejar.preventive_maintenance.isActive.field.edit.byxpath          | True       | False      |
#      | ejar.preventive_maintenance.cancel.button.byxpath                | True       | False      |
#      | ejar.preventive_maintenance.save.button.edit.byxpath             | False      | False      |
#    And set random text in variable and into element: ejar.preventive_maintenance.nameEnglish.field.byxpath with size: 10 and initial string: UI Automation Preventive Maintenance and store value in variable: preventiveNameVariable
#    And set value into field: ejar.preventive_maintenance.nameArabic.field.byxpath from stored variable: preventiveNameVariable
#    And set random number into element: ejar.preventive_maintenance.kilometer.field.byxpath of size: 3
#    And user click on action with id: ejar.preventive_maintenance.isActive.field.byxpath
#    And user click on action with id: ejar.preventive_maintenance.save.button.byxpath
#    And click on action if exist: ejar.preventive_maintenance.linkedaccountsmodal.close.action.byxpath
#    And click on action if exist: ejar.preventive_maintenance.cancel.button.byxpath
#    And filter view on column name: Name of Maintenance Plan,اسم خطة الصيانة and enter value stored in variable: preventiveNameVariable
#    And user click on view action: Edit,تعديل  related to record with text stored in variable: preventiveNameVariable then select record at index: 1
#    And user click on action with id: ejar.preventive_maintenance.isActive.field.byxpath
#    And user click on action with id: ejar.preventive_maintenance.save.button.byxpath
#    And wait for element not present: ejar.preventive_maintenance.save.button.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Create And Verify Occupations Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.operationalCountry.occupations.action.byxpath
#    And user click on action with id: ejar.occupations.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: create-or-edit-occupation-modal text: ejar.occupations.label.text
#    And verify form page labels and text:
#      | Text                              | TagType |
#      | Create New Occupation,إضافة وظيفة | span    |
#      | Country,الدولة                    | label   |
#      | Name [en],الاسـم [en]              | label   |
#      | Name [ar],الاسـم [ar]              | label   |
#      | Occupation Code,الرمز الوظيفي     | label   |
#      | Occupation Level,درجة الوظيفة     | label   |
#      | Is Active,فعال                    | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.occupations.country.field.read.byxpath                      | False      | False      |
#      | ejar.occupations.nameEnglish.field.edit.byxpath                  | True       | True       |
#      | ejar.occupations.nameArabic.field.edit.byxpath                   | True       | True       |
#      | ejar.occupations.occupationCode.field.edit.byxpath               | True       | True       |
#      | ejar.occupations.occupationLevel.field.edit.byxpath              | True       | True       |
#      | ejar.occupations.isActive.field.byxpath                          | True       | False      |
#      | ejar.occupations.isActive.field.byxpath                          | True       | False      |
#      | ejar.occupations.save.button.edit.byxpath                        | False      | False      |
#      | ejar.occupations.cancel.button.byxpath                           | True       | False      |
#    And set random text in variable and into element: ejar.occupations.nameEnglish.field.byxpath with size: 10 and initial string: UI Automation Occupation and store value in variable: occupationSettingVariable
#    And set value into field: ejar.occupations.nameArabic.field.byxpath from stored variable: occupationSettingVariable
#    And set random number into element: ejar.occupations.occupationCode.field.byxpath of size: 10
#    And user select value in drop down field: ejar.occupations.occupationLevel.field.byxpath by option text: First Level,مستوى أول
#    And user click on action with id: ejar.occupations.save.button.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: occupationSettingVariable
#    And user click on view action: Edit,تعديل  related to record with text stored in variable: occupationSettingVariable then select record at index: 1
#    And user click on action with id: ejar.occupations.isActive.field.byxpath
#    And user click on action with id: ejar.occupations.save.button.byxpath
#    And verify element present: ejar.occupations.createnew.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Create And Verify Regions Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.regions.link.inOperationalCountry.action.byxpath
#    And user click on action with id: ejar.regions.createnew.byxpath
#    And verify ejar fields label with soft assertion in form: create-or-edit-region-modal text: ejar.regions.labels.text
#    And verify form page labels and text:
#      | Text                             | TagType |
#      | Name [en],الاسـم [en]             | label   |
#      | Name [ar],الاسـم [ar]             | label   |
#      | Country,الدولة                   | label   |
#      | Is Active,فعال                   | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.regions.nameEnglish.field.byxpath                           | True       | True       |
#      | ejar.regions.nameArabic.field.byxpath                            | True       | True       |
#      | ejar.regions.country.fields.byxpath                              | False      | True       |
#      | ejar.regions.isActive.field.edit.byxpath                         | True       | False      |
#      | ejar.regions.save.button.edit.byxpath                            | False      | False      |
#      | ejar.regions.close.button.byxpath                                | True       | False      |
#    And set random text in variable and into element: ejar.regions.nameEnglish.field.byxpath with size: 10 and initial string: UI Automation Regions and store value in variable: RegionsNameVariable
#    And set value into field: ejar.regions.nameArabic.field.byxpath from stored variable: RegionsNameVariable
#    And user click on action with id: ejar.regions.save.button.byxpath
#    And wait for element not present: ejar.regions.savedsuccessfully.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: RegionsNameVariable
#    And user click on view action: Edit,تعديل  related to record with text stored in variable: RegionsNameVariable then select record at index: 1
#    And user click on action with id: ejar.regions.isActive.field.byxpath
#    And user click on action with id: ejar.regions.save.button.byxpath
#    And wait for element not present: ejar.regions.save.button.byxpath
#
#  @TestType-Smoke
#  Scenario: Open And Verify Transfer Form And Save It
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.TransferCost.occupations.action.byxpath
#    And verify form page labels and text:
#      | Text                                   | TagType |
#      | Transfer Costs,رسوم الشحن              | h1      |
#      | Manage Transfer Costs,اداره رسوم الشحن | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.TransferCost.close.button.byxpath                           | True       | False      |
#    And user click on action with id: ejar.TransferCost.save.button.byxpath
#    And verify element present: ejar.TransferCost.occupations.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Open And Verify Insurance Deposits Form And Save It
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.InsuranceDeposits.action.byxpath
#    And verify form page labels and text:
#      | Text                                   | TagType |
#      | Insurance Deposits,دفعات التأمين       | h1      |
#      | Basic information,المعلومات الأساسية    | li      |
#      | Category,الفئة                         | span    |
#      | Amount,قيمة                            | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.InsuranceDeposits.create.button.byxpath                     | True       | False      |
#      | ejar.generic.cancel.action.byxpath                               | True       | False      |
#    And user click on action with id: ejar.InsuranceDeposits.create.button.byxpath
#    And verify element present: ejar.InsuranceDeposits.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Open And Verify Driver Authorization Form And Save It
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.DriverAuthorization.action.byxpath
#    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.DriverAuthorization.labels.text
#    And verify form page labels and text:
#      | Text                                                                        | TagType |
#      | Driver Authorization,تفويض السائق                                           | h1      |
#      | Create Driver Authorization,إنشاء تفويض سائق                                | li      |
#      | User name,اسم المستخدم                                                      | label   |
#      | Password,كلمة المرور                                                        | label   |
#      | User Id,User Id                                                             | label   |
#      | Minimum Allowed Period,الحد الأدنى المسموح به للفترة                         | label   |
#      | Maximum Allowed Period For Internal,الحد الأقصى المسموح بها للفترة (للداخل)  | label   |
#      | Maximum Allowed Period For External,الحد الأقصى المسموح بها للفترة (للخارج)  | label   |
#      | Success Code,كود النجاح                                                     | label   |
#      | OTP Expiration Period In Seconds,فترة انتهاء صلاحية OTP بالثواني             | label   |
#      | Allowed Authorization Countries,الدول المسموح لها بالتصريح                  | label   |
#      | Blocker Messages,الرسائل المحظورة                                           | label   |
#      | Blocker With Permission Messages,الرسائل المحظورة مع الاذن                   | label   |
#      | Cancelled Authorization Messages,الرسائل الملغية                            | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.DriverAuthorization.userName.input.byxpath                       | True       | True       |
#      | ejar.DriverAuthorization.password.input.byxpath                       | True       | True       |
#      | ejar.DriverAuthorization.userID.input.byxpath                         | True       | True       |
#      | ejar.DriverAuthorization.minimumAllowedPeriod.input.byxpath           | True       | True       |
#      | ejar.DriverAuthorization.maximumAllowedPeriodInternal.input.byxpath   | True       | True       |
#      | ejar.DriverAuthorization.maximumAllowedPeriodExternal.input.byxpath   | True       | True       |
#      | ejar.DriverAuthorization.successCode.input.byxpath                    | True       | False      |
#      | ejar.DriverAuthorization.otpExpirationPeriod.input.byxpath            | True       | True       |
#      | ejar.DriverAuthorization.allowedAuthorizationCountries.input.byxpath  | True       | True       |
#      | ejar.DriverAuthorization.blockerMessage.input.byxpath                 | True       | False      |
#      | ejar.DriverAuthorization.blockerWithPermission.input.byxpath          | True       | False      |
#      | ejar.DriverAuthorization.cancelledAuthorizationMessages.input.byxpath | True       | False      |
#      | ejar.DriverAuthorization.save.button.byxpath                          | True       | False      |
#      | ejar.DriverAuthorization.cancel.button.byxpath                        | True       | False      |
#    And user click on action with id: ejar.DriverAuthorization.cancel.button.byxpath
#    And verify element present: ejar.DriverAuthorization.action.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Open And Verify Simah Form Then Save It
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And user click on action with id: ejar.Simah.action.byxpath
#    And verify ejar fields label with soft assertion in form: ejar-content-template text: ejar.Simah.labels.text
#    And verify form page labels and text:
#      | Text                                                                        | TagType |
#      | Simah Setting,إعدادات سما                                                   | h1      |
#      | Create Simah Setting,إنشاء اعدادات سما                                      | li      |
#      | Create Simah Setting,إنشاء اعدادات سما                                      | li      |
#      | Ftp Response Path,Ftp Response Path                                         | label   |
#      | Ftp Request Path,Ftp Request Path                                           | label   |
#      | Simah Private Key Local Path,Simah Private Key Local Path                   | label   |
#      | Simah Partner Id,Simah Partner Id                                           | label   |
#      | Simah User Id,Simah User Id                                                 | label   |
#      | Simah Password,Simah Password                                               | label   |
#      | Simah Passphrase,Simah Passphrase                                           | label   |
#      | Simah User name,Simah User name                                             | label   |
#      | Simah Port,Simah Port                                                       | label   |
#      | Simah Host,Simah Host                                                       | label   |
#      | Number of Contracts File,Number of Contracts File                           | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                            | isEditable | isRequired |
#      | ejar.Simah.ftpResponsePath.field.byxpath                              | True       | True       |
#      | ejar.Simah.ftpRequestPath.field.byxpath                               | True       | True       |
#      | ejar.Simah.simahPrivateKeyLocalPath.field.byxpath                     | True       | True       |
#      | ejar.Simah.simahPartnerId.field.byxpath                               | True       | True       |
#      | ejar.Simah.simahPassword.field.byxpath                                | True       | True       |
#      | ejar.Simah.simahPassphrase.field.byxpath                              | True       | True       |
#      | ejar.Simah.simahUsername.field.byxpath                                | True       | True       |
#      | ejar.Simah.simahPort.field.byxpath                                    | True       | True       |
#      | ejar.Simah.simahHost.field.byxpath                                    | True       | True       |
#      | ejar.Simah.noOfContractsPerFile.field.byxpath                         | True       | True       |
#      | ejar.Simah.noOfContractsPerFile.field.byxpath                         | True       | True       |
#      | ejar.Simah.save.button.byxpath                                        | True       | False      |
#      | ejar.Simah.cancel.button.byxpath                                      | True       | False      |
#    And user set in field: ejar.Simah.ftpResponsePath.field.byxpath value: Ftp Response Path
#    And user set in field: ejar.Simah.ftpRequestPath.field.byxpath value: Ftp Request Path
#    And user set in field: ejar.Simah.simahPrivateKeyLocalPath.field.byxpath value: simah Private Key Local Path
#    And user set in field: ejar.Simah.simahPartnerId.field.byxpath value: Simah Partner Id
#    And user set in field: ejar.Simah.simahUserId.field.byxpath value: Simah User Id
#    And user set in field: ejar.Simah.simahPassword.field.byxpath value: Simah Pass
#    And user set in field: ejar.Simah.simahPassphrase.field.byxpath value: Simah Passphrase
#    And user set in field: ejar.Simah.simahUsername.field.byxpath value:  Simah User name
#    And set random number into element: ejar.Simah.simahPort.field.byxpath of size: 4
#    And user set in field: ejar.Simah.simahHost.field.byxpath value: Simah Host
#    And user set in field: ejar.Simah.noOfContractsPerFile.field.byxpath value: 2
#    And user click on action with id: ejar.Simah.save.button.byxpath
#    And verify element present: ejar.Simah.action.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Printing Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-printer-settings-list
#    And user click on action with id: ejar.printing.createnew.button.byxpath
#    And verify ejar fields label with soft assertion in form: printer-configuration text: ejar.printing.labels.label.text
#    And verify form page labels and text:
#      | Text                             | TagType |
#      | Printer Settings,إعدادات الطابعة |  h1     |
#      | Printer Settings,إعدادات الطابعة | span    |
#      | Settings,الإعدادات                |  div    |
#      | Applied On,مطبق على              |  div    |
#      | Template Type,نوع النموذج        | label   |
#      | Template Name ,إسم النموذج       | label   |
#      | Tray,السلة (الحافظة)             | label   |
#      | Copies,رقم النسخ                 | label   |
#      | Orientation ,التوجيه             | label   |
#      | Printer,الطابعة                  | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.printing.tempType.field.edit.byxpath                        | True       | True       |
#      | ejar.printing.tempName.field.edit.byxpath                        | True       | True       |
#      | ejar.printing.tray.field.edit.byxpath                            | True       | True       |
#      | ejar.printing.copy.field.edit.byxpath                            | True       | True       |
#      | ejar.printing.printerorientations.field.edit.byxpath             | True       | True       |
#      | ejar.printing.printername.field.edit.byxpath                     | True       | False      |
#      | ejar.printing.next.button.byxpath                                | False      | False      |
#      | ejar.printing.cancel.button.byxpath                              | True       | False      |
#      | ejar.printing.save.button.byxpath                                | False      | False      |
#    And set random text into element: ejar.printing.tempName.field.byxpath with size: 10 and initial string: UI Automation Printing Template Name
#    And user set in field: ejar.printing.tray.field.byxpath value: 1
#    And user set in field: ejar.printing.copy.field.byxpath value: 1
#    And select option in ejar kendo option field: ejar.printing.printerorientations.field.byxpath by index: 1
#    And user click on action with id: ejar.printing.next.button.byxpath
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                             | isEditable | isRequired |
#      | ejar.printing.back.button.byxpath                      | True       | False      |
#      | ejar.printing.save.button.byxpath                      | False      | False      |
#    And user click on action with xpath: //span[contains(.,'جميع') or contains(.,'All')]/preceding-sibling::span
#    And user click on action with xpath: //ul[@kendotreeviewgroup]//span[contains(.,'السعودية') or contains(.,'Saudi Arabia')]//preceding::input[1]
#    And user click on action with id: ejar.printing.cancel.button.byxpath
#
#  @TestType-Smoke
#  Scenario: Create And Verify Notification Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-notifications
#    And user click on action with id: ejar.notifications.createnew.button.byxpath
#    And user select value in drop down field: ejar.notifications.type.field.byxpath by option text: Vehicle Color Changed, تم تغير لون المركبه
#    And user click on action with id: ejar.notifications.addChannel.button.byxpath
#    And verify ejar fields label with soft assertion in form: createoreditejarnotification text: ejar.notifications.alllabels.label.text
#    And verify form page labels and text:
#      | Text                                           | TagType |
#      | Create New Notification,إضافة تنبيه            | span    |
#      | Type,النوع                                     | label   |
#      | Is Active,فعال                                 | span    |
#      | Channel,الوسيله                                | span    |
#      | Excluded Countries,الدول المستثناه             | span    |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.notifications.type.field.byxpath                            | True       | True       |
#      | ejar.notifications.active.field.byxpath                          | True       | False      |
#      | ejar.notifications.channels.field.byxpath                        | True       | True       |
#      | ejar.notifications.excludedcountries.field.byxpath               | True       | False      |
#      | ejar.notifications.save.channel.button.byxpath                   | True       | False      |
#      | ejar.notifications.cancel.button.byxpath                         | True       | False      |
#      | ejar.notifications.cancelform.button.byxpath                     | True       | False      |
#      | ejar.notifications.saveform.button.edit.byxpath                  | False      | False      |
#    And user select value in drop down field: ejar.notifications.channels.field.byxpath by option text: SMS,رساله
#    And user click on action with id: ejar.notifications.save.channel.button.byxpath
#    And user click on action with id: ejar.notifications.saveform.button.byxpath
#    And click on action if exist: ejar.notifications.duplicatedType.Close.button.byxpath
#    And click on action if exist: ejar.notifications.cancelform.button.byxpath
#    And filter view on column name: Type,النوع and enter value: Vehicle Color Changed, تم تغير لون المركبه
#    And user click on view action: Edit,تعديل  related to record with text: Vehicle Color Changed, تم تغير لون المركبه  then select record at index: 1
#    And user click on action with id: ejar.notifications.active.byxpath
#    And user click on action with id: ejar.notifications.saveform.button.byxpath
#    And click on action if exist: ejar.notifications.duplicatedType.Close.button.byxpath
#    And click on action if exist: ejar.notifications.cancelform.button.byxpath
#
#  @TestType-Smoke
#  Scenario: Open Identity Setting Form And Save It
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/ejar-country-settings
#    And user click on action with xpath: //app-country-settings//button//span[contains(.,'Save') or contains(.,'حفظ') or contains(.,'حـفظ') ]
#
#  @TestType-Smoke
#  Scenario: Create and verify Soft Pos Mapping form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/pos-device-configuration
#    And user click on action with id: ejar.SoftPOSMapping.createnew.action.byxpath
#    And verify ejar fields label with soft assertion in form: create-or-edit-pos-device-configuration-modal text: ejar.SoftPOSMapping.labels.text
#    And verify form page labels and text:
#      | Text                                                                  | TagType |
#      | Add New Soft POS,إضافة نقطة بيع افتراضية                              |  span   |
#      | Soft POS Id,رقم تعريف نقطة البيع الافتراضية                            |  label  |
#      | POS Provider,مزود نقطة البيع                                          |  label  |
#      | Is Active,فعال                                                        |  span   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                       | isEditable | isRequired |
#      | ejar.SoftPOSMapping.posProvider.field.edit.byxpath               | True       | True       |
#      | ejar.SoftPOSMapping.posProvider.field.edit.byxpath               | True       | True       |
#      | ejar.SoftPOSMapping.isActive.field.byxpath                       | True       | False      |
#      | ejar.SoftPOSMapping.save.action.byxpath                          | False      | False      |
#      | ejar.SoftPOSMapping.cancel.action.byxpath                        | True       | False      |
#    And set random number into element: ejar.SoftPOSMapping.softPosId.field.byxpath with size: 10 and store value in variable: softPos
#    And select option in ejar kendo option field: ejar.SoftPOSMapping.posProvider.field.byxpath by index: 1
#    And user click on action with id: ejar.SoftPOSMapping.save.action.byxpath
#    And wait for element not present: ejar.regions.savedsuccessfully.byxpath
#    And filter view on column name: Soft POS Id,رقم تعريف نقطة البيع الافتراضية and enter value stored in variable: softPos
#    And filter view on column name: Soft POS Id,رقم تعريف نقطة البيع الافتراضية and enter value stored in variable: softPos
#    And click on element: ejar.SoftPOSMapping.delete.button.byxpath
#
#
#  @TestType-Smoke
#  Scenario: Create And Verify Tax Form
#    Given user open ejar project url
#    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
#    And click on link: ejar.taxconfigurations.tax.button.byxpath
#    And click on link: ejar.tax.create.add.byxpath
#    And verify ejar fields label with soft assertion in form: tax-configurations-details text: ejar.tax.alllabels.label.text
#    And verify form page labels and text:
#      | Text                                              | TagType |
#      | Tax Configurations,إعدادات الضريبة                |  h1     |
#      | Manage Tax Configurations,ادارة اعداديات الضريبة  | span    |
#      | Basic information,المعلومات الأساسية               | li      |
#      | Name [en],الاسـم [en]                              | label   |
#      | Name [ar],الاسـم [ar]                              | label   |
#      | Country,الدولة                                    | label   |
#      | Start Date,وقت البداية                            | label   |
#      | Tax Type,نوع الضريبة                              | label   |
#      | Items,سجل                                         | h6      |
#      | Item,بند                                          | th      |
#      | Tax %,الضريبة %                                   | th      |
#      | VAT on leasing contract,الضريبة على العقود السنوية| h6      |
#      | Exemption Period,فترة الاعفاء                      | span    |
#      | Start Date,وقت البداية                            | label   |
#      | End Date,وقت النهاية                              | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                  | isEditable | isRequired |
#      | ejar.tax.nameEN.field.edit.byxpath          | True       | True       |
#      | ejar.tax.nameAR.field.edit.byxpath          | True       | True       |
#      | ejar.tax.country.field.read.byxpath         | False      | False      |
#      | ejar.tax.startDate.field.edit.byxpath       | True       | True       |
#      | ejar.tax.taxType.field.edit.byxpath         | True       | True       |
#      | ejar.tax.exemptionPeriod.field.edit.byxpath | True       | False      |
#      | ejar.tax.vatStartDate.field.edit.byxpath    | True       | False      |
#      | ejar.tax.vatEndDate.field.edit.byxpath      | True       | False      |
#      | ejar.tax.create.button.edit.byxpath         | False      | False      |
#      | ejar.tax.cancel.button.byxpath              | True       | False      |
#      | ejar.tax.definetaxes.button.byxpath         | True       | False      |
#    And set random text in variable and into element: ejar.tax.nameEN.field.edit.byxpath with size: 5 and initial string: UI Automation Tax and store value in variable: taxName
#    And set value into field: ejar.tax.nameAR.field.edit.byxpath from stored variable: taxName
#    And user select date in ejar calendar field: ejar.tax.startDate.field.input.byxpath plus days: 5
#    And user select value in drop down field: ejar.tax.taxType.field.edit.byxpath by index: 1
#    And click on link: ejar.tax.definetaxes.button.byxpath
#    And verify form page labels and text:
#      | Text                                                                    | TagType |
#      | Items,سجل                                                               |  span   |
#      | Items,سجل                                                               |  h4     |
#      | Define Taxes on Contract Items,تحديد الضرائب على بنود العقد             |  p      |
#      | Tax Configurations,إعدادات الضريبة                                      |  h1     |
#      | Tax Configurations,إعدادات الضريبة                                      |  h1     |
#      | Item,بند                                                                |  div    |
#      | Tax %,الضريبة %                                                         |  div    |
#      | Trip Days,ايام الرحلة                                                   |  label  |
#      | Extra Hours,الساعات الزائدة                                             |  label  |
#      | Transfer Cost,رسوم الشحن                                                |  label  |
#      | Fuel Cost,تكلفة الوقود                                                  |  label  |
#      | Traffic Violation,مخالفات                                               |  label  |
#      | Extra Km,الكيلومتر الزائد                                               |  label  |
#      | Booking Penalty,غرامة الغاء/انتهاء الحجز                                |  label  |
#      | Baby Seat,مقعد طفل رضيع                                                 |  label  |
#      | Insurance Fees,رسوم تأمين                                               |  label  |
#      | Insurance Fees +,+ رسوم تأمين                                           |  label  |
#      | Open KM,كم مفتوح                                                        |  label  |
#      | GPS,نظام ملاحة                                                           |  label  |
#      | Parking Fees,رسوم المواقف                                               |  label  |
#      | Tolls,رسوم الطرق                                                        |  label  |
#      | Internal Authorization,تفويض داخلى                                      |  label  |
#      | Unlimited Tolls,رسوم سالك بلا حدود                                       |  label  |
#      | Damages Cost,تكلفة التلفيات                                             |  label  |
#      | Accident Cost,تكلفة الحادث                                              |  label  |
#      | Trip Months,شهور الرحلة                                                 |  label  |
#      | Early Return Penalty,غرامة ارجاع مبكر                                   |  label  |
#      | Filling Fuel Fees,رسوم إعادة تعبئة الوقود                               |  label  |
#      | Other Charges,رسوم أخرى                                                 |  label  |
#      | Refund Online Payment Fees,رسوم رديات دفع الكتروني                      |  label  |
#      | Other Charges (Without VAT),رسوم أخرى (بدون ضريبه)                      |  label  |
#      | External Authorization,تفويض خارجى                                      |  label  |
#      | Non Refunded,الغير مصروف                                                |  label  |
#      | Advance Payment,دفعه مقدمه                                              |  label  |
#      | Leasing Extras (In Month),إضافات العقود السنوية (بالشهر)                |  label  |
#      | Leasing Extras (In Days),إضافات العقود السنوية (باليوم)                 |  label  |
#      | Out Side Branch Border,غرامة ارجاع خارج حدود الفرع                      |  label  |
#      | Out City Estimation,تقدير إغلاق العقد خارج حدود المدينة                  |  label  |
#      | Child Seat,مقعد طفل                                                     |  label  |
#      | Chauffeur,سائق خاص                                                      |  label  |
#      | Additional Driver,سائق اضافي                                            |  label  |
#      | Collision Damage Waiver,التنازل عن اضرار الحادث                         |  label  |
#      | Contract Creation or Extension Fees,رسوم إبرام أو تمديد العقد           |  label  |
#      | Super Liability Protection,تغطية فائقة للمسؤولية                        |  label  |
#      | Theft Protection,تأمين ضد السرقة                                        |  label  |
#      | Super Theft Protection,تأمين فائق ضد السرقة                             |  label  |
#      | Tires & Windshield Protection,تأمين الإطارات والزجاج الأمامي              |  label  |
#      | Collision Damage Waiver Inclusive,تأمين التصادم                         |  label  |
#      | Roadside Assistance Protection,تغطية المساعدة الطارئة على الطريق        |  label  |
#      | Rate Difference for Extension/Late Return,فرق السعر عند التمديد/التأخير |  label  |
#      | Refueling Service,خدمة تعبئة الوقود                                     |  label  |
#      | Foreign Use,استخدام خارجي                                               |  label  |
#      | Snow Chains,سلاسل الثلج                                                  |  label  |
#      | Magnetic Ski Rack,حامل زلاجات مغناطيسي                                   |  label  |
#      | Trip Hours,ساعات الرحلة                                                 |  label  |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                                     | isEditable | isRequired |
#      | ejar.tax.defineTripDays.field.edit.byxpath                     | True       | False      |
#      | ejar.tax.defineExtraHours.field.edit.byxpath                   | True       | False      |
#      | ejar.tax.defineTransferCost.field.edit.byxpath                 | True       | False      |
#      | ejar.tax.defineFuelCost.field.edit.byxpath                     | True       | False      |
#      | ejar.tax.defineTrafficViolation.field.edit.byxpath             | True       | False      |
#      | ejar.tax.defineExtraKm.field.edit.byxpath                      | True       | False      |
#      | ejar.tax.defineBookingPenalty.field.edit.byxpath               | True       | False      |
#      | ejar.tax.defineBabySeat.field.edit.byxpath                     | True       | False      |
#      | ejar.tax.defineInsuranceFees.field.edit.byxpath                | True       | False      |
#      | ejar.tax.defineInsuranceFeesP.field.edit.byxpath               | True       | False      |
#      | ejar.tax.defineOpenKM.field.edit.byxpath                       | True       | False      |
#      | ejar.tax.defineGPS.field.edit.byxpath                          | True       | False      |
#      | ejar.tax.defineParkingFees.field.edit.byxpath                  | True       | False      |
#      | ejar.tax.defineTolls.field.edit.byxpath                        | True       | False      |
#      | ejar.tax.defineInternalAuthorization.field.edit.byxpath        | True       | False      |
#      | ejar.tax.defineUnlimitedTolls.field.edit.byxpath               | True       | False      |
#      | ejar.tax.defineDamagesCost.field.edit.byxpath                  | True       | False      |
#      | ejar.tax.defineAccidentCost.field.edit.byxpath                 | True       | False      |
#      | ejar.tax.defineTripMonths.field.edit.byxpath                   | True       | False      |
#      | ejar.tax.defineEarlyReturnPenalty.field.edit.byxpath           | True       | False      |
#      | ejar.tax.defineFillingFuelFees.field.edit.byxpath              | True       | False      |
#      | ejar.tax.defineOtherCharges.field.edit.byxpath                 | True       | False      |
#      | ejar.tax.defineRefundOnlineFees.field.edit.byxpath             | True       | False      |
#      | ejar.tax.defineOtherChargesNoVAT.field.edit.byxpath            | True       | False      |
#      | ejar.tax.defineExternalAuth.field.edit.byxpath                 | True       | False      |
#      | ejar.tax.defineNonRefunded.field.edit.byxpath                  | True       | False      |
#      | ejar.tax.defineAdvancePayment.field.edit.byxpath               | True       | False      |
#      | ejar.tax.defineLeasingExtrasMonth.field.edit.byxpath           | True       | False      |
#      | ejar.tax.defineLeasingExtrasDays.field.edit.byxpath            | True       | False      |
#      | ejar.tax.defineOutBranchBorder.field.edit.byxpath              | True       | False      |
#      | ejar.tax.defineOutCityEstimation.field.edit.byxpath            | True       | False      |
#      | ejar.tax.defineChildSeat.field.edit.byxpath                    | True       | False      |
#      | ejar.tax.defineChauffeur.field.edit.byxpath                    | True       | False      |
#      | ejar.tax.defineAdditionalDriver.field.edit.byxpath             | True       | False      |
#      | ejar.tax.defineCollisionWaiver.field.edit.byxpath              | True       | False      |
#      | ejar.tax.defineContractFees.field.edit.byxpath                 | True       | False      |
#      | ejar.tax.defineSuperLiability.field.edit.byxpath               | True       | False      |
#      | ejar.tax.defineTheftProtection.field.edit.byxpath              | True       | False      |
#      | ejar.tax.defineSuperTheftProtection.field.edit.byxpath         | True       | False      |
#      | ejar.tax.defineTiresProtection.field.edit.byxpath              | True       | False      |
#      | ejar.tax.defineCollisionInclusive.field.edit.byxpath           | True       | False      |
#      | ejar.tax.defineRoadsideAssistance.field.edit.byxpath           | True       | False      |
#      | ejar.tax.defineRateDiffExtension.field.edit.byxpath            | True       | False      |
#      | ejar.tax.defineRefuelingService.field.edit.byxpath             | True       | False      |
#      | ejar.tax.defineForeignUse.field.edit.byxpath                   | True       | False      |
#      | ejar.tax.defineSnowChains.field.edit.byxpath                   | True       | False      |
#      | ejar.tax.defineSkiRack.field.edit.byxpath                      | True       | False      |
#      | ejar.tax.defineTripHours.field.edit.byxpath                    | True       | False      |
#      | ejar.tax.define.button.field.edit.byxpath                      | True       | False      |
#      | ejar.tax.cancel.button.field.edit.byxpath                      | True       | False      |
#    And click on element: ejar.tax.cancel.button.field.edit.byxpath
#    And click on element: ejar.tax.create.button.byxpath
#    And click on element: ejar.generic.yes.action.byxpath
#    And filter view on column name: Name,الاسـم and enter value stored in variable: taxName
#    And click on element: ejar.tax.firstRow.a.byxpath
#
#    And verify form page labels and text:
#      | Text                                              | TagType |
#      | Tax Configurations,إعدادات الضريبة                |  h1     |
#      | Manage Tax Configurations,ادارة اعداديات الضريبة  | span    |
#      | Basic information,المعلومات الأساسية               | li      |
#      | Name [en],الاسـم [en]                              | label   |
#      | Name [ar],الاسـم [ar]                              | label   |
#      | Country,الدولة                                    | label   |
#      | Start Date,وقت البداية                            | label   |
#      | Tax Type,نوع الضريبة                              | label   |
#      | Items,سجل                                         | h6      |
#      | Item,بند                                          | th      |
#      | Tax %,الضريبة %                                   | th      |
#      | VAT on leasing contract,الضريبة على العقود السنوية| h6      |
#      | Exemption Period,فترة الاعفاء                      | span    |
#      | Start Date,وقت البداية                            | label   |
#      | End Date,وقت النهاية                              | label   |
#    And verify form page fields, field editable and required statuses:
#      | fieldXpath                                  | isEditable | isRequired |
#      | ejar.tax.nameEN.field.read.byxpath          | False      | False      |
#      | ejar.tax.nameAR.field.read.byxpath          | False      | False      |
#      | ejar.tax.country.field.read.byxpath         | False      | False      |
#      | ejar.tax.startDate.field.read.byxpath       | False      | False      |
#      | ejar.tax.taxType.field.read.byxpath         | False      | False      |
#      | ejar.tax.exemptionPeriod.field.read.byxpath | False      | False      |
#      | ejar.tax.vatStartDate.field.read.byxpath    | False      | False      |
#      | ejar.tax.vatEndDate.field.read.byxpath      | False      | False      |
#      | ejar.generic.cancel.action.byxpath          | True       | False      |
#      | ejar.tax.copy.button.byxpath                | True       | False      |
#      | ejar.tax.delete.button.byxpath              | True       | False      |
#    And click on element: ejar.tax.delete.button.byxpath
#    And click on element: ejar.generic.yes.action.byxpath
#    And wait for element present: ejar.tax.create.add.byxpath for period in seconds: 120
#

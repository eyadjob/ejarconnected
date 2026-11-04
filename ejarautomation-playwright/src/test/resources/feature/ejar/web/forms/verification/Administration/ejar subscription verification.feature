Feature: Subscription Profile Verification

  @TestType-Smoke
  Scenario: Subscription form verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/admin/subscription-management
    And wait for element present: ejar.subscription.subscription-information.linklabel.byxpath for period in seconds: 200
    And verify form page labels and text:
      | Text                                                      | TagType |
      | Subscription,الاشتراكات                                    |  h1     |
      | Subscription information,معلومات الاشتراك                  | span    |
      | Payment history,سجل الدفعات                               | span    |
      | Subscription start date,تاريخ بدء الاشتراك                 | small   |
      | Subscription end date,تاريخ انتهاء الاشتراك                | small   |
      | What's included in your plan,What's included in your plan | small   |
    And verify form page fields, field editable and required statuses:
      | fieldXpath                                                       | isEditable | isRequired |
      |ejar.subscription.subscription-information.linklabel.byxpath      | True       | False      |
    And click on link: ejar.subscription.subscription-information.linklabel.byxpath
    And verify table header: ejar.subscription.tableheaders.label.byxpath with text: ejar.subscription.tableheaders.label.text

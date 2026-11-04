Feature: Login Validation

  @TestType-Smoke
  Scenario: login with valid credentials
    Given user open page using url: https://ejar-jor-test.iyelo.com:4900/
    And user click on action with id: ejar.loginpage.changetenantlink.byxpath
    And user click on action with id: ejar.loginpage.switchtotenant.checkbox.byxpath
    And user set in field: ejar.loginpage.tenantnamenew.byxpath value: Default
    And user click on action with id: ejar.loginpage.tenantsumitbuttonnew.byxpath
    And user set in field: ejar.loginpage.username.byxpath value: admin2
    And wait for number of seconds: 1
    And user set in field: ejar.loginpage.password.byxpath value: 123456
    And wait for number of seconds: 5
    And user click on action with id: ejar.loginpage.loginaction.byxpath
    And wait for element not present: ejar.loginpage.username.byxpath
    And wait for element present: ejar.dashboard.menu.title.byxpath for period in seconds: 240
    Then verify page that contains url is displayed: /app/main/fleet-dashboard
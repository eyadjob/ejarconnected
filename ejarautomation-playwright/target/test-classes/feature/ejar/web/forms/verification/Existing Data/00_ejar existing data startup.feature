Feature:Startup for Existing Data Verification

  @TestType-Smoke
  Scenario: startup for existing data
    Given user open ejar project url
    Given ejar open url and login with tenant: ejar and user name: ejaradmin and password: 123456 url: /app/admin/ejar-settings/operational-countries
    And click on element: ejar.countrysettingsaudi.countrysettings.i.byxpath
    And user select value in drop down field: ejar.existingstart.fuelSetting.byxpath by option text: 0%,0%
    And set value into element : ejar.existingstart.minKm.byxpath value: 0
    And set value into element : ejar.existingstart.maxKM.byxpath value: 900000000
    And user select value in drop down field: ejar.existingstart.odometerConfirmation.byxpath by option text: Off,ايقاف
    And ensure checkbox is unchecked with id: ejar.existingstart.fuelIntegration.byxpath
    And ensure checkbox is unchecked with id: ejar.existingstart.invoiceIntegration.byxpath
    And set value into element : ejar.existingstart.maxNumOfBookings.byxpath value: 500
    And set value into element : ejar.existingstart.hoursAllowedBeforePickup1.byxpath value: 999
    And set value into element : ejar.existingstart.hoursAllowedBeforePickup2.byxpath value: 999
    And remove attribute for element: ejar.countrysettings.save.button.byxpath attribute: disabled
    And click on element: ejar.countrysettings.save.button.byxpath
    And wait for element present: ejar.countrysettingsaudi.savingdone.h1.byxpath for period in seconds: 100
    And open page using url: /app/fleet-management/branches
    And filter view on column name: Name,الاسم and enter value:Automation Branch,Automation Branch
    And click on element: ejar.existingstart.branchDots.button.byxpath
    And click on element: ejar.existingstart.branchSettings.button.byxpath
    And ensure checkbox is unchecked with id: ejar.existingstart.enableTajeer.checkbox.byxpath
    And ensure checkbox is unchecked with id: ejar.existingstart.enableInsurance.checkbox.byxpath
    And ensure checkbox is checked with id: ejar.existingstart.embeddedEcheck.checkbox.byxpath
    And remove attribute for element: ejar.existingstart.saveBranchSettings.button.byxpath attribute: disabled
    And click on element: ejar.existingstart.saveBranchSettings.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.branches.createnew.byxpath for period in seconds: 100

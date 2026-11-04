Feature: Fleet View Verification

  @TestType-Regression
  Scenario: vehicles view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles
    And verify ejar view title text: ejar.vehicle.view.title.label.text
    And verify ejar view sub title text: ejar.vehicle.view.subtitle.label.text
    And verify ejar buttons label in view: Vehicles,المركبات text: ejar.vehicle.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Vehicles,المركبات text: ejar.vehicle.view.secondary.bar.actions.label.text
    And verify ejar view: Vehicles,المركبات table headers: ejar.vehicle.view.table.headers.text
    And verify ejar view: Vehicles,المركبات table headers with filter: ejar.vehicle.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.vehicles.uplopadbulk.action.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And user click on action with id: ejar.vehicles.customerServicePeriod.action.byxpath
    And user click on action with id: ejar.vehicles.cancelserviceperiod.byxpath
    And user click on action with id: ejar.vehicles.ExecutePreventiveMaintenance.action.byxpath
    And user click on action with id: ejar.vehicles.ExecutePreventiveMaintenance.close.action.byxpath
    And user click on action with id: ejar.vehicles.UpdateVehicleDocuments.action.byxpath
    And user click on action with id: ejar.vehicles.UpdateVehicleDocuments.cancel.action.byxpath
    And user click on action with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: maintenance vehicles view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/maintenance
    And verify ejar view title text: ejar.maintenance.vehicle.view.title.label.text
    And verify ejar view sub title text: ejar.maintenance.vehicle.view.subtitle.label.text
    And verify ejar fields label in view: Maintenance Vehicles,مركبات الصيانة text: ejar.maintenance.vehicle.view.fields.label.text
    And verify ejar buttons label in view: Maintenance Vehicles,مركبات الصيانة text: ejar.maintenance.vehicle.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Maintenance Vehicles,مركبات الصيانة text: ejar.maintenance.vehicle.view.secondary.bar.actions.label.text
    And verify ejar view: Maintenance Vehicles,مركبات الصيانة table headers: ejar.maintenance.vehicle.view.table.headers.text
    And verify ejar view: Maintenance Vehicles,مركبات الصيانة table headers with filter: ejar.maintenance.vehicle.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: expenses view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/expenses
    And verify ejar view title text: ejar.expenses.view.title.label.text
    And verify ejar view sub title text: ejar.expenses.view.subtitle.label.text
    And verify ejar fields label in view: Expenses,المصاريف text: ejar.expenses.view.fields.label.text
    And verify ejar buttons label in view: Expenses,المصاريف text: ejar.expenses.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Expenses,المصاريف text: ejar.expenses.view.secondary.bar.actions.label.text
    And verify ejar view: Expenses,المصاريف table headers: ejar.expenses.view.table.headers.text
    And verify ejar view: Expenses,المصاريف table headers with filter: ejar.expenses.view.table.headers.with.filter.text
    And click on element: ejar.expenses.view.addExpenses.button.byxpath
    And click on element if exist: ejar.generic.popupok.action.byxpath with wait: 2
    And click on element if exist: ejar.expenses.view.cancelModal.button.byxpath with wait: 1
    And verify element present: ejar.expenses.view.fromDate.datepicker.byxpath
    And verify element present: ejar.expenses.view.toDate.datepicker.byxpath
    And verify element present: ejar.expenses.view.branch.select.byxpath
    And verify element present: ejar.expenses.view.plateNumber.select.byxpath
    And click on element: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And click on element: ejar.expenses.view.search.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And click on element: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible



  @TestType-Regression
  Scenario: electronic check view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/e-check-list
    And verify ejar view title text: ejar.electronic.view.title.label.text
    And verify ejar fields label in view: E-Check,التفقد الالكتروني text: ejar.electronic.check.view.fields.label.text
    And verify ejar buttons label in view: E-Check,التفقد الالكتروني text: ejar.electronic.check.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: E-Check,التفقد الالكتروني text: ejar.electronic.check.view.secondary.bar.actions.label.text
    And verify ejar view: E-Check,التفقد الالكتروني table headers: ejar.electronic.check.view.table.headers.text
    And verify ejar view: E-Check,التفقد الالكتروني table headers with filter: ejar.electronic.check.view.table.headers.with.filter.text
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: receive vehicle view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/transfer
    And verify ejar view title text: ejar.receive.vehicle.view.title.label.text
    And verify ejar view sub title text: ejar.receive.vehicle.view.subtitle.label.text
    And verify ejar fields label in view: Receive Vehicle,استلام المركبات text: ejar.receive.vehicle.view.fields.label.text
    And verify ejar buttons label in view: Receive Vehicle,استلام المركبات text: ejar.receive.vehicle.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Receive Vehicle,استلام المركبات text: ejar.receive.vehicle.view.secondary.bar.actions.label.text
    And verify ejar view: Receive Vehicle,استلام المركبات table headers: ejar.receive.vehicle.view.table.headers.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Branches view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/branches
    And verify ejar view title text: ejar.branches.view.title.label.text
    And verify ejar view sub title text: ejar.branches.view.subtitle.label.text
    And verify ejar fields label in view: Branches,الفروع text: ejar.branches.view.fields.label.text
    And verify ejar view secondary bar buttons in view: Branches,الفروع text: ejar.branches.view.secondary.bar.actions.label.text
    And verify ejar view: Branches,الفروع table headers: ejar.branches.view.table.headers.text
    And verify ejar view: Branches,الفروع table headers with filter: ejar.branches.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.branches.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.createnewparking.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.createnewworkShop.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.createnewsellcenter.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: traffic violations view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/traffic-violations
    And verify ejar view title text: ejar.traffic.violations.view.title.label.text
    And verify ejar view sub title text: ejar.traffic.violations.view.subtitle.label.text
    And verify ejar fields label in view: Traffic Violations,المخالفات text: ejar.traffic.violations.view.fields.label.text
    And verify ejar buttons label in view: Traffic Violations,المخالفات text: ejar.traffic.violations.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Traffic Violations,المخالفات text: ejar.traffic.violations.view.secondary.bar.actions.label.text
    And verify ejar view: Traffic Violations,المخالفات table headers: ejar.traffic.violations.view.table.headers.text
    And verify ejar view: Traffic Violations,المخالفات table headers with filter: ejar.traffic.violations.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on action if exist: ejar.CreateTrafficViolations.CancelExport.button.byxpath
    And click on link: ejar.CreateTrafficViolations.action.byxpath
    And user click on action with id: ejar.CreateTrafficViolations.Cancel.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: accidents view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/accidents
    And verify ejar view title text: ejar.accidents.view.title.label.text
    And verify ejar view sub title text: ejar.accidents.view.subtitle.label.text
    And verify ejar fields label in view: Accidents,الحوادث text: ejar.accidents.view.fields.label.text
    And verify ejar buttons label in view: Accidents,الحوادث text: ejar.accidents.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Accidents,الحوادث text: ejar.accidents.view.secondary.bar.actions.label.text
    And verify ejar view: Accidents,الحوادث table headers: ejar.accidents.view.table.headers.text
    And verify ejar view: Accidents,الحوادث table headers with filter: ejar.accidents.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.action.byxpath
    And user click on action with id: ejar.generic.advancedsearch.close.action.byxpath
    And click on link: ejar.accident.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: transfer report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/transfer-report
    And verify ejar fields count in the opened report view: 6
    And verify ejar fields label in the opened report view: ejar.fleet.transfer.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Difference in the km report page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/missing-km-report
    And verify ejar fields count in the opened report view: 4
    And verify ejar fields label in the opened report view: ejar.fleet.differenceinthekm.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Check Types view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/check-types
    And verify ejar view title text: ejar.checktypes.view.title.label.text
    And verify ejar view sub title text: ejar.checktypes.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Check Types,أنواع التفقدات text: ejar.checktypes.view.secondary.bar.actions.label.text
    And verify ejar view: Check Types,أنواع التفقدات table headers: ejar.checktypes.view.table.headers.text
    And verify ejar view: Check Types,أنواع التفقدات table headers with filter: ejar.checktypes.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Check Items view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/check-items
    And verify ejar view title text: ejar.checkitems.view.title.label.text
    And verify ejar view sub title text: ejar.checkitems.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Check Items,عناصر التفقد text: ejar.checkitems.view.secondary.bar.actions.label.text
    And verify ejar view: Check Items,عناصر التفقد table headers: ejar.checkitems.view.table.headers.text
    And verify ejar view: Check Items,عناصر التفقد table headers with filter: ejar.checkitems.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.checkitem.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Checklists view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/check-lists
    And verify ejar view title text: ejar.checklists.view.title.label.text
    And verify ejar view sub title text: ejar.checklists.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Checklists,قوائم التفقد text: ejar.checklists.view.secondary.bar.actions.label.text
    And verify ejar view: Checklists,قوائم التفقد table headers: ejar.checklists.view.table.headers.text
    And verify ejar view: Checklists,قوائم التفقد table headers with filter: ejar.checklists.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And click on link: ejar.checklist.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Damage Types view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/damage-types
    And verify ejar view title text: ejar.damagetypes.view.title.label.text
    And verify ejar view sub title text: ejar.damagetypes.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Damage Types,أنواع التلفيات text: ejar.damagetypes.view.secondary.bar.actions.label.text
    And verify ejar view: Damage Types,أنواع التلفيات table headers: ejar.damagetypes.view.table.headers.text
    And verify ejar view: Damage Types,أنواع التلفيات table headers with filter: ejar.damagetypes.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Skeleton view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/skeleton
    And verify ejar view title text: ejar.skeleton.view.title.label.text
    And verify ejar view sub title text: ejar.skeleton.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Skeleton,الرسم الكروكى text: ejar.skeleton.view.secondary.bar.actions.label.text
    And verify ejar view: Skeleton,الرسم الكروكى table headers: ejar.skeleton.view.table.headers.text
    And verify ejar view: Skeleton,الرسم الكروكى table headers with filter: ejar.skeleton.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Spare Parts view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/spare-parts
    And verify ejar view title text: ejar.spareparts.view.title.label.text
    And verify ejar view secondary bar buttons in view: Spare Parts,قطع الغيار text: ejar.spareparts.view.secondary.bar.actions.label.text
    And verify ejar view: Spare Parts,قطع الغيار table headers: ejar.spareparts.view.table.headers.text
    And verify ejar view: Spare Parts,قطع الغيار table headers with filter: ejar.spareparts.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.createsparepart.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Wages view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/wages
    And verify ejar view title text: ejar.wages.view.title.label.text
    And verify ejar view secondary bar buttons in view: Wages,أجور text: ejar.wages.view.secondary.bar.actions.label.text
    And verify ejar view: Wages,أجور table headers: ejar.wages.view.table.headers.text
    And verify ejar view: Wages,أجور table headers with filter: ejar.wages.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.wage.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario:  Repair Tasks view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/repair-tasks
    And verify ejar view title text: ejar.repairtasks.view.title.label.text
    And verify ejar view sub title text: ejar.repairtasks.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Repair Tasks,مهام الاصلاح text: ejar.repairtasks.view.secondary.bar.actions.label.text
    And verify ejar view: Repair Tasks,مهام الاصلاح table headers: ejar.repairtasks.view.table.headers.text
    And verify ejar view: Repair Tasks,مهام الاصلاح table headers with filter: ejar.repairtasks.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.createRepairTask.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario:  Skeleton Bodies view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/skeleton-bodies
    And verify ejar view title text: ejar.skeletonbodies.view.title.label.text
    And verify ejar view sub title text: ejar.skeletonbodies.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Skeleton Bodies,هياكل السيارة text: ejar.skeletonbodies.view.secondary.bar.actions.label.text
    And verify ejar view: Skeleton Bodies,هياكل السيارة table headers: ejar.skeletonbodies.view.table.headers.text
    And verify ejar view: Skeleton Bodies,هياكل السيارة table headers with filter: ejar.skeletonbodies.view.table.headers.with.filter.text
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Spare Part Costs view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/spare-parts-Tariff
    And verify ejar view title text: ejar.sparepartcosts.view.title.label.text
    And verify ejar fields label in view: Spare Part Costs,تكاليف قطع الغيار text: ejar.sparepartcosts.view.fields.label.text
    And verify ejar buttons label in view: Spare Part Costs,تكاليف قطع الغيار text: ejar.sparepartcosts.view.buttons.label.text
    And verify ejar view secondary bar buttons in view: Spare Part Costs,تكاليف قطع الغيار text: ejar.sparepartcosts.view.secondary.bar.actions.label.text
    And verify ejar view: Spare Part Costs,تكاليف قطع الغيار table headers: ejar.sparepartcosts.view.table.headers.text
    And verify ejar view: Spare Part Costs,تكاليف قطع الغيار table headers with filter: ejar.sparepartcosts.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.sparepartcost.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.sparepartcost.upload.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Wage Costs view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/e-check/wageTariffs
    And verify ejar view title text: ejar.wagecosts.view.title.label.text
    And verify ejar fields label in view: Wage Costs,تكاليف الاجور text: ejar.wagecosts.view.fields.label.text
    And verify ejar view secondary bar buttons in view: Wage Costs,تكاليف الاجور text: ejar.wagecosts.view.secondary.bar.actions.label.text
    And verify ejar view: Wage Costs,تكاليف الاجور table headers: ejar.wagecosts.view.table.headers.text
    And verify ejar view: Wage Costs,تكاليف الاجور table headers with filter: ejar.wagecosts.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And click on link: ejar.wageCost.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

#########################
  @TestType-Regression
  Scenario: Working Hours Templates view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/rental/administration/working-hours-templates
    And verify ejar view title text: ejar.workinghourstemplatess.view.title.label.text
    And verify ejar view sub title text: ejar.workinghourstemplatess.view.subtitle.label.text
    And verify ejar view: Working Hours Templates,نماذج ساعات العمل table headers: ejar.workinghourstemplatess.view.table.headers.text
    And verify ejar view: Working Hours Templates,نماذج ساعات العمل table headers with filter: ejar.workinghourstemplatess.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.workinghourstemplates.export.byxpath
    And user click on action with xpath: //div[contains(@class,'secondary_actions')]//following-sibling::div//button[contains(.,'Search') or contains(.,'بحث')]
    And user click on action with xpath: //div[contains(@class,'secondary_actions')]//following-sibling::div//button[contains(.,'Clear') or contains(.,'إفراغ') ]
    And click on link: ejar.workinghourstemplates.createnew.byxpath
    And user click on action with id: ejar.workinghourstemplates.cancel1.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible
    And user click on action with id: ejar.generic.close.action.byxpath


  @TestType-Regression
  Scenario: Cars Models Costs view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/car-models
    And verify ejar view title text: ejar.models.view.title.label.text
    And verify ejar view sub title text: ejar.models.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Car Models,موديلات المركبات text: ejar.models.view.secondary.bar.actions.label.text
    And verify ejar view: Car Models,موديلات المركبات table headers: ejar.models.view.table.headers.text
    And verify ejar view: Car Models,موديلات المركبات table headers with filter: ejar.models.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Car Categories view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/car-categories
    And verify ejar view title text: ejar.carcategories.view.title.label.text
    And verify ejar view sub title text: ejar.carcategories.view.subtitle.label.text
    And verify ejar view secondary bar buttons in view: Car Categories,فئات المركبة text: ejar.carcategories.view.secondary.bar.actions.label.text
    And verify ejar view: Car Categories,فئات المركبة table headers: ejar.carcategories.view.table.headers.text
    And verify ejar view: Car Categories,فئات المركبة table headers with filter: ejar.carcategories.view.table.headers.with.filter.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.category.createnew.byxpath
    And user click on action with id: ejar.category.cancel.button.byxpath
    And verify ejar view pages footer
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Shifts view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/shifts/shifts-list
    And verify ejar view title text: ejar.shifts.view.title.label.text
    And verify ejar view sub title text: ejar.shifts.view.subtitle.label.text
    And verify ejar view: Shifts,الورديات table headers: ejar.shifts.view.table.headers.text
    And verify ejar view: Shifts,الورديات table headers with filter: ejar.shifts.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.shifts.view.labels.text
    And click on action if exist: ejar.shifts.create.button.action.byxpath
    And click on action if exist: ejar.generic.cancel.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on action if exist: ejar.generic.search.action.byxpath
    And click on action if exist: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Maintenance Cards view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/maintenance-cards/cards-list
    And verify ejar view title text: ejar.maintenancecards.view.title.label.text
    And verify ejar view sub title text: ejar.maintenancecards.view.subtitle.label.text
    And verify ejar view: Maintenance Cards,بطاقات الصيانة table headers: ejar.maintenancecards.view.table.headers.text
    And verify ejar view: Maintenance Cards,بطاقات الصيانة table headers with filter: ejar.maintenancecards.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.maintenancecards.view.labels.text
    And click on action if exist: ejar.maintenancecards.create.button.action.byxpath
    And click on action if exist: ejar.generic.close.action.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on action if exist: ejar.generic.search.action.byxpath
    And click on action if exist: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Preventive Maintenance view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/preventive-maintenance
    And verify ejar view title text: ejar.preventivemaintenance.view.title.label.text
    And verify ejar view sub title text: ejar.preventivemaintenance.view.subtitle.label.text
    And verify ejar view: Preventive Maintenance,الصيانة الوقائية table headers: ejar.preventivemaintenance.view.table.headers.text
    And verify ejar view: Preventive Maintenance,الصيانة الوقائية table headers with filter: ejar.preventivemaintenance.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.preventivemaintenance.view.labels.text
    And verify form fields using labels xpath: //kendo-grid//kendo-grid-toolbar//button text: ejar.preventivemaintenance.view.toolbarbuttons.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.preventivemaintenance.sent.radio.action.byxpath
    And user click on action with id: ejar.preventivemaintenance.vehicleBlocked.radio.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: E-check Damages List view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/echeck-damages-list
    And verify ejar view title text: ejar.echeckdamagelist.view.title.label.text
    And verify ejar view sub title text: ejar.echeckdamagelist.view.subtitle.label.text
    And verify ejar view: E-check Damages List,قائمة اعطال التفقد الالكترونى table headers: ejar.echeckdamagelist.view.table.headers.text
    And verify ejar view: E-check Damages List,قائمة اعطال التفقد الالكترونى table headers with filter: ejar.echeckdamagelist.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.echeckdamagelist.view.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.echeckdamagelist.view.createnew.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Theft Reports view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/theft-requests
    And verify ejar view title text: ejar.theftreports.view.title.label.text
    And verify ejar view sub title text: ejar.theftreports.view.subtitle.label.text
    And verify ejar view: Theft Reports,تقارير السرقات table headers: ejar.theftreports.view.table.headers.text
    And verify ejar view: Theft Reports,تقارير السرقات table headers with filter: ejar.theftreports.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.theftreports.view.labels.text
    And verify element present: ejar.theftreports.view.country.byxpath
    And verify element present: ejar.theftreports.view.city.byxpath
    And verify element present: ejar.theftreports.view.status.byxpath
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action if enabled with id: ejar.theftreports.view.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Authorizations view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/authorizations-list
    And verify ejar view title text: ejar.authorizations.view.title.label.text
    And verify ejar view sub title text: ejar.authorizations.view.subtitle.label.text
    And verify ejar view: Authorizations,التفويضات table headers: ejar.authorizations.view.table.headers.text
    And verify ejar view: Authorizations,التفويضات table headers with filter: ejar.authorizations.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.authorizations.view.labels.text
    And verify element present: ejar.generic.export.action.byxpath
    And click on link: ejar.existingauthorization.createNew.action.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And click on link: ejar.addmanualauthorization.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Vehicle Out Of Service view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vehicles-out-of-service
    And verify ejar view title text: ejar.vehicleoutofservice.view.title.label.text
    And verify ejar view sub title text: ejar.vehicleoutofservice.view.subtitle.label.text
    And verify ejar view: Vehicle Out Of Service,مركبات خارج الخدمة table headers: ejar.vehicleoutofservice.view.table.headers.text
    And verify ejar view: Vehicle Out Of Service,مركبات خارج الخدمة table headers with filter: ejar.vehicleoutofservice.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.vehicleoutofservice.view.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on link: ejar.outofservice.createnew.byxpath
    And user click on action with id: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Vendors view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/vendors
    And verify ejar view title text: ejar.vendors.view.title.label.text
    And verify ejar view sub title text: ejar.vendors.view.subtitle.label.text
    And verify ejar view: Vendors,الموردين table headers: ejar.vendors.view.table.headers.text
    And verify ejar view: Vendors,الموردين table headers with filter: ejar.vendors.view.table.headers.with.filters.text
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.vendors.createnew.byxpath
    And user click on action with id: ejar.vendors.cancel.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Insurance Companies view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/insurance-companies
    And verify ejar view title text: ejar.insurancecompanies.view.title.label.text
    And verify ejar view sub title text: ejar.insurancecompanies.view.subtitle.label.text
    And verify ejar view: Insurance Companies,شركات التأمين table headers: ejar.insurancecompanies.view.table.headers.text
    And verify ejar view: Insurance Companies,شركات التأمين table headers with filter: ejar.insurancecompanies.view.table.headers.with.filters.text
    And click on link: ejar.createnewinsurancecompany.createnew.byxpath
    And user click on action with id: ejar.createnewinsurancecompany.cancel.button.byxpath
    And verify element present: ejar.generic.export.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Transport Companies view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/transport-companies
    And verify ejar view title text: ejar.transportcompanies.view.title.label.text
    And verify ejar view sub title text: ejar.transportcompanies.view.subtitle.label.text
    And verify ejar view: Transport Companies,شركات النقل table headers: ejar.transportcompanies.view.table.headers.text
    And verify ejar view: Transport Companies,شركات النقل table headers with filter: ejar.transportcompanies.view.table.headers.with.filters.text
    And verify element present: ejar.generic.export.action.byxpath
    And click on link: ejar.createnewtransportcompany.createnew.byxpath
    And user click on action with form name: app-transport-company and action id: ejar.generic.cancel.withoutclassname.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Rented vehicles vendors view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/external-company
    And verify ejar view title text: ejar.rentedvehiclesvendors.view.title.label.text
    And verify ejar view sub title text: ejar.rentedvehiclesvendors.view.subtitle.label.text
    And verify ejar view: Rented vehicles vendors,موردين المركبات المستأجرة table headers: ejar.rentedvehiclesvendors.view.table.headers.text
    And verify ejar view: Rented vehicles vendors,موردين المركبات المستأجرة table headers with filter: ejar.rentedvehiclesvendors.view.table.headers.with.filters.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.createnewrentalcompany.createnew.byxpath
    And user click on action with id: ejar.createnewrentalcompany.cancel.button.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Road Assistance Requests view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/road-assistance
    And verify ejar view title text: ejar.roadassistancerequests.view.title.label.text
    And verify ejar view sub title text: ejar.roadassistancerequests.view.subtitle.label.text
    And verify ejar view: Road Assistance Requests,طلبات المساعدة على الطريق table headers: ejar.roadassistancerequests.view.table.headers.text
    And verify ejar view: Road Assistance Requests,طلبات المساعدة على الطريق table headers with filter: ejar.roadassistancerequests.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.roadassistancerequests.view.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And click on link: ejar.opl.createnew.byxpath
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Expected Vehicles Need Preventive Maintenance view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/maintenance-report
    And verify ejar fields count in the opened report view: 3
    And verify ejar fields label in the opened report view: ejar.rental.preventivemaintenance.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Accidents Report view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/accidents-report
    And verify ejar view title text: ejar.accidentsreport.view.title.label.text
    And verify ejar view: Accidents,الحوادث table headers: ejar.accidentsreport.view.table.headers.text
    And verify ejar view: Accidents,الحوادث table headers with filter: ejar.accidentsreport.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.accidentsreport.view.labels.text
    And verify element present: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Vehicles Report view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/vehicles-report
    And verify ejar view title text: ejar.vehichlesreport.view.title.label.text
    And verify ejar view: Vehicles,المركبات table headers: ejar.vehichlesreport.view.table.headers.text
    And verify ejar view: Vehicles,المركبات table headers with filter: ejar.vehichlesreport.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.vehichlesreport.view.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Branches Report view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/Branches-report
    And verify ejar fields count in the opened report view: 1
    And verify ejar fields label in the opened report view: ejar.rental.branches.report.view.preview.fields.labels.text
    And verify ejar report view standard actions present
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

#####################
  @TestType-Regression
  Scenario: Vehicle History view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/vehicles-history
    And verify ejar view title text: ejar.vehiclehistory.view.title.label.text
    And verify ejar view: Vehicle History,سجل العمليات table headers: ejar.vehiclehistory.view.table.headers.text
    And verify ejar view: Vehicle History,سجل العمليات table headers with filter: ejar.vehiclehistory.view.table.headers.with.filters.text
    And verify form fields using labels xpath: //secondaryactionbar//following-sibling::div//form//label text: ejar.vehiclehistory.view.labels.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.vehiclehistory.view.clear.labels.byxpath
    And user click on action with id: ejar.vehiclehistory.view.search.labels.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible

  @TestType-Regression
  Scenario: Assistance Issues view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/assistance-issues-list
    And verify ejar view title text: ejar.assistanceissues.view.title.label.text
    And verify ejar view sub title text: ejar.assistanceissues.view.subtitle.label.text
    And verify ejar view: Assistance Issues,أعطال الطريق table headers: ejar.assistanceissues.view.table.headers.text
    And verify ejar view: Assistance Issues,أعطال الطريق table headers with filter: ejar.assistanceissues.view.table.headers.with.filters.text
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And wait for element present: ejar.generic.export.action.byxpath for period in seconds: 20
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And click on link: ejar.AssistanceIssues.createnew.byxpath
    And user click on action with id: ejar.generic.close.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: External Drivers view verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/external-drivers
    And verify ejar view title text: ejar.externaldrivers.view.title.label.text
    And verify ejar view sub title text: ejar.externaldrivers.view.subtitle.label.text
    And verify ejar view: External Drivers,سائقين خارجيين table headers: ejar.externaldrivers.view.table.headers.text
    And verify ejar view: External Drivers,سائقين خارجيين table headers with filter: ejar.externaldrivers.view.table.headers.with.filters.text
    And verify element present: ejar.generic.export.action.byxpath
    And verify element present: ejar.externaldrivers.view.addNewDriver.button.byxpath
    And click on element: ejar.externaldrivers.view.addNewDriver.button.byxpath
    And click on element: ejar.generic.cancel.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 1 and status: visible


  @TestType-Regression
  Scenario: Maintenance Cards Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/maintenance-cards-report
    And verify ejar view title text: ejar.maintenancecardreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Maintenance Cards Report,تقرير بطاقات الصيانة text: ejar.maintenancecardreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Maintenance Cards Report,تقرير بطاقات الصيانة text: ejar.maintenancecardreport.view.labels.text
    And verify element present: ejar.maintenancecardreport.view.filter.plateNumber.dropdown.byxpath
    And verify element present: ejar.maintenancecardreport.view.filter.country.dropdown.byxpath
    And verify element present: ejar.maintenancecardreport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.maintenancecardreport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Maintenance Cards Report,تقرير بطاقات الصيانة text: ejar.maintenancecardreport.view.buttons.label.text
    And verify ejar view: Maintenance Cards Report,تقرير بطاقات الصيانة table headers: ejar.maintenancecardreport.view.table.headers.text
    And verify ejar view: Maintenance Cards Report,تقرير بطاقات الصيانة table headers with filter: ejar.maintenancecardreport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible



  @TestType-Regression
  Scenario: Fleet Utilization Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/fleet-utilization-report
    And verify ejar view title text: ejar.fleetutilizationreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Fleet Utilization Report,تقرير تشغيل الأسطول text: ejar.fleetutilizationreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Fleet Utilization Report,تقرير تشغيل الأسطول text: ejar.fleetutilizationreport.view.labels.text
    And verify element present: ejar.fleetutilizationreport.view.filter.plateNumber.dropdown.byxpath
    And verify element present: ejar.fleetutilizationreport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.fleetutilizationreport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Fleet Utilization Report,تقرير تشغيل الأسطول text: ejar.fleetutilizationreport.view.buttons.label.text
    And verify ejar view: Fleet Utilization Report,تقرير تشغيل الأسطول table headers: ejar.fleetutilizationreport.view.table.headers.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible



  @TestType-Regression
  Scenario: Vehicle last assignment Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/vehicle-last-assignment-report
    And verify ejar view title text: ejar.vehiclelastassignmentreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Vehicle Last Assignment Report,تقرير آخر تعيين للمركبة text: ejar.vehiclelastassignmentreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Vehicle Last Assignment Report,تقرير آخر تعيين للمركبة text: ejar.vehiclelastassignmentreport.view.labels.text
    And verify element present: ejar.vehiclelastassignmentreport.view.filter.branch.dropdown.byxpath
    And verify element present: ejar.vehiclelastassignmentreport.view.filter.status.multiselect.byxpath
    And verify ejar buttons label in view: Vehicle Last Assignment Report,تقرير آخر تعيين للمركبة text: ejar.vehiclelastassignmentreport.view.buttons.label.text
    And verify ejar view: Vehicle Last Assignment Report,تقرير آخر تعيين للمركبة table headers: ejar.vehiclelastassignmentreport.view.table.headers.text
    And verify ejar view: Vehicle Last Assignment Report,تقرير آخر تعيين للمركبة table headers with filter: ejar.vehiclelastassignmentreport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible




  @TestType-Regression
  Scenario: Maintenance Reasons Report view page verification
    Given user open ejar project url
    Given ejar open url and login with tenant: AutomationTenant and user name: ejaradmin and password: 123456 url: /app/fleet-management/report/maintenance-reason-report
    And verify ejar view title text: ejar.maintenancereasonsreport.view.title.label.text
    And verify ejar view secondary bar buttons in view: Maintenance Reasons Report,تقرير أسباب الصيانة text: ejar.maintenancereasonsreport.view.secondary.bar.actions.label.text
    And verify ejar fields label in view: Maintenance Reasons Report,تقرير أسباب الصيانة text: ejar.maintenancereasonsreport.view.labels.text
    And verify element present: ejar.maintenancereasonsreport.view.filter.country.multiselect.byxpath
    And verify element present: ejar.maintenancereasonsreport.view.filter.region.dropdown.byxpath
    And verify element present: ejar.maintenancereasonsreport.view.filter.branch.dropdown.byxpath
    And verify element present: ejar.maintenancereasonsreport.view.filter.from.kendo-datepicker.byxpath
    And verify element present: ejar.maintenancereasonsreport.view.filter.to.kendo-datepicker.byxpath
    And verify ejar buttons label in view: Maintenance Reasons Report,تقرير أسباب الصيانة text: ejar.maintenancereasonsreport.view.buttons.label.text
    And verify ejar view: Maintenance Reasons Report,تقرير أسباب الصيانة table headers: ejar.maintenancereasonsreport.view.table.headers.text
    And verify ejar view: Maintenance Reasons Report,تقرير أسباب الصيانة table headers with filter: ejar.maintenancereasonsreport.view.table.headers.with.filter.text
    And verify ejar view pages footer
    And user click on action if enabled with id: ejar.generic.export.action.byxpath
    And user click on action with id: ejar.generic.search.action.byxpath
    And user click on action with id: ejar.generic.clear.action.byxpath
    And verify element not present: ejar.generic.errorModal.span.byxpath within time of seconds: 2 and status: visible

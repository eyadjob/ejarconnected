Feature: Yelo OPL Page Validation

  Scenario: validate yelo opl - create request - as a employee
    Given user open website page: yelo
    And login to yelo site with user: automationOpl@qoad.com and password: Yelo123456
    And click on element: yelo.header.moreMenu.span.byxpath
    And click on element: yelo.header.moreMenu.opl.a.byxpath
    And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 1
    And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 1
    And click on element: yelo.opl.next-button.byxpath
    And click on link: yelo.opl.isemployeeYes-button.byxpath
    And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
    And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001502
    And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
    And click on link: yelo.opl.submit-btn.byxpath
    And verify element present: yelo.opl.request.successful.byxpath
    And verify text present on page: yelo.opl.request-msg.text
    And click on link: yelo.header.userArrowDropDown.byxpath
    And click on link: yelo.header.myProfile.byxpath
    And click on link: yelo.opl.list.byxpath
    And click on link: yelo.opl.cancel-req.byxpath

 Scenario: validate yelo opl - create request  not as a employee
   Given user open website page: yelo
   And login to yelo site with user: automationOpl@qoad.com and password: Yelo123456
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 1
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 1
   And click on element: yelo.opl.next-button.byxpath
   And click on link: yelo.opl.isemployeeNo-button.byxpath
   And user set in field: yelo.opl.comment.field.byxpath value: OPL-Test
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element present: yelo.opl.request.successful.byxpath
   And verify text present on page: yelo.opl.request-msg.text
   And click on link: yelo.header.userArrowDropDown.byxpath
   And click on link: yelo.header.myProfile.byxpath
   And click on link: yelo.opl.list.byxpath
   And click on link: yelo.opl.cancel-req.byxpath


 Scenario: validate yelo opl - create request - more than one opl request
   Given user open website page: yelo
   And login to yelo site with user: automationOpl@qoad.com and password: Yelo123456
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 28
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 3
   And click on element: yelo.opl.next-button.byxpath
   And click on link: yelo.opl.isemployeeYes-button.byxpath
   And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
   And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001502
   And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element present: yelo.opl.request.successful.byxpath
   And verify text present on page: yelo.opl.request-msg.text
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 28
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 3
   And click on element by id: OPL-next-btn
   And click on link: yelo.opl.isemployeeYes-button.byxpath
   And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
   And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001502
   And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element text present: yelo.opl.errorSection.byxpath with text: yelo.opl.errorSection.moreThanOpl.text
   And click on link: yelo.header.userArrowDropDown.byxpath
   And click on link: yelo.header.myProfile.byxpath
   And click on link: yelo.opl.list.byxpath
   And click on link: yelo.opl.cancel-req.byxpath


 Scenario: validate yelo opl - create request - with attachment
   Given user open website page: yelo
   And login to yelo site with user: automationOpl@qoad.com and password: Yelo123456
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 28
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 3
   And click on element: yelo.opl.next-button.byxpath
   And click on link: yelo.opl.isemployeeYes-button.byxpath
   And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
   And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001502
   And upload file to element: yelo.opl.uploadfield.byxpath with path: //uploadFiles//logo_high.png
   And verify element present: yelo.opl.attachmentItem.byxpath
   And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element present: yelo.opl.request.successful.byxpath
   And verify text present on page: yelo.opl.request-msg.text
   And click on link: yelo.header.userArrowDropDown.byxpath
   And click on link: yelo.header.myProfile.byxpath
   And click on link: yelo.opl.list.byxpath
   And click on link: yelo.opl.cancel-req.byxpath


 Scenario: validate yelo opl - create request - without completed profile
   Given user open website page: yelo
   And login to yelo site with user: automationNotComplete@qoad.com and password: Yelo123456
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 1
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 1
   And click on element: yelo.opl.next-button.byxpath
   And click on link: yelo.opl.isemployeeYes-button.byxpath
   And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
   And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001504
   And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element text present: yelo.opl.errorSection.byxpath with text: yelo.opl.unCompletedProfileErr.text

   
 Scenario: validate yelo opl list - create request
   Given user open website page: yelo
   And login to yelo site with user: automationNotComplete@qoad.com and password: Yelo123456
   And click on element: yelo.header.moreMenu.span.byxpath
   And click on element: yelo.header.moreMenu.opl.a.byxpath
   And user select value in drop down field: yelo.opl.select-city.byxpath by option value: 1
   And user select value in drop down field: yelo.opl.select-category.byxpath by option value: 1
   And store element value: yelo.oplList.createModel.byxpath value name: OPLModelName text only: true and remove new line: true
   And store element value: yelo.oplList.createCost.byxpath and value name: OPLCost and keep number only: true
   And click on element: yelo.opl.next-button.byxpath
   And click on link: yelo.opl.isemployeeYes-button.byxpath
   And user set in field: yelo.opl.corporate.field.byxpath value: Automation-OPL-Corporate-Name
   And user select value in drop down field: yelo.opl.salary.field.byxpath by option value: 1001504
   And user set in field: yelo.opl.comment.field.byxpath value: Automation-OPL-Comment
   And click on link: yelo.opl.submit-btn.byxpath
   And verify element present: yelo.opl.request.successful.byxpath
   And verify text present on page: yelo.opl.request-msg.text
   And click on link: yelo.header.userArrowDropDown.byxpath
   And click on link: yelo.header.leaseRequests.byxpath
   And verify element text present: yelo.oplList.title.byxpath with text: yelo.oplList.title.text
   And compare list of elements text: yelo.oplList.header.byxpath with text: yelo.oplList.header.text
   And store element value: yelo.oplList.model.byxpath value name: OPLModelNameAfterCreate text only: true and remove new line: true
   And verify two values are equal, first value: OPLModelName second value: OPLModelNameAfterCreate param type: string
   And verify element text present: yelo.oplList.status.byxpath with text: yelo.oplList.status.text
   And verify element text present: yelo.oplList.period.byxpath with text: yelo.oplList.period.text
   And store element value: yelo.oplList.cost.byxpath and value name: OPLCostAfterCreate and keep number only: true
   And verify two values are equal, first value: OPLCost second value: OPLCostAfterCreate param type: decimal
   And verify element text present: yelo.oplList.employer.byxpath with text: yelo.oplList.employer.text
   And verify element text present: yelo.oplList.city.byxpath with text: yelo.oplList.city.text
   And verify element text present: yelo.oplList.comment.byxpath with text: yelo.oplList.comment.text
   And click on link: yelo.opl.cancel-req.byxpath
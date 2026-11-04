Feature: Alyam Corporate Lease Page Validation

  Scenario: validate alyam Coporate Lease - request corporate portal access
    Given user open website page: alyam
    And login to yelo site with user: autoationpaynow@qoad.com and password: Alyam123456
    And user open page yelo page: /long-term-car-rental/corporate
    And user select value in drop down field: alyam.corpOPL.colleagueNumber.select.byxpath by index: 2
    And user select value in drop down field: alyam.corpOPL.duration.select.byxpath by index: 2
    And set random text into element: alyam.corpOPL.firstName.input.byxpath with size: 5 and initial string: Automation first name
    And set random text into element: alyam.corpOPL.lastName.input.byxpath with size: 5 and initial string: Automation last name
    And set random email into element: alyam.corpOPL.email.input.byxpath
    And set value into element : alyam.corpOPL.mobileNo.input.byxpath value: 566857321
    And set random text into element: alyam.corpOPL.companyName.input.byxpath with size: 5 and initial string: Automation Corporate
    And set random text into element: alyam.corpOPL.comment.input.byxpath with size: 5 and initial string: Automation Comment
    And click on element: alyam.corpOPL.submitRequest.button.byxpath
    And verify element present: alyam.corpOPL.submitModal.div.byxpath
    And click on element: alyam.corpOPL.cancelModal.div.byxpath
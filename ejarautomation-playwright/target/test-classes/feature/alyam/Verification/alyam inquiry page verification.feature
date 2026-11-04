Feature: Alyam inquiry Page Verification

  @TestType-Regression
  Scenario: verify inquiry  page
    Given user open website page: alyam
    Given login to yelo site with user: alyamqoadautomation@qoad.com and password: Alyam123456
    And click on element: alyam.header.profileArrow.a.byxpath
    And store element value: alyam.header.userName.lable.byxpath and value name: userName and keep number only: false
    And user open page yelo page: /profile/myInquiries
    And verify element text present: alyam.inquiry.section1.byxpath with text: alyam.inquiry.section1.text
    And verify element text present: alyam.inquiry.section2.byxpath with text: alyam.inquiry.section2.text
    And verify text present on page: alyam.inquiry.section2.help.text
    And verify element present: alyam.inquiry.section2.type1.byxpath
    And verify element present: alyam.inquiry.section2.type2.byxpath
    And verify element present: alyam.inquiry.section2.type3.byxpath
    And click on element: alyam.inquiry.section2.type1.byxpath
    And verify text present on page: alyam.inquiry.inquiryType.help.text
    And verify element present: alyam.inquiry.inquiryType.byxpath
    And click on element: alyam.inquiry.inquiryType.byxpath
    And verify element present: alyam.inquiry.ِaddComplaint.back.img.byxpath
    And verify element present: alyam.inquiry.ِaddComplaint.back.byxpath
    And verify element present: alyam.inquiry.ِaddComplaint.textarea.byxpath
    And verify element present: alyam.inquiry.ِaddComplaintCancel.byxpath
    And verify element present: alyam.inquiry.ِaddComplaintSubmit.byxpath
    And verify text present on page: alyam.inquiry.bookingNum.text
    And user select value in drop down field: alyam.inquiry.bookingNum.select.byxpath by index: 2
    And set random text in variable and into element: alyam.inquiry.ِaddComplaint.textarea.byxpath with size: 10 and initial string: Automation Comment  and store value in variable: comment
    And click on element: alyam.inquiry.ِaddComplaintSubmit.byxpath
    And verify text present on page: alyam.inquiry.successP1.text
    And verify text present on page: alyam.inquiry.successP2.text
    And verify element present: alyam.inquiry.success.img.byxpath
    And click on element: alyam.inquiry.ok.button.byxpath
    And verify element present: alyam.inquiry.statusCardOpen.div.byxpath
    And click on action with locator: alyam.inquiry.inquiryID.a.byxpath with replacing variable with stored value: comment
    And verify element present: alyam.inquiry.booking.div.byxpath
    And wait for element present with locator: alyam.inquiry.inquiryComment.div.byxpath and replace variable value: comment
    And verify text present on page: alyam.inquiry.inquiryType.text
    And verify element present: alyam.inquiry.ِaddComplaint.back.byxpath
    And verify element present: alyam.inquiry.status.div.byxpath
    And verify text present on page: alyam.inquiry.customerServiceTitle.text
    And verify text present on page: alyam.inquiry.inqueryDate.text
    And verify if current date equals date on element: alyam.inquiry.inqueryDate.span.byxpath in inquiry page
    And verify text present on page: alyam.inquiry.inqueryLocation.text
    And set random text in variable and into element: alyam.inquiry.chat.input.byxpath with size: 10 and initial string: Automation Chat Message  and store value in variable: message
    And click on element: alyam.inquiry.sendMessage.img.byxpath
    And wait for element present with locator: alyam.inquiry.messageSent.div.byxpath and replace variable value: message
    And verify element present: alyam.inquiry.sentMessage.img.byxpath
    And user open ejar project url
    And ejar open url and login with tenant: AutomationTenant and user name: admin and password: 123456 url: /app/crm/inquiries
    And filter view on column name: Customer,العميل and enter value stored in variable: userName
    And click on element: ejar.feedback.firstRow.a.byxpath
    And click on element: ejar.feedback.edit.button.byxpath
    And wait for element not present: ejar.feedback.load.div.byxpath
    And user select option by text in ejar kendo option field without typing: ejar.feedback.state.button.byxpath option: Close,مغلق
    And click on element: ejar.feedback.save.button.byxpath
    And click on element: ejar.generic.yes.action.byxpath
    And wait for element present: ejar.feedback.settings.button.byxpath for period in seconds: 120
    And user open website page: alyam
    And user open page yelo page: /profile/myInquiries
    And wait for element present: alyam.inquiry.section2.type1.byxpath for period in seconds: 120
    And wait for element not present: alyam.inquiry.statusCardOpen.div.byxpath
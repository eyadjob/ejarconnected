Feature: My Profile Page Verification

  @TestType-Regression
  Scenario: verify my profile page
    Given user open website page: alyam
    And login to yelo site with user: alyamqoadautomation@qoad.com and password: Alyam123456
    And user open page yelo page: /profile/getCustomerInfo
    And verify element text present: yelo.myProfile.loginInfo.byxpath with text: yelo.myProfile.loginInfo.text
    And verify text present on page: yelo.myProfile.email.text
    And verify element present: yelo.myProfile.email.input.byxpath
    And verify element: yelo.myProfile.email.input.byxpath attribute: readonly contains value: readonly is: true
    And verify element text present: yelo.myProfile.changePassword.a.byxpath with text: yelo.myProfile.changePassword.text
    And verify text present on page: yelo.myProfile.personalInfo.text
    And verify text present on page: yelo.myProfile.firstName.text
    And verify element present: yelo.myProfile.firstName.input.byxpath
    And verify element: yelo.myProfile.firstName.input.byxpath attribute: readonly contains value: readonly is: true
    And verify text present on page: yelo.myProfile.lastName.text
    And verify element present: yelo.myProfile.lastName.input.byxpath
    And verify element: yelo.myProfile.lastName.input.byxpath attribute: readonly contains value: readonly is: true
    And verify text present on page: yelo.myProfile.dateOfBirth.text
    And verify element present: yelo.myProfile.dateOfBirth.input.byxpath
    And verify element: yelo.myProfile.dateOfBirth.input.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.nationality.text
    And verify element present: yelo.myProfile.nationality.select.byxpath
    And verify element: yelo.myProfile.nationality.select.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.identityType.text
    And verify element present: yelo.myProfile.identityType.select.byxpath
    And verify element: yelo.myProfile.identityType.select.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.identityNumber.text
    And verify element present: yelo.myProfile.identityNumber.input.byxpath
    And verify element: yelo.myProfile.identityNumber.input.byxpath attribute: readonly contains value: readonly is: true
    And verify text present on page: yelo.myProfile.identityIssueCountry.text
    And verify element present: yelo.myProfile.identityIssueCountry.input.byxpath
    And verify element: yelo.myProfile.identityIssueCountry.input.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.gender.text
    And verify element present: yelo.myProfile.gender.input.byxpath
    And verify element: yelo.myProfile.gender.input.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.maritalStatus.text
    And verify element present: yelo.myProfile.maritalStatus.select.byxpath
    And verify element: yelo.myProfile.maritalStatus.select.byxpath attribute: disabled contains value: disabled is: true
    And verify element text present: yelo.myProfile.contactInfo.div.byxpath with text: yelo.myProfile.contactInfo.text
    And verify text present on page: yelo.myProfile.mobileNumber.text
    And verify element present: yelo.myProfile.mobileNumber.input.byxpath
    And verify element: yelo.myProfile.mobileNumber.input.byxpath attribute: readonly contains value: readonly is: true
    And verify text present on page: yelo.myProfile.secondaryMobileNumber.text
    And verify element present: yelo.myProfile.mobileNumber.input.byxpath
    And verify element: yelo.myProfile.secondaryMobileNumber.input.byxpath attribute: readonly contains value: readonly is: true
    And verify element text present: yelo.myProfile.drivingLicenseInfo.div.byxpath with text: yelo.myProfile.drivingLicenseInfo.text
    And verify text present on page: yelo.myProfile.drivingLicenseNumber.text
    And verify element present: yelo.myProfile.drivingLicenseNumber.input.byxpath
    And verify element: yelo.myProfile.drivingLicenseNumber.input.byxpath attribute: readonly contains value: readonly is: true
    And verify text present on page: yelo.myProfile.drivingLicenseIssueCountry.text
    And verify element present: yelo.myProfile.drivingLicenseIssueCountry.input.byxpath
    And verify element: yelo.myProfile.drivingLicenseIssueCountry.input.byxpath attribute: disabled contains value: disabled is: true
    And verify text present on page: yelo.myProfile.drivingLicenseExpiryDate.text
    And verify element present: yelo.myProfile.drivingLicenseExpiryDate.input.byxpath
    And verify element: yelo.myProfile.drivingLicenseExpiryDate.input.byxpath attribute: readonly contains value: readonly is: true
    And verify element text present: yelo.myProfile.edit.button.byxpath with text: yelo.myProfile.edit.text


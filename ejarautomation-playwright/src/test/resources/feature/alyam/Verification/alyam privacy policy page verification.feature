Feature: Alyam privacy policy Page Verification

  @TestType-Regression
  Scenario: verify privacy policy page
    Given user open website page: alyam
    And user open page yelo page: /privacy-policy
    And verify text present on page: alyam.privacyPolicy.firstParagrapgh.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollectTitle.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollectP.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp1.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp2.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp3.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp4.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp5.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp6.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp7.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp8.text
    And verify text present on page: alyam.privacyPolicy.informationWeCollect.Bp10.text
    And verify text present on page: alyam.privacyPolicy.useYourInformationTitle.text
    And verify text present on page: alyam.privacyPolicy.useYourInformationP.text
    And verify text present on page: alyam.privacyPolicy.useYourInformationBp1.text
    And verify text present on page: alyam.privacyPolicy.useYourInformationBp2.text
    And verify text present on page: alyam.privacyPolicy.useYourInformationBp3.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformationTitle
    And verify text present on page: alyam.privacyPolicy.shareYourInformationP.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformation.Bp1.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformation.Bp2.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformation.Bp3.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformation.Bp4.text
    And verify text present on page: alyam.privacyPolicy.shareYourInformation.Bp5.text
    And verify text present on page: alyam.privacyPolicy.yourConsentTitle.text
    And verify text present on page: alyam.privacyPolicy.yourConsentP.text
    And verify text present on page: alyam.privacyPolicy.personalInformationTitle.text
    And verify text present on page: alyam.privacyPolicy.personalInformationP.text
    And verify text present on page: alyam.privacyPolicy.cookiesAndTrackingTitle.text
    And verify text present on page: alyam.privacyPolicy.cookiesAndTrackingP.text
    And verify text present on page: alyam.privacyPolicy.externalLinksTitle.text
    And verify text present on page: alyam.privacyPolicy.externalLinksP.text
    And verify text present on page: alyam.privacyPolicy.childrenPrivacyTitle.text
    And verify text present on page: alyam.privacyPolicy.childrenPrivacyP.text
    And verify text present on page: alyam.privacyPolicy.accuracyTitle.text
    And verify text present on page: alyam.privacyPolicy.accuracyP.text
    And verify text present on page: alyam.privacyPolicy.policyUpdatesTitle.text
    And verify text present on page: alyam.privacyPolicy.policyUpdatesP.text
    And verify text present on page: alyam.privacyPolicy.contactInformationTitle.text

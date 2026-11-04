Feature: OPL Corporate Page Verification

  @TestType-Regression
  Scenario: verify services page
    Given user open website page: alyam
    And user open page yelo page: /long-term-car-rental/corporate
    And verify element present: alyam.corpOPL.slideImage.img.byxpath
    And verify element text present: alyam.corpOPL.slideImageTitle.h1.byxpath with text: alyam.corpOPL.slideImageTitle.text
    And verify element text present: alyam.corpOPL.slideImageSubText.span.byxpath with text: alyam.corpOPL.slideImageSubText.text
    And verify element text present: alyam.corpOPL.sectionTitle1.span.byxpath with text: alyam.corpOPL.sectionTitle1.text
    And verify element text present: alyam.corpOPL.sectionTitle1.span.byxpath with text: alyam.corpOPL.sectionTitle1.text
    And verify count of element: alyam.corpOPL.perksImages.img.byxpath equals: 6
    And verify element present: alyam.corpOPL.perk1Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk1Title.label.byxpath with text: alyam.corpOPL.perk1Title.text
    And verify element text present: alyam.corpOPL.perk1Paragraph.span.byxpath with text: alyam.corpOPL.perk1Paragraph.text
    And verify element present: alyam.corpOPL.perk2Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk2Title.label.byxpath with text: alyam.corpOPL.perk2Title.text
    And verify element text present: alyam.corpOPL.perk2Paragraph.span.byxpath with text: alyam.corpOPL.perk2Paragraph.text
    And verify element present: alyam.corpOPL.perk3Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk3Title.label.byxpath with text: alyam.corpOPL.perk3Title.text
    And verify element text present: alyam.corpOPL.perk3Paragraph.span.byxpath with text: alyam.corpOPL.perk3Paragraph.text
    And verify element present: alyam.corpOPL.perk4Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk4Title.label.byxpath with text: alyam.corpOPL.perk4Title.text
    And verify element text present: alyam.corpOPL.perk4Paragraph.span.byxpath with text: alyam.corpOPL.perk4Paragraph.text
    And verify element present: alyam.corpOPL.perk5Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk5Title.label.byxpath with text: alyam.corpOPL.perk5Title.text
    And verify element text present: alyam.corpOPL.perk5Paragraph.span.byxpath with text: alyam.corpOPL.perk5Paragraph.text
    And verify element present: alyam.corpOPL.perk6Image.img.byxpath
    And verify element text present: alyam.corpOPL.perk6Title.label.byxpath with text: alyam.corpOPL.perk6Title.text
    And verify element text present: alyam.corpOPL.perk6Paragraph.span.byxpath with text: alyam.corpOPL.perk6Paragraph.text
    And verify element text present: alyam.corpOPL.sectionTitle2.span.byxpath with text: alyam.corpOPL.sectionTitle2.text
    And verify element present: alyam.corpOPL.employee.img.byxpath
    And verify element text present: alyam.corpOPL.employeeTitle.label.byxpath with text: alyam.corpOPL.employeeTitle.text
    And verify element text present: alyam.corpOPL.employeeP.label.byxpath with text: alyam.corpOPL.employeeP.text
    And verify element present: alyam.corpOPL.businessImage2.img.byxpath
    And verify element text present: alyam.corpOPL.companyTitle.label.byxpath with text: alyam.corpOPL.companyTitle.text
    And verify element text present: alyam.corpOPL.companyP.label.byxpath with text: alyam.corpOPL.companyP.text
    And verify element present: alyam.corpOPL.corporatePortalImage.img.byxpath
    And verify element text present: alyam.corpOPL.corporatePortalTitle.span.byxpath with text: alyam.corpOPL.corporatePortalTitle.text
    And verify element text present: alyam.corpOPL.corporatePortalParagraph.span.byxpath with text: alyam.corpOPL.corporatePortalParagraph.text
    And verify count of element: alyam.corpOPL.corporatePortalImages.span.byxpath equals: 4
    And compare list of elements text: alyam.corpOPL.corporatePortalBenefits.span.byxpath with text: alyam.corpOPL.corporatePortalBenefits.text
    And verify element text present: alyam.corpOPL.corporateRequestTitle.span.byxpath with text: alyam.corpOPL.corporateRequestTitle.text
    And verify element present: alyam.corpOPL.colleagueNumber.select.byxpath
    And verify element present: alyam.corpOPL.duration.select.byxpath
    And verify element present: alyam.corpOPL.firstName.input.byxpath
    And verify element present: alyam.corpOPL.lastName.input.byxpath
    And verify element present: alyam.corpOPL.email.input.byxpath
    And verify element present: alyam.corpOPL.mobileNo.input.byxpath
    And verify element present: alyam.corpOPL.companyName.input.byxpath
    And verify element present: alyam.corpOPL.comment.input.byxpath
    And verify element present: alyam.corpOPL.submitRequest.button.byxpath
    And verify element present: alyam.corpOPL.alreadyHaveAccount.a.byxpath
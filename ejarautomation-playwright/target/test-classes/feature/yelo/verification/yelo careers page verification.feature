Feature: Careers Page Verification

  @TestType-Regression
  Scenario: verify careers page
    Given user open page yelo page: /Careers
    And verify text present on page: yelo.careers.title.text
    And verify text present on page: yelo.careers.description.text
    And verify element text present: yelo.careers.resume.a.byxpath with text: yelo.careers.resumeLink.text
    And click on link: yelo.careers.resume.a.byxpath
    And change zoom level: 0.3
    And verify text present on page: yelo.careers.personalInfo.text
    And verify element text present: yelo.careers.firstName.label.byxpath with text: yelo.careers.firstName.text
    And verify element present: yelo.careers.firstName.input.byxpath
    And verify element text present: yelo.careers.secondName.label.byxpath with text: yelo.careers.secondName.text
    And verify element present: yelo.careers.secondName.input.byxpath
    And verify element text present: yelo.careers.lastName.label.byxpath with text: yelo.careers.lastName.text
    And verify element present: yelo.careers.lastName.input.byxpath
    And verify element text present: yelo.careers.dateOfBirth.label.byxpath with text: yelo.careers.dateOfBirth.text
    And verify element present: yelo.careers.dateOfBirth.input.byxpath
    And verify element text present: yelo.careers.gender.label.byxpath with text: yelo.careers.gender.text
    And verify element present: yelo.careers.gender.select.byxpath
    And verify element text present: yelo.careers.religion.label.byxpath with text: yelo.careers.religion.text
    And verify element present: yelo.careers.religion.select.byxpath
    And verify element text present: yelo.careers.nationality.label.byxpath with text: yelo.careers.nationality.text
    And verify element present: yelo.careers.nationality.select.byxpath
    And verify element text present: yelo.careers.IdNumber.label.byxpath with text: yelo.careers.IdNumber.text
    And verify element present: yelo.careers.IdNumber.input.byxpath
    And verify element text present: yelo.careers.address.label.byxpath with text: yelo.careers.address.text
    And verify element present: yelo.careers.address.input.byxpath
    And verify element text present: yelo.careers.email.label.byxpath with text: yelo.careers.email.text
    And verify element present: yelo.careers.email.input.byxpath
    And verify element text present: yelo.careers.telephone.label.byxpath with text: yelo.careers.telephone.text
    And verify count of element: yelo.careers.telephone.div.byxpath equals: 1
    And verify element text present: yelo.careers.educationTitle.label.byxpath with text: yelo.careers.educationTitle.text
    And verify element present: yelo.careers.education.plusCircle.byxpath
    And verify element present with status: yelo.careers.education.div.byxpath status: present
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: collapse is: true
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: in is: false
    And click on element: yelo.careers.education.plusCircle.byxpath
    And verify element present: yelo.careers.education.minusCircle.byxpath
    And verify element present: yelo.careers.education.div.byxpath
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: collapse is: false
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: in is: true
    And verify element text present: yelo.careers.startDate.label.byxpath with text: yelo.careers.startDate.text
    And verify count of element: yelo.careers.startDate.label.byxpath equals: 3
    And verify count of element: yelo.careers.startDate.input.byxpath equals: 3
    And verify element text present: yelo.careers.endDate.label.byxpath with text: yelo.careers.endDate.text
    And verify count of element: yelo.careers.endDate.label.byxpath equals: 3
    And verify count of element: yelo.careers.endDate.input.byxpath equals: 3
    And verify element text present: yelo.careers.gpa.label.byxpath with text: yelo.careers.gpa.text
    And verify element present: yelo.careers.gpa.input.byxpath
    And verify element text present: yelo.careers.educations.label.byxpath with text: yelo.careers.educations.text
    And verify element present: yelo.careers.educations.select.byxpath
    And verify element text present: yelo.careers.levelEducation.label.byxpath with text: yelo.careers.levelEducation.text
    And verify element present: yelo.careers.levelEducation.select.byxpath
    And verify element text present: yelo.careers.institution.label.byxpath with text: yelo.careers.institution.text
    And verify element present: yelo.careers.institution.select.byxpath
    And verify element text present: yelo.careers.educationDesc.label.byxpath with text: yelo.careers.educationDesc.text
    And verify element present: yelo.careers.educationDesc.textarea.byxpath
    And verify element text present: yelo.careers.levelEducationDesc.label.byxpath with text: yelo.careers.levelEducationDesc.text
    And verify element present: yelo.careers.levelEducationDesc.textarea.byxpath
    And verify element text present: yelo.careers.institutionDescription.label.byxpath with text: yelo.careers.institutionDescription.text
    And verify element present: yelo.careers.institutionDescription.textarea.byxpath
    And verify element text present: yelo.careers.addEducation.button.byxpath with text: yelo.careers.addEducation.text
    And click on element: yelo.careers.education.minusCircle.byxpath
    And verify element present: yelo.careers.education.plusCircle.byxpath
    And verify element present with status: yelo.careers.education.div.byxpath status: present
    And wait for number of seconds: 2
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: collapse is: true
    And verify element: yelo.careers.education.div.byxpath attribute: class contains value: in is: false
    And verify text present on page: yelo.careers.skills.text
    And verify element present: yelo.careers.skill.plusCircle.byxpath
    And verify element present with status: yelo.careers.skill.div.byxpath status: present
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: collapse is: true
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: in is: false
    And click on element: yelo.careers.skill.plusCircle.byxpath
    And verify element present: yelo.careers.skill.minusCircle.byxpath
    And verify element present: yelo.careers.skill.div.byxpath
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: collapse is: false
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: in is: true
    And verify element text present: yelo.careers.skillSelect.label.byxpath with text: yelo.careers.skillSelect.text
    And verify element present: yelo.careers.skillSelect.select.byxpath
    And verify element text present: yelo.careers.levelSelect.label.byxpath with text: yelo.careers.levelSelect.text
    And verify element present: yelo.careers.levelSelect.select.byxpath
    And verify element text present: yelo.careers.levelDate.label.byxpath with text: yelo.careers.levelDate.text
    And verify element present: yelo.careers.levelDate.input.byxpath
    And verify element text present: yelo.careers.skillDescription.label.byxpath with text: yelo.careers.skillDescription.text
    And verify element present: yelo.careers.skillDescription.textarea.byxpath
    And verify element text present: yelo.careers.experience.label.byxpath with text: yelo.careers.experience.text
    And verify element present: yelo.careers.experience.input.byxpath
    And verify element text present: yelo.careers.addskill.button.byxpath with text: yelo.careers.addskill.text
    And click on element: yelo.careers.skill.minusCircle.byxpath
    And verify element present: yelo.careers.skill.plusCircle.byxpath
    And verify element present with status: yelo.careers.skill.div.byxpath status: present
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: collapse is: true
    And verify element: yelo.careers.skill.div.byxpath attribute: class contains value: in is: false
    And verify text present on page: yelo.careers.proExperiences.text
    And verify element present: yelo.careers.proExperiences.plusCircle.byxpath
    And verify element present with status: yelo.careers.proExperiences.div.byxpath status: present
    And verify element: yelo.careers.proExperiences.div.byxpath attribute: class contains value: collapse is: true
    And verify element: yelo.careers.proExperiences.div.byxpath attribute: class contains value: in is: false
    And click on element: yelo.careers.proExperiences.plusCircle.byxpath
    And verify element present: yelo.careers.proExperiences.minusCircle.byxpath
    And verify element present: yelo.careers.proExperiences.div.byxpath
    And verify element: yelo.careers.proExperiences.div.byxpath attribute: class contains value: collapse is: false
    And verify element: yelo.careers.proExperiences.div.byxpath attribute: class contains value: in is: true
    And verify element text present: yelo.careers.proExperiencesStartDate.label.byxpath with text: yelo.careers.proExperiencesStartDate.text
    And verify element present: yelo.careers.proExperiencesStartDate.input.byxpath
    And verify element text present: yelo.careers.proExperiencesEndDate.label.byxpath with text: yelo.careers.proExperiencesEndDate.text
    And verify element present: yelo.careers.proExperiencesEndDate.input.byxpath
    And verify element text present: yelo.careers.employes.label.byxpath with text: yelo.careers.employes.text
    And verify element present: yelo.careers.employes.input.byxpath
    And verify element text present: yelo.careers.position.label.byxpath with text: yelo.careers.position.text
    And verify element present: yelo.careers.position.input.byxpath
    And verify element text present: yelo.careers.addProExperiences.button.byxpath with text: yelo.careers.addProExperiences.text
    And verify text present on page: yelo.careers.certificate.text
    And click on element: yelo.careers.certificate.plusCircle.byxpath
    And click on element if exist: yelo.careers.certificateField.plusCircle.byxpath with wait: 1
    And verify element present: yelo.careers.certificateType.select.byxpath
    And verify element text present: yelo.careers.addCertificate.button.byxpath with text: yelo.careers.addCertificate.text
    And click on element: yelo.careers.references.plusCircle.byxpath
    And verify element present: yelo.careers.references.minusCircle.byxpath
    And verify element text present: yelo.careers.referenceName.label.byxpath with text: yelo.careers.referenceName.text
    And verify element present: yelo.careers.referenceName.input.byxpath
    And verify element text present: yelo.careers.company.label.byxpath with text: yelo.careers.company.text
    And verify element present: yelo.careers.company.input.byxpath
    And verify element text present: yelo.careers.relationship.label.byxpath with text: yelo.careers.relationship.text
    And verify element present: yelo.careers.relationship.select.byxpath
    And verify element text present: yelo.careers.referencetelephone.label.byxpath with text: yelo.careers.referencetelephone.text
    And verify element present: yelo.careers.referencetelephone.input.byxpath
    And verify element present: yelo.careers.saveReference.button.byxpath
    And verify element present: yelo.careers.submit.button.byxpath
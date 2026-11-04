Feature: Contact Us Page Verification

  @TestType-Regression
  Scenario: verify contact us page
    Given user open page yelo page: /Home/Contact
    And verify text present on page: yelo.contactus.title.text
    And verify element text present: yelo.contactus.titleDesc.p.byxpath with text: yelo.contactus.titleDesc.p.text
    And verify element present: yelo.contactus.contactdetails.title.byxpath
    And verify element present: yelo.contactus.contactdetails.desc.byxpath
    And verify element text present: yelo.contactus.needHelp.byxpath with text: yelo.contactus.needHelp.text
    And verify element present: yelo.contactus.emailUs.div.byxpath
    And verify element present: yelo.contactus.e-mail.byxpath
    And verify element present: yelo.contactus.phone.div.byxpath
    And verify element text present: yelo.contactus.phonenumber.byxpath with text: yelo.contactus.phonenumber.text
    And verify element text present: yelo.contactus.phone.byxpath with text: yelo.contactus.phone.text
    And verify element present: yelo.contactus.chatUs.div.byxpath
    And verify element text present: yelo.contactus.chatwithus.byxpath with text: yelo.contactus.chatwithus.text
    And verify element present: yelo.contactus.reachUs.byxpath
    And verify element present: yelo.contactus.reachUs.title.byxpath
    And verify element present: yelo.contactus.reachUs.paragraph.byxpath
    And verify element present: yelo.contactus.instagram.img.byxpath
    And verify element present: yelo.contactus.instagram.a.byxpath
    And verify element present: yelo.contactus.twitter.img.byxpath
    And verify element present: yelo.contactus.twitter.a.byxpath
    And verify element present: yelo.contactus.facebook.img.byxpath
    And verify element present: yelo.contactus.facebook.a.byxpath
    And verify element present: yelo.contactus.youtube.img.byxpath
    And verify element present: yelo.contactus.youtube.a.byxpath
    And verify element present: yelo.contactus.linkedin.byxpath
    And verify element present: yelo.contactus.inquiry.byxpath
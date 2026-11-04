Feature: Alyam FAQ page Verification

  @TestType-Regression
  Scenario: verify FAQ page
    Given user open website page: alyam
    And click on link: alyam.faq.login-link.byxpath
    And verify element text present: alyam.faq.title.byxpath with text: alyam.faq.title.text
    And click on element: alyam.faq.q1.byxpath
    And verify element text present: alyam.faq.q1.byxpath with text: alyam.faq.q1.text
    And verify element text present: alyam.faq.a1.byxpath with text: alyam.faq.a1.text
    And click on element: alyam.faq.q2.byxpath
    And verify element text present: alyam.faq.q2.byxpath with text: alyam.faq.q2.text
    And verify element text present: alyam.faq.a2.byxpath with text: alyam.faq.a2.text
    And click on element: alyam.faq.q3.byxpath
    And verify element text present: alyam.faq.q3.byxpath with text: alyam.faq.q3.text
    And verify element text present: alyam.faq.a3.byxpath with text: alyam.faq.a3.text
    And click on element: alyam.faq.q4.byxpath
    And verify element text present: alyam.faq.q4.byxpath with text: alyam.faq.q4.text
    And verify element text present: alyam.faq.a4.byxpath with text: alyam.faq.a4.text
    And click on element: alyam.faq.q5.byxpath
    And verify element text present: alyam.faq.q5.byxpath with text: alyam.faq.q5.text
    And verify element text present: alyam.faq.a5.byxpath with text: alyam.faq.a5.text
    And click on element: alyam.faq.q6.byxpath
    And verify element text present: alyam.faq.q6.byxpath with text: alyam.faq.q6.text
    And verify element text present: alyam.faq.a6.byxpath with text: alyam.faq.a6.text
    And click on element: alyam.faq.q7.byxpath
    And verify element text present: alyam.faq.q7.byxpath with text: alyam.faq.q7.text
    And verify element text present: alyam.faq.a7.byxpath with text: alyam.faq.a7.text
    And click on element: alyam.faq.q8.byxpath
    And verify element text present: alyam.faq.q8.byxpath with text: alyam.faq.q8.text
    And verify element text present: alyam.faq.a8.byxpath with text: alyam.faq.a8.text
    And click on element: alyam.faq.q9.byxpath
    And verify element text present: alyam.faq.q9.byxpath with text: alyam.faq.q9.text
    And verify element text present: alyam.faq.a9.byxpath with text: alyam.faq.a9.text
    And click on element: alyam.faq.q10.byxpath
    And verify element text present: alyam.faq.q10.byxpath with text: alyam.faq.q10.text
    And verify element text present: alyam.faq.a10.byxpath with text: alyam.faq.a10.text



@ai-mcp @yelo @login
Feature: Yelo login page verified with the Playwright MCP browser

  The page is opened and inspected t+hrough the Playwright MCP server (npx @playwright/mcp),
  which is the same browser tooling an AI agent uses, instead of the Java DriverFactory.

  Scenario: Login page renders the expected elements
    Given the Playwright MCP browser is started
    When I open the Yelo login page at "https://ejarypp.qoad.com:4800/"
    And DeepSeek confirms the page matches the Yelo login design based on description
      """
      - Rentey wordmark in the top-right corner
      - Yellow "YELO يلو" tenant logo centred above the login form
      - the Label must NOT be visible "User name or email" with an empty text input below it
      - Label "Password" with a masked input and an eye toggle icon
      - Salmon / light-orange "Log in" button below the password field
      - Four small language flag icons underneath the button
      - Footer text "© 2026, Qoad Software Solutions. All rights reserved. | Rentey"
      - Left half shows  with a notice card reading
        "A successful experience is based on correct information. Update your information about our services"
        and "Customer Service Team"
      """
    And the Playwright MCP browser saves a screenshot named "yelo-login-page.png"
    And the Playwright MCP browser is closed

  @visual-mockup
  Scenario: Login page matches the provided mockup design image
    Given the Playwright MCP browser is started
    When I open the Yelo login page at "https://ejarypp.qoad.com:4800/"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/login-page-mockup-correct-field-location.png"
    And the Playwright MCP browser is closed

  # Recorded walk-through (video 2026-11-13): login as ejaradmin -> Rental -> Bookings ->
  # Create Spot Booking -> details -> vehicle -> customer -> extras -> Save -> "Saved successfully".
  # Every screen is compared with the layout captured from that recording
  # (src/test/resources/mockups/yelo/booking/), and every action is chosen and executed by DeepSeek
  # from the accessibility snapshot: this scenario contains no selectors and no JavaScript.
  @booking @regression
  Scenario: Create a spot booking from the rental menu and verify it is saved
    Given the Playwright MCP browser is started
    When I open the Yelo login page at "https://ejarypp.qoad.com:4800/account/login"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/01-login.png"
    And DeepSeek confirms the page shows no error message
    When DeepSeek performs the action "type the user name 'ejaradmin' into the 'User name or email' field"
    And DeepSeek performs the action "type the password '123456' into the 'Password' field"
    And DeepSeek performs the action "click the 'Log in' button"
    And DeepSeek confirms the page shows "Dashboard"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/02-dashboard-rental-menu.png"
    When DeepSeek performs the action "open the 'Rental' menu in the top navigation bar"
    And DeepSeek performs the action "click 'Bookings' in the Rental menu"
    And DeepSeek confirms the page shows "Create Spot Booking"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/03-bookings-list.png"
    When DeepSeek performs the action "click the '+ Create Spot Booking' button"
    And DeepSeek confirms the page shows "Booking Details"
    And DeepSeek performs the action "select 'Saudi Arabia' in the Countries dropdown"
    And DeepSeek performs the action "select 'Pickup' in the Type dropdown"
    And DeepSeek performs the action "select 'Automation Branch' in the Pick-up & Return dropdown"
    And DeepSeek performs the action "set the Pick-up Date to today and the Drop-off Date to tomorrow"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/04-booking-details.png"
    And DeepSeek confirms the page shows no error message
    When DeepSeek performs the action "click the 'Next' button on the Booking Details step"
    And DeepSeek confirms the page shows "Categories"
    And DeepSeek performs the action "select 'Automation Small Sedan' in the Categories dropdown"
    And DeepSeek performs the action "select 'Automation Accent' in the Models dropdown"
    And DeepSeek performs the action "select '2020' in the Years dropdown"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/05-vehicle-selection.png"
    When DeepSeek performs the action "click the 'Next' button on the Vehicle step"
    And DeepSeek confirms the page shows "Identity number"
    And DeepSeek performs the action "type 'Eyad Autom' into the 'Customer Name' field, then select the first entry in the suggestion list"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/06-customer-selection.png"
    When DeepSeek performs the action "click the 'Next' button on the Customer step"
    And DeepSeek confirms the page shows "Payments details for the current operation"
    Then DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/07-extras-payment.png"
    And DeepSeek confirms the page shows no error message
    When DeepSeek performs the action "click the 'Save' button to save the booking"
    Then DeepSeek confirms the booking was saved successfully
    And DeepSeek compares the opened page with the mockup image "src/test/resources/mockups/yelo/booking/08-booking-saved.png"
    And DeepSeek confirms the page shows no error message
    And the Playwright MCP browser is closed
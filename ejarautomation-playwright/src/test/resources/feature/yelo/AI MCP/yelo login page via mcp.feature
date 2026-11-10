@ai-mcp @yelo @login
Feature: Yelo login page verified with the Playwright MCP browser

  The page is opened and inspected t+hrough the Playwright MCP server (npx @playwright/mcp),
  which is the same browser tooling an AI agent uses, instead of the Java DriverFactory.

  Scenario: Login page renders the expected elements
    Given the Playwright MCP browser is started
    When I open the Yelo login page at "https://ejarypp.qoad.com:4800/"
    Then the page title should be "Rentey"
    And DeepSeek confirms the page matches the Yelo login design
      """
      - Rentey wordmark in the top-right corner
      - Yellow "YELO بيلو" tenant logo centred above the login form
      - the Label must NOT be visible "User name or email" with an empty text input below it
      - Label "Password" with a masked input and an eye toggle icon
      - Salmon / light-orange "Log in" button below the password field
      - Four small language flag icons underneath the button
      - Footer text "© 2026, Qoad Software Solutions. All rights reserved. | Rentey"
      - Left half shows a dark-blue 3D logistics illustration with a notice card reading
        "A successful experience is based on correct information. Update your information about our services"
        and "Customer Service Team"
      """
    And the Playwright MCP browser saves a screenshot named "yelo-login-page.png"
    And the Playwright MCP browser is closed

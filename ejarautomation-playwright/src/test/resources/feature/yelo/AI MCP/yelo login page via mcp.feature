@ai-mcp @yelo @login
Feature: Yelo login page verified with the Playwright MCP browser

  The page is opened and inspected through the Playwright MCP server (npx @playwright/mcp),
  which is the same browser tooling an AI agent uses, instead of the Java DriverFactory.

  Scenario: Login page renders the expected elements
    Given the Playwright MCP browser is started
    When I open the Yelo login page at "https://ejarypp.qoad.com:4800/"
    Then the page title should be "Rentey"
    And the login form should show these fields:
      | label              | selector                             |
      | User name or email | input[name="userNameOrEmailAddress"] |
      | Password           | input[name="password"]               |
    And the "Log in" button should be displayed
    And the tenant logo should be displayed
    And the footer should mention "Qoad Software Solutions" and "Rentey"
    And the customer service notice should be displayed
    And the Playwright MCP browser saves a screenshot named "yelo-login-page.png"
    And the Playwright MCP browser is closed

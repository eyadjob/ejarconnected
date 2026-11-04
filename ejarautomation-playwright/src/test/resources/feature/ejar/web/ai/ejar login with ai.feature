@EjarAiLogin @TestType-Regression
Feature: Ejar login with AI assistance (Ollama / Playwright)
  As a tester
  I want to log in to Ejar using the same flow as other cases, with AI (Ollama qwen3-coder:30b at localhost:11434) confirming the login page
  So that we validate AI-assisted UI verification alongside Playwright automation

  # Optional: run Ollama with model qwen3-coder:30b at http://localhost:11434 for the AI confirmation step.
  # If Ollama is not available, the AI step is skipped and the scenario still runs (login + dashboard verification).

  Scenario: Login to Ejar with AI confirming the login page
    Given AI server http://localhost:11434 using model qwen3-coder:30b
    Given Ejar login page is opened for AI-assisted login
    And AI get page inner text and respond with yes or no based on the following prompt: You are a test assistant. The following is the visible text from a web page. Is this a login page that has username (or user name/email) and password fields?\
    And AI get page html and respond with yes or no based on the following prompt: Does the page have the following exact language switching visible buttons 1. English (us flag)\n 2. French (`fr` flag)\n 3. German (`de` flag)\n 4. Arabic (`sa` flag)?
    When user logs in to Ejar with tenant: AutomationTenant and user name: admin and password: 123456
    Then Ejar dashboard is displayed
    And close browser and close driver

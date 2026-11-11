# Mockup images for the visual AI comparison

The scenario `Login page matches the provided mockup design image`
(`src/test/resources/feature/yelo/AI MCP/yelo login page via mcp.feature`) compares a screenshot of the
running login page with an approved design image.

## How to use it

1. Put the approved design here as **`login-page-mockup.png`** (PNG, JPG, GIF or WebP all work — the
   MIME type is detected from the bytes):

   ```
   src/test/resources/mockups/yelo/login-page-mockup.png
   ```

2. Run the scenario from `TestRunner_Yelo_MCP_Login_Page`, or just run the feature file in the IDE.

3. Read the verdict in the console:

   ```
   DeepSeek mockup verdict: pass=false, confidence=0.9, failedItems=[FAIL <element> (...)], findings=[...]
       OK   Rentey wordmark top-right (found at the top of the right panel)
       OK   Yellow YELO logo above the login form (centred, same wording)
       FAIL Language flag icons (only three flags visible)
       OK   No error state (no validation or error banner on the page)
   ```

The step passes only when **every** element the model identifies in the mockup is present on the page
**and** the page shows no error state (validation message, error banner, stack trace, broken image or
blank/partial render).

## Notes

- The mockup is only read, never written; the live page screenshot is saved to
  `test output/playwright-mcp/mockup-compare-page.png` so you can compare them side by side after a failure.
- Different image size/scale than the real viewport is fine — the model is told to ignore harmless
  differences such as anti-aliasing, exact pixel positions and font rendering.
- This is a different judgement than `DeepSeek confirms the page matches the Yelo login design based on
  description`, which checks a written checklist instead of a design image.

# PROJECT_MEMORY.md

Persistent project notes for **`ejarautomation-playwright`** — the end-to-end and API automation
suite for the **Ejar** and **Yelo** vehicle-rental platforms built by Qoad Software Solutions.

> This file answers *what this project is and what it contains*.
> Working rules, pitfalls and the change log live in [AGENT.md](AGENT.md).

---

## 1. What this project is

A single Maven module that drives real browsers against the Ejar back-office and the Yelo
customer-facing website, verifies business flows (booking, contracts, payments, administration
forms, customer data), produces Extent reports, and e-mails branded result reports to the QA team.

It also contains a small API automation layer, an SQL Server helper, cloud storage uploaders
(Google Drive / OneDrive), an AI layer (DeepSeek vision verdicts, a local Ollama client and a
Playwright-MCP browser driver), and the report/e-mail rendering pipeline.

Two product families are covered:

| Product  | What is tested |
|----------|----------------|
| **Ejar** | Back-office / ERP web app (rental, fleet, financial, collection, customer and administration forms) plus its reports/views |
| **Yelo** | Public rental website (`iyelo.com`): login, home, pages, booking + pay-now/pay-later flows, production health checks |

---

## 2. Quick facts

| Item | Value |
|---|---|
| Language / build | Java **17**, Maven (`org:ejar:1.0-SNAPSHOT`, packaging `jar`) |
| BDD engine | Cucumber **6.9.1** (`cucumber-java`, `cucumber-junit`) on **JUnit 4**; TestNG is also on the classpath |
| Browser automation | Playwright for Java **1.58.0** (thread-local `Browser`/`Page`) |
| Reporting | ExtentReports **5.0.7** + `extentreports-cucumber6-adapter` |
| Other libraries | Gson, Jsoup, Apache Commons (IO/CSV), Lombok, JavaMail, MSSQL JDBC 8.4.1, Google API client (Drive/Gmail), Graphwalker |
| Feature files | **62** `.feature` files under `src/test/resources/feature` |
| Framework classes | **58** Java classes under `src/main/java/automation` |
| Test classes | **24** Java classes (16 `TestRunner*` + 8 step-definition classes) |
| Entry points | **16** runners, each also selectable through a Maven profile in `pom.xml` |
| Browser drivers | Bundled under `drivers/` (`chrome/`, `firefox/`) |

---

## 3. Where this fits

```
ejarconnected/                     ← git repository (GitHub: eyadjob/ejarconnected)
├── README.md                      ← repository-level overview
└── ejarautomation-playwright/     ← THIS module
```

Other folders in the repository (`APIsSecurityChecker`, `performance/`, `ImportCustomers`,
`rentalAgentRunner`, …) are separate tools/suites — they are not part of this Maven module.

---

## 4. Directory map

| Path | Contents |
|---|---|
| `pom.xml` | Dependencies, Surefire include pattern (`${test-classes}`) and one Maven profile per runner |
| `maven commands.txt` | Legacy note about Maven's default test-name conventions |
| `src/main/java/automation/framework/` | Framework code (see §5) |
| `src/test/java/runner/testrunners/` | `TestRunner*` classes — the entry points, grouped by product/language |
| `src/test/java/stepdefs/` | Cucumber glue: `generic`, `ejar.web`, `yelo.web`, `mcp` |
| `src/test/resources/feature/` | `.feature` files: `ejar/…`, `yelo/{verification,validation,precondition,AI MCP}/`, `API Test Cases/` |
| `src/test/resources/locators/` | Locator repositories as `.properties`, one file per page (`ejar/…`, `yelo/…`) |
| `src/test/resources/mockups/` | Design images used by the visual AI comparison steps |
| `src/test/resources/*.properties` | Runtime configuration (see §8) |
| `drivers/` | Bundled chrome/firefox drivers and the repackaged Sikuli API jar |
| `email html/` | Legacy e-mail assets (icons, `Qoad logo.png`, `welcome to yelo.html`) used by older mails |
| `logos/` | Current brand assets for report e-mails (Yelo wordmark PNG/JPG/WebP) |
| `AI Agent Credentials/` | **Untracked** DeepSeek API key for the AI validation steps |
| `personaplex-setup/` | Vendored local AI-assistant setup (third-party, not part of the suite) |
| `uploadFiles/` | Sample payloads used by upload scenarios (xlsx, rar, images, upload scripts) |
| `test output/` | Generated artefacts: `Json/ExtentJson.json`, `playwright-mcp/` (MCP screenshots + console logs) |
| `customReports/` | Generated Extent HTML report, per-feature screenshots and `.webm` videos |

---

## 5. Framework architecture

```
TestRunner_*  (@RunWith(Cucumber.class) + @CucumberOptions)
   │  before class: sets execution language + project, RunnerListener.testRunStarted(...)
   ▼
Cucumber ──► stepdefs (generic / ejar.web / yelo.web / mcp)
   │              │
   │              ├─ PropManager  ── loads every .properties under src/test/resources,
   │              │                   resolves locator keys by name
   │              ├─ DriverFactory ── thread-local Playwright browser/page, video recording
   │              └─ Element       ── locator wrapper (wait/click/fill/assert + console logging)
   ▼
Hooks (stepdefs.generic.Hook)  ── per-step console timing, screenshots, video, Extent enrichment
   ▼
RunnerListener.testRunFinished(...)  ── copies the report, builds and sends the result e-mail
   ▼
SendAggregatedReport / EmailHandler → MicrosoftGraphMailSender (Microsoft Graph API)
```

Key classes in `src/main/java/automation/framework`:

| Class | Responsibility |
|---|---|
| `Element` | Wraps a Playwright `Locator`: explicit waits, clear/fill/check/click, visibility assertions, verbose `System.out` tracing. Wait budget from `driver.element.wait` |
| `threadData.DriverFactory` | Creates/reuses per-thread browser contexts, sizes from `execution.screen.*`, optional video recording |
| `threadData.TestData` / `SharedMethods` | Thread-scoped run data (feature/scenario names, folders, copy path) |
| `propmanager.PropManager` | Loads all `.properties` files from `src/test/resources` into a map keyed by file name; `getProperty`, `setProperty`, `loadProperties`, `getLocatorName`, `getLocatorsPath` |
| `listener.RunnerListener` | Run start/finish: report folder copy, backup folder, aggregated e-mail trigger |
| `listener.StepTimingFormatter` | Cucumber plugin printing `step → N ms` (used by Maven/runner executions) |
| `listener.StepTimingSupport` | Thread-local step label used by the generic hook when the formatter is not active |
| `listener.TestEventHandlerPlugin` | Minimal event listener used for run-level console markers |
| `business.SendAggregatedReport` | Builds the HTML result e-mail (production Yelo layout + aggregated report), injects logo/video links, sends it |
| `business.EmailHandler` | Recipient resolution, inline logo handling (CID), Graph/SMTP send entry points |
| `business.MicrosoftGraphMailSender` | Raw Microsoft Graph `sendMail` JSON builder (inline + file attachments) |
| `business.ReportDataHandler`, `RunResultsInformation`, `PieChartGenerator` | Report data model and pie charts |
| `business` (others) | File/drive utilities, date helpers, regex, screenshots, video assembly, CSV, network, Windows shell, soft-assert beans |
| `ai.DeepSeekVisionValidator` | LLM-as-judge: checklist mode and mockup-image comparison mode; strict JSON verdicts |
| `mcp.McpPlaywrightClient` | Starts `npx @playwright/mcp` and drives it over stdio (`browser_navigate`, `browser_take_screenshot`, snapshots) |
| `business.OllamaClient` | Local Ollama chat client (used by the Ejar AI login scenario) |
| `ApiAutomation/*` | REST client, URIs, headers and record beans for API checks |
| `DatabaseHelper` | JDBC access to the Ejar SQL Server database for data preparation/validation |
| `EmailValidator` | IMAP mailbox polling and validation of received mail |

---

## 6. Test coverage map

| Runner / profile | Feature folder | Purpose |
|---|---|---|
| `TestRunner_Ejar_Forms_Verification_{English,Arabic}` | `feature/ejar/web/forms` | Verify every back-office form field |
| `TestRunner_Ejar_Views_Verification_{English,Arabic}` | `feature/ejar/web/views` | Reports and view screens |
| `TestRunner_Ejar_Existing_Data_English` | `feature/ejar/...` | Existing-data validation flows |
| `TestRunner_Ejar_Login_With_AI` | `feature/ejar/web/ai` (**folder is currently empty** — the runner selects zero scenarios) | AI-assisted login confirmation |
| `TestRunner_Yelo_Verification_{English,Arabic}` | `feature/yelo/verification` | Public site pages: home, fleet, branches, about, FAQ, terms, footer, … |
| `TestRunner_Yelo_Validation_{English,Arabic}` | `feature/yelo/validation` | User journeys: login, booking, pay now/later, coupons, currency, memberships |
| `TestRunner_Yelo_Rental_Agent_{English,V2_English}` | `feature/yelo/...` | Rental-agent regression flows |
| `TestRunner_Yelo_Performance_English` | single feature `feature/yelo/validation/yelo pay later validation for performance test.feature` | Timing/navigation checks |
| `TestRunner_Yelo_Precondition` | `feature/yelo/precondition` | Creates prerequisite data |
| `TestRunner_Yelo_Rental_Agent_Production` | `feature/yelo/validation` (name filter) | **Live production** health check — creates and cancels a real booking and sends a real report e-mail |
| `TestRunner_Yelo_MCP_Login_Page` | `feature/yelo/AI MCP` | AI/MCP scenarios; plain JUnit test that asserts `Main.run` exit status |

`pom.xml` also still declares profiles for `Alyam` runners that no longer exist — selecting them
runs zero tests (see AGENT.md).

---

## 7. Locator model

Locators are data, not code. Each page has a `.properties` file under
`src/test/resources/locators/<project>/<page>/`, for example:

```properties
yelo.login.termsemail.label.byxpath=//label[@for='email']
yelo.aboutus.title.text=About us
```

Conventions:

- key prefix mirrors the page (`yelo.<page>.<element>.<kind>`)
- suffix describes the lookup: `.byxpath`, `.text`, `.id`, `.css`, …
- steps reference the key by name (`verify element present: yelo.aboutus.title.text`), and
  `PropManager.getLocatorName(key)` resolves it — no selector strings inside feature files.

---

## 8. Configuration files (`src/test/resources`)

| File | Used for |
|---|---|
| `appProperties.properties` | Main runtime config: environment URLs (`ejar.environment.url`, `yelo.environment.url`, `yelo.production.environment.url`), browser/headless, viewport sizes, element wait, report folders, video flags, e-mail recipients/sender, OneDrive + Google Drive settings, database credentials, feature toggles |
| `appApiProperties.properties` | API base URLs/credentials for `ApiAutomation` |
| `cucumber.properties` | Cucumber global options (publish flag, timing plugin for IDE runs) |
| `emailProperites.properties` | Template strings for the aggregated (non-production) result e-mail |
| `RentalAgentEmail.properties` | Body template for the rental-agent report e-mail |
| `extent.properties` + `extent-config.xml` | Extent reporter names, output paths, theme |
| `locators/**` | Page locator repositories (§7) |
| `mockups/**` | Design images for the AI mockup comparison |

`PropManager` loads **every** `.properties` file found directly under `src/test/resources`, keyed by
file name; the same key may therefore exist in more than one file. Runner classes change the active
language/project at runtime via `setExecutionLanguageProperty` / `setTheExecutionProject`.

---

## 9. Reporting and e-mail pipeline

1. `Hook` enriches every step in Extent and prints per-step timings.
2. Extent writes `customReports/currentReport.html`, `test output/Json/ExtentJson.json` and a PDF path.
3. `RunnerListener.testRunFinished` copies the report into
   `execution.reports.backup.folder\<date>\<runner> <timestamp>\` (outside the repo), including
   screenshots, `.webm` videos and the logo used.
4. Production runs build the Yelo-branded e-mail (`SendAggregatedReport`) with pass/fail summary,
   scenario table, video links (OneDrive when enabled) and send it through Microsoft Graph
   (`EmailHandler` → `MicrosoftGraphMailSender`). The logo travels as a **CID inline attachment**.
5. Optional clean-up of old backup folders and old OneDrive videos, driven by properties.

Brand palette currently used by the report e-mail: header/footer `#4D0970`, accent `#FACB03`
(the word "Yelo" in the footer), white body text.

---

## 10. AI features

| Piece | What it does |
|---|---|
| `DeepSeekVisionValidator.validate(...)` | Screenshot vs. written checklist; one verdict per checklist line |
| `DeepSeekVisionValidator.validateAgainstMockup(...)` | Screenshot vs. **mockup image**: the model derives the element list from the design, checks each element on the page, and always adds a "no error state" item |
| `McpPlaywrightClient` | Drives the Playwright MCP server (`npx @playwright/mcp`, override with `-Dmcp.playwright.package=...`) instead of `DriverFactory` |
| `OllamaClient` + `stepdefs.ejar.web.AiStepDefs` | Local-model confirmation of login pages (used by `ejar login with ai local weight Ollama.feature`) |

The DeepSeek key is resolved from `DEEPSEEK_API_KEY`, `-Ddeepseek.key.file=...`, or
`AI Agent Credentials/deepseek.key` (untracked). Model/endpoint are overridable with
`-Ddeepseek.model` / `-Ddeepseek.api.url`.

---

## 11. Running

```bash
cd ejarconnected/ejarautomation-playwright

mvn test                                    # every **/TestRunner*.java
mvn test -P yelo-verification-en            # one suite via profile
mvn test -P TestRunner_Yelo_Rental_Agent_Production
mvn -DskipTests test-compile                # compile only
```

Requirements: JDK 17, Maven 3.8+, Playwright browsers installed (`npx playwright install`),
Chrome/Firefox available for the bundled drivers. MCP scenarios additionally need Node/npx.

Generated folders (`customReports/`, `test output/`, `chartTempFolder/`, `target/`) are **not**
source — see AGENT.md before committing anything that looks like a report.

---

## 12. Security notes

- The repository is **public**. Never commit `AI Agent Credentials/`, service-account JSON keys,
  database passwords, mail passwords or customer data.
- `appProperties.properties` ships real connection strings, mail accounts and OneDrive/Google
  credentials as defaults — treat them as deployment configuration, not test fixtures.
- `MicrosoftGraphMailSender.main` contains sample client credentials for manual testing; do not copy
  them into new code, logs or issues.

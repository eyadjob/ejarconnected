# AGENT.md

Working agreement for coding agents (and humans) touching **`ejarautomation-playwright`**.

Read [PROJECT_MEMORY.md](PROJECT_MEMORY.md) first for *what* the project is. This file is about
**how to change it without breaking a live QA suite**.

---

## 1. Read before you edit

| You are changing… | Read first |
|---|---|
| A test scenario | the `.feature` file, its runner's `@CucumberOptions` (features/glue/name filter), and the step definitions under `src/test/java/stepdefs` |
| A locator | the page `.properties` under `src/test/resources/locators/...` and `PropManager.getLocatorName` |
| The result e-mail | `SendAggregatedReport` (HTML is built from Java strings), `EmailHandler`, `MicrosoftGraphMailSender` |
| AI steps | `DeepSeekVisionValidator`, `stepdefs/mcp/PageMcpStepsDef.java`, `feature/yelo/AI MCP/` |
| Framework behaviour | `Element`, `DriverFactory`, `Hook`, `RunnerListener`, `PropManager` |
| Build/run behaviour | `pom.xml` (profiles + surefire include) |

---

## 2. Non-negotiable rules

1. **Never commit secrets.** `AI Agent Credentials/`, `*service-account*.json`, `Credentials/`,
   database/mail passwords and customer data are gitignored for a reason. The repository is public.
   Do not paste credentials into logs, issues, commit messages or docs.
2. **Never commit generated artefacts.** `target/`, `customReports/`, `test output/`,
   `chartTempFolder/`, `*.class`, Extent HTML/JSON, screenshots and `.webm` files.
3. **Do not re-add IDE files.** `.idea/` and `*.iml` are intentionally untracked (see §6).
4. **Do not run the production runner casually.** `TestRunner_Yelo_Rental_Agent_Production` books a
   real car on `iyelo.com`, cancels it, uploads a video to OneDrive and sends a real e-mail to the
   addresses in `email.sendProductionReportTo`. Ask before triggering it.
5. **Never "clean up" noisy framework logging** (`Element`, `Hook`) as a side task — the console
   trace is the primary debugging tool for flaky locators.
6. **Respect the data-driven locator model.** Selectors belong in `locators/**/*.properties`; feature
   files reference key names only.
7. **Keep secrets out of new code paths.** Read them from `appProperties.properties`, environment
   variables or untracked key files — never hard-code new ones.

---

## 3. Build, run, verify

```bash
cd ejarconnected/ejarautomation-playwright

mvn -B -DskipTests test-compile          # fastest compile gate (main + tests)
mvn -B test                              # every **/TestRunner*.java
mvn -B test -P <profile-id>              # one suite (ids listed in pom.xml <profiles>)
mvn -B test -Dtest=TestRunner_Yelo_MCP_Login_Page
```

Minimum verification for any change: **`mvn -B -DskipTests test-compile` must pass.**

### 3.1 Verify cucumber bindings without a browser (recommended)

A dry run catches undefined/ambiguous steps in seconds and is the cheapest way to validate a new
scenario or renamed step:

```java
// run from the module directory with the test classpath
byte status = io.cucumber.core.cli.Main.run(new String[]{
        "src/test/resources/feature/yelo/AI MCP/",
        "--glue", "stepdefs.mcp",
        "--dry-run", "--monochrome", "--plugin", "pretty"
}, Thread.currentThread().getContextClassLoader());
```

Expected: `N Scenarios (N passed)`; `undefined` or `ambiguous` means the glue no longer matches.

### 3.2 Verify an e-mail template without sending it

`SendAggregatedReport.buildProductionEmailHeader()` / `buildProductionEmailFooter()` are private but
render the whole mail. Invoke them by reflection in a scratch class (put it under `target/`, never in
`src/`), replace `src="cid:high-logo"` with a base64 data URI, write the HTML and screenshot it with
headless Chrome:

```bash
chrome --headless=new --screenshot=out.png --window-size=1000,1100 file:///.../mail.html
```

This is how the production e-mail layout is regression-checked without sending anything.

---

## 4. Change playbooks

### 4.1 Add or change a scenario

1. Put the `.feature` file under `src/test/resources/feature/<project>/<area>/`.
2. Add/adjust locator keys in `src/test/resources/locators/<project>/<page>/…properties`.
3. Reuse existing steps (`GenericStepDefs`, `EjarGenericStepDefs`, `YeloGenericStepDefs`) before
   writing a new one.
4. Confirm the runner that owns the folder picks it up:
   - `features = {...}` must include the folder,
   - `name = {...}` filters must match the new scenario title (the production runner filters by
     exact scenario name regex),
   - a folder-based runner (`AI MCP`) needs no filter change.
5. Run the dry run (§3.1), then the single runner.

### 4.2 Add a new step definition

- Prefer generic steps that take a locator key.
- If the step needs secrets/config, read it through `PropManager`, never inline.
- Do **not** print step timings inside the step body: `Hook` and `StepTimingFormatter` already do it
  (§5.2). If the step knows its own display text (MCP style), call
  `StepTimingSupport.setLabel("…")` instead of printing.

### 4.3 Change the report e-mail

- HTML lives in `SendAggregatedReport` (production layout) and in the `*.properties` templates for
  the older/aggregated mails. There is no `.html` file for the production mail.
- Logo: keep the `cid:high-logo` reference and let `EmailHandler` attach the file inline. Outlook
  cannot render `data:` URIs, and remote images are blocked — see §5.1.
- After editing, render and inspect (§3.2), then send once to a single recipient if needed.

---

## 5. Pitfalls that have already cost time

### 5.1 Outlook images (report e-mail)

| Symptom | Cause | Fix |
|---|---|---|
| Broken-image icon in the mail | logo embedded as `data:image/...;base64` | Outlook ignores `data:` URIs — send a **CID inline attachment** and keep `src="cid:high-logo"` |
| "Show blocked content" banner, no images | logo referenced by an `https://` URL | expected for remote images; CID avoids it |
| Logo missing only for Windows Outlook users | WebP or SVG asset | Outlook does not render WebP/SVG — use PNG/JPG (the `logos/Yelo_logo_text_only.png` was converted from the WebP for this reason) |
| Logo attaches but does not display | Graph `contentId` written as `"<high-logo>"` | it must be the bare id `high-logo` so it matches `cid:high-logo` |

### 5.2 Step timings in the IDE

- `StepTimingFormatter` is a Cucumber **plugin**; IDE runs that start a `.feature` directly ignore
  `@CucumberOptions`, so the plugin never loads. `stepdefs.generic.Hook` therefore prints timings
  itself when `StepTimingFormatter.isActive()` is false.
- `cucumber.properties` also registers the formatter (`cucumber.plugin=...`) so IDE runs may get the
  real step text; runner options override it for Maven runs.
- Adding a second print in a step definition produces duplicate lines — don't.

### 5.3 "Green build, failed scenario"

Surefire reports `Tests run: 0` for `@RunWith(Cucumber.class)` runners in this Maven version, so a
failed scenario can still yield `BUILD SUCCESS`. Any CI gate must check the Extent JSON
(`test output/Json/ExtentJson.json`), the copied HTML report, or follow the MCP runner pattern
(`TestRunner_Yelo_MCP_Login_Page` asserts `Main.run` exit status).

### 5.4 MCP folder and glue gaps

`TestRunner_Yelo_MCP_Login_Page` runs the **whole** `feature/yelo/AI MCP/` folder with
`--glue stepdefs.mcp`. `ejar login with ai local weight Ollama.feature` in that folder has its steps
in `stepdefs.ejar.web.AiStepDefs`, so they are **undefined** there and the runner fails regardless of
the MCP scenarios. The runner that matches those steps, `TestRunner_Ejar_Login_With_AI`, points at
`feature/ejar/web/ai`, which is **empty** — so the Ollama scenario currently has no runner that can
execute it. Options: add `stepdefs.ejar.web` to the MCP runner's glue, move the Ollama feature under
`feature/ejar/web/ai` (and give that runner the right glue), or exclude it from the MCP path.

### 5.5 Windows and long paths

Feature/locator paths plus deep `Generated_Build` folders can exceed the 260-character limit. Use
`git -c core.longpaths=true …` (or set it per repo) for checkout/status/diff on deep trees; IDE
checkouts of very long paths may fail silently and leave directories empty.

### 5.6 IDE after a fresh clone

`.idea/` is untracked. IntelliJ must re-import the Maven project (`pom.xml` → *Add as Maven Project*
or **Reload All Maven Projects**) or source roots and Lombok annotation processing (`@Slf4j`) are
missing and the project appears "not runnable".

### 5.7 Generated files churn `git status`

`customReports/` and `test output/` were tracked historically. After a run, `git status` shows
deleted/regenerated PNG/WebM/JSON files. **Never `git add .` blindly** — stage source files
explicitly, or restore the artefacts first.

### 5.8 Waiting

`Element` waits honour `driver.element.wait` (default **120 s**) and log every retry. A scenario that
"hangs" is usually one locator that changed; check the console for the repeated
`Waiting for element: <key>` lines before raising timeouts.

### 5.9 Dead Maven profiles

`pom.xml` still lists `TestRunner_Alyam_*` profiles whose runner classes and features no longer
exist. Selecting them runs zero tests and "passes". Do not use them as evidence of coverage.

### 5.10 Misc

- Pie-chart generation logs `chartTempFolder … The system cannot find the path specified` — the
  folder is missing; harmless for the production mail, but create it if charts are expected.
- `PropManager` loads **all** `.properties` files from `src/test/resources`; duplicate keys across
  files resolve by map order. Change the file the runner actually reads.
- Arabic content is UTF-8; keep the encoding when editing feature files and mail templates.
- `MicrosoftGraphMailSender.main` contains sample credentials for manual runs — do not copy them.

---

## 6. Recent changes worth knowing (newest first)

| Area | Change |
|---|---|
| Report e-mail | Rebuilt the production "Automation Test Report" on the Yelo layout: merged logo + title into one purple header cell (`#4D0970`), 196 px logo, tightened header (≈117 px) and footer (≈130 px), white footer text with the word "Yelo" in `#FACB03`, footer now says Yelo / `info@iyelo.com` |
| Report e-mail | Logo switched to the Yelo wordmark (`logos/Yelo_logo_text_only.png`, converted from WebP) and resolution made resilient to file renames |
| Report e-mail | Logo delivery fixed for Outlook: CID inline attachment instead of base64 data URI; Graph `contentId` corrected to `high-logo` |
| Report e-mail | `emailProperites.properties`, `RentalAgentEmail.properties` rebranded from QOAD to Yelo (titles, alt text, footer copy, colours) |
| IDE/console | Per-step timings now print for ordinary features too (`Hook` + `StepTimingSupport`), matching the AI/MCP output |
| AI | New `validateAgainstMockup(...)` + step `DeepSeek compares the opened page with the mockup image "…"` in `feature/yelo/AI MCP/yelo login page via mcp.feature`; mockups live in `src/test/resources/mockups/<project>/` |
| Tooling | `TestRunner_Yelo_MCP_Login_Page` added: runs AI/MCP scenarios through Cucumber `Main.run` and asserts the exit status |
| Hygiene | `.idea/`, `*.iml`, `target/`, `**/playwright-mcp/`, `**/AI Agent Credentials/` are gitignored; tracked `.class` files were removed |

---

## 7. Known gaps / safe next steps

1. MCP runner glue gap (§5.4) — the Ollama feature cannot pass under `stepdefs.mcp`, and its own
   runner (`TestRunner_Ejar_Login_With_AI`) selects an empty `feature/ejar/web/ai` folder.
2. Dead `Alyam` profiles in `pom.xml`.
3. `verify form page fields…` soft-assert failures are converted to step failures in `Hook`; treat
   those steps as multi-element assertions when triaging.
4. Report artefacts are still partially tracked in `customReports/`; consider ignoring the folder
   once history allows.
5. `personaplex-setup/` and `uploadFiles/` are separate concerns — don't fold them into test code.

---

## 8. Definition of done (checklist)

- [ ] `mvn -B -DskipTests test-compile` passes.
- [ ] New/changed scenarios verified with the Cucumber dry run (§3.1).
- [ ] Feature title still matches its runner's `name = {...}` filter (if any).
- [ ] Locators are in `locators/**`, not inline in features or steps.
- [ ] No secrets, no generated artefacts, no `.idea`/`target` files staged.
- [ ] If the e-mail changed: rendered and visually inspected (§3.2), Outlook-safe assets only.
- [ ] If a production/live scenario changed: side effects (bookings, e-mails, uploads) reviewed with
      the requester before running.
- [ ] Notes added to this file when a new pitfall is discovered.

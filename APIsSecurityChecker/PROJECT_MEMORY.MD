# PROJECT_MEMORY.md

Persistent project notes for **`APIsSecurityChecker`** — a small Spring Boot service that scans the
Ejar API surface for endpoints that respond **without authentication** and e-mails the findings.

> This file answers *what this project is and what it contains*.
> Working rules, known defects and verification recipes live in [AGENT.md](AGENT.md).

---

## 1. What it is

A standalone Spring Boot web application that:

1. downloads the **Swagger/OpenAPI document** of an Ejar environment,
2. extracts every documented path + HTTP verb,
3. calls each endpoint **without any authorization header**,
4. classifies the response, and
5. renders a branded HTML report and sends it by e-mail through **Microsoft Graph**.

It is a security smoke test for "did we forget `[Authorize]` on this controller?", not a full
penetration-testing tool: there is no payload fuzzing, no token tampering and no vulnerability
scanning beyond the unauthenticated-access check.

The result e-mail uses the Yelo report layout shared with the `ejarautomation-playwright` project:
a purple `#4D0970` header band with the Yelo wordmark and report title, three summary cards
(`TOTAL APIS VALIDATED`, `WITH AUTHENTICATION`, `WITHOUT REQUIRED AUTH`), a table of the suspect
endpoints and the timestamp of the run.

---

## 2. Quick facts

| Item | Value |
|---|---|
| Runtime | Spring Boot **2.1.0.RELEASE**, Java **11** target (`java.version` in `pom.xml`), Maven wrapper included |
| Coordinates | `eyad.com.example:h2o:1.0.0` — name *Generator*, description *"Eyad Yelo Test Cases Generator"* (legacy naming from the tool this was forked from) |
| HTTP port | **8083** (`server.port` in `src/main/resources/application.properties`) |
| Entry point | `eyad.com.yelo.apisecuritychecker.ApiSecurityChecker` |
| Trigger | `GET /SecurityValidator/ValidateEjarAPIs/` |
| Classes | **25** main + **1** test = 26 Java files |
| Tests | one Spring context smoke test (`ApiSecurityCheckerTests.contextLoads`) |
| Reporting | ExtentReports 5.0.7 + `extentreports-cucumber6-adapter` (both inherited from the parent framework, not actually used by the live flow) |
| Email transport | Microsoft Graph (`MicrosoftGraphMailSender`, client-credentials flow) |
| Persistence | none — DataSource/JPA/Mongo auto-configuration are explicitly excluded |

**Repository status:** the folder exists **only on disk**. It is not present in `HEAD` of the
`ejarconnected` repository (`git ls-files APIsSecurityChecker` is empty), so it is not built by CI and
is not part of the shared history of the mirror. Treat it as a locally maintained utility.

---

## 3. How a scan runs

```
GET /SecurityValidator/ValidateEjarAPIs/
        │
        ▼
SecurityCheckerController ──► CheckerService.validateAPisSecurityForEjar()
        │
        ├─ 1. RestTemplate GET  {ejar.environment.url}swagger/v1/swagger.json
        ├─ 2. regxExtractor(...)  → Map<fullUrl, verb>   (regex over the raw Swagger JSON)
        ├─ 3. for each entry: requestAPi(url, verb)      (no auth headers at all)
        │        → String[]{ url, verb, suspectFlag, responseMessage }
        ├─ 4. collect url → "verb,suspectFlag,response"
        ▼
SendAggregatedReport.buildTestResultsContent(map)
        ├─ addResultRecords(...)        → table rows (only rows whose suspectFlag == "true")
        ├─ fillGeneralDateResults(...)  → the three summary cards
        ├─ substitutes GeneralDataVariable / TimestampVariable / CurrentYearVariable
        ▼
EmailHandler.sendReportEmail(subject, content, "alert.email.to")
        └─ MicrosoftGraphMailSender (Graph sendMail, inline CID icons + logo)
```

`CheckerService` runs **synchronously inside the HTTP request thread**; the controller replies
`202`-style JSON immediately only after the whole scan has finished (the scan can take minutes).

### 3.1 Classification logic (read this before trusting the report)

`CheckerService.requestAPi` initialises `suspectFlag = "false"` and then:

| Outcome of the unauthenticated call | suspectFlag | Meaning in the report |
|---|---|---|
| `401 Unauthorized` (exception message contains `401`) | `"false"` | counted as **WITH AUTHENTICATION** |
| Any other exception (`403`, `404`, `500`, timeout, SSL error …) | `"true"` | counted as **WITHOUT REQUIRED AUTH** and listed in the table |
| Success (HTTP 200) | `"false"` | counted as **WITH AUTHENTICATION** — **incorrect**: a fully public endpoint looks protected |

So a `200 OK` from an unauthenticated call is **not** reported as a finding. The table is also
filtered to `suspectFlag == "true"`, which means suspicious-but-successful endpoints are invisible
in the e-mail. Fixing this is the top known issue — see AGENT.md §5.1.

### 3.2 Swagger parsing

`regxExtractor` uses the pattern `(?=")(.*):\s+\{\s+("post"|"get"|"put"|"delete")` against the raw
JSON text and prefixes every hit with `ejar.environment.url`. It therefore depends on the formatting
of the generated Swagger document (item order `"path": { "verb"`) and on the document exposing verbs in
lowercase inside an object. Nested objects, `parameters`-only entries or `$ref`-based paths are not
handled. Nothing validates that the extracted URL is a real route.

---

## 4. HTTP API

`GET /SecurityValidator/ValidateEjarAPIs/` → `application/json`

```json
// 200 — scan completed, e-mail dispatched
{ "status": "success", "message": "API security validation started. Email will be sent upon completion." }

// 500 — unexpected failure while scanning
{ "status": "error", "message": "An error occurred: <exception message>" }
```

Note the response body says "started", but the scan has already finished by the time it is returned.

---

## 5. Project structure

```
APIsSecurityChecker/
├── pom.xml                     Spring Boot 2.1 parent, Java 11, Graph/Selenium/Extent/… deps
├── mvnw, mvnw.cmd, .mvn/       Maven wrapper (keep the wrapper jar tracked via the .gitignore exception)
├── .gitignore                  target/, IDE files
├── data/
│   └── APIs Automation Regression Test Cases.csv   2.3 MB legacy dataset (NOT read by the code)
├── email html/                 images referenced by the report template (logo + footer icons)
├── datanull                    0-byte stray file left by an earlier property-loading failure
└── src/
    ├── main/java/eyad/com/yelo/apisecuritychecker/
    │   ├── ApiSecurityChecker.java              Spring Boot main + @EnableScheduling
    │   ├── controller/SecurityCheckerController.java   REST trigger
    │   ├── service/CheckerService.java          swagger fetch → extract → probe → report
    │   ├── service/ApiRequester.java            header template (currently unused)
    │   ├── service/SendEmailHandler.java        legacy report/e-mail path (unused)
    │   ├── business/PropManager.java            loads every .properties from src/test/resources
    │   ├── business/SendAggregatedReport.java   HTML report builder + send trigger
    │   ├── business/EmailHandler.java           recipients, CID inline images, Graph call
    │   ├── business/MicrosoftGraphMailSender.java  raw Graph sendMail JSON
    │   ├── business/PieChartGenerator.java      chart helper (only used by legacy SendEmailHandler)
    │   ├── business/{DateHelper,FileHandler,RegxHelper,ReportDataHandler,RunResultsInformation}.java
    │   ├── business/UploadToGoogleDrive.java    legacy uploader (unused)
    │   ├── business/DriverQuickStart.java       legacy Selenium helper (unused)
    │   ├── cron/MyScheduledTask.java            fully commented out
    │   ├── annotation/LogMethodExecutionTime.java + aspect/…Aspect.java   timing AOP (annotation never applied)
    │   ├── bean/{EjarAuthenticationEntity,EyadTest,RegexSearchPayloadWrapper}.java   unused DTOs
    │   └── utility/{JsonUtility,RegxHelper}.java   second RegxHelper copy
    ├── main/resources/application.properties    server.port=8083, DEBUG logging
    ├── main/resources/{banner.txt,img.png}      Spring banner / classpath image
    └── test/
        ├── java/…/ApiSecurityCheckerTests.java  contextLoads smoke test
        └── resources/
            ├── appProperties.properties         environment URL, recipients, SMTP, Graph keys
            ├── emailHtml.properties             report.email.body + report.email.footer (Yelo-branded HTML)
            ├── alertEmailHtml.properties        legacy alert template (unused)
            ├── defaultHeaders.properties        header set for the unused ApiRequester
            └── ejar apis/authenticate.properties  authenticate.uri
```

---

## 6. Configuration

`PropManager` reads **every** `.properties` file directly under
`System.getProperty("user.dir") + "/src/test/resources/"` and exposes the merged values through
`getProperty(name)`. Consequences:

- the application must be started with the **project root as the working directory** (running the
  packaged jar from elsewhere silently loses the configuration),
- properties live in `src/test/resources` even though the app is `main`-scoped,
- duplicate keys across files are resolved by load order.

| Key | File | Purpose |
|---|---|---|
| `ejar.environment.url` | `appProperties.properties` | Base URL; the scan requests `<base>swagger/v1/swagger.json` and prefixes every extracted path with it |
| `security.report.email.to` | `appProperties.properties` | Default recipient list (used by the 2-arg `sendReportEmail`) |
| `alert.email.to` | `appProperties.properties` | Recipient list actually used by the scan report |
| `email.user` | `appProperties.properties` | Sender mailbox (Graph `from`) |
| `email.smtp.*` | `appProperties.properties` | Legacy SMTP settings, unused by the Graph path |
| `onedrive.client.id` / `.secret` / `.tenant.id` | expected (not present in this folder's copy) | Graph app registration used to send the mail; tenant falls back to a hard-coded GUID in `EmailHandler` |
| `report.email.body`, `report.email.footer` | `emailHtml.properties` | Report HTML shell (contains `GeneralDataVariable`, `TimestampVariable`, `CurrentYearVariable`) |
| `authenticate.uri` | `ejar apis/authenticate.properties` | Login endpoint used by the legacy `EjarAuthenticationEntity` flow |
| `server.port` | `application.properties` | 8083 |

---

## 7. Report e-mail

- Template: `report.email.body` + the generated rows + `report.email.footer`, all in
  `emailHtml.properties`.
- Placeholders replaced at runtime: `GeneralDataVariable` (summary cards), `TimestampVariable`
  (`YYYY-MM-dd HH:mm:ss`), `CurrentYearVariable` (footer year).
- Subject: `APIs Automated Security Validation  <timestamp>`.
- Recipients: the comma-separated list in **`alert.email.to`**.
- Inline images (`cid:`): `email.svg`, `mobile.svg`, `location.svg` and the logo
  (`email html/Yelo logo.png`) are attached with matching `contentId`, not embedded as `data:` URIs —
  this is required because Outlook/Gmail block data URIs.
- Sending happens on a **new thread** (`SendAggregatedReport.sendResultsEmail`), so a short-lived CLI
  run can exit before the mail leaves.

The header and footer follow the Yelo report layout shared with `ejarautomation-playwright`: a purple
`#4D0970` header band carrying the wordmark and the report title, and a purple footer with the white
English/Arabic copyright lines (the word "Yelo" in `#FACB03`), `info@iyelo.com` and the contact row.

---

## 8. Running

```bash
cd ejarconnected/APIsSecurityChecker

./mvnw -DskipTests compile                  # verified to succeed
./mvnw spring-boot:run                      # starts on http://localhost:8083
# or
./mvnw -DskipTests package && java -jar target/h2o-1.0.0.jar

curl http://localhost:8083/SecurityValidator/ValidateEjarAPIs/
```

The scan needs network access to the Ejar environment in `ejar.environment.url` and Graph
credentials in order to deliver the mail. There is no dry-run mode; running it against a live
environment will fire unauthenticated requests at **every** endpoint in the Swagger document.

---

## 9. Legacy / unused inventory

These compile but are not reachable from the live flow. Do not wire them in without a reason and a
review.

| Component | Status |
|---|---|
| `service.SendEmailHandler` | Old report/e-mail path, superseded by `SendAggregatedReport` |
| `service.ApiRequester` | Header template only; `defaultHeaders.properties` is unused |
| `business.DriverQuickStart` | Selenium/Chrome helper from the browser-automation era |
| `business.PieChartGenerator`, `business.UploadToGoogleDrive` | Only referenced by the legacy path |
| `cron.MyScheduledTask` | Entirely commented out (a `@Scheduled` run existed once) |
| `annotation.LogMethodExecutionTime` + `aspect.RecordMethodExecutionTimeAspect` | Annotation is never applied, so the aspect never fires |
| `bean.EjarAuthenticationEntity`, `bean.EyadTest`, `bean.RegexSearchPayloadWrapper` | Unused DTOs |
| `utility.RegxHelper` | Duplicate of `business.RegxHelper` |
| `data/APIs Automation Regression Test Cases.csv` | 2.3 MB export from the original "test cases generator"; no code reads it |
| `test/resources/alertEmailHtml.properties` | Alert template, unused |
| `email html/unlocker-setup.exe` | 2.1 MB stray Windows binary — should not be committed |

---

## 10. Security notes

- The project is **not tracked** in the mirror repository, but treat anything added here as public if
  it is ever committed: `appProperties.properties` contains real mailbox names and the Graph
  credentials are expected in the same file family.
- `MicrosoftGraphMailSender.main` contains sample fallback credentials for manual testing — never copy
  them into new code, logs or issues.
- The scanner deliberately sends **unauthenticated** requests to a live environment; only run it
  against environments you are allowed to probe, and be aware it may hit destructive verbs
  (`POST`/`PUT`/`DELETE`) on unprotected endpoints.

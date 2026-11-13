# AGENT.md

Working agreement for coding agents (and humans) touching **`APIsSecurityChecker`**.

Read [PROJECT_MEMORY.md](PROJECT_MEMORY.md) first for *what* the service does. This file covers
**how to change it safely**.

---

## 1. Read before you edit

| You are changing… | Read first |
|---|---|
| The scan itself | `service/CheckerService.java` (`validateAPisSecurityForEjar`, `requestAPi`, `regxExtractor`) |
| What counts as a finding | `CheckerService.requestAPi`, `SendAggregatedReport.addResultRecords` and `fillGeneralDateResults` — the flag is used in **three** places |
| The report layout | `src/test/resources/emailHtml.properties` (HTML stored as a `.properties` value) |
| Recipients / sender | `src/test/resources/appProperties.properties` (`alert.email.to`, `email.user`) |
| Mail transport | `business/EmailHandler.java` → `business/MicrosoftGraphMailSender.java` |
| Startup/HTTP surface | `ApiSecurityChecker.java`, `controller/SecurityCheckerController.java`, `src/main/resources/application.properties` |

---

## 2. Non-negotiable rules

1. **Do not call the scan endpoint against an environment you do not own.**
   `GET /SecurityValidator/ValidateEjarAPIs/` reads the Swagger document and then sends
   **unauthenticated `POST`/`PUT`/`DELETE`** requests to every documented endpoint. On an unprotected
   endpoint that can create or delete real data.
2. **Never commit secrets or customer data.** `appProperties.properties` holds real mailboxes and is
   where Graph credentials are expected; `MicrosoftGraphMailSender.main` contains sample fallback
   credentials — never copy them into code, logs, issues or docs.
3. **This folder is not tracked by git.** `git ls-files APIsSecurityChecker` is empty; it is local to
   the machine. Do not assume CI builds it, and confirm with the owner before deleting/moving it.
4. **Do not commit artefacts:** `target/`, `datanull` (0-byte stray), `data/*.csv` (2.3 MB legacy
   export) and especially `email html/unlocker-setup.exe` (2.1 MB Windows binary that must not ship).
5. **Do not resurrect dead code** (see §5.5) unless the task is explicitly about it.
6. **Keep the e-mail Outlook-safe:** images stay `cid:` inline attachments. `data:` URIs are ignored
   by Outlook and remote images are blocked behind "download images".

---

## 3. Build, run, verify

```bash
cd ejarconnected/APIsSecurityChecker

./mvnw -DskipTests compile          # compile gate — verified passing
./mvnw spring-boot:run              # starts Spring Boot, listens on :8083
curl http://localhost:8083/SecurityValidator/ValidateEjarAPIs/    # ⚠ starts a real scan (see §2.1)
```

Observed environment facts (verified 2026-11-13):

- `./mvnw -DskipTests compile` → **BUILD SUCCESS**.
- `./mvnw spring-boot:run` → starts and **listens on 8083**, even though `pom.xml` targets Java 11 and
  the wrapper picked up a modern JDK (JDK 22 on the verification machine). Spring Boot 2.1 is EOL —
  treat a version upgrade as a separate project, not a drive-by change.

### 3.1 How to verify a change safely

There is no unit-test coverage beyond `contextLoads`, and no "dry-run" switch. Practical options:

1. `./mvnw -DskipTests compile` — always.
2. Start the app and confirm the log line `Started ApiSecurityChecker in …` — do **not** hit the
   endpoint on a real environment.
3. To exercise the scan, point `ejar.environment.url` at a **test/staging** host (ideally one with a
   throwaway database) or serve a small local `swagger/v1/swagger.json` stub and run against that.
4. For the report rendering, the fastest loop is to call
   `new SendAggregatedReport("Automation API Security Validation").buildTestResultsContent(map)` from a
   scratch class with a hand-made `Map<String,String>` (`url → "get,true,404"`), intercept the send by
   pointing `alert.email.to` at your own mailbox.

---

## 4. Where to change what

| Goal | Touch |
|---|---|
| Classify results differently (e.g. treat `200` as a finding) | `CheckerService.requestAPi` + the filter in `SendAggregatedReport.addResultRecords` + the counting in `fillGeneralDateResults` |
| Change the summary cards / table columns | `SendAggregatedReport.addResultRecords`, `fillGeneralDateResults`, `statCard` |
| Change the HTML shell | `src/test/resources/emailHtml.properties` (`report.email.body`, `report.email.footer`) |
| Change recipients / sender | `appProperties.properties` (`alert.email.to`, `security.report.email.to`, `email.user`) |
| Change what gets scanned | `CheckerService.regxExtractor` (swagger parsing) and/or `ejar.environment.url` |
| Add request headers (only if the scan ever needs auth) | `CheckerService.requestAPi` — note `ApiRequester` is dead code today |

---

## 5. Known issues and pitfalls

### 5.1 A protected-looking result may be a fully public endpoint (top issue)

`requestAPi` starts with `suspectFlag = "false"` and only flips it to `"true"` when the call throws an
exception whose message does **not** contain `401`. Consequences:

- **HTTP 200 without a token** → `"false"` → counted as *WITH AUTHENTICATION* and hidden from the
  table (`addResultRecords` renders only `"true"` rows).
- `403`, `404`, `500`, timeouts and SSL errors → `"true"` → listed as *WITHOUT REQUIRED AUTH*, which
  over-reports broken URLs and under-reports genuinely open endpoints.

If you fix this, fix all three call sites (§4) and update the summary labels accordingly.

### 5.2 The scan is destructive by design

Every extracted `post`/`put`/`delete` path is invoked with an empty JSON body
(`objectConverterToJSONString(new Object())` → `{}`) and **no auth**. An unprotected delete endpoint
will delete. Never point this at production data you care about.

### 5.3 No timeouts, synchronous request thread

`RestTemplate` is created per call with default settings: **no connect/read timeout**. A hanging
endpoint blocks the scan, which blocks the controller thread, which blocks the caller. If you add
timeouts, add them here (`SimpleClientHttpRequestFactory` / `RequestConfig` + `HttpComponents`), not in
the controller.

### 5.4 The controller message is misleading

`/ValidateEjarAPis/` returns *"validation started"* only **after** `validateAPisSecurityForEjar()`
has finished (the method is synchronous). Long scans look like hung requests to the caller.

### 5.5 Dead code — do not wire in

`SendEmailHandler`, `ApiRequester` (+ `defaultHeaders.properties`), `DriverQuickStart`,
`PieChartGenerator`, `UploadToGoogleDrive`, `MyScheduledTask` (fully commented out), the
`@LogMethodExecutionTime` annotation + `RecordMethodExecutionTimeAspect` (annotation never applied),
`EjarAuthenticationEntity`, `EyadTest`, `RegexSearchPayloadWrapper`, `alertEmailHtml.properties`,
`data/APIs Automation Regression Test Cases.csv`.

### 5.6 E-mail is sent on a detached thread

`SendAggregatedReport.sendResultsEmail` starts `new Thread(...)`. In a short-lived process (e.g.
`java -jar` from a script) the JVM can exit before the mail leaves, and send failures are only printed
to stdout. If you need reliable delivery, consider joining the thread or returning a status.

### 5.7 Configuration depends on the working directory

`PropManager` reads `System.getProperty("user.dir") + "/src/test/resources/"`. Run the app from the
project root (`./mvnw spring-boot:run` does). A packaged jar started from another directory will find
no properties and fail quietly (the 0-byte `datanull` file in the repo root is a relic of such a
failure path).

### 5.8 Graph credentials are easy to misconfigure

`EmailHandler` reads `onedrive.client.id` / `onedrive.client.secret` / `onedrive.tenant.id`. The tenant
silently falls back to a **hard-coded GUID** when unset. If the client id/secret are missing, the send
throws and is caught — the scan "succeeds" with no mail. Check the console for
`Error sending email: …`.

### 5.9 `.properties` HTML breaks easily

`emailHtml.properties` stores an entire HTML document using `\` line continuations. A missing or extra
backslash silently truncates or corrupts the mail. After editing, load the file
(`new PropManager().getProperty("report.email.body")`) and confirm the value is still one coherent
document before running a scan.

### 5.10 Two `RegxHelper` classes

`business.RegxHelper` and `utility.RegxHelper` are duplicates. `CheckerService` does not use either
(it calls its own `regxExtractor`), but imports elsewhere may resolve to either one — check the import
before editing.

### 5.11 Legacy naming is intentional noise

The Maven coordinates are `eyad.com.example:h2o`, the name is *Generator*, and javadoc says
`eyadm@amazon.com`. These are historical; renaming is a coordinated refactor, not a cleanup.

### 5.12 Branding and e-mail assets

The project is branded **Yelo**: package namespace `eyad.com.yelo`, templates, footer copy and
`info@iyelo.com`. The report logo is `email html/Yelo logo.png`, sent as a `cid:high-logo` inline
attachment. Keep it that way — Outlook ignores `data:` URIs, blocks remote images and cannot render
WebP/SVG, so convert new brand assets to PNG/JPG before referencing them. The `*legacy*.png` files in
`email html/` are the previous brand's copies and are no longer referenced.

### 5.13 `application.properties` logs at DEBUG

`logging.level.root=DEBUG` produces very noisy output on every request. Lower it when profiling.

---

## 6. Definition of done

- [ ] `./mvnw -DskipTests compile` passes.
- [ ] No secrets, binaries (`unlocker-setup.exe`), `data/*.csv`, `datanull` or `target/` added.
- [ ] If classification changed: all three call sites (§4) updated and the summary labels still match.
- [ ] If `emailHtml.properties` changed: the property still loads as one HTML document (§5.9).
- [ ] If recipients/config changed: verified with a test mailbox, not the production list.
- [ ] Scan changes were exercised against a **test** environment only.
- [ ] If a new pitfall was discovered, append it here.

---

## 7. Change log (observed, not from git — the folder is untracked)

| Area | Current state |
|---|---|
| Report layout | Results table uses percentage columns (58% URL / 16% method / 26% response) with `table-layout:fixed`, compact padding and mobile media rules — on phones the URL column no longer collapses while method/response keep empty space |
| Branding | Report e-mail rebuilt on the Yelo layout: purple `#4D0970` header band + footer, `#FACB03` accent on the word "Yelo", `info@iyelo.com`; namespace `eyad.com.yelo`; logo `email html/Yelo logo.png` sent as a CID inline part |
| Mail transport | Microsoft Graph client-credentials flow (`EmailHandler` → `MicrosoftGraphMailSender`); the SMTP path and `SendEmailHandler` are legacy leftovers of a Gmail-based sender |
| Report template | Modern card layout (`stat-total` / `stat-ok` / `stat-bad`), method pills, zebra rows, `GeneralDataVariable` + `TimestampVariable` placeholders |
| Robustness | `validateAPisSecurityForEjar` gained null/empty guards for the swagger response and the result map before building the report |
| Swagger source | Switched from the old API list to `swagger/v1/swagger.json` scraped with a regex |
| Scheduling | The cron trigger is commented out; the scan is only reachable through the REST endpoint |

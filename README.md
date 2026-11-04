# ejarconnected

Test automation for the Ejar platform — a Java + Maven (Cucumber/JUnit + Playwright/Selenium)
framework driven by `TestRunner*` classes under `ejarautomation-playwright/`.

## Layout

```
ejarautomation-playwright/
├── pom.xml                 # Maven build, test profiles and dependencies
├── src/main/               # Framework code (page objects, utilities, step definitions)
├── src/test/               # Feature files, runners and test resources
├── drivers/                # Browser drivers and bundled automation jars
└── personaplex-setup/      # Local AI-assistant setup (vendored third-party tool)
```

## Requirements

- JDK 17
- Maven 3.8+
- Chrome / Firefox (drivers are bundled under `drivers/`)

## Running

The default run executes every `**/TestRunner*.java` class:

```bash
cd ejarconnected/ejarautomation-playwright
mvn test
```

A single suite can be selected with one of the profiles defined in `pom.xml`, for example:

```bash
mvn test -P ejar-verification-forms-ar
```

## Credentials (not committed)

The Google Drive uploader authenticates with a service-account key that is intentionally
excluded from version control. To enable it locally, place the key at the project root:

```
ejarautomation-playwright/yeloautomationresultsdrive-<id>.json
```

The filename is read from `google.drive.service.account.key.file` in
`src/test/resources/appProperties.properties`. Share the target Drive folder with the
service account's `client_email`.

## Security

This repository is public. Do not commit API keys, service-account JSON files, passwords or
customer data. Configuration that carries a secret should be injected through environment
variables rather than checked-in defaults.

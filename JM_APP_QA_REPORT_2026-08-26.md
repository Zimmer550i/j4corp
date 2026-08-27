# JM App — QA report

Date: 2026-08-21
Device: Samsung Galaxy Z Fold6 (`SM-F956U`), Android 16
APK SHA-256: `788362F7F0923CC1B5FE1D1D3D96363411D2A6511AB1533483FACBDE3BF32C2B`

> Private QA document. Credentials, session tokens, and personal data are omitted.

## Verified

- APK installs successfully as an update and retains app data.
- APK signature matches the previously installed build.
- App launches without crashing.
- Login succeeds against `https://api.jm.j4corp.net/`.
- Home screen loads after authentication.
- Schedule Service screen loads without an immediate error.
- Empty Select Unit flow offers an **Add New** action instead of crashing.
- Sell Us Your Bike screen loads without an immediate error.
- Inbox eventually renders an empty Jimenez Motorsports conversation; no QA message was sent.
- Settings screen loads without an immediate error.
- Personal Information and Edit Profile load successfully; no profile changes were saved during QA.

## Issues

### JM-MOB-SEC-001 — Authentication tokens written to Android logs

- Severity: Critical
- Steps: Launch the app and sign in, then inspect process logs through ADB.
- Expected: Passwords, access tokens, refresh tokens, authorization headers, and full authentication payloads are never logged.
- Actual: The app logs the complete successful login response, including access and refresh tokens and personal profile data.
- Evidence: ADB process log at login time. Sensitive values are intentionally not copied into this report.
- Required fix: Remove response-body logging from release builds; redact security and personal fields in development logging; rotate/revoke exposed test tokens; verify release logging is disabled.

### JM-MOB-AI-001 — AI feature uses an unreachable private development endpoint

- Severity: Critical / release blocker
- Steps: Sign in and open **Meet Your AI Assistant**.
- Expected: The app creates a chat session through a production HTTPS endpoint.
- Actual: The screen shows `Exception: Something went wrong. Please try again.`
- Root cause: The release APK calls `http://10.10.12.46:8001/sessions?...`, which is a private LAN address and returns `No route to host` outside the developer network.
- Evidence: User screenshot and ADB process log at 13:43 CDT.
- Required fix: Deploy the AI service behind a production HTTPS hostname, configure the release flavor to use it, remove private development URLs, rebuild, and test from an external network.

### JM-MOB-BUILD-001 — Updated APK did not increment Android version

- Severity: High / store blocker
- Expected: Every distributed build has a monotonically increasing `versionCode` and meaningful `versionName`.
- Actual: Updated APK remains `versionCode=1`, `versionName=1.0.0`, identical to the previous build.
- Required fix: Increment both values before the next QA build and every store upload.

### JM-MOB-ID-001 — Placeholder application identifier

- Severity: High / store blocker
- Actual: Package identifier is `com.example.j4corp`.
- Required fix: Select a permanent reverse-domain application ID owned by J4Corp before store submission. Changing it later creates a different application and breaks upgrade continuity.

### JM-MOB-CONFIG-001 — Development URLs embedded in release APK

- Severity: High
- Actual: Release binary contains `http://10.10.12.111:8000` and `http://10.10.12.46:8001` in addition to the production API URL.
- Required fix: Remove development endpoints from the release flavor and enforce HTTPS-only production configuration.

### JM-MOB-UI-001 — Incorrect agreement text on login

- Severity: Low
- Actual: Login screen says `By signing up...` while the user is signing in.
- Required fix: Use sign-in language or show this agreement only during account creation.

### JM-MOB-UI-002 — Ambiguous avatar placeholder

- Severity: Low
- Actual: Home screen avatar renders as an exclamation icon.
- Required fix: Provide a recognizable default avatar and verify profile-image error handling.

### JM-MOB-PROFILE-001 — Date of birth validation permits invalid/future values

- Severity: High
- Steps: View the supplied QA account in Personal Information/Edit Profile.
- Expected: Date of birth must not be in the future and must satisfy the approved minimum-age rule.
- Actual: The stored birthday is `12 August, 2026`, demonstrating that invalid date-of-birth data is accepted or remains unvalidated.
- Evidence: User screenshots and profile API response.
- Required fix: Enforce server-side and client-side date constraints, reject future dates, apply the approved age requirement, and remediate invalid existing records.

### JM-MOB-SVC-003 — Appointment detail loses its associated unit

- Severity: High
- Steps: Open Settings > Scheduled Services and view/edit the appointment dated 05 September 2026.
- Expected: Select Unit shows the motorcycle associated with the appointment and does not permit an orphaned appointment.
- Actual: The service description, location, and date are populated, but Select Unit remains empty.
- Evidence: User screenshot.
- Required fix: Persist and return the unit relationship, render the selected unit, and prevent save/submission when the association is missing.

### JM-MOB-SEC-002 — Authenticated user can access another customer's service records

- Severity: Critical / security and privacy release blocker
- Steps: Sign in as the supplied non-admin QA user and open **Settings > Scheduled Services**.
- Expected: The API returns only service/appointment records owned by the authenticated user (unless an explicitly authorized staff role is used).
- Actual: `GET /v1/unit/services/` returns records whose `full_name` is `Rakib Admin`, including that customer's email, unit IDs/models, locations, appointment dates, and service details. The current QA user's Garage is empty.
- Evidence: User screenshot plus ADB log of the authenticated API response. Sensitive fields are omitted from this report.
- Impact: Cross-account personal and service-data disclosure; likely broken object-level authorization. Detail/update/cancel endpoints may also permit unauthorized modification and must be treated as compromised until tested/fixed.
- Immediate QA action: No record was modified or cancelled. The app was force-stopped when its unit-request loop restarted.
- Required fix: Enforce ownership filtering and object-level authorization server-side on list/retrieve/update/delete/cancel endpoints; never rely on client filtering. Add negative authorization tests with two unrelated users, review access logs, assess exposure, and rotate/revoke affected test sessions as appropriate.

### JM-MOB-SVC-004 — Appointment location conflicts with dealership options

- Severity: High
- Actual: Existing appointment shows `Main HQ`, while Add Unit/Schedule Service offers BMW San Antonio, BMG Xtreme Sports, and Triumph Houston; RGV is missing.
- Expected: Appointment records reference the same authoritative dealership/location dataset used throughout the app.
- Required fix: Replace stale fixture/location values, migrate existing records, and enforce one shared location source.

### JM-MOB-SVC-005 — Scheduled appointments and completed service history need explicit separation

- Severity: Medium / product requirement clarification
- Observation: The detail view is an editable appointment form with Cancel Appointment and Save Changes. The displayed example is future-dated, so cancellation is appropriate for this record.
- Expected information architecture: Upcoming/scheduled appointments remain editable/cancellable; completed services appear in a read-only history tied to each motorcycle, including date, dealership, work performed, mileage, status, and documents where applicable.
- Required fix: Show explicit status and separate Upcoming from Service History. Never offer cancellation for completed work.

### JM-MOB-SVC-006 — Scheduled Services lacks status and chronological ordering

- Severity: Medium
- Actual: Future dates appear in the order Sep 5, Sep 2, Sep 4, followed by past-dated Aug 13. No Upcoming/Completed/Cancelled status is displayed.
- Expected: Records are separated by status and ordered predictably, normally nearest upcoming first and completed history newest first.
- Required fix: Add explicit lifecycle status, split/filter the views, and apply deterministic server-side ordering.

### JM-MOB-UI-003 — Cancel Appointment label is clipped

- Severity: Low
- Actual: `Cancel Appointment` does not fit cleanly within its button on the Fold6 viewport.
- Required fix: Use responsive button layout, wrapping, or vertical stacking and test supported screen sizes/font scales.

### JM-MOB-A11Y-001 — Bottom navigation lacks visible labels

- Severity: Medium
- Actual: Only the selected Home item shows a text label; other destinations are icon-only.
- Required fix: Add persistent labels or verify accessible names and selected-state behavior against the approved design/accessibility requirements.

### JM-MOB-DLR-001 — Home omits two required dealerships

- Severity: High
- Steps: Sign in, open Home, and review the complete **Our Dealerships** list.
- Expected: BMW SA, Triumph HOU, RGV, and BMG-X are all displayed.
- Actual: Only BMW SA and Triumph HOU are available; RGV and BMG-X are missing.
- Evidence: User verification on the Fold6 and Home screenshot. The Add Unit selector includes BMG Xtreme Sports but not RGV, while Home omits both BMG-X and RGV.
- Required fix: Confirm the authoritative dealership data source, include all four locations, ensure active/status filtering is correct, and add a QA test asserting the expected list.

### JM-MOB-DLR-002 — Dealership data is inconsistent across screens

- Severity: High
- Steps: Compare the Home dealership cards with **My Garage > Add Unit > Store Location**.
- Expected: Both views use the same authoritative, complete list.
- Actual: BMG Xtreme Sports appears in Store Location but not Home. RGV appears in neither view. BMW San Antonio and Triumph Houston appear in both.
- Evidence: User screenshots of Home and the Store Location dropdown.
- Required fix: Replace duplicated/hard-coded dealership lists with one backend-driven data source and test cross-screen consistency.

### JM-MOB-COPY-001 — BMG city misspelled

- Severity: Low
- Steps: Open the Store Location dropdown.
- Expected: `Las Vegas`.
- Actual: `Lav Segas`.
- Evidence: User screenshot.
- Required fix: Correct the dealership location data at its authoritative source.

### JM-MOB-COPY-002 — Incorrect Terms label

- Severity: Low
- Actual: Settings and the legal page display `Terms Of Services`.
- Expected: `Terms of Service` (or the approved legal document title).
- Required fix: Correct capitalization and singular/plural wording consistently across the app and legal document.

### JM-MOB-LEGAL-001 — Terms of Service endpoint returns 404 and spinner never ends

- Severity: Critical / store submission blocker
- Steps: Open **Settings > Terms Of Services**.
- Expected: The approved Terms of Service document loads over HTTPS, or a recoverable error state offers retry/back navigation.
- Actual: The app displays `Error fetching Terms Of Services`, the API returns HTTP 404 for `/v1/privacy/terms-conditions/`, and the loading spinner continues indefinitely.
- Evidence: User screenshots and ADB process logs at 18:21 CDT.
- Required fix: Publish/configure the correct legal-document endpoint, populate approved content, reset loading state on every success/error path, show a useful retry action, and add endpoint/content monitoring.

### JM-MOB-LEGAL-002 — Privacy Policy endpoint returns 404 and spinner never ends

- Severity: Critical / store submission blocker
- Steps: Open **Settings > Privacy Policy**.
- Expected: The approved, current privacy policy loads over HTTPS and remains publicly accessible.
- Actual: The app briefly displays an error, `GET /v1/privacy/privacy-policy/` returns HTTP 404, and the loading spinner continues indefinitely.
- Evidence: User observation and ADB process logs at 18:33 CDT.
- Required fix: Publish the approved policy at the configured endpoint (and a stable public web URL for store listings), reset loading on failure, provide retry/back behavior, and monitor availability.

### JM-MOB-CONTENT-001 — About Us endpoint returns 404 and spinner never ends

- Severity: High
- Steps: Open **Settings > About Us**.
- Expected: Approved company/application information loads over HTTPS.
- Actual: `GET /v1/privacy/about-us/` returns HTTP 404, the app displays an error, and the loading spinner continues indefinitely.
- Evidence: User observation and ADB process logs at 12:17 CDT on 2026-08-26.
- Required fix: Publish/configure About Us content, end loading on failure, provide retry/back behavior, and test all production content endpoints before release.

### JM-MOB-UNIT-001 — Empty unit selector triggers an infinite API request loop

- Severity: Critical / release blocker
- Steps: Use an account with no registered vehicles and expand Select Unit in Services or Sell.
- Expected: One request loads the empty result, loading ends, and **Add New** remains available.
- Actual: The loading spinner never stops and the app repeatedly requests `/v1/unit/register-units/` approximately 3–4 times per second, even though every response is HTTP 200 with `results: []`. The UI becomes effectively unusable.
- Evidence: User screenshots and ADB process logs showing hundreds of repeated successful GET responses within minutes.
- Impact: Backend load amplification, battery and mobile-data consumption, degraded UI, and possible API outage if multiple clients reproduce it.
- Immediate QA action: App was safely force-stopped to terminate the request storm; no data was deleted.
- Required fix: Remove fetch calls from rebuild/render paths, fetch once per lifecycle/user action, end loading for empty success responses, deduplicate in-flight requests, add timeout/backoff safeguards, and add an automated empty-list regression test.

### JM-MOB-SVC-002 — Multiple dropdowns can remain expanded simultaneously

- Severity: Medium
- Steps: Expand Store Location, then expand Select Unit.
- Expected: Opening one dropdown collapses the other, keeping the form readable.
- Actual: Select Unit and Store Location are expanded at the same time, consuming most of the screen.
- Evidence: User screenshot.
- Required fix: Enforce a single expanded selector or use modal/bottom-sheet selection.

### JM-MOB-INBOX-001 — New empty chat room causes a visible null-cast error

- Severity: High
- Steps: Open Inbox for a user without an existing conversation.
- Expected: A new/empty conversation loads without exposing implementation errors.
- Actual: The app displays `type 'Null' is not a subtype of type 'String' in type cast` for about four seconds, then renders the empty chat.
- Root cause evidence: The room-creation API succeeds with HTTP 201 and returns `last_message: null`; the Flutter client casts the nullable value to a non-null String.
- Required fix: Model `last_message` as nullable, supply a safe empty-state fallback, and never show raw language/runtime exceptions to users.

### JM-MOB-INBOX-002 — Opening Inbox creates a server-side room automatically

- Severity: Medium
- Steps: Navigate to Inbox without typing or sending a message.
- Expected: Viewing Inbox is read-only until the user starts or sends a conversation, unless automatic room creation is an explicitly approved requirement.
- Actual: The app sends `POST /v1/chat/rooms/create/` and creates a chat room immediately.
- Evidence: ADB log shows HTTP 201 with `created: true`; no message was sent.
- Required fix: Confirm product intent. Prefer lazy room creation on first send, or make the automatic behavior explicit and idempotent.

### JM-MOB-GAR-001 — Typo in empty Garage state

- Severity: Low
- Steps: Open **My Garage** with an account that has no registered vehicles.
- Expected: `No Vehicles in your garage`.
- Actual: `No Vehicles in your garange`.
- Evidence: User screenshot.
- Required fix: Correct the copy and add UI copy review to release QA.

### JM-MOB-DATA-001 — Brand and Model accept unconstrained free text

- Severity: Medium
- Steps: Open **My Garage > Add Unit**.
- Expected: Vehicle data is selected from or validated against an authoritative make/model dataset, with a controlled fallback if necessary.
- Actual: Brand and Model are independent free-text fields, allowing invalid combinations.
- Evidence: User screenshot; admin fixtures already contain implausible combinations such as Tesla/Mustang and BMW/Camry.
- Required fix: Add dependent make/model selection or server-side validation, normalize values, and reject implausible combinations.

## Evidence

- `evidence/01_app_launch.png`
- `evidence/02_home_after_login.png`
- User-provided screenshot of the AI error.

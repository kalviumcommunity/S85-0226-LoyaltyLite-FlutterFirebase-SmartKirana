# FCM Daily Alert Integration

This project now includes Firebase Cloud Messaging (FCM) support for the "Daily Alert" scenario.

## What is implemented

- Firebase Messaging dependency added.
- Notification permission request on app start.
- FCM token retrieval and live refresh.
- FCM topic subscription: `all_staff`.
- Foreground listener (`onMessage`).
- Background-open listener (`onMessageOpenedApp`).
- Terminated-open listener (`getInitialMessage`).
- Background message handler registration (`onBackgroundMessage`).
- Android 13+ notification permission (`POST_NOTIFICATIONS`).
- iOS remote notification background mode enabled in Info.plist.
- Dashboard UI section to:
  - view permission status
  - view and copy FCM token
  - refresh token
  - view last received alert and app-state receive context

## Daily Alert demo steps (for video)

1. Launch the app on a physical device.
2. Sign in and open Dashboard.
3. In "Daily Alert (FCM)", copy the displayed FCM token.
4. Open Firebase Console -> Cloud Messaging -> Send message.
5. Use:
   - Title: `Shift Update`
   - Body: `Urgent: Duty timing has changed.`
6. Target either:
   - Single device token (paste token), or
   - Topic `all_staff`.
7. Send and record the exact receive moment in one state:
   - Foreground, or
   - Background, or
   - Terminated.

## Submission checklist

- Include all code changes in one PR.
- Include Google Drive video link in PR description.
- Ensure Google Drive link has edit access enabled for all reviewers.

## Important iOS note

For iOS push delivery on real devices, ensure APNs key/certificate and app capabilities are correctly configured in Apple Developer and Firebase settings.

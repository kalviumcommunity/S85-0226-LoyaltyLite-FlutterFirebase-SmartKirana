# Task Overview: FlutterFire CLI Setup for SmartKirana

This guide maps FlutterFire setup to this repository:

- Project root: `S85-0226-LoyaltyLite-FlutterFirebase-SmartKirana`
- Primary app entry: `lib/main.dart`
- Firebase options file: `lib/firebase_options.dart`

## 1) What FlutterFire CLI does

FlutterFire CLI connects your Flutter app to Firebase by:

- Registering Android, iOS, and Web apps in one flow
- Generating and updating Firebase config files
- Creating `lib/firebase_options.dart` for platform-safe initialization

Why this matters in SmartKirana:

- Keeps Firebase setup consistent across multiple demo and production entry files
- Avoids manual key copy mistakes
- Makes updates repeatable for team members

## 2) Install prerequisites and CLI

Run these in PowerShell:

```powershell
npm install -g firebase-tools
dart pub global activate flutterfire_cli
flutterfire --version
```

Expected:

- `firebase` and `flutterfire` commands resolve
- Version output appears for FlutterFire CLI

If `flutterfire` is not recognized, add Pub cache binary path to PATH.
Typical Windows path:

- `%USERPROFILE%\\AppData\\Local\\Pub\\Cache\\bin`

## 3) Login and configure this project

From project root (`S85-0226-LoyaltyLite-FlutterFirebase-SmartKirana`):

```powershell
firebase login
flutterfire configure
```

When prompted:

- Select the correct Firebase project for SmartKirana
- Select platforms you support now (Android, iOS, Web)

Output to confirm:

- `lib/firebase_options.dart` is created or updated

Project note:

- `android/app/google-services.json` already exists in this repo.
- `ios/Runner/GoogleService-Info.plist` is not currently present; choose iOS in `flutterfire configure` to generate iOS configuration requirements.

## 4) Dependencies for this repo

`pubspec.yaml` already contains Firebase dependencies:

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_storage`

Refresh packages:

```powershell
flutter pub get
```

## 5) Firebase initialization in SmartKirana app

The main app entry is now configured to initialize Firebase with FlutterFire-generated options:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

Location:

- `lib/main.dart`

This uses the generated `DefaultFirebaseOptions` so Android/iOS/Web each get the right credentials.

## 6) Verify setup

Run:

```powershell
flutter run
```

Success checks:

- App launches without Firebase initialization errors
- Debug log includes: `Firebase initialized with DefaultFirebaseOptions`
- In Firebase Console > Project settings > Your apps, selected platforms are registered

## 7) Add more Firebase SDKs (as needed)

This repo already includes several Firebase packages. To add more:

```yaml
dependencies:
  firebase_analytics: ^11.0.0
```

Then run:

```powershell
flutter pub get
```

No extra initialization file changes are needed after `flutterfire configure` unless you switch projects/platforms.

## 8) Common issues (SmartKirana specific)

| Issue                               | Cause                                                    | Solution                                                                                                                    |
| ----------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `flutterfire` not recognized        | Pub cache bin path not in PATH                           | Add `%USERPROFILE%\\AppData\\Local\\Pub\\Cache\\bin` to PATH and restart terminal                                           |
| Firebase not initialized            | Missing `await Firebase.initializeApp(...)` with options | Ensure `lib/main.dart` calls `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`                      |
| Wrong Firebase project used         | Wrong selection in CLI prompt                            | Re-run `flutterfire configure` and select the correct project                                                               |
| Android build Firebase plugin error | Google services plugin misconfigured                     | Confirm `com.google.gms.google-services` is in `android/app/build.gradle.kts` and declared in `android/settings.gradle.kts` |
| iOS Firebase not working            | Missing iOS app registration or plist                    | Re-run `flutterfire configure` with iOS selected and add generated iOS config                                               |

## Quick command checklist

```powershell
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
flutter pub get
flutter run
```

If you change Firebase project, run `flutterfire configure` again to regenerate `lib/firebase_options.dart`.

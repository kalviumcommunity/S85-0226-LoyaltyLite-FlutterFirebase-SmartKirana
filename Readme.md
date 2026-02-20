# SmartKirana Firebase Integration (Sprint 2)

## Project Title

SmartKirana – Firebase Authentication and Firestore CRUD Integration

## Short Description

This Flutter project integrates Firebase Authentication and Cloud Firestore to support secure signup/login/logout and real-time CRUD operations for user notes.

## Firebase Setup Instructions

### 1) Create Firebase project

1. Open Firebase Console and create a new project.
2. Add Android app and iOS app.
3. Download config files and place them in:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

### 2) Configure FlutterFire

Run in project root:

```bash
flutterfire configure
```

### 3) Install dependencies

Already included in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

Then run:

```bash
flutter pub get
```

### 4) Firebase initialization in app

`lib/main.dart` initializes Firebase:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SmartKiranaApp());
}
```

## Implemented Features

### 1) Firebase Authentication

- `lib/services/auth_service.dart`
  - `signUp(email, password)`
  - `login(email, password)`
  - `logout()`
- `lib/screens/signup_screen.dart`
- `lib/screens/login_screen.dart`
- Auth routing in `lib/main.dart` using `FirebaseAuth.instance.authStateChanges()`.

### 2) Cloud Firestore CRUD

- `lib/services/firestore_service.dart`
  - `addUserData(uid, data)`
  - `createNote(uid, text)`
  - `streamNotes(uid)`
  - `updateNote(noteId, updatedText)`
  - `deleteNote(noteId)`
- `lib/screens/dashboard_screen.dart`
  - Add note
  - Real-time list (`StreamBuilder`)
  - Edit note
  - Delete note

## Code Snippets

### Authentication logic

```dart
final user = await _authService.login(email, password);
if (user == null) {
  // show error
}
```

### Firestore create/read/update/delete

```dart
await _firestoreService.createNote(uid: user.uid, text: 'First note');

stream: _firestoreService.streamNotes(user.uid)

await _firestoreService.updateNote(noteId: noteId, updatedText: 'Updated');

await _firestoreService.deleteNote(noteId);
```

## Test Authentication and Data Persistence

Run app:

```bash
flutter run
```

Perform checks:

- Create a new user via signup screen.
- Login with created credentials.
- Add note in dashboard.
- Edit the note.
- Delete the note.
- Verify Authentication records in Firebase Console.
- Verify Firestore records in `notes` collection update in real-time.

## Screenshots (Add before final submission)

Add screenshots to `docs/screenshots/` and reference them below.

- User successfully logged in
- Firestore data displayed in dashboard
- Authentication record in Firebase Console
- Firestore record in Firebase Console

Example markdown after adding images:

```md
![Login success](docs/screenshots/login-success.png)
![Firestore notes](docs/screenshots/firestore-notes.png)
![Firebase Auth console](docs/screenshots/firebase-auth-console.png)
![Firestore console](docs/screenshots/firestore-console.png)
```

## Reflection

Challenges faced:

- Correctly wiring platform Firebase config files and FlutterFire setup.
- Handling authentication state transitions cleanly between screens.
- Structuring Firestore queries and updates to keep UI real-time and stable.

How Firebase improves scalability and collaboration:

- Firebase Authentication provides secure, managed user auth without custom backend code.
- Cloud Firestore enables real-time sync across devices with minimal client logic.
- Managed infrastructure allows faster iteration and easier scaling for small teams.

## Submission Guidelines

### Commit message

```bash
feat: integrated Firebase Auth and Firestore with working login and data flow
```

### Pull Request title

```text
[Sprint-2] Firebase Integration – TeamName
```

### PR description should include

`lib/firebase_options.dart` currently contains placeholder values. Replace it by running `flutterfire configure` and using the generated configuration before production use.

## Project Structure

Detailed explanation available in:
PROJECT_STRUCTURE.md

- Summary of implemented Firebase features
- Screenshots of authentication and Firestore
- Reflection on learning outcomes

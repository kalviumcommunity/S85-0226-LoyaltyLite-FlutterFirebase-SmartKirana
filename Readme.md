# LoyaltyLite Firebase Integration

This assignment demonstrates how Firebase solves backend challenges in a mobile app without managing custom servers.

## Objective

Learn how Firebase enables:

- secure authentication,
- real-time database synchronization,
- scalable file storage,

and how these services work together to deliver a smooth multi-device user experience.

## Firebase Setup (Flutter)

### 1) Create and connect Firebase project

1. Open Firebase Console and create a project.
2. Add Android and/or iOS apps.
3. Download configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
4. Run FlutterFire CLI in project root:

```bash
flutterfire configure
```

5. Install dependencies:

```bash
flutter pub get
```

### 2) Dependencies used

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0
```

### 3) Firebase initialization

Firebase is initialized in `lib/main.dart`:

```dart
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
   );
   runApp(const LoyaltyLiteFirebaseApp());
}
```

## Key Firebase Services in This App

| Service                    | Purpose                                  | Assignment implementation                  |
| -------------------------- | ---------------------------------------- | ------------------------------------------ |
| Firebase Authentication    | Secure sign-up/sign-in and session state | Email + password sign-up/sign-in, sign-out |
| Cloud Firestore            | Real-time NoSQL data sync                | `tasks` collection with live task updates  |
| Firebase Storage           | Upload and host files                    | Optional upload of sync evidence text file |
| Cloud Functions (optional) | Serverless backend logic                 | Not required in this implementation        |

## Implemented Features

### 1) Firebase Authentication

- Sign up and sign in with email/password.
- Auth state listener automatically moves user between login and task screens.
- Success/error messages shown using SnackBars.

Files:

- `lib/services/auth_service.dart`
- `lib/main.dart`

### 2) Firestore Real-Time Data

- Add new tasks to Firestore with server timestamps.
- Read tasks using `snapshots()` for live updates.
- UI updates automatically via `StreamBuilder` (no manual refresh).
- Debug logs added to prove live sync events in console.

Files:

- `lib/services/firestore_service.dart`
- `lib/main.dart`

### 3) Optional Firebase Storage

- Upload an optional text file as sync evidence.
- Retrieve and show download URL after successful upload.

Files:

- `lib/services/storage_service.dart`
- `lib/main.dart`

## Why Firestore Sync Is Real-Time

The app uses Firestore live query streams:

```dart
FirebaseFirestore.instance
   .collection('tasks')
   .where('uid', isEqualTo: uid)
   .orderBy('createdAt', descending: true)
   .snapshots()
```

When one user/device writes data, all connected clients subscribed to the same query receive updates instantly. This removes polling and manual refresh logic.

## Run Instructions

```bash
flutter pub get
flutter run
```

## Evidence Checklist for Submission

- [x] Firebase Auth flow implemented and working.
- [x] Firestore real-time sync implemented and visible in UI.
- [x] Debug console logs available for live sync proof.
- [x] Optional Firebase Storage integration added.
- [ ] Add screenshots of login and live task updates.
- [ ] Record demo video showing updates across devices/tabs.
- [ ] Add Drive video link and PR link in submission form.

## Reflection

Firebase reduced backend complexity by handling the three core needs of collaborative mobile apps:

- **Secure access** through Firebase Auth,
- **Real-time synchronization** through Cloud Firestore,
- **Scalable file handling** through Firebase Storage.

Instead of building and maintaining custom servers, session logic, and realtime sockets, this app uses managed Firebase services. That allowed faster implementation of core product behavior and a smoother multi-device experience.

## Important Note

`lib/firebase_options.dart` currently contains placeholder values. Replace it by running `flutterfire configure` and using the generated configuration before production use.

## Project Structure

Detailed explanation available in:
PROJECT_STRUCTURE.md


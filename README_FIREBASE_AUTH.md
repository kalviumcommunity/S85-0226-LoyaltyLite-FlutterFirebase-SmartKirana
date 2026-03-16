# Firebase Authentication Implementation

This project demonstrates the implementation of Firebase Authentication with Email & Password in a Flutter application using the SmartKirana project.

## Overview

Firebase Authentication provides a secure and reliable way to handle user signups, logins, and session management without building your own authentication backend. This implementation includes:

- Email & Password authentication
- User registration and login flows
- Authentication state management
- Error handling and user feedback
- Firebase console integration

## Features Implemented

### 1. Authentication Screen (`lib/screens/auth_screen.dart`)
- Combined login and signup interface
- Toggle between login and signup modes
- Form validation for email and password
- Loading states and error handling
- Modern UI with gradient background and card design

### 2. Authentication Service (`lib/services/auth_service.dart`)
- Wrapper around Firebase Auth methods
- Login functionality (`signInWithEmailAndPassword`)
- Signup functionality (`createUserWithEmailAndPassword`)
- Logout functionality (`signOut`)
- Error handling with null returns

### 3. Main App Integration (`lib/main.dart`)
- Firebase initialization
- AuthScreen as the entry point
- Stream-based authentication state listening

### 4. Test Screen (`lib/screens/auth_test_screen.dart`)
- Comprehensive testing interface
- Auth status monitoring
- Real-time user information display
- Firebase console verification instructions

## Setup Instructions

### 1. Firebase Console Setup

1. Open your **Firebase Console** → **Authentication** → **Sign-in method** tab
2. Click **Email/Password**
3. Enable the toggle for **Email/Password** and click **Save**
4. This allows your app to perform signup and login operations via Firebase APIs

### 2. Firebase Configuration

Update `lib/firebase_options.dart` with your actual Firebase project configuration:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_STORAGE_BUCKET',
);
```

### 3. Dependencies

The following dependencies are already included in `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.13.1
  firebase_auth: ^5.5.4
  cloud_firestore: ^5.6.8
  firebase_storage: ^12.4.6
```

### 4. Run the Application

```bash
flutter pub get
flutter run
```

## Code Implementation

### Authentication Flow

The authentication flow is handled through the `AuthScreen` widget:

```dart
// Login functionality
await _auth.signInWithEmailAndPassword(
  email: email,
  password: password,
);

// Signup functionality
await _auth.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

### Form Validation

Email and password validation with proper error messages:

```dart
validator: (value) {
  if (value == null || !value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
},
```

### Error Handling

Comprehensive error handling for Firebase Auth exceptions:

```dart
} on FirebaseAuthException catch (e) {
  String errorMessage = 'Authentication Error';
  if (e.code == 'weak-password') {
    errorMessage = 'The password provided is too weak.';
  } else if (e.code == 'email-already-in-use') {
    errorMessage = 'An account already exists for this email.';
  }
  // ... more error cases
}
```

## Firebase Console Verification

After implementing authentication:

1. **Test the signup flow** in your app
2. **Go to Firebase Console** → **Authentication** → **Users**
3. **Verify registered users** appear in the users table
4. **Check user details** including email, UID, and creation date

## Common Issues & Solutions

| Error | Cause | Fix |
|-------|-------|-----|
| `ERROR_INVALID_EMAIL` | Invalid email format | Use proper email validation |
| `Password should be at least 6 characters` | Firebase restriction | Enforce minimum password length |
| `Firebase not initialized` | Missing initialization | Add `await Firebase.initializeApp()` in main() |
| `App crashes on sign-in` | Missing dependency or version mismatch | Run `flutter pub get` and check versions |

## Security Features

Firebase Authentication provides enterprise-grade security:

- **Password Hashing**: Automatic secure password storage
- **Session Management**: Built-in token handling
- **Email Verification**: Optional email verification flow
- **Password Reset**: Built-in password recovery
- **Multi-factor Authentication**: Available for enhanced security

## Testing

Use the provided `AuthTestScreen` to verify authentication:

1. Navigate to the test screen
2. Use the test buttons to verify signup, login, and logout
3. Monitor real-time authentication status
4. Cross-reference with Firebase Console

## Reflection Questions

### How does Firebase simplify authentication management?
- Eliminates need for backend authentication servers
- Provides secure token management automatically
- Handles password security and hashing
- Offers built-in email verification and password reset

### What security features make it better than custom auth systems?
- Enterprise-grade security standards
- Regular security updates from Google
- Built-in protection against common vulnerabilities
- OAuth integration for social providers

### What challenges did you face while implementing both flows?
- Proper error handling for different Firebase exceptions
- Managing authentication state across the app
- Form validation and user experience
- Firebase configuration and setup

## Video Demo Guidelines

For your assignment submission, create a 1-2 minute video demonstrating:

1. **App Running**: Show the authentication interface
2. **Signup Flow**: Create a new user account
3. **Login Flow**: Sign in with the created account
4. **Firebase Console**: Display registered users in the console
5. **Error Handling**: Show validation and error messages
6. **Logout**: Demonstrate sign-out functionality

## Submission Requirements

### Pull Request
- **Commit Message**: `feat: implemented Firebase Auth (email & password)`
- **PR Title**: `[Sprint-2] Firebase Authentication (Email & Password) – TeamName`
- **PR Description**: Include implementation summary and Firebase Console screenshot

### Files Modified
- `lib/screens/auth_screen.dart` - Main authentication interface
- `lib/main.dart` - Updated to use AuthScreen
- `lib/screens/auth_test_screen.dart` - Testing interface
- `README_FIREBASE_AUTH.md` - This documentation

## Resources

- [Firebase Authentication for Flutter](https://firebase.google.com/docs/auth/flutter/start)
- [Firebase Console – Authentication Setup](https://console.firebase.google.com/)
- [firebase_auth Plugin](https://pub.dev/packages/firebase_auth)
- [Managing User Sessions](https://firebase.google.com/docs/auth/flutter/manage-users)
- [Handling Authentication Errors](https://firebase.google.com/docs/auth/flutter/errors)

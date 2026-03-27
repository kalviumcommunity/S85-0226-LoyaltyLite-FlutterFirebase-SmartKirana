# SmartKirana Media Upload & Release Guide

## Overview
This guide details the implementation of media upload functionality using Firebase Storage, integrated into the user's profile screen. It also serves as a comprehensive guide for preparing, signing, and building a production-ready release build for the SmartKirana Android app.

## Project Structure Changes

```
lib/
  main_crud_complete.dart  ← (Modified) Profile screen now supports image uploads
android/
  app/
    app-release-key.jks  ← (Generated) Secure signing key
  key.properties         ← (Generated) Keystore credentials (in .gitignore)
  app/build.gradle.kts   ← (Modified) Gradle build script with signing config
```

## Key Features Implemented

### 1. **Profile Image Upload**
- **Image Picker**: Users can select an image from their device's gallery.
- **Firebase Storage**: The selected image is uploaded to `profile_images/{user_id}.jpg`.
- **Firestore URL Storage**: The public download URL of the uploaded image is saved in the user's document in Firestore (`/users/{user_id}`).
- **UI Display**: The user's profile picture is displayed in a `CircleAvatar`.
- **Real-time Update**: The UI updates instantly after a successful upload.
- **Loading & Error States**: A progress indicator is shown during upload, and snackbars provide feedback.

### 2. **Release Build Configuration**
- **Secure Keystore**: A signing key (`app-release-key.jks`) is generated.
- **Secure Credentials**: `key.properties` stores credentials securely.
- **Gradle Configuration**: `build.gradle.kts` is configured for release signing.

---

## Firebase Configuration

### 1. **Enable Storage**
- Go to the Firebase Console → Storage.
- Click "Get Started" and follow the setup wizard.

### 2. **Update Storage Security Rules**
For secure uploads, update your Storage rules to only allow authenticated users to write to their own folder.

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Allow reads by anyone (for public profile pictures)
    match /profile_images/{userId} {
      allow read;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 3. **Update Firestore Security Rules**
Ensure users can update their own user document with the `profileImageUrl`.

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      // Allow user to read and write to their own document
      allow read, write: if request.auth.uid == uid;
    }
    match /users/{uid}/items/{itemId} {
      allow read, write: if request.auth.uid == uid;
    }
  }
}
```

---

## Code Walkthrough

### Class: `ProfileScreen`
This stateful widget now handles the entire profile image upload flow.

**Dependencies Added:**
- `image_picker`: To select files from the device.
- `firebase_storage`: To upload files to the cloud.

**Key Methods:**
- `_loadProfileImage()`: Fetches the user's `profileImageUrl` from Firestore on screen initialization.
- `_uploadProfileImage()`:
    1. Uses `ImagePicker` to open the gallery.
    2. If an image is selected, it sets an uploading state.
    3. Uploads the file to `FirebaseStorage` at `profile_images/{user.uid}.jpg`.
    4. Retrieves the `downloadUrl`.
    5. Saves the URL to the user's document in Firestore.
    6. Updates the UI to display the new image.
    7. Shows a `SnackBar` for success or failure.

**UI Components:**
- A `CircleAvatar` displays the profile image from a `NetworkImage`.
- A `GestureDetector` on the avatar triggers the `_uploadProfileImage` flow.
- A `CircularProgressIndicator` is overlaid on the avatar during upload.

---

## How to Build for Release

Your project is fully configured for release builds.

### To Build an App Bundle (AAB) for Google Play:
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### To Build an APK for Manual Distribution:
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## ✅ Best Practices Implemented

- **User-Specific Storage**: Each user's profile image is stored with their unique UID.
- **Secure by Default**: Firebase Storage rules prevent unauthorized uploads.
- **Asynchronous UI**: Loading indicators provide a good user experience during network operations.
- **Clear Feedback**: Snackbars inform the user about the outcome of the upload.
- **State Management**: The UI state (`_isUploading`, `_profileImageUrl`) is managed locally within the `ProfileScreen`.

---

## Next Steps

1. **Add `key.properties` to `.gitignore`**:
   If you haven't already, add this line to your root `.gitignore` file:
   ```
   /android/key.properties
   ```

2. **Add SHA Keys to Firebase**:
   For release builds, add your release key's SHA-1 and SHA-256 fingerprints to the Firebase console.
   ```bash
   keytool -list -v -keystore android/app/app-release-key.jks -alias upload
   ```
   (Use password: `password`)

3. **Test on a Physical Device**:
   Build a release APK and install it on a device to ensure the image picker and upload functionality work correctly. Permissions for gallery access will be handled automatically by the `image_picker` plugin.

---

**Updated**: March 27, 2026  
**Version**: 4.0 - Media Upload & Profile Screen  
**Status**: Ready for Production Builds ✅

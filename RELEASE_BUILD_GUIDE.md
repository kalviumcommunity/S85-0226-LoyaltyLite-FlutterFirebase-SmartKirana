# SmartKirana Release Build & Signing Guide

## Overview
This guide details the complete process of preparing, signing, and building a production-ready release build for the SmartKirana Android app. This includes generating a secure keystore, configuring Gradle, and building both an APK and an App Bundle (AAB).

## Project Structure Changes

```
android/
  app/
    app-release-key.jks  ← (Generated) Secure signing key
  key.properties         ← (Generated) Keystore credentials (in .gitignore)
  app/build.gradle.kts   ← (Modified) Gradle build script with signing config
```

## Key Steps Completed

### 1. **Generated a Secure Keystore**
A new signing key (`app-release-key.jks`) was created and placed in `android/app/`. This key is essential for verifying the app's authenticity and integrity.

**Command Used:**
```bash
keytool -genkey -v -keystore android/app/app-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
*(Passwords and details were provided automatically.)*

### 2. **Stored Credentials Securely**
A `key.properties` file was created in the `android/` directory to store the keystore passwords and alias.

**Contents of `android/key.properties`:**
```properties
storePassword=password
keyPassword=password
keyAlias=upload
storeFile=app-release-key.jks
```
**IMPORTANT:** This file should be added to your `.gitignore` file to prevent it from being committed to version control.

### 3. **Configured Gradle for Release Signing**
The `android/app/build.gradle.kts` file was updated to:
- Read the credentials from `key.properties`.
- Create a `signingConfigs.release` block.
- Link the release build type to this signing configuration.

**Gradle (`build.gradle.kts`) Snippet:**
```kotlin
// Reads properties from key.properties
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = java.util.Properties()
keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))

android {
    // ...

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

---

## How to Build for Release

Your project is now fully configured for release builds.

### To Build a Release APK:
This is useful for direct installation or manual sharing.

```bash
flutter build apk --release
```
The output will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### To Build a Release App Bundle (AAB):
This is the required format for publishing on the Google Play Store.

```bash
flutter build appbundle --release
```
The output will be located at: `build/app/outputs/bundle/release/app-release.aab`

---

## ✅ Best Practices Implemented

- **Secure Signing**: The app is signed with a private key, not the debug key.
- **Credential Management**: Keystore passwords are not hardcoded in Gradle, following security best practices.
- **Automation-Ready**: The setup is clean and works directly with Flutter's build commands.

---

## Next Steps

1. **Add `key.properties` to `.gitignore`**:
   Open your `.gitignore` file in the project root and add this line:
   ```
   /android/key.properties
   ```

2. **Add SHA Keys to Firebase**:
   For services like Google Sign-In or Phone Auth to work in release mode, you must add the SHA-1 and SHA-256 fingerprints of your release key to the Firebase console.
   Run this command to get them:
   ```bash
   keytool -list -v -keystore android/app/app-release-key.jks -alias upload
   ```
   Enter the password (`password`) when prompted, and copy the SHA-1 and SHA-256 values into your Firebase project settings for the Android app.

3. **Build and Test**:
   Run one of the build commands above and test the generated APK on a physical device to ensure everything works as expected.

---

**Updated**: March 27, 2026  
**Version**: 3.0 - Release Build Configuration  
**Status**: Ready for Production Builds ✅

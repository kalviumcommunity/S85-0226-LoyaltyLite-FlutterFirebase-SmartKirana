# Flutter Project Structure Exploration

## Introduction

This document captures the folder structure exploration for the SmartKirana Flutter project. It explains how Flutter organizes application logic, platform-specific code, tooling metadata, and generated build output so the project stays scalable and maintainable.

## Core Folder and File Purpose

| Folder/File                | Purpose               | Key Details                                                                                                    |
| -------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------- |
| `lib/`                     | Main Dart source code | Contains `main.dart` (entry point) and app modules such as `screens/`, `widgets/`, `services/`, and `models/`. |
| `android/`                 | Android native setup  | Includes Gradle scripts, AndroidManifest, and app-level configuration in `android/app/build.gradle.kts`.       |
| `ios/`                     | iOS native setup      | Includes Xcode project files and metadata in `ios/Runner/Info.plist`.                                          |
| `assets/`                  | Static resources      | Stores images, fonts, and data files used by the app. Must be declared in `pubspec.yaml`.                      |
| `test/`                    | Testing code          | Contains unit/widget/integration tests, including default `widget_test.dart`.                                  |
| `pubspec.yaml`             | Project manifest      | Defines dependencies, Flutter settings, assets, versions, and metadata.                                        |
| `.gitignore`               | Git exclusions        | Prevents generated or local-only files from being committed.                                                   |
| `build/`                   | Generated output      | Auto-generated compilation artifacts for each platform. Do not edit manually.                                  |
| `.dart_tool/` and `.idea/` | Tool and IDE metadata | Maintain local analysis state and editor/project settings.                                                     |

## Recommended `lib/` Modular Layout

```text
lib/
┣ main.dart
┣ screens/
┣ widgets/
┣ services/
┗ models/
```

## Visual Hierarchy (Simplified)

```text
S85-0226-LoyaltyLite-FlutterFirebase-SmartKirana/
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── services/
│   └── ...
├── android/
├── ios/
├── assets/
│   ├── images/
│   └── fonts/
├── test/
├── pubspec.yaml
├── PROJECT_STRUCTURE.md
└── Readme.md
```

## Assets Declaration Example

```yaml
flutter:
  assets:
    - assets/images/
    - assets/fonts/
```

## Reflection

- Understanding each folder helps developers navigate and debug faster.
- A structured `lib/` layout improves readability and feature-level ownership.
- Clear separation between app logic and native platform files improves maintainability.
- Consistent structure improves teamwork, onboarding speed, and delivery quality.

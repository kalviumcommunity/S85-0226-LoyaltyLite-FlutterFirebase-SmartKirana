# Flutter Project Structure Overview

## Introduction

This document explains the folder structure of a Flutter project and the purpose of each directory and configuration file. Understanding this structure helps maintain scalability and clean code organization.

---

## Core Folders

### 1. lib/
This is the main folder where all Dart code is written.

- `main.dart` → Entry point of the app.
- Can contain subfolders:
  - screens/ → UI screens
  - widgets/ → Reusable components
  - models/ → Data models
  - services/ → API or Firebase logic

---

### 2. android/
Contains Android-specific configuration and build files.

- `build.gradle` → Controls Android build configuration.
- `AndroidManifest.xml` → Defines permissions and app metadata.

---

### 3. ios/
Contains iOS-specific configuration files.

- `Info.plist` → Defines permissions and iOS metadata.

---

### 4. test/
Contains automated test files.

- `widget_test.dart` → Default test file.

---

### 5. pubspec.yaml
Most important configuration file.

Used to:
- Add dependencies
- Register assets
- Manage fonts
- Define environment settings

---

### 6. build/
Auto-generated folder containing compiled files.  
Should not be modified manually.

---

### 7. .dart_tool/
Contains Dart and Flutter generated configurations.

---

### 8. .gitignore
Specifies which files Git should ignore.

---

## Folder Hierarchy (Example)

project_root/
│
├── lib/
│ └── main.dart
├── android/
├── ios/
├── test/
├── pubspec.yaml
└── README.md


---

## Reflection

Understanding Flutter's folder structure helps in:

- Writing organized and scalable code.
- Separating UI, business logic, and data layers.
- Improving collaboration in team environments.
- Maintaining cross-platform compatibility for Android and iOS.

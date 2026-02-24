# How to Run LoyalBazaar Application

## 🚀 Quick Start Guide

### Prerequisites
- Flutter SDK installed
- Android Studio or VS Code
- Android Emulator or Physical Device

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Run the Application
```bash
flutter run --target=lib/main_responsive.dart
```

### Step 3: Alternative Run Commands
```bash
# Run with specific device
flutter run --target=lib/main_responsive.dart -d chrome

# Run in debug mode
flutter run --debug --target=lib/main_responsive.dart

# Run in release mode
flutter run --release --target=lib/main_responsive.dart
```

## 📱 App Flow

1. **Splash Screen** - LoyalBazaar branding (3 seconds)
2. **Onboarding** - Feature introduction
3. **Login/Register** - User authentication
4. **Dashboard** - Role-based home screen

## 🎯 Features Available

### Shop Owner
- Customer Management
- Reward Creation
- Analytics Dashboard
- QR Code Generation

### Customer
- Points Balance
- Reward Redemption
- QR Code Scanner
- Transaction History

## 🔧 If You Encounter Errors

### Common Issues & Solutions

1. **"flutter_spinkit not found"**
   - Run: `flutter pub get`
   - The app now uses built-in CircularProgressIndicator

2. **"Missing dependencies"**
   - Check pubspec.yaml for all required packages
   - Run: `flutter clean && flutter pub get`

3. **"Target file not found"**
   - Ensure you're in the correct directory: `cd "d:\Smart Kirana"`
   - Use: `flutter run --target=lib/main_responsive.dart`

4. **"No connected devices"**
   - Start Android Emulator
   - Connect physical device with USB debugging
   - Use: `flutter devices` to check available devices

## 🎨 UI Preview

The app features:
- **Orange Theme** - Professional Indian business colors
- **Bilingual Support** - Hindi + English
- **Modern UI** - Material Design 3
- **Responsive Design** - Works on all screen sizes

## 📊 Test Data

The app includes sample data for:
- 5+ customers with points
- 6+ rewards to redeem
- Analytics charts and metrics
- QR code functionality

## 🔍 Debug Mode

For development, use:
```bash
flutter run --debug --target=lib/main_responsive.dart
```

This enables:
- Hot reload
- Debug console
- Performance overlay
- Widget inspector

## 🚀 Production Build

```bash
flutter build apk --release --target=lib/main_responsive.dart
```

## 📞 Support

If you face any issues:
1. Check Flutter Doctor: `flutter doctor`
2. Clean project: `flutter clean`
3. Get dependencies: `flutter pub get`
4. Restart IDE

---

**Your LoyalBazaar app is ready to run!** 🎉

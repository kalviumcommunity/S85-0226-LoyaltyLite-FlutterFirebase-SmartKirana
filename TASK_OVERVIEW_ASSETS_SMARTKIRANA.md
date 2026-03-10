# Task Overview: Assets in SmartKirana

## 1. Understand What Assets Are

Assets are static files packaged with the app and loaded at runtime using `Image.asset` or `AssetImage`.

In SmartKirana, assets are used for:

- Brand/logo presentation
- Onboarding and dashboard visuals
- UI consistency (icons and local visual resources)

## 2. Add Assets to Your Project

The project already has this structure:

```text
assets/
  images/
  fonts/
```

Add image files to `assets/images/`.

`pubspec.yaml` already includes:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/fonts/
```

## 3. Display Images in App

Use:

```dart
Image.asset('assets/images/app_logo.png', width: 120)
```

For a background:

```dart
Container(
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/dashboard_bg.png'),
      fit: BoxFit.cover,
    ),
  ),
)
```

## 4. Use Built-in Icons

SmartKirana already uses Material icons for actions and stats.

Examples:

- `Icons.people`
- `Icons.card_giftcard`
- `Icons.analytics`
- `Icons.currency_rupee`

## 5. Combined Layout Implemented

A working combined layout is implemented in:

- `lib/screens/asset_demo_screen.dart`

It displays:

- Local logo image (`app_logo.png`)
- Local background image (`dashboard_bg.png`)
- Built-in icons in a row

## 6. Troubleshooting

- Wrong path: ensure exact asset path in code.
- YAML spacing: use two spaces per nested level.
- New files not loaded: run `flutter pub get`.
- Case mismatch in names causes runtime load errors.

## 7. Test and Verify

1. Run `flutter pub get`
2. Run app with `flutter run` (or project batch script)
3. Log in and open **Open Assets Demo** from dashboard
4. Confirm images and icons render without missing-asset errors

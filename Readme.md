# School Event Planner

A Flutter app that demonstrates creative event planning using lateral thinking techniques. This project generates unique school event ideas by applying creative thinking methods like reversal, random association, and analogical thinking. Part of Sprint #2: Introduction to Flutter & Dart.

---

## 🗂 Folder Structure

```
lib/
├── main.dart          # Entry point of the app
├── screens/           # Individual UI screens (e.g. WelcomeScreen)
├── widgets/           # Reusable UI components (buttons, cards)
├── models/            # Data structures and domain classes
├── services/          # Backend/API or Firebase logic (future use)
```

- **Purpose of each directory**
  - `lib/main.dart` contains `main()` and the root `MaterialApp`.
  - `screens/` keeps each page’s widgets separate, enabling modular navigation.
  - `widgets/` holds shared components so they can be reused across screens.
  - `models/` helps keep data representations clean when state or API data is added.
  - `services/` isolates networking or database logic from UI code.

Naming conventions used throughout the project:
- **Files:** `lower_snake_case.dart` (e.g. `welcome_screen.dart`).
- **Classes/Widgets:** `UpperCamelCase` (e.g. `WelcomeScreen`).
- **State classes:** underscored with leading `_` when private, matching their parent widget name.

This structure supports modular app design by separating concerns; UI, data, and logic can be developed and tested independently.

---

## ⚙️ Setup Instructions

1. **Install Flutter SDK**
   - Follow the [official docs](https://docs.flutter.dev/get-started/install).
   - Add `flutter/bin` to your `PATH`.

2. **Install an IDE**
   - Android Studio or VS Code with the Flutter & Dart extensions.

3. **Verify installation**
   ```bash
   flutter doctor
   ```
   Fix any reported issues (e.g. Android licenses).

4. **Create the project** (if not already created via this repo):
   ```bash
   flutter create school_event_planner
   ```

5. **Run the app**
   - Launch an emulator or connect a physical device.
   - In the project root:
     ```bash
     flutter run
     ```

---

## 🎯 Demo

![App Screenshot](assets/demo_screenshot.png)

> *Screenshot of the app running on an emulator. Replace the placeholder with your actual screenshot.*

---

## 💭 Reflection

This project introduced me to Flutter's widget system and state management while exploring lateral thinking techniques for creative problem-solving. Building the event idea generator taught me how `StatefulWidget` and `setState` enable dynamic UI interactions that can inspire creativity.

The app demonstrates three lateral thinking techniques:
- **Reversal Thinking**: Flipping normal concepts upside down (Reverse Day Festival)
- **Random Association**: Combining unrelated concepts (Silent Disco Library)
- **Analogical Thinking**: Applying patterns from one domain to another (Problem-Solving Olympics)

The modular folder structure will be crucial as we expand the app to include more features like event scheduling, participant registration, and idea voting systems. Separating screens, widgets, models, and services allows for independent development and testing of each component.

This approach to event planning moves beyond traditional ideas by systematically applying creative thinking techniques, resulting in more engaging and memorable school experiences.

---

## 📎 Links

- Video demo: _[link to Loom/YouTube/Drive]_ (include when available)

---

*Commit message example:* `feat: initialized Flutter project and basic UI setup`  
*PR title example:* `[Sprint-2] Flutter & Dart Basics – TeamName`  

Feel free to personalize themes, icons, and text for your team’s app concept.
Happy coding! 🚀

# Widget Tree & Reactive UI Demo

A comprehensive Flutter application that demonstrates the widget tree hierarchy and Flutter's reactive UI model. This project showcases how widgets form hierarchical structures and how state changes trigger efficient UI updates through the `setState()` mechanism.

---

## 🌳 Widget Tree Hierarchy

### Complete Widget Tree Structure
```
MaterialApp
┣━ MaterialApp
┃  ┣━ WidgetTreeDemo (StatefulWidget)
┃  ┃  ┣━ Scaffold
┃  ┃  ┃  ┣━ AppBar
┃  ┃  ┃  ┃  ┣━ Text (Title)
┃  ┃  ┃  ┃  ┗━ IconButton (Dark Mode Toggle)
┃  ┃  ┃  ┣━ SingleChildScrollView
┃  ┃  ┃  ┃  ┣━ Padding
┃  ┃  ┃  ┃  ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃  ┣━ Card (Profile Card)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Container
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ CircleAvatar
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Icon
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (User Name)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Subtitle)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Row (Stats)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┣━ Column (Stat 1)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┃  ┣━ Text (Value)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┃  ┗━ Text (Label)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┣━ Column (Stat 2)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Value)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Text (Label)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┗━ Column (Stat 3)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃        ┣━ Text (Value)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃        ┗━ Text (Label)
┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┣━ Card (Counter Section)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Padding
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Title)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Container
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Label)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Text (Counter Value)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Row (Buttons)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┣━ ElevatedButton (Decrement)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┣━ ElevatedButton (Reset)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃     ┗━ ElevatedButton (Increment)
┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┣━ Card (Control Panel)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Padding
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Title)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ ElevatedButton (Background Color)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Column (Font Size)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ Text (Label)
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ Slider
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┃  ┃  ┗━ SwitchListTile (Card Visibility)
┃  ┃  ┃  ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃  ┗━ Card (Dynamic Content) [Conditional]
┃  ┃  ┃  ┃  ┃  ┃     ┣━ Padding
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┣━ Column
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┣━ Row
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┃  ┣━ Icon
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┃  ┗━ Text (Title)
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┣━ Text (Description)
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┣━ SizedBox
┃  ┃  ┃  ┃  ┃  ┃     ┃  ┃  ┗━ ElevatedButton (Change Name)
┃  ┃  ┃  ┃  ┃  ┃     ┗━ SizedBox.shrink() [When hidden]
```

---

## 🔄 Reactive UI Model Demonstration

### State Variables
The app manages multiple state variables that trigger UI updates:

```dart
int _counter = 0;                    // Counter value
Color _backgroundColor = Colors.blue.shade50;  // Background color
bool _showCard = true;               // Card visibility
String _userName = 'Flutter Student';  // User display name
double _fontSize = 16.0;             // Dynamic font size
bool _isDarkMode = false;            // Dark mode toggle
```

### setState() Usage Examples

#### Counter Update
```dart
void _incrementCounter() {
  setState(() {
    _counter++;  // Triggers rebuild of counter display
  });
}
```

#### Background Color Change
```dart
void _changeBackgroundColor() {
  setState(() {
    _colorIndex = (_colorIndex + 1) % _colors.length;
    _backgroundColor = _colors[_colorIndex];  // Triggers background rebuild
  });
}
```

#### Dynamic Font Size
```dart
void _changeFontSize(double newSize) {
  setState(() {
    _fontSize = newSize;  // Triggers text size updates throughout app
  });
}
```

---

## 📱 Interactive Features

### 1. **Profile Card Section**
- Displays user information with avatar
- Shows stats in a horizontal row
- Font size changes affect all text dynamically
- User name can be changed through button interaction

### 2. **Counter Section**
- Demonstrates basic state management
- Increment, decrement, and reset functionality
- Color changes when counter exceeds 10
- Shows real-time value updates

### 3. **Control Panel**
- **Background Color**: Cycles through predefined colors
- **Font Size Slider**: Dynamically adjusts text sizes (12-24px)
- **Card Visibility Toggle**: Shows/hides dynamic content card
- **Dark Mode Toggle**: Switches between light and dark themes

### 4. **Dynamic Content Card**
- Conditionally rendered based on toggle state
- Demonstrates widget addition/removal from tree
- Contains interactive elements that modify other state

---

## 📸 State Change Screenshots

### Initial State
![Initial State](assets/initial_state.png)
*Default app state with all elements visible*

### After Counter Increment
![Counter Changed](assets/counter_changed.png)
*Counter value updated, color changed when > 10*

### Background Color Change
![Background Changed](assets/background_changed.png)
*Background color cycled to next option*

### Font Size Adjustment
![Font Size Changed](assets/font_size_changed.png)
*Font size increased via slider*

### Dynamic Card Hidden
![Card Hidden](assets/card_hidden.png)
*Dynamic content card hidden via toggle*

### Dark Mode Activated
![Dark Mode](assets/dark_mode.png)
*Dark theme applied across all widgets*

---

## 💡 Key Concepts Explained

### What is a Widget Tree?
A widget tree is Flutter's way of representing UI as a hierarchical structure where:
- **Parent widgets** contain child widgets
- **State flows down** from parent to child
- **Events bubble up** from child to parent
- **Each widget** has a specific place in the hierarchy

### How Does the Reactive Model Work?
1. **State Change**: User interaction triggers `setState()`
2. **Mark Dirty**: Widget is marked as needing rebuild
3. **Build Method**: `build()` method is called again
4. **Widget Comparison**: Flutter compares old and new widget trees
5. **Minimal Updates**: Only changed widgets are redrawn

### Why Does Flutter Rebuild Only Parts?
Flutter uses a **diffing algorithm** that:
- Compares the new widget tree with the previous one
- Identifies minimal set of changes needed
- Updates only the affected widgets
- Preserves state of unchanged widgets
- Provides smooth 60fps performance

---

## 🚀 How to Run

1. **Navigate to project directory**
   ```bash
   cd "Smart Kirana"
   ```

2. **Run the widget tree demo**
   ```bash
   flutter run --target=lib/main_widget_tree.dart
   ```

3. **Test reactive features**:
   - Click increment/decrement buttons
   - Adjust font size slider
   - Change background colors
   - Toggle card visibility
   - Switch dark mode

---

## 🎯 Learning Outcomes

### Widget Tree Understanding
- **Hierarchical Structure**: How widgets nest within each other
- **Parent-Child Relationships**: Data flow and event handling
- **Widget Composition**: Building complex UI from simple widgets

### Reactive Model Mastery
- **State Management**: Using `setState()` effectively
- **Performance Optimization**: Understanding minimal rebuilds
- **UI Synchronization**: State and UI staying in sync

### Practical Skills
- **Interactive Design**: Creating responsive user interfaces
- **State Patterns**: Managing multiple state variables
- **Widget Lifecycle**: Understanding build/rebuild cycles

---

## 📎 Demo Video

[Link to widget tree and reactive UI demo video]

*Video demonstrates the widget hierarchy, state changes, and how Flutter efficiently updates only the necessary parts of the UI.*

---

*Commit message:* `feat: demonstrated widget tree and reactive UI model with state updates`  
*PR title:* `[Sprint-2] Widget Tree & Reactive UI – TeamName`

This implementation provides a comprehensive understanding of Flutter's widget tree and reactive programming model through practical, interactive examples.

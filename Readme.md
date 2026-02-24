# SmartKirana Flutter Assignment: Widget Tree & Reactive UI

This assignment demo uses `lib/main_widget_tree.dart` to show Flutter widget hierarchy and real-time state-driven updates with `setState()`.

## Project Title

**Widget Tree & Reactive UI Demo (SmartKirana)**

## Short App Explanation

The app demonstrates how Flutter builds UI as a nested widget tree and how interactions (button taps, switches, slider changes) trigger reactive UI rebuilds.

Run the assignment app:

```bash
flutter run --target=lib/main_widget_tree.dart
```

## Widget Tree Diagram

```text
MaterialApp
 ┗ WidgetTreeDemo (StatefulWidget)
	 ┗ Scaffold
		 ┣ AppBar
		 ┃  ┣ Text (title)
		 ┃  ┗ IconButton (theme toggle)
		 ┗ Body (SingleChildScrollView)
			 ┗ Column
				 ┣ Profile Card
				 ┃  ┣ CircleAvatar
				 ┃  ┣ Text (user name)
				 ┃  ┗ Row (stats)
				 ┣ Counter Card
				 ┃  ┣ Text (count)
				 ┃  ┗ Row (decrement / reset / increment)
				 ┣ Control Panel Card
				 ┃  ┣ ElevatedButton (background color)
				 ┃  ┣ Slider (font size)
				 ┃  ┗ SwitchListTile (show/hide dynamic card)
				 ┗ Dynamic Content Card (conditional)
					 ┣ Text + Icon
					 ┗ ElevatedButton (change name)
```

## Reactive UI State Updates

State variables used in the demo:

- `int _counter`
- `Color _backgroundColor`
- `bool _showCard`
- `String _userName`
- `double _fontSize`
- `bool _isDarkMode`

Example state update:

```dart
void _incrementCounter() {
  setState(() {
	 _counter++;
  });
}
```

Whenever state changes, Flutter rebuilds the relevant UI and reflects updates immediately.

## Screenshots (Initial vs Updated State)

Add your screenshots in `assets/images/` with these names:

- `widget_tree_initial.png` (initial app state)
- `widget_tree_updated.png` (after interaction)

Screenshot placeholders:

![Initial State](assets/images/widget_tree_initial.png)
![Updated State](assets/images/widget_tree_updated.png)

## Reflection

### How does the widget tree help Flutter manage complex UIs?

The widget tree structures UI into parent-child layers, making complex screens easier to compose, debug, and maintain. Each widget has a clear role and position in the hierarchy.

### Why is Flutter’s reactive model more efficient than manually updating views?

In Flutter, developers update state once and Flutter computes minimal UI changes automatically. This avoids manual view lookup and redraw logic, reduces bugs, and improves performance.

## Assignment Files

- `lib/main_widget_tree.dart`
- `lib/screens/widget_tree_demo.dart`
- `README.md`

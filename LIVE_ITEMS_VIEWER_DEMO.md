# Live Items Viewer: State Handling Demo

This task is implemented in the screen:

- `lib/screens/live_items_viewer_screen.dart`

## States Covered

1. Loader State

- A `CircularProgressIndicator` appears while async data is loading.

2. Empty State

- When source returns an empty list, UI shows:
  - "No items found"
  - CTA-style action "Add your first item"

3. Error State

- When source throws, UI shows:
  - Friendly message: "Could not load items. Please try again."
  - `Retry` button to fetch again

## How To Run

Option A (direct demo screen):

```bash
flutter run -t lib/main_live_items_demo.dart
```

Option B (inside app dashboard):

- Sign in to app
- Open "Live Items Viewer" from Dashboard quick actions

## Video Demo Script

1. Open Live Items Viewer.
2. Keep mode as "Success (Data Available)" and show loader then list.
3. Switch mode to "Empty Response" and show empty state UI.
4. Switch mode to "Error Response" and show error message.
5. Press Retry while still in error mode (error remains).
6. Switch back to success mode and press Retry to show recovery.

## PR Checklist

- [ ] Include `lib/screens/live_items_viewer_screen.dart`
- [ ] Include dashboard integration in `lib/screens/dashboard_screen.dart`
- [ ] Include demo entrypoint `lib/main_live_items_demo.dart`
- [ ] Attach Google Drive video link with edit access

# SmartKirana Flutter Assignment: User Input Form & Validation

This assignment demonstrates Flutter input widgets and form validation using `TextField`, `ElevatedButton`, `Form`, and `TextFormField`.

## Project Title

**User Input Form Demo (SmartKirana)**

## Short Description

Implemented a functional user input form in `lib/screens/user_input_form.dart` with:

- Name and Email input fields
- Validation rules for empty and invalid values
- Submit button action
- Success feedback via `SnackBar`

The screen is integrated into the app from `DashboardScreen` with a button: **Open User Input Form Demo**.

## Core Input Widgets Used

### TextField (Basic Input Example)

```dart
TextField(
	decoration: InputDecoration(
		labelText: 'Enter your name',
		border: OutlineInputBorder(),
	),
)
```

### TextFormField (Name)

```dart
TextFormField(
	controller: _nameController,
	decoration: const InputDecoration(
		labelText: 'Name',
		hintText: 'Enter your name',
		border: OutlineInputBorder(),
	),
	validator: (value) =>
			value == null || value.trim().isEmpty ? 'Enter your name' : null,
)
```

### TextFormField (Email + Validation)

```dart
TextFormField(
	controller: _emailController,
	keyboardType: TextInputType.emailAddress,
	decoration: const InputDecoration(
		labelText: 'Email',
		hintText: 'Enter your email',
		border: OutlineInputBorder(),
	),
	validator: (value) {
		final email = value?.trim() ?? '';
		if (email.isEmpty) return 'Enter your email';
		if (!email.contains('@')) return 'Enter a valid email';
		return null;
	},
)
```

### ElevatedButton (Submit)

```dart
ElevatedButton(
	onPressed: _submitForm,
	child: const Text('Submit'),
)
```

### Form + Feedback Logic

```dart
void _submitForm() {
	if (_formKey.currentState!.validate()) {
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(
				content: Text('Form submitted successfully for ${_nameController.text.trim()}!'),
			),
		);
	}
}
```

## Screenshots (Before and After Validation)

Add screenshots in `assets/images/` with these names:

- `user_form_empty_validation.png` (empty field errors visible)
- `user_form_success_snackbar.png` (successful submit with snackbar)

Screenshot placeholders:

![Empty Field Validation](assets/images/user_form_empty_validation.png)
![Successful Submit Snackbar](assets/images/user_form_success_snackbar.png)

## Reflection

### What are the benefits of input validation in mobile apps?

Input validation prevents bad data from being submitted, reduces backend errors, and guides users to correct mistakes immediately.

### How does FormState simplify input handling?

`FormState` centralizes validation and submit flow so multiple input fields can be checked together with one `validate()` call.

### What user experience improvements can be made through feedback widgets like SnackBar?

Feedback widgets provide immediate confirmation or guidance, improve user confidence, and make app interactions clearer without navigating away from the current screen.

## Assignment Files

- `lib/screens/user_input_form.dart`
- `lib/screens/dashboard_screen.dart`
- `Readme.md`

## Firebase Persistent Login Flow

SmartKirana now uses Firebase Authentication session persistence at the app root in `lib/main.dart`.

### Implemented Behavior

- The app listens globally with `FirebaseAuth.instance.authStateChanges()` inside `AuthGate`
- A loading screen is shown while Firebase checks the cached session
- Signed-in users are routed directly to `DashboardScreen`
- Signed-out users are routed to `AuthScreen`
- Logout uses `FirebaseAuth.instance.signOut()` through `AuthService.logout()`
- No `SharedPreferences` or manual local session storage is used

### Auto-Login Verification Cases

1. Login with a valid Firebase email and password.
2. Confirm the app opens `DashboardScreen`.
3. Fully close the app.
4. Reopen the app.
5. Expected result: the app skips the login screen and opens `DashboardScreen` directly.

### Logout Verification Cases

1. While signed in, tap the logout button in the dashboard app bar.
2. Expected result: the app returns to `AuthScreen` immediately.
3. Fully close the app after logout.
4. Reopen the app.
5. Expected result: the app stays on `AuthScreen`; auto-login does not trigger.

### Session State Expectations

- Logged-in state persists after app restart
- Logged-out state persists after app restart
- Login and logout changes are reflected immediately because the root widget listens to Firebase auth state changes
- The loading screen prevents incorrect routing while the session is being restored

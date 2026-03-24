# Profile Details Form - Submission Checklist

## Implemented Feature

A validated multi-field `Profile Details Form` is implemented in:

- `lib/screens/responsive_forms.dart`

It validates:

1. Full Name: required and minimum 3 characters
2. Email: required and valid email format
3. Phone Number: required and exactly 10 digits
4. Password: required and minimum 8 characters
5. Confirm Password: required and must match Password

Submission behavior:

- Invalid form: submission is blocked and field-level errors are shown.
- Valid form: success message and success SnackBar are shown.

## How to Run

Use:

```bash
flutter run -d chrome --target=lib/main_responsive_design_demo.dart
```

The app now opens directly to the form route (`/forms`) for easier demo recording.

## Video Demo Script (Required)

Record a short demo and include these three sections:

### 1. Validation Errors

- Keep all fields empty and tap **Save Profile**.
- Show error messages for all required fields.
- Enter invalid values:
  - Name with fewer than 3 chars
  - Invalid email (example: `abc`)
  - Phone not equal to 10 digits
  - Password shorter than 8 chars
  - Confirm password not matching password
- Tap **Save Profile** and show submission is blocked.

### 2. Successful Validation

- Enter valid values in all fields.
- Tap **Save Profile**.
- Show that no errors remain and success message appears.

### 3. Explanation in Video

Explain:

- Validators are defined per field and attached with `validator`.
- `GlobalKey<FormState>` is used to reference the form and call `validate()`.
- Invalid submissions return errors and do not proceed.
- Valid submissions pass `validate()` and show success.

## Pull Request Checklist

Include these code changes in your PR:

- `lib/screens/responsive_forms.dart`
- `lib/main_responsive_design_demo.dart`
- `PROFILE_FORM_VALIDATION_SUBMISSION.md`

Suggested PR title:

- `feat: implement Profile Details Form with multi-field validation`

Suggested PR description:

- Implemented `Profile Details Form` with required validators.
- Added submission blocking for invalid states.
- Added success feedback for valid submission.
- Updated responsive demo app to open directly on forms route for demonstration.
- Added submission/video checklist markdown.

## Google Drive Submission

1. Upload the demo video to Google Drive.
2. Set link sharing/edit permissions as required by your evaluator.
3. Paste the Drive link into your PR description.

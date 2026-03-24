import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveForms extends StatefulWidget {
  const ResponsiveForms({super.key});

  @override
  State<ResponsiveForms> createState() => _ResponsiveFormsState();
}

class _ResponsiveFormsState extends State<ResponsiveForms> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _submitted = false;
  String? _submitStatus;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Full Name is required';
    }
    if (text.length < 3) {
      return 'Full Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Phone Number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(text)) {
      return 'Phone Number must be exactly 10 digits';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Password is required';
    }
    if (text.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Confirm Password is required';
    }
    if (text != _passwordController.text) {
      return 'Confirm Password must match Password';
    }
    return null;
  }

  void _submitProfile() {
    setState(() {
      _submitted = true;
      _submitStatus = null;
    });

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _submitStatus = 'Fix the highlighted fields before saving your profile.';
      });
      return;
    }

    setState(() {
      _submitStatus = 'Profile submitted successfully.';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile submitted successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final compact = width < 700;
    final fieldSpacing = compact ? 10.0 : 14.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Details Form')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: compact ? width : 720),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter your details to save your profile',
                      style: TextStyle(
                        fontSize: compact ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'e.g. Priya Sharma',
                      ),
                      validator: _validateFullName,
                    ),
                    SizedBox(height: fieldSpacing),
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'name@example.com',
                      ),
                      validator: _validateEmail,
                    ),
                    SizedBox(height: fieldSpacing),
                    TextFormField(
                      controller: _phoneController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '10-digit mobile number',
                      ),
                      validator: _validatePhone,
                    ),
                    SizedBox(height: fieldSpacing),
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Minimum 8 characters',
                      ),
                      validator: _validatePassword,
                    ),
                    SizedBox(height: fieldSpacing),
                    TextFormField(
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    SizedBox(height: compact ? 16 : 20),
                    FilledButton(
                      onPressed: _submitProfile,
                      child: const Text('Save Profile'),
                    ),
                    if (_submitStatus != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _submitStatus!,
                        style: TextStyle(
                          color: _submitStatus!.toLowerCase().contains('successfully')
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    SizedBox(height: compact ? 14 : 18),
                    Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Validation Rules: Full Name required (min 3), valid Email format, Phone Number exactly 10 digits, Password min 8 chars, Confirm Password must match.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

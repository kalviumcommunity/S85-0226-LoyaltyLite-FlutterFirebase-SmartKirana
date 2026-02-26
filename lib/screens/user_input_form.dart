import 'package:flutter/material.dart';import 'package:flutter/material.dart';






















































































}  }    );      ),        ),          ),            ],              ),                child: const Text('Submit'),                onPressed: _submitForm,              ElevatedButton(              const SizedBox(height: 24),              ),                },                  return null;                  }                    return 'Enter a valid email';                  if (!email.contains('@')) {                  }                    return 'Enter your email';                  if (email.isEmpty) {                  final email = value?.trim() ?? '';                validator: (value) {                ),                  border: OutlineInputBorder(),                  hintText: 'Enter your email',                  labelText: 'Email',                decoration: const InputDecoration(                keyboardType: TextInputType.emailAddress,                controller: _emailController,              TextFormField(              const SizedBox(height: 16),              ),                    value == null || value.trim().isEmpty ? 'Enter your name' : null,                validator: (value) =>                ),                  border: OutlineInputBorder(),                  hintText: 'Enter your name',                  labelText: 'Name',                decoration: const InputDecoration(                controller: _nameController,              TextFormField(            children: [            crossAxisAlignment: CrossAxisAlignment.stretch,          child: Column(          key: _formKey,        child: Form(        padding: const EdgeInsets.all(16),      body: Padding(      appBar: AppBar(title: const Text('User Input Form')),    return Scaffold(  Widget build(BuildContext context) {  @override  }    }      );        ),          ),            'Form submitted successfully for ${_nameController.text.trim()}!',          content: Text(        SnackBar(      ScaffoldMessenger.of(context).showSnackBar(    if (_formKey.currentState!.validate()) {  void _submitForm() {  }    super.dispose();    _emailController.dispose();    _nameController.dispose();  void dispose() {  @override  final _emailController = TextEditingController();  final _nameController = TextEditingController();  final _formKey = GlobalKey<FormState>();class _UserInputFormState extends State<UserInputForm> {}  State<UserInputForm> createState() => _UserInputFormState();  @override  const UserInputForm({super.key});class UserInputForm extends StatefulWidget {
class UserInputForm extends StatefulWidget {
  const UserInputForm({super.key});

  @override
  State<UserInputForm> createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form submitted successfully for $name ($email)!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your email';
                  }
                  final email = value.trim();
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

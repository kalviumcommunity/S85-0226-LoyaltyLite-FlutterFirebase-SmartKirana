import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/customer_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _nameController,
                label: 'Customer name',
                validator: _requiredField,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _phoneController,
                label: 'Phone number',
                keyboardType: TextInputType.phone,
                validator: _requiredField,
              ),
              const SizedBox(height: 16),
              if (customerProvider.errorMessage != null)
                Text(
                  customerProvider.errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              const Spacer(),
              PrimaryButton(
                label: 'Save Customer',
                isLoading: customerProvider.isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await customerProvider.addCustomer(
                    name: _nameController.text.trim(),
                    phone: _phoneController.text.trim(),
                  );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/business_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class BusinessSetupScreen extends StatefulWidget {
  const BusinessSetupScreen({super.key});

  @override
  State<BusinessSetupScreen> createState() => _BusinessSetupScreenState();
}

class _BusinessSetupScreenState extends State<BusinessSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController(text: '100');
  final _pointsController = TextEditingController(text: '1');

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  String? _requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _positiveInt(String? value) {
    final parsed = int.tryParse(value?.trim() ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Enter a positive number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final businessProvider = context.watch<BusinessProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Business Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create your business profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _nameController,
                label: 'Store name',
                validator: _requiredField,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _amountController,
                label: 'Amount for reward (INR)',
                keyboardType: TextInputType.number,
                validator: _positiveInt,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _pointsController,
                label: 'Points per reward',
                keyboardType: TextInputType.number,
                validator: _positiveInt,
              ),
              const SizedBox(height: 16),
              if (businessProvider.errorMessage != null)
                Text(
                  businessProvider.errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              const Spacer(),
              PrimaryButton(
                label: 'Save Business',
                isLoading: businessProvider.isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await businessProvider.createBusiness(
                    name: _nameController.text.trim(),
                    rewardRuleAmount:
                        int.parse(_amountController.text.trim()),
                    rewardRulePoints:
                        int.parse(_pointsController.text.trim()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

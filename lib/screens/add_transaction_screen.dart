import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import '../models/loyalty_transaction.dart';
import '../providers/customer_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  Customer? _selectedCustomer;
  TransactionType _transactionType = TransactionType.earn;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _positiveAmount(String? value) {
    final amount = double.tryParse(value?.trim() ?? '');
    if (amount == null || amount <= 0) {
      return 'Enter a valid amount.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerProvider>();
    final transactionProvider = context.watch<TransactionProvider>();
    final customers = customerProvider.customers;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: customers.isEmpty
            ? const Center(
                child: Text('Add a customer first to record transactions.'),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<Customer>(
                      value: _selectedCustomer,
                      items: customers
                          .map(
                            (customer) => DropdownMenuItem<Customer>(
                              value: customer,
                              child: Text(customer.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedCustomer = value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Customer',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Select a customer.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<TransactionType>(
                      value: _transactionType,
                      items: const [
                        DropdownMenuItem(
                          value: TransactionType.earn,
                          child: Text('Earn Points'),
                        ),
                        DropdownMenuItem(
                          value: TransactionType.redeem,
                          child: Text('Redeem Points'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _transactionType = value);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: _amountController,
                      label: 'Bill amount (INR)',
                      keyboardType: TextInputType.number,
                      validator: _positiveAmount,
                    ),
                    const SizedBox(height: 16),
                    if (transactionProvider.errorMessage != null)
                      Text(
                        transactionProvider.errorMessage!,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Save Transaction',
                      isLoading: transactionProvider.isSubmitting,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        final amount =
                            double.parse(_amountController.text.trim());
                        await transactionProvider.addTransaction(
                          customer: _selectedCustomer!,
                          amount: amount,
                          type: _transactionType,
                        );
                        if (mounted && transactionProvider.errorMessage == null) {
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

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconPressed;
  final bool isEnabled;
  final int maxLines;
  final FocusNode? focusNode;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onSuffixIconPressed,
    this.isEnabled = true,
    this.maxLines = 1,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      enabled: isEnabled,
      maxLines: maxLines,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.orange) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.orange),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: isEnabled ? Colors.white : Colors.grey.shade100,
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const CustomSearchBar({
    Key? key,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

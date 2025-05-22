import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A reusable text input field widget used for form inputs.
///
/// Automatically sets the keyboard type to `TextInputType.phone` or `TextInputType.emailAddress`
/// if the hint text contains "phone" or "email" (case-insensitive), respectively.
class InputField extends StatelessWidget {
  final String hintText;
  final String? errorMessage;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? trailingIcon;
  final String? labelText;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.errorMessage,
    this.trailingIcon,
    this.labelText,
  });

  /// Determine keyboard type based on hint text content
  TextInputType _getKeyboardType() {
    final hint = hintText.toLowerCase();
    if (hint.contains('phone')) {
      return TextInputType.phone;
    } else if (hint.contains('email')) {
      return TextInputType.emailAddress;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: _getKeyboardType(),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorMessage,
        suffixIcon:
            trailingIcon != null
                ? Icon(trailingIcon, color: context.theme.primaryColor)
                : null,
      ),
    );
  }
}

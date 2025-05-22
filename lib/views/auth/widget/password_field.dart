import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';

/// A reusable password input field widget with visibility toggle.
///
/// This widget displays a [TextFormField] for password input and
/// allows the user to toggle visibility (obscured vs visible).
class PasswordField extends StatelessWidget {
  /// Controller used to retrieve and manage the password text.
  final TextEditingController controller;
  final String? hintText;

  /// Creates a [PasswordField].
  const PasswordField({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    /// Determines whether the password text is obscured.
    RxBool isObscured = true.obs;
    return Obx(
      () => TextFormField(
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isObscured.value,
        decoration: InputDecoration(
          hintText: hintText ?? 'Password',
          suffixIcon: IconButton(
            icon: Icon(
              isObscured.value ? Icons.visibility_off : Icons.visibility,
              color: context.theme.hintColor,
            ),
            // Toggle the password visibility using the extension method.
            onPressed: isObscured.toggle,
          ),
        ),
      ),
    );
  }
}

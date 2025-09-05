import 'package:flutter/material.dart';

/// A reusable custom text field component with consistent styling
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? suffixText;
  final TextInputType keyboardType;
  final bool enabled;
  final String? hintText;
  final void Function(String)? onChanged;
  final EdgeInsets? padding;
  final bool suffixDropdown;
  final bool suffixCalendar;
  final VoidCallback? onCalendarTap;

  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.hintText,
    this.onChanged,
    this.padding,
    this.suffixDropdown = false,
    this.suffixCalendar = false,
    this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              suffixText: suffixText,
              suffixStyle: const TextStyle(color: Colors.grey),
              suffixIcon:
                  suffixCalendar
                      ? GestureDetector(
                        onTap: onCalendarTap,
                        child: const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 16,
                        ),
                      )
                      : suffixDropdown
                      ? const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                        size: 16,
                      )
                      : null,
              suffixIconConstraints:
                  (suffixDropdown || suffixCalendar)
                      ? const BoxConstraints(minWidth: 16, minHeight: 16)
                      : null,
            ),
          ),
          if (label.isNotEmpty) const Divider(height: 12),
        ],
      ),
    );
  }
}

/// Extension widget to easily create two CustomTextFields in a row
class LabeledTextFieldRow extends StatelessWidget {
  final LabeledTextField firstField;
  final LabeledTextField secondField;
  final double spacing;

  const LabeledTextFieldRow({
    super.key,
    required this.firstField,
    required this.secondField,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: firstField),
        SizedBox(width: spacing),
        Expanded(child: secondField),
      ],
    );
  }
}

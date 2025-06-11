import 'package:flutter/material.dart';

class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? dropdownColor;
  final Color? iconColor;
  final double? iconSize;

  const LabeledDropdown({
    Key? key,
    required this.label,
    required this.items,
    this.hintText,
    this.value,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.labelStyle,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
    this.dropdownColor,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding and sizing
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalSpacing = screenWidth * 0.02; // 2% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width, with constraints

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text
        Padding(
          padding: EdgeInsets.only(bottom: verticalSpacing.clamp(6.0, 12.0)),
          child: Text(
            label,
            style:
                labelStyle ??
                TextStyle(
                  fontSize: fontSize.clamp(14.0, 18.0),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
        ),

        // Dropdown with container
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
            border: Border.all(
              color: borderColor ?? Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: enabled ? onChanged : null,
            validator: validator,
            dropdownColor: dropdownColor ?? Colors.white,
            hint:
                hintText != null
                    ? Text(
                      hintText!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSize.clamp(14.0, 16.0),
                      ),
                    )
                    : null,
            style:
                textStyle ??
                TextStyle(
                  fontSize: fontSize.clamp(14.0, 16.0),
                  color: Colors.black,
                ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: iconColor ?? Colors.black54,
              size: iconSize ?? fontSize.clamp(20.0, 24.0),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: fontSize.clamp(14.0, 16.0),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: horizontalPadding.clamp(12.0, 16.0),
                    vertical: verticalSpacing.clamp(12.0, 16.0),
                  ),
              fillColor: Colors.transparent,
              filled: true,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
            ),
            isExpanded: true,
            focusColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

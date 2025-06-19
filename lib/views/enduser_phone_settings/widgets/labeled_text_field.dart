import 'package:flutter/material.dart';

class LabeledTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isPassword; // New parameter for password functionality
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon; // New parameter for custom suffix icon
  final bool readOnly; // New parameter for read-only state
  final VoidCallback? onTap; // New parameter for tap callback

  const LabeledTextField({
    Key? key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.isPassword = false, // Default to false
    this.validator,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
    this.suffixIcon,
    this.readOnly = false, // Default to false
    this.onTap,
  }) : super(key: key);

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding and sizing
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalSpacing = screenWidth * 0.02; // 2% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width, with constraints

    // Determine if text should be obscured
    bool shouldObscureText =
        widget.isPassword ? !_isPasswordVisible : widget.obscureText;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(
                bottom: verticalSpacing.clamp(6.0, 12.0),
              ),
              child: Text(
                widget.label!,
                style:
                    widget.labelStyle ??
                    TextStyle(
                      fontSize: fontSize.clamp(14.0, 18.0),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
              ),
            ),
          // Text field with container
          Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
              border: Border.all(
                color: widget.borderColor ?? Colors.grey.shade300,
                width: 1.0,
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: shouldObscureText,
              validator: widget.validator,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              style:
                  widget.textStyle ??
                  TextStyle(
                    fontSize: fontSize.clamp(14.0, 16.0),
                    color: Colors.black87,
                  ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(
                      color: Colors.black87,
                      fontSize: fontSize.clamp(14.0, 16.0),
                    ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding:
                    widget.contentPadding ??
                    EdgeInsets.symmetric(
                      horizontal: horizontalPadding.clamp(12.0, 16.0),
                      vertical: verticalSpacing.clamp(12.0, 16.0),
                    ),
                // Add suffix icon for password toggle
                suffixIcon:
                    widget.isPassword
                        ? IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey.shade600,
                            size: fontSize.clamp(16.0, 20.0),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          splashRadius: 20,
                        )
                        : widget
                            .suffixIcon, // Use the custom suffix icon if provided
              ),
            ),
          ),
        ],
      ),
    );
  }
}

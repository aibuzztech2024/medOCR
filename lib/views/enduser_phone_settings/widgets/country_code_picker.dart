import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

/// Country picker widget compatible with GetBuilder and other GetX patterns
class StyledCountryPicker extends StatefulWidget {
  final Function(Country value) onSelect;
  final String label;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final double? height;
  final Country? initialCountry;

  const StyledCountryPicker({
    Key? key,
    required this.onSelect,
    this.label = 'Country Code',
    this.labelStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 6.0,
    this.contentPadding,
    this.enabled = true,
    this.height,
    this.initialCountry,
  }) : super(key: key);

  @override
  State<StyledCountryPicker> createState() => _StyledCountryPickerState();
}

class _StyledCountryPickerState extends State<StyledCountryPicker> {
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    // Initialize with default country (India) or provided initial country
    try {
      selectedCountry =
          widget.initialCountry ??
          Country(
            phoneCode: '91',
            countryCode: 'IN',
            e164Sc: 0,
            geographic: true,
            level: 1,
            name: 'India',
            example: '9123456789',
            displayName: 'India',
            displayNameNoCountryCode: 'India',
            e164Key: '',
          );
    } catch (e) {
      debugPrint('Error initializing country: $e');
      // Fallback country
      selectedCountry = Country(
        phoneCode: '91',
        countryCode: 'IN',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'India',
        example: '9123456789',
        displayName: 'India',
        displayNameNoCountryCode: 'India',
        e164Key: '',
      );
    }
  }

  void _updateCountry(Country country) {
    if (mounted) {
      setState(() {
        selectedCountry = country;
      });
      widget.onSelect(country);
    }
  }

  void _showCountryPicker() {
    if (!mounted || !widget.enabled) return;

    try {
      showCountryPicker(
        context: context,
        showPhoneCode: true,
        useSafeArea: true,
        useRootNavigator: false,
        onSelect: _updateCountry,
        onClosed: () {
          debugPrint('Country picker closed');
        },
      );
    } catch (e) {
      debugPrint('Error showing country picker: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening country picker: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || selectedCountry == null) {
      return const SizedBox.shrink();
    }

    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding and sizing
    final horizontalPadding = screenWidth * 0.04;
    final verticalSpacing = screenWidth * 0.02;
    final fontSize = screenWidth * 0.04;

    // Calculate height to match TextFormField
    final containerHeight =
        widget.height ??
        (verticalSpacing.clamp(12.0, 16.0) * 2 +
            fontSize.clamp(14.0, 16.0) * 1.4 +
            4.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.clamp(12.0, 24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Padding(
            padding: EdgeInsets.only(bottom: verticalSpacing.clamp(6.0, 12.0)),
            child: Text(
              widget.label,
              style:
                  widget.labelStyle ??
                  TextStyle(
                    fontSize: fontSize.clamp(14.0, 18.0),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
            ),
          ),

          // Country picker container
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
              border: Border.all(
                color: widget.borderColor ?? Colors.grey.shade300,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 6.0),
                onTap: widget.enabled ? _showCountryPicker : null,
                child: Container(
                  height: double.infinity,
                  padding:
                      widget.contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: horizontalPadding.clamp(12.0, 16.0),
                        vertical: verticalSpacing.clamp(12.0, 16.0),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Selected Country flag
                      Text(
                        selectedCountry!.flagEmoji,
                        style: TextStyle(
                          fontSize: fontSize.clamp(20.0, 24.0),
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Country code
                      Text(
                        '+${selectedCountry!.phoneCode}',
                        style: TextStyle(
                          fontSize: fontSize.clamp(14.0, 16.0),
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                      const Spacer(),
                      // Dropdown icon
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: widget.enabled ? Colors.black54 : Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

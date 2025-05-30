import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_radio_button.dart';

/// Reusable payment option card widget
class PaymentOptionCard extends StatelessWidget {
  final String method;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color borderColor;
  final EdgeInsets padding;
  final bool showDivider;

  const PaymentOptionCard({
    Key? key,
    required this.method,
    required this.isSelected,
    required this.onTap,
    this.trailing,
    this.borderColor = const Color(0xFFFF6B6B),
    this.padding = const EdgeInsets.all(16),
    this.showDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding,
            child: Row(
              children: [
                CustomRadioButton(isSelected: isSelected),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    method,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(height: 1, color: borderColor.withOpacity(0.2)),
      ],
    );
  }
}

/// Standalone UPI payment option widget
class UPIPaymentOption extends StatelessWidget {
  final String method;
  final bool isSelected;
  final VoidCallback onTap;

  const UPIPaymentOption({
    Key? key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CustomRadioButton(isSelected: isSelected),
            const SizedBox(width: 12),
            Text(
              method,
              style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
            ),
            const Spacer(), // Add const here
            SvgPicture.asset("assets/icons/upi.svg"),
          ],
        ),
      ),
    );
  }
}

/// Container for multiple payment options with border
class PaymentOptionsContainer extends StatelessWidget {
  final List<Widget> children;
  final Color borderColor;

  const PaymentOptionsContainer({
    Key? key,
    required this.children,
    this.borderColor = const Color(0xFFFF6B6B),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: Column(children: children),
    );
  }
}

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

/// A reusable button widget for withdrawing earnings.
/// Shows a spinner if [isLoading] is true.
class WithdrawButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const WithdrawButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Button container styling
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: LightThemeColors.pharmacyColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        // Disable button when loading
        onTap: isLoading ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Clock icon (symbolic of withdrawal time)
            Icon(
              Icons.access_time,
              color: LightThemeColors.pharmacyColor,
              size: 16,
            ),
            const SizedBox(width: 8),

            // Loading indicator or "Withdraw" text
            isLoading
                ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      LightThemeColors.pharmacyColor,
                    ),
                  ),
                )
                : AppText.body(
                  'Withdraw',
                  fontWeight: FontWeight.w400,
                  color: LightThemeColors.pharmacyColor,
                ),
          ],
        ),
      ),
    );
  }
}

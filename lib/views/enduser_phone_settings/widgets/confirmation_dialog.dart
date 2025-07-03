import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable confirmation dialog component
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? successMessage;
  final String cancelText;
  final String confirmText;
  final Color? confirmColor;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showSuccessMessage;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.successMessage,
    this.cancelText = 'No',
    this.confirmText = 'Yes',
    this.confirmColor,
    this.onConfirm,
    this.onCancel,
    this.showSuccessMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(title, style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                padding: EdgeInsets.zero,
                height: 36,
                width: 89,
                type: ButtonType.outlined,
                text: cancelText,
                onPressed: () {
                  onCancel?.call();
                  Get.back();
                },
              ),
              const SizedBox(width: 10),
              AppButton(
                padding: EdgeInsets.zero,
                height: 36,
                width: 89,
                color: confirmColor ?? const Color(0xFFB0020A),
                type: ButtonType.filled,
                text: confirmText,
                onPressed: () {
                  onConfirm?.call();
                  Get.back();
                  if (showSuccessMessage && successMessage != null) {
                    Get.snackbar(
                      'Success',
                      successMessage!,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ],
          ),
          if (showSuccessMessage && successMessage != null) ...[
            const SizedBox(height: 8),
            AppText(successMessage!),
          ],
        ],
      ),
    );
  }

  /// Static method to show the dialog
  static Future<T?> show<T>({
    required String title,
    required String message,
    String? successMessage,
    String cancelText = 'No',
    String confirmText = 'Yes',
    Color? confirmColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showSuccessMessage = false,
  }) {
    return Get.dialog(
      ConfirmationDialog(
        title: title,
        message: message,
        successMessage: successMessage,
        cancelText: cancelText,
        confirmText: confirmText,
        confirmColor: confirmColor,
        onConfirm: onConfirm,
        onCancel: onCancel,
        showSuccessMessage: showSuccessMessage,
      ),
    );
  }
}

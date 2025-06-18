import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/enduser_phone_settings/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable account deletion dialog component
class AccountDeletionDialog extends StatefulWidget {
  final Function(String reason, String? otherReason)? onDelete;

  const AccountDeletionDialog({Key? key, this.onDelete}) : super(key: key);

  @override
  State<AccountDeletionDialog> createState() => _AccountDeletionDialogState();
}

class _AccountDeletionDialogState extends State<AccountDeletionDialog> {
  String? selectedReason;
  final TextEditingController otherReasonController = TextEditingController();

  final List<String> reasons = [
    'I found a better alternative',
    'The app is hard to use',
    'Not getting enough value',
    'Just taking a break',
    'Other (please specify)',
  ];

  @override
  void dispose() {
    otherReasonController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (selectedReason != null) {
      String reason = selectedReason!;
      String otherText = otherReasonController.text;

      // Log the selected reason
      print('Selected reason: $reason');
      if (reason == 'Other (please specify)' && otherText.isNotEmpty) {
        print('Other reason: $otherText');
      }

      Get.back();

      // Show confirmation
      Get.snackbar(
        'Account Deletion',
        'Account deletion request submitted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Call the callback
      widget.onDelete?.call(reason, otherText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: Get.width * 0.95,
        constraints: BoxConstraints(maxWidth: 400, maxHeight: Get.height * 0.8),
        padding: const EdgeInsets.all(24),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  AppText(
                    'Do you want to delete your profile ?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          color: Colors.black,
                          padding: EdgeInsets.zero,
                          height: 36,
                          type: ButtonType.outlined,
                          text: 'No',
                          onPressed: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          padding: EdgeInsets.zero,
                          height: 36,
                          color: const Color(0xFFB0020A),
                          type: ButtonType.filled,
                          text: 'Yes',
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sorry message
                  AppText(
                    'We are sorry you are going, Please select your reason',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  // Radio button options
                  ...reasons.map((reason) {
                    return Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = reason;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  reason,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Radio<String>(
                                value: reason,
                                groupValue: selectedReason,
                                onChanged: (value) {
                                  setState(() {
                                    selectedReason = value;
                                  });
                                },
                                activeColor: const Color(0xFFFF9800),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 12),

                  // Text field for "Other" reason
                  LabeledTextField(
                    hintText: 'Specify your reason (10 words)',
                    borderColor: Colors.grey,
                    controller: otherReasonController,
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Submit button
                  Center(
                    child: AppButton(
                      padding: EdgeInsets.zero,
                      height: 40,
                      width: 79,
                      color:
                          selectedReason != null
                              ? const Color(0xFFFF9800)
                              : Colors.grey.shade300,
                      type: ButtonType.filled,
                      text: 'Submit',
                      onPressed: selectedReason != null ? _handleSubmit : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Static method to show the dialog
  static Future<T?> show<T>({
    Function(String reason, String? otherReason)? onDelete,
  }) {
    return Get.dialog(AccountDeletionDialog(onDelete: onDelete));
  }
}

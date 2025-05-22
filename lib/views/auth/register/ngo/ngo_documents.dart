import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class NgoDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const NgoDocuments({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Registration Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: '12A Document Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Section 8 Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Image & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        Wrap(
          runSpacing: 5,
          children: [
            InputField(
              hintText: 'NGO Description',
              controller: TextEditingController(),
            ),
            AppText.caption(
              'Description must be 8+ characters with uppercase, lowercase, number, and symbol',
              color: context.theme.primaryColor,
            ),
          ],
        ),
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.infinity,
          onPressed: onContinue,
        ),
        SizedBox(),
      ],
    );
  }
}

import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';

class ClientDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const ClientDocuments({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Incorporation Number & Document',
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
        AppButton(
          type: ButtonType.filled,
          text: 'Continue',
          width: double.maxFinite,
          onPressed: onContinue,
        ),
      ],
    );
  }
}

import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class MedicalProviderDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const MedicalProviderDocuments({super.key, required this.onContinue});

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

        InputWithAction(
          expandedChild: InputField(
            hintText: 'Medical License Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'Bank Account Number & Document',
            controller: TextEditingController(),
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),

        SizedBox(
          height: 60,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  height: 50,
                  child: AppUploadButton(onUpload: () {}),
                ),
              ),
              Positioned(
                top: 0,
                left: 18,
                child: Container(
                  color: Colors.white,
                  child: AppText.body(
                    'Store-front Image',
                    color: context.theme.hintColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        AppButton(
          type: ButtonType.filled,
          width: double.infinity,
          text: 'Continue',
          onPressed: onContinue,
        ),

        SizedBox(),
      ],
    );
  }
}

import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_controller.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NgoDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const NgoDocuments({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    // Use existing or initialize controller
    final controller =
        Get.isRegistered<NgoController>()
            ? Get.find<NgoController>()
            : Get.put(NgoController());

    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Registration Number & Document',
            controller: controller.ngoRegController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: controller.gstController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: controller.panController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: controller.tanController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: '12A Document Number & Document',
            controller: controller.doc12AController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Section 8 Number & Document',
            controller: controller.section8Controller,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Image & Document',
            controller: controller.ngoImageController,
          ),
          trailingChild: AppUploadButton(onUpload: () {}),
        ),
        Wrap(
          runSpacing: 5,
          children: [
            InputField(
              hintText: 'NGO Description',
              controller: controller.descriptionController,
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
        const SizedBox(),
      ],
    );
  }
}

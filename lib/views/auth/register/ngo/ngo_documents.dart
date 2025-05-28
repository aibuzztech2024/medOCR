import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/ngo/ngo_document_controller.dart';
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
    final NgoDocumentController ngoDocumentController = Get.put(
      NgoDocumentController(),
    );
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Registration Number & Document',
            controller: ngoDocumentController.ngoRegistrationNumberController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadNgoRegistrationNumber();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: ngoDocumentController.ngoGstController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadNgoGst();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: ngoDocumentController.ngoPanController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadNgoPan();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: ngoDocumentController.ngoTanController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadNgoTan();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: '12A Document Number & Document',
            controller: ngoDocumentController.ngo12aDocumentController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.upload12ADocument();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Section 8 Number & Document',
            controller: ngoDocumentController.ngoSection8Controller,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadSection8Number();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'NGO Image & Document',
            controller: ngoDocumentController.ngoImageController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              ngoDocumentController.uploadNgoImage();
            },
          ),
        ),
        Wrap(
          runSpacing: 5,
          children: [
            InputField(
              hintText: 'NGO Description',
              controller: ngoDocumentController.ngoDescriptionController,
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

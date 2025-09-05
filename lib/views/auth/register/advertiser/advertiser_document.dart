import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/advertiser/advertiser_profile_controller.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvertiserDocument extends StatelessWidget {
  final VoidCallback onContinue;
  const AdvertiserDocument({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final AdvertiserController advertiserDocumentController = Get.put(
      AdvertiserController(),
    );
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Incorporation Number & Document',
            controller: advertiserDocumentController.incorporationController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              advertiserDocumentController
                  .uploadAdvertiserIncorporationNumber();
            },
          ), //handle with a controller
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: advertiserDocumentController.gstController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              advertiserDocumentController.uploadAdvertiserGst();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: advertiserDocumentController.panController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              advertiserDocumentController.uploadAdvertiserPan();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: advertiserDocumentController.tanController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              advertiserDocumentController.uploadAdvertiserTan();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Brand Image',
            controller: advertiserDocumentController.brandImageController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              advertiserDocumentController.uploadBrandImage();
            },
          ),
        ),
        Wrap(
          runSpacing: 5,
          children: [
            InputField(
              hintText: 'Brand Description',
              controller: advertiserDocumentController.descriptionController,
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

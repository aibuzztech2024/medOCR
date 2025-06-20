import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/viewModels/auth/register/client/client_profile_controller.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const ClientDocuments({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final ClientController clientDocumentController =
        Get.find<ClientController>();
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Incorporation Number & Document',
            controller: clientDocumentController.incorporationController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              clientDocumentController.uploadClientIncorporationNumber();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: clientDocumentController.gstController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              clientDocumentController.uploadClientGst();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: clientDocumentController.panController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              clientDocumentController.uploadClientPan();
            },
          ),
        ),
        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: clientDocumentController.tanController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              clientDocumentController.uploadClientTan();
            },
          ),
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

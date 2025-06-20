import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/auth/register/medical_provider/medical_provider_controller.dart';
import 'package:avatar/views/auth/widget/app_upload_button.dart';
import 'package:avatar/views/auth/widget/input_field.dart';
import 'package:avatar/views/auth/widget/input_with_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalProviderDocuments extends StatelessWidget {
  final VoidCallback onContinue;
  const MedicalProviderDocuments({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final MedicalProviderController medicalDocumentController = Get.put(
      MedicalProviderController(),
    );
    return Column(
      spacing: 25,
      children: [
        InputWithAction(
          expandedChild: InputField(
            hintText: 'Incorporation Number & Document',
            controller: medicalDocumentController.incorporationController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalIncorporationNumber();
            },
          ),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'GST Number & Document',
            controller: medicalDocumentController.gstController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalGst();
            },
          ),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'PAN Number & Document',
            controller: medicalDocumentController.panController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalPan();
            },
          ),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'TAN Number & Document',
            controller: medicalDocumentController.tanController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalTan();
            },
          ),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'Medical License Number & Document',
            controller:
                medicalDocumentController.medicalLicenseNumberController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalLicenseNumber();
            },
          ),
        ),

        InputWithAction(
          expandedChild: InputField(
            hintText: 'Bank Account Number & Document',
            controller: medicalDocumentController.bankAccountNumberController,
          ),
          trailingChild: AppUploadButton(
            onUpload: () {
              medicalDocumentController.uploadMedicalAccountNumber();
            },
          ),
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
                  child: AppUploadButton(
                    onUpload: () {
                      medicalDocumentController.uploadStoreFrontImage();
                    },
                  ),
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

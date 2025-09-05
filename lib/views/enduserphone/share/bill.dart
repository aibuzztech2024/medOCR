import 'package:avatar/core/widgets/single_text_field_widget.dart';
import 'package:avatar/viewModels/hospital/patient_prescription_controller.dart';
import 'package:avatar/views/enduserphone/share/prescription_card.dart';
import 'package:avatar/views/enduserphone/share/sharebilltextfield.dart';
import 'package:avatar/views/hospital/Widgets/upload_issue_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../models/hospital/prescription_card_model.dart';
import '../../../viewModels/hospital/upload_issue_image_controller.dart';

class bill extends StatelessWidget {
  bill({super.key});

  final PatientPrescriptionController patientPrescriptionController = Get.put(
    PatientPrescriptionController(),
  );

  @override
  Widget build(BuildContext context) {
    final UploadIssueImage uploadIssueImage = Get.put(UploadIssueImage());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
            child: Column(
              children: [
                SingleTextFieldWidget(
                  label: "Doctor Name ",
                  value: patientPrescriptionController.doctorName,
                  textController:
                      patientPrescriptionController.doctorNameController,
                ),
                SingleTextFieldWidget(
                  label: "Patient Name",
                  value: patientPrescriptionController.patientName,
                  textController:
                      patientPrescriptionController.patientNameController,
                ),
                SizedBox(height: 20),
                UploadIssueImageWidget(controller: uploadIssueImage),

                PrescriptionCard(
                  detail: PrescriptionCardModel(
                    patientName: 'John Doe',
                    gender: 'Male',
                    age: 45,
                    weight: 78,
                    prescriptionDate: DateTime.now(),
                    diagnosis: 'Respiratory tract infection',
                    doctorName: 'Dr. A. Sharma',
                    speciality: 'Dentist',
                    regNo: 'XY12345',
                    contact: '7509092218',
                    medicineName: 'Crocine',
                    frequency: '1 tab, 3x/day',
                    duration: '5 days',
                    method: 'Oral',
                    dosage: '500mg',
                    instructions: 'After Meals',
                  ),
                  onEdit: () {
                    Get.to(ShareBillTextfield());
                    // open edit form…
                  },
                  onAddAnother: () {
                    // add another prescription…
                  },
                ),
                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButton(
                        type: ButtonType.outlined,
                        text: 'Cancel',
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppButton(
                        type: ButtonType.filled,
                        text: 'Share',
                        onPressed: () {
                          // Save logic here
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

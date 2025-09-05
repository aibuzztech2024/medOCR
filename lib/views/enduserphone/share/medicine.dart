import 'dart:io';

import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_button.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/core/widgets/single_text_field_widget.dart';
import 'package:avatar/models/hospital/medicine_info_model.dart';
import 'package:avatar/viewModels/hospital/medicine_info_controller.dart';
import 'package:avatar/viewModels/hospital/patient_prescription_controller.dart';
import 'package:avatar/views/enduserphone/share/share_history.dart';
import 'package:avatar/views/hospital/Widgets/upload_issue_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewModels/hospital/upload_issue_image_controller.dart';
import '../../hospital/Widgets/medicine_info_view.dart';
import 'medicine_prescription_card.dart';
import 'medicine_search_bar.dart';

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  final PatientPrescriptionController patientPrescriptionController = Get.put(
    PatientPrescriptionController(),
  );
  final UploadIssueImage frontImageController = Get.put(
    UploadIssueImage(),
    tag: 'front',
  );
  final UploadIssueImage backImageController = Get.put(
    UploadIssueImage(),
    tag: 'back',
  );
  final MedicineInfoController medicineInfoController = Get.put(
    MedicineInfoController(),
  );

  bool showMedicineCard = false;

  @override
  void dispose() {
    Get.delete<UploadIssueImage>(tag: 'front');
    Get.delete<UploadIssueImage>(tag: 'back');
    Get.delete<MedicineInfoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    AppText.heading("Front Img"),
                    SizedBox(width: 3),
                    AppText.body(
                      '(medicine name & salt composition)',
                      color: LightThemeColors.hintText,
                    ),
                  ],
                ),
                Obx(() {
                  final files = frontImageController.files;
                  if (files.isEmpty) {
                    return UploadIssueImageWidget(
                      controller: frontImageController,
                      addLabel: "+ Upload Front Image",
                    );
                  } else {
                    final file = files.first;
                    return UploadedImageCard(
                      filePath: file.filePath,
                      onRemove: () => frontImageController.removeFile(0),
                    );
                  }
                }),
                SizedBox(height: 20),
                Row(
                  children: [
                    AppText.heading("Back Img"),
                    SizedBox(width: 3),
                    AppText.body(
                      '(MGF Date, Expiry Date, Batch No, Price)',
                      color: LightThemeColors.hintText,
                    ),
                  ],
                ),
                Obx(() {
                  final files = backImageController.files;
                  if (files.isEmpty) {
                    return UploadIssueImageWidget(
                      controller: backImageController,
                      addLabel: "+ Upload Back Image",
                    );
                  } else {
                    final file = files.first;
                    return UploadedImageCard(
                      filePath: file.filePath,
                      onRemove: () => backImageController.removeFile(0),
                    );
                  }
                }),
                SizedBox(height: 30),

                // Get Details Button (only if both images are uploaded and card not shown)
                Obx(() {
                  final frontUploaded = frontImageController.files.isNotEmpty;
                  final backUploaded = backImageController.files.isNotEmpty;
                  if (!showMedicineCard && frontUploaded && backUploaded) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightThemeColors.buttoncolors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showMedicineCard = true;
                          });
                        },
                        child: const Text("Get Details"),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),

                // Medicine Prescription Card and Add Another Medicine
                if (showMedicineCard) ...[
                  SizedBox(height: 16),
                  Obx(() {
                    final model = MedicineInfoModel(
                      medicineName:
                          medicineInfoController.medicineName.value.isNotEmpty
                              ? medicineInfoController.medicineName.value
                              : 'Nimin-GP2',
                      productPrice:
                          medicineInfoController.productPrice.value.isNotEmpty
                              ? medicineInfoController.productPrice.value
                              : '20.00',
                      manufacture:
                          medicineInfoController.manufacture.value.isNotEmpty
                              ? medicineInfoController.manufacture.value
                              : 'Nimble Pharmaceutical',
                      batchNo:
                          medicineInfoController.batchNo.value.isNotEmpty
                              ? medicineInfoController.batchNo.value
                              : 'Ngp230501',
                      manufacturingDate:
                          medicineInfoController
                                  .manufacturingDate
                                  .value
                                  .isNotEmpty
                              ? medicineInfoController.manufacturingDate.value
                              : 'May.2023',
                      expiryDate:
                          medicineInfoController.expiryDate.value.isNotEmpty
                              ? medicineInfoController.expiryDate.value
                              : 'Aug.2024',
                    );
                    return MedicinePrescriptionCard(
                      model: model,
                      onEdit: () {
                        final frontImagePath =
                            frontImageController.files.isNotEmpty
                                ? frontImageController.files.first.filePath
                                : null;
                        final backImagePath =
                            backImageController.files.isNotEmpty
                                ? backImageController.files.first.filePath
                                : null;
                        Get.to(
                          MedicineInfoView(
                            initialModel: model,
                            frontImagePath: frontImagePath,
                            backImagePath: backImagePath,
                          ),
                        );
                      },
                      onAddAnother: () {
                        // add another medicine logic
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Add another medicine logic here
                    },
                    child: Text(
                      "+ Add Another Medicine",
                      style: TextStyle(
                        color: LightThemeColors.buttoncolors,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButton(
                        type: ButtonType.outlined,
                        text: 'BillCard',
                        onPressed: () => Get.to(MedicineSearchBar()),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppButton(
                        type: ButtonType.filled,
                        text: 'History',
                        onPressed: () => Get.to(ShareHistory()),
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

class UploadedImageCard extends StatelessWidget {
  final String filePath;
  final VoidCallback onRemove;

  const UploadedImageCard({
    super.key,
    required this.filePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = filePath.split('/').last;
    final isPdf = filePath.toLowerCase().endsWith('.pdf');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: LightThemeColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                isPdf
                    ? Container(
                      width: 48,
                      height: 48,
                      color: LightThemeColors.prescriptionBackground,
                      child: const Icon(
                        Icons.picture_as_pdf,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                    : Image.file(
                      File(filePath),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body(fileName, fontWeight: FontWeight.w600),
                SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.check_box, size: 18, color: Colors.green),
                    SizedBox(width: 4),
                    Text("Virus scan", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, color: Colors.black54),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:avatar/viewModels/hospital/patient_prescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/single_text_field_widget.dart';

class PatientPrescriptionView extends StatelessWidget {
  final PatientPrescriptionController controller = Get.put(
    PatientPrescriptionController(),
  );

  PatientPrescriptionView({super.key});

  void showBottomSheet(List<String> options, Function(String) onSelect) {
    Get.bottomSheet(
      Container(
        child: ListView(
          shrinkWrap: true,
          children:
              options.map((option) {
                return ListTile(
                  title: AppText.body(option),
                  onTap: () {
                    onSelect(option);
                    Get.back();
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget buildField({
    required String label,
    required RxString value,
    List<String>? dropdownOptions,
    TextEditingController? textController,
    bool isEditable = true,
  }) {
    return SingleTextFieldWidget(
      label: label,
      value: value,
      showDropdown: dropdownOptions != null,
      onTap:
          dropdownOptions != null
              ? () {
                showBottomSheet(dropdownOptions, (val) {
                  value.value = val;
                });
              }
              : null,
      isEditable: dropdownOptions == null && isEditable,
      textController: textController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            /// ---------------- Patient Info ----------------
            AppText.heading(
              'Patient Info',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Patient Name',
                        value: controller.patientName,
                        textController: controller.patientNameController,
                      ),
                      buildField(
                        label: 'Age',
                        value: controller.age,
                        dropdownOptions: controller.ageOptions,
                      ),
                      buildField(
                        label: 'Prescription Date',
                        value: controller.prescriptionDate,
                        dropdownOptions: ['Today', 'Yesterday'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Gender',
                        value: controller.gender,
                        dropdownOptions: controller.genderOptions,
                      ),
                      buildField(
                        label: 'Weight',
                        value: controller.weight,
                        dropdownOptions: controller.weightOptions,
                      ),
                      buildField(
                        label: 'Diagnosis',
                        value: controller.diagnosis,
                        textController: controller.diagnosisController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            /// ---------------- Doctor Info ----------------
            AppText.heading(
              'Doctor Info',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Doctor Name',
                        value: controller.doctorName,
                        textController: controller.doctorNameController,
                      ),
                      buildField(
                        label: 'Reg. No.',
                        value: controller.regNo,
                        textController: controller.regNoController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Speciality',
                        value: controller.speciality,
                        dropdownOptions: controller.specialityOptions,
                      ),
                      buildField(
                        label: 'Contact',
                        value: controller.contact,
                        textController: controller.contactController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            /// ---------------- Medicine Info ----------------
            AppText.heading(
              'Medicine Info',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Medicine Name',
                        value: controller.medicineName,
                        textController: controller.medicineNameController,
                      ),
                      buildField(
                        label: 'Duration',
                        value: controller.duration,
                        dropdownOptions: controller.durationOptions,
                      ),
                      buildField(
                        label: 'Dosage',
                        value: controller.dosage,
                        textController: controller.dosageController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildField(
                        label: 'Frequency',
                        value: controller.frequency,
                        dropdownOptions: controller.frequencyOptions,
                      ),
                      buildField(
                        label: 'Method',
                        value: controller.method,
                        dropdownOptions: controller.methodOptions,
                      ),
                      buildField(
                        label: 'Instructions',
                        value: controller.instructions,
                        dropdownOptions: controller.instructionsOptions,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                    text: 'Save',
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
    );
  }
}

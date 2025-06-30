import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/single_text_field_widget.dart';
import '../../../viewModels/hospital/image_prescription_controller.dart';
import '../../../viewModels/hospital/medicine_info_controller.dart';

class MedicineInfoView extends StatelessWidget {
  final MedicineInfoController controller = Get.put(MedicineInfoController());
  final ImagePrescriptionController imageController = Get.put(
    ImagePrescriptionController(),
  );

  MedicineInfoView({super.key});

  Widget buildImagePicker({required String label, required int index}) {
    return Obx(() {
      final images = imageController.prescriptions;
      final hasImage = images.length > index;
      return Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: imageController.pickImageFromGallery,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  hasImage
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(images[index].imagePath),
                          fit: BoxFit.cover,
                        ),
                      )
                      : Center(
                        child: SvgPicture.asset(
                          'assets/icons/add_svgrepo.com.svg',
                          width: 32,
                          height: 32,
                        ),
                      ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 18),
              const SizedBox(width: 4),
              Text(
                'Virus scan Passed',
                style: TextStyle(color: Colors.green, fontSize: 13),
              ),
            ],
          ),
          if (hasImage)
            IconButton(
              icon: Icon(Icons.close, size: 18),
              onPressed: () => imageController.removePrescription(index),
            ),
        ],
      );
    });
  }

  Widget buildField({
    required String label,
    required RxString value,
    TextEditingController? textController,
    TextInputType? keyboardType,
  }) {
    return SingleTextFieldWidget(
      label: label,
      value: value,
      textController: textController,
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImagePicker(label: 'Front Img', index: 0),
                buildImagePicker(label: 'Back Img', index: 1),
              ],
            ),
            const SizedBox(height: 18),
            AppText.heading(
              'Medicine Info',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildField(
                        label: 'Medicine Name',
                        value: controller.medicineName,
                        textController: controller.medicineNameController,
                      ),
                      buildField(
                        label: 'Manufacture',
                        value: controller.manufacture,
                        textController: controller.manufactureController,
                      ),
                      buildField(
                        label: 'Manufacturing Date',
                        value: controller.manufacturingDate,
                        textController: controller.manufacturingDateController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: [
                      buildField(
                        label: 'Product Price',
                        value: controller.productPrice,
                        textController: controller.productPriceController,
                        keyboardType: TextInputType.number,
                      ),
                      buildField(
                        label: 'Batch No.',
                        value: controller.batchNo,
                        textController: controller.batchNoController,
                      ),
                      buildField(
                        label: 'Expiry Date',
                        value: controller.expiryDate,
                        textController: controller.expiryDateController,
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

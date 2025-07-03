import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../models/hospital/medicine_info_model.dart';

class MedicineInfoView extends StatelessWidget {
  final MedicineInfoModel initialModel;
  final String? frontImagePath;
  final String? backImagePath;

  const MedicineInfoView({
    Key? key,
    required this.initialModel,
    this.frontImagePath,
    this.backImagePath,
  }) : super(key: key);

  Widget buildImagePreview(String? imagePath, String label) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              imagePath != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(imagePath), fit: BoxFit.cover),
                  )
                  : Center(child: Icon(Icons.image, size: 32)),
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
      ],
    );
  }

  Widget buildReadOnlyField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const Divider(height: 16, thickness: 1),
        ],
      ),
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
                buildImagePreview(frontImagePath, 'Front Img'),
                buildImagePreview(backImagePath, 'Back Img'),
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
                      buildReadOnlyField(
                        label: 'Medicine Name',
                        value: initialModel.medicineName,
                      ),
                      buildReadOnlyField(
                        label: 'Manufacture',
                        value: initialModel.manufacture,
                      ),
                      buildReadOnlyField(
                        label: 'Manufacturing Date',
                        value: initialModel.manufacturingDate,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: [
                      buildReadOnlyField(
                        label: 'Product Price',
                        value: '₹ ${initialModel.productPrice}',
                      ),
                      buildReadOnlyField(
                        label: 'Batch No.',
                        value: initialModel.batchNo,
                      ),
                      buildReadOnlyField(
                        label: 'Expiry Date',
                        value: initialModel.expiryDate,
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

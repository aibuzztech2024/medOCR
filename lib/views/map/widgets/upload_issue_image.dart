import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/light/light_theme_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/height_box.dart';
import '../../../core/widgets/width_box.dart';
import '../../../viewModels/hospital/image_prescription_controller.dart';

class UploadIssueImage extends StatelessWidget {
  final PrescriptionController controller;
  final String addLabel;
  final bool showPdfSupport;

  const UploadIssueImage({
    super.key,
    required this.controller,
    this.addLabel = "+ Upload Issue Image",
    this.showPdfSupport = true,
  });

  bool _isPdf(String path) => path.toLowerCase().endsWith('.pdf');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.prescriptions;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Box
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: controller.pickImageFromGallery,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.add,
                    color: LightThemeColors.orangeicon,
                    size: 28,
                  ),
                ),
              ),
              WidthBox(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body(
                    addLabel,
                    fontWeight: FontWeight.w600,
                  ),
                  HeightBox(2),
                  AppText.caption(
                    'Accepts: JPG, PNG, PDF ( Max 1MB )',
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),

          HeightBox(16),

          // Uploaded Files List
          ...items.map((item) {
            final isPdf = _isPdf(item.imagePath);
            final fileName = item.imagePath.split('/').last;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  // File preview
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: isPdf
                        ? Container(
                      width: 48,
                      height: 48,
                      color: LightThemeColors.prescriptionBackground,
                      child: Icon(Icons.picture_as_pdf,
                          size: 30, color: Colors.red),
                    )
                        : Image.file(
                      File(item.imagePath),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  WidthBox(12),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.body(
                          fileName,
                          fontWeight: FontWeight.w600,
                        ),
                        HeightBox(4),
                        Row(
                          children: [
                            AppText.caption('Virus scan',
                                color: Colors.green),
                            WidthBox(4),
                            Icon(Icons.check_box,
                                size: 18, color: Colors.green),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Remove icon
                  IconButton(
                    onPressed: () => controller.removePrescription(
                      items.indexOf(item),
                    ),
                    icon: Icon(Icons.close, color: Colors.black54),
                    splashRadius: 20,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      );
    });
  }
}

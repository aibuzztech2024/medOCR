import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/light/light_theme_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/height_box.dart';
import '../../../core/widgets/width_box.dart';
import '../../../viewModels/hospital/upload_issue_image_controller.dart';

class UploadIssueImageWidget extends StatelessWidget {
  final UploadIssueImage controller;
  final String addLabel;

  const UploadIssueImageWidget({
    super.key,
    required this.controller,
    this.addLabel = "+ Upload Issue Image",
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.files;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Button
          Container(
            height: Get.height * 0.12,
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
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Open dialog to choose between PDF or image
                      Get.bottomSheet(
                        Container(
                          color: LightThemeColors.scaffoldBackground,
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: AppText.body('Upload Image'),
                                onTap: () {
                                  controller.pickImageFromGallery();
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.picture_as_pdf),
                                title: const Text('Upload PDF'),
                                onTap: () {
                                  controller.pickPdfFromFilePicker();
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                  WidthBox(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.body(addLabel, fontWeight: FontWeight.w600),
                      HeightBox(3),
                      AppText.caption(
                        'Accepts: JPG, PNG, PDF ( Max 1MB )',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          HeightBox(16),

          // Uploaded File List

          ...items.map((item) {
            final isPdf = controller.isPdf(item.filePath);
            final fileName = item.filePath.split('/').last;

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
                              File(item.filePath),
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                  ),
                  WidthBox(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.body(fileName, fontWeight: FontWeight.w600),
                        HeightBox(4),
                        Row(
                          children: const [
                            Icon(
                              Icons.check_box,
                              size: 18,
                              color: Colors.green,
                            ),
                            WidthBox(4),
                            Text(
                              "Virus scan",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.removeFile(items.indexOf(item)),
                    icon: const Icon(Icons.close, color: Colors.black54),
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

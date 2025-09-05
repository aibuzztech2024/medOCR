import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UploadPrescriptionController extends GetxController {
  RxList<PlatformFile> uploadedFiles = <PlatformFile>[].obs;

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      uploadedFiles.addAll(result.files);
    }
  }

  void removeFile(int index) {
    uploadedFiles.removeAt(index);
  }
}

class UploadPrescriptionComponent extends StatelessWidget {
  final String title;
  final UploadPrescriptionController controller = Get.put(
    UploadPrescriptionController(),
  );

  UploadPrescriptionComponent({Key? key, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double fontSize = width < 400 ? 14 : 16;
        double iconSize = width < 400 ? 20 : 24;
        double padding = width < 400 ? 12 : 16;

        return Container(
          height: 152,
          width: double.infinity,
          child: DottedBorder(
            color: const Color(0xFF3AAFA9),
            strokeWidth: 1.5,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Upload Button
                  GestureDetector(
                    onTap: controller.pickFiles,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding + 4,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Upload more',
                            style: TextStyle(
                              fontSize: fontSize - 1,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: iconSize,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Uploaded Files List
                  Obx(() {
                    if (controller.uploadedFiles.isEmpty) {
                      return SizedBox.shrink();
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              controller.uploadedFiles.asMap().entries.map((
                                entry,
                              ) {
                                int index = entry.key;
                                PlatformFile file = entry.value;

                                return Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        file.name,
                                        style: TextStyle(
                                          fontSize: fontSize - 2,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      GestureDetector(
                                        onTap:
                                            () => controller.removeFile(index),
                                        child: Icon(
                                          Icons.close,
                                          size: iconSize - 4,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Usage Example
class UploadPrescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Prescription')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            UploadPrescriptionComponent(title: 'Prescription'),
            SizedBox(height: 20),
            // Other widgets can go here
          ],
        ),
      ),
    );
  }
}

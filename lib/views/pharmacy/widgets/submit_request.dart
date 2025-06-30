import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'medicine_screen.dart';

class SubmitRequestPage extends StatelessWidget {
  SubmitRequestPage({Key? key}) : super(key: key);

  final RxString doctorName = ''.obs;
  final RxString patientName = ''.obs;
  final RxString pickedFilePath = ''.obs;

  @override
  Widget build(BuildContext context) {
    final width = Get.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Doctor’s Name Input
            TextField(
              decoration: const InputDecoration(
                labelText: "Doctor’s Name",
                labelStyle: TextStyle(fontSize: 16),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                contentPadding: EdgeInsets.only(left: 0, bottom: 8),
              ),
              onChanged: (value) => doctorName.value = value,
            ),
            const SizedBox(height: 20),

            // Patient’s Name Input
            TextField(
              decoration: const InputDecoration(
                labelText: "Patient’s Name",
                labelStyle: TextStyle(fontSize: 16),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                contentPadding: EdgeInsets.only(left: 0, bottom: 8),
              ),
              onChanged: (value) => patientName.value = value,
            ),
            const SizedBox(height: 30),

            /// Upload Box or Preview
            Obx(() {
              final path = pickedFilePath.value;
              if (path.isEmpty) {
                // Upload prompt
                return GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp3', 'pdf', 'mp4', 'mov'],
                    );
                    if (result != null) {
                      String? filePath = result.files.single.path;
                      if (filePath != null) pickedFilePath.value = filePath;
                    }
                  },
                  child: DottedBorder(
                    color: const Color(0xFF3AAFA9),
                    strokeWidth: 1,
                    dashPattern: const [8, 4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(6),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.cloud_upload_outlined, color: Color(0xFF3AAFA9), size: 40),
                          SizedBox(height: 10),
                          Text(
                            "Upload Image or record audio, & video",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                // Preview with X
                return Stack(
                  children: [
                    DottedBorder(
                      color: const Color(0xFF3AAFA9),
                      strokeWidth: 1,
                      dashPattern: const [8, 4],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(6),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Image.file(
                            File(path),
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 28,
                      child: GestureDetector(
                        onTap: () {
                          pickedFilePath.value = '';
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),

            const SizedBox(height: 30),

            // Medicine List Section
            MedicineListWidget(),
          ],
        ),
      ),
    );
  }
}

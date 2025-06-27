import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/hospital/upload_issue_image_model.dart';

class UploadIssueImage extends GetxController {
  final files = <UploadIssueImageModel>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    print('UploadIssueImage controller initialized'); // Debug log
  }

  Future<void> pickImageFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      await _handleFile(picked.path);
    }
  }

  Future<void> pickPdfFromFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null &&
          result.files.isNotEmpty &&
          result.files.single.path != null) {
        await _handleFile(result.files.single.path!);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick PDF file');
    }
  }

  Future<void> _handleFile(String path) async {
    try {
      final file = File(path);
      final sizeInMB = await file.length() / (1024 * 1024);

      if (sizeInMB <= 1.0) {
        files.add(UploadIssueImageModel(filePath: path));
        Get.snackbar('Success', 'File uploaded successfully');
      } else {
        Get.snackbar('File too large', 'Only files ≤ 1MB are allowed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to process file');
    }
  }

  void removeFile(int index) {
    files.removeAt(index);
  }

  bool isPdf(String path) => path.toLowerCase().endsWith('.pdf');
}

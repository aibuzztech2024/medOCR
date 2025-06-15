import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/hospital/image_prescription_model.dart';


class PrescriptionController extends GetxController {
  RxList<PrescriptionModel> prescriptions = <PrescriptionModel>[].obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      prescriptions.add(PrescriptionModel(imagePath: image.path));
    }
  }

  void removePrescription(int index) {
    prescriptions.removeAt(index);
  }
}

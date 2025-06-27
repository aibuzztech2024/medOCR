import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/hospital/image_prescription_model.dart';

class PrescriptionController extends GetxController {
  RxList<PrescriptionModel> prescriptions = <PrescriptionModel>[].obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Check if the image is already added by comparing both path and filename
      bool isAlreadyAdded = prescriptions.any((prescription) {
        // Compare the full path
        if (prescription.imagePath == image.path) {
          return true;
        }

        // Also compare the filename as a fallback
        String existingFileName = prescription.imagePath.split('/').last;
        String newFileName = image.path.split('/').last;
        return existingFileName == newFileName;
      });

      if (!isAlreadyAdded) {
        prescriptions.add(PrescriptionModel(imagePath: image.path));
        print('Image added: ${image.path}'); // Debug log
      } else {
        print('Duplicate image detected: ${image.path}'); // Debug log
        // Show a message that the image is already added
        Get.snackbar(
          'Image Already Added',
          'This image has already been added to the prescriptions.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void removePrescription(int index) {
    prescriptions.removeAt(index);
  }
}

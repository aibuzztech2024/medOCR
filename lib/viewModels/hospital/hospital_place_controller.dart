// controllers/hospital_controller.dart
import 'package:get/get.dart';

import '../../core/constants/image_paths.dart';
import '../../models/hospital/hospital_place_model.dart';

class HospitalPlaceController extends GetxController {
  var hospitalList = <HospitalPlaceModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchHospitals();
    super.onInit();
  }

  void fetchHospitals() async {
    await Future.delayed(Duration(seconds: 2)); // simulate network delay

    // Simulated server data with 10 hospitals
    var dataFromServer = List.generate(
      10,
      (i) => {
        "name": "Zenith Hospital",
        "address": "Flat no.7, 11th floor, Chembur, Mumbai.",
        "rating": 4.3,
        "reviews": 3723,
        "imageUrl": ImagePaths.hospitalImage,
      },
    );

    hospitalList.value =
        dataFromServer
            .map((hospital) => HospitalPlaceModel.fromJson(hospital))
            .toList();

    isLoading.value = false;
  }
}

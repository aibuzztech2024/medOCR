
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

enum AddressType { home, office, hostel, other }

class AddressModel {
  final String id;
  final AddressType type;
  final String fullAddress;

  AddressModel({
    required this.id,
    required this.type,
    required this.fullAddress,
  });

  String get label => type.name.capitalizeFirst!;
}
class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;
  var selectedAddressId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Add two default addresses for debugging
    addresses.addAll([
      AddressModel(
        id: '1',
        type: AddressType.home,
        fullAddress: 'RKL Anand phase 1, Runwal Skylark, Floor 7th, Pimpri Chinchwad, Maharashtra',
      ),
      AddressModel(
        id: '2',
        type: AddressType.office,
        fullAddress: 'Tech Park, 5th Floor, Hinjawadi, Pune, Maharashtra',
      ),
    ]);
    selectedAddressId.value = '1'; // Default selected
  }

  void addAddress(AddressModel address) {
    addresses.add(address);
  }

  void updateAddress(String id, AddressModel updated) {
    final index = addresses.indexWhere((e) => e.id == id);
    if (index != -1) addresses[index] = updated;
  }

  void deleteAddress(String id) {
    addresses.removeWhere((e) => e.id == id);
    // Deselect if the deleted one was selected
    if (selectedAddressId.value == id) selectedAddressId.value = '';
  }

  void selectAddress(String id) {
    selectedAddressId.value = id;
  }
}

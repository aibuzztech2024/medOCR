import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineInfoController extends GetxController {
  RxString medicineName = ''.obs;
  RxString productPrice = ''.obs;
  RxString manufacture = ''.obs;
  RxString batchNo = ''.obs;
  RxString manufacturingDate = ''.obs;
  RxString expiryDate = ''.obs;

  final medicineNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final manufactureController = TextEditingController();
  final batchNoController = TextEditingController();
  final manufacturingDateController = TextEditingController();
  final expiryDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    medicineNameController.text = medicineName.value;
    medicineNameController.addListener(() {
      medicineName.value = medicineNameController.text;
    });
    productPriceController.text = productPrice.value;
    productPriceController.addListener(() {
      productPrice.value = productPriceController.text;
    });
    manufactureController.text = manufacture.value;
    manufactureController.addListener(() {
      manufacture.value = manufactureController.text;
    });
    batchNoController.text = batchNo.value;
    batchNoController.addListener(() {
      batchNo.value = batchNoController.text;
    });
    manufacturingDateController.text = manufacturingDate.value;
    manufacturingDateController.addListener(() {
      manufacturingDate.value = manufacturingDateController.text;
    });
    expiryDateController.text = expiryDate.value;
    expiryDateController.addListener(() {
      expiryDate.value = expiryDateController.text;
    });
  }

  @override
  void onClose() {
    medicineNameController.dispose();
    productPriceController.dispose();
    manufactureController.dispose();
    batchNoController.dispose();
    manufacturingDateController.dispose();
    expiryDateController.dispose();
    super.onClose();
  }
}

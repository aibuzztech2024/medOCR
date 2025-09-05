import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientPrescriptionController extends GetxController {
  // Patient Info
  RxString patientName = ''.obs;
  RxString gender = ''.obs;
  RxString age = ''.obs;
  RxString weight = ''.obs;
  RxString prescriptionDate = ''.obs;
  RxString diagnosis = ''.obs;

  // Doctor Info
  RxString doctorName = ''.obs;
  RxString speciality = ''.obs;
  RxString regNo = ''.obs;
  RxString contact = ''.obs;

  // Medicine Info
  RxString medicineName = ''.obs;
  RxString frequency = ''.obs;
  RxString duration = ''.obs;
  RxString method = ''.obs;
  RxString dosage = ''.obs;
  RxString instructions = ''.obs;

  // TextEditingControllers for editable fields
  final patientNameController = TextEditingController();
  final diagnosisController = TextEditingController();
  final doctorNameController = TextEditingController();
  final regNoController = TextEditingController();
  final contactController = TextEditingController();
  final medicineNameController = TextEditingController();
  final dosageController = TextEditingController();

  // Dropdown Options (normally from API)
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<String> ageOptions = List.generate(100, (index) => '${index + 1}');
  List<String> weightOptions = List.generate(
    150,
    (index) => '${index + 30} kg',
  );
  List<String> specialityOptions = [
    'Dentist',
    'Cardiologist',
    'ENT',
    'Neurologist',
  ];
  List<String> frequencyOptions = [
    '1 Tab, 1x/day',
    '1 Tab, 3x/day',
    '2 Tabs, 2x/day',
  ];
  List<String> durationOptions = ['3 days', '5 days', '7 days'];
  List<String> methodOptions = ['Oral', 'Injection'];
  List<String> instructionsOptions = ['After Meals', 'Before Meals'];

  void updateField(RxString field, String value) {
    field.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    // Sync RxString <-> TextEditingController
    patientNameController.text = patientName.value;
    patientNameController.addListener(() {
      patientName.value = patientNameController.text;
    });
    diagnosisController.text = diagnosis.value;
    diagnosisController.addListener(() {
      diagnosis.value = diagnosisController.text;
    });
    doctorNameController.text = doctorName.value;
    doctorNameController.addListener(() {
      doctorName.value = doctorNameController.text;
    });
    regNoController.text = regNo.value;
    regNoController.addListener(() {
      regNo.value = regNoController.text;
    });
    contactController.text = contact.value;
    contactController.addListener(() {
      contact.value = contactController.text;
    });
    medicineNameController.text = medicineName.value;
    medicineNameController.addListener(() {
      medicineName.value = medicineNameController.text;
    });
    dosageController.text = dosage.value;
    dosageController.addListener(() {
      dosage.value = dosageController.text;
    });
  }

  @override
  void onClose() {
    patientNameController.dispose();
    diagnosisController.dispose();
    doctorNameController.dispose();
    regNoController.dispose();
    contactController.dispose();
    medicineNameController.dispose();
    dosageController.dispose();
    super.onClose();
  }
}

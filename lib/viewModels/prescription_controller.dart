import 'package:get/get.dart';
import '../models/hospital/prescription_card_model.dart';

class PrescriptionController extends GetxController {
  var prescription =
      PrescriptionCardModel(
        patientName: 'John Doe',
        gender: 'Male',
        age: 45,
        weight: 78,
        prescriptionDate: DateTime.now(),
        diagnosis: 'Respiratory tract infection',
        doctorName: 'Dr. A. Sharma',
        speciality: 'Dentist',
        regNo: 'XY12345',
        contact: '7509092218',
        medicineName: 'Crocine',
        frequency: '1 tab, 3x/day',
        duration: '5 days',
        method: 'Oral',
        dosage: '500mg',
        instructions: 'After Meals',
      ).obs;

  void updatePrescription(PrescriptionCardModel newModel) {
    prescription.value = newModel;
  }
}

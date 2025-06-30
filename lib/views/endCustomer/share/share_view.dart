import 'package:avatar/views/endCustomer/share/widgets/prescription_Card.dart';
import 'package:flutter/material.dart';

import '../../../models/endCustomer/share/prescription_Modal.dart';

class share_view extends StatelessWidget {
  const share_view({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 15,
          children: [
            PrescriptionCard(
              detail: PrescriptionDetail(
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
              ),
              onEdit: () {
                // open edit form…
              },
              onAddAnother: () {
                // add another prescription…
              },
            ),
            PrescriptionCard(
              detail: PrescriptionDetail(
                patientName: 'Johnny  Doe Jonny',
                gender: 'female',
                age: 35,
                weight: 89,
                prescriptionDate: DateTime.now(),
                diagnosis: 'oral Bacterial infection',
                doctorName: 'Dr. A. Jangra',
                speciality: 'Dentist',
                regNo: 'XY12345',
                contact: '7509092218',
                medicineName: 'Sarsdon',
                frequency: '2 tab, 3x/day',
                duration: '3 days',
                method: 'Oral',
                dosage: '300mg',
                instructions: 'After Meals',
              ),
              onEdit: () {
                // open edit form…
              },
              onAddAnother: () {
                // add another prescription…
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Model class for the prescription bill
class BillModel {
  final String status;
  final String fileName;
  final String doctor;
  final String patientName;
  final int points;
  final String fileSize;
  final String dateTime;
  final String frontImageAsset;
  final String backImageAsset;

  BillModel({
    required this.status,
    required this.fileName,
    required this.doctor,
    required this.patientName,
    required this.points,
    required this.fileSize,
    required this.dateTime,
    required this.frontImageAsset,
    required this.backImageAsset,
  });
}

/// ViewModel using GetX for reactive state management
class BillViewModel extends GetxController {
  final billData = BillModel(
    status: "Complete",
    fileName: "Bills",
    doctor: "Dr. Aisha Rahman",
    patientName: "Monika Singh",
    points: 234,
    fileSize: "2.5MB",
    dateTime: "20/03/25, 14:30",
    frontImageAsset: 'assets/images/tablet.jpg',
    backImageAsset: 'assets/images/tablet2.jpg',
  ).obs;

  final RxBool isFrontImage = true.obs;

  /// Toggle between front and back image
  void toggleImage(bool showFront) {
    isFrontImage.value = showFront;
  }
}

/// Main UI screen for viewing the prescription bill
class PrescriptionBill extends StatelessWidget {
  final BillViewModel vm = Get.put(BillViewModel());

  PrescriptionBill({super.key});

  /// Widget for key-value display (e.g., Doctor: Dr. Aisha)
  Widget _buildRow(String title, String value, {bool isStatus = false}) {
    const TextStyle titleStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.2,
      color: Color(0xFF1F1F1F),
    );

    const TextStyle valueStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.2,
      color: Color(0xFF929296),
    );

    if (isStatus) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Text("$title:", style: titleStyle),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF9F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value, // Dynamic status value
                style: const TextStyle(
                  color: Color(0xFF28A745),
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: Get.width * 0.35, child: Text("$title:", style: titleStyle)),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(value, style: valueStyle, textAlign: TextAlign.right),
            ),
          ),
        ],
      ),
    );
  }

  /// Dot indicator widget for toggling front/back image
  Widget _buildDot(int index) {
    return Obx(() {
      bool isActive = (index == 0 && vm.isFrontImage.value) || (index == 1 && !vm.isFrontImage.value);
      return GestureDetector(
        onTap: () => vm.toggleImage(index == 0),
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isActive ? Colors.teal : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final bill = vm.billData.value;
        final currentImage = vm.isFrontImage.value
            ? bill.frontImageAsset
            : bill.backImageAsset;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Share and Download Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Share tap handler
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3AAFA9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/1.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Download tap handler
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3AAFA9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/2.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Get.height * 0.02),

              /// Prescription Image Display
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  currentImage,
                  width: Get.width * 0.9,
                  height: Get.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: Get.height * 0.03),

              /// Toggle Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildDot(0), _buildDot(1)],
              ),

              SizedBox(height: Get.height * 0.03),

              /// Dynamic Bill Details
              _buildRow("Status", bill.status, isStatus: true),
              _buildRow("File Name", bill.fileName),
              _buildRow("Doctor", bill.doctor),
              _buildRow("Patient Name", bill.patientName),
              _buildRow("Points", bill.points.toString()),
              _buildRow("File Size", bill.fileSize),
              _buildRow("Date & Time", bill.dateTime),
            ],
          ),
        );
      }),
    );
  }
}

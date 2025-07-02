import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model class representing a Bill entity.
class BillModel {
  final String doctor;
  final String patient;
  final String status;
  final int points;
  final double fileSize;
  final DateTime dateTime;

  BillModel({
    required this.doctor,
    required this.patient,
    required this.status,
    required this.points,
    required this.fileSize,
    required this.dateTime,
  });
}

/// Controller managing the bill data using GetX.
class BillController extends GetxController {
  final Rx<BillModel> bill = BillModel(
    doctor: 'Dr. Aisha Rahman',
    patient: 'Monika Singh',
    status: 'Complete',
    points: 234,
    fileSize: 2.5,
    dateTime: DateTime(2025, 3, 20, 14, 30),
  ).obs;

  final RxBool isBookmarked = false.obs;

  /// Toggles the bookmark icon state
  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }
}

/// Bill card widget (no Scaffold)
class BillCardView extends StatelessWidget {
  final BillController controller = Get.put(BillController());

  BillCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth.clamp(320, double.infinity);
        final isSmallScreen = screenWidth < 400;

        final cardWidth = isSmallScreen ? screenWidth * 0.92 : 368.0;
        final cardHeight = isSmallScreen ? 154.0 * (cardWidth / 368.0) : 154.0;
        final imageSize = 96.0 * (cardHeight / 154.0);

        const padding = 16.0;

        return Center(
          child: Container(
            width: cardWidth,
            height: cardHeight,
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE9E9E9),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Obx(() {
              final bill = controller.bill.value;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF929292),
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/images/med_bill.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: padding),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Bills",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    height: 1.2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Obx(() {
                                return GestureDetector(
                                  onTap: controller.toggleBookmark,
                                  child: Icon(
                                    controller.isBookmarked.value
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    color: Colors.teal,
                                    size: 22,
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 2),
                          _infoRow("Doctor", bill.doctor),
                          _infoRow("Patient", bill.patient),
                          _infoRow("Status", bill.status, valueColor: Colors.green),
                          _infoRow("Points", "${bill.points}"),
                          _infoRow("File Size", "${bill.fileSize} MB"),
                          _infoRow("Date & Time", _formatDate(bill.dateTime)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  Widget _infoRow(String title, String value, {Color valueColor = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 55,
            child: Text(
              "$title:",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 1.2,
                color: Color(0xFF929292),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.2,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return "${_pad(dt.day)}/${_pad(dt.month)}/${dt.year.toString().substring(2)}, ${_pad(dt.hour)}:${_pad(dt.minute)}";
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}

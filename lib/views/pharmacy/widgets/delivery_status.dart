import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Model representing status information
class StatusModel {
  final String status;
  final String time;

  StatusModel({required this.status, required this.time});
}

/// ViewModel managing status data reactively
class StatusViewModel extends GetxController {
  var statusModel = StatusModel(
    status: "In-Packaging",
    time: "12:31 PM",
  ).obs;

  void updateStatus(String newStatus, String newTime) {
    statusModel.value = StatusModel(status: newStatus, time: newTime);
  }
}

/// Reusable status card widget (no Scaffold)
class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final StatusViewModel vm = Get.put(StatusViewModel());
    final w = Get.width;

    return Obx(() => Container(
      width: w * 0.9,
      height: 66,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0x0D3AAFA9), // 5% opacity body color
        border: Border.all(color: const Color(0x4D3AAFA9), width: 1), // 30% opacity border
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: 'Current Status: ',
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
                color: Color(0xFF484848),
              ),
              children: [
                TextSpan(
                  text: vm.statusModel.value.status,
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.2,
                    color: Color(0xFF484848),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 62,
            height: 17,
            child: Text(
              vm.statusModel.value.time,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.2,
                color: Color(0xFF929292),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

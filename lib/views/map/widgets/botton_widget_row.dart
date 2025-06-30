import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// ---------------------
/// Model Class
/// ---------------------
class ServiceModel {
  final String title;
  final String iconPath;

  ServiceModel({
    required this.title,
    required this.iconPath,
  });
}

/// ---------------------
/// ViewModel Class
/// ---------------------
class ServiceViewModel extends GetxController {
  var selectedIndex = 0.obs;

  final services = <ServiceModel>[
    ServiceModel(title: 'Hospitals', iconPath: 'assets/icons/hospital.svg'),
    ServiceModel(title: 'Pharmacy', iconPath: 'assets/icons/pharmacy.svg'),
    ServiceModel(title: 'Lab', iconPath: 'assets/icons/lab.svg'),
    ServiceModel(title: 'Doctor', iconPath: 'assets/icons/doctor.svg'),
  ];
}

/// ---------------------
/// Main Widget with View
/// ---------------------
class BottonWidgetRow extends StatelessWidget {
  final ServiceViewModel controller = Get.put(ServiceViewModel());
  final String title;

  BottonWidgetRow({super.key, this.title = "Where to?"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Get.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                controller.services.length,
                    (index) => ServiceTile(
                  model: controller.services[index],
                  isSelected: controller.selectedIndex.value == index,
                  onTap: () => controller.selectedIndex.value = index,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

/// ---------------------
/// Custom Notched Service Tile (Pixel Perfect)
/// ---------------------
class ServiceTile extends StatelessWidget {
  final ServiceModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceTile({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = Get.width * 0.22;
    final double iconSize = Get.width * 0.055;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Card
          Container(
            width: cardWidth,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF8F0) : const Color(0xFFF7F7FB),
              borderRadius: BorderRadius.circular(16),
              border: isSelected
                  ? Border.all(color: const Color(0xFFFFA000), width: 1)
                  : Border.all(color: Colors.transparent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: Get.width * 0.033,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),

          // Floating Icon
          Positioned(
            top: -20,
            left: (cardWidth - 48) / 2,
            child: Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFA000) : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                model.iconPath,
                height: iconSize,
                width: iconSize,
                colorFilter: isSelected
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

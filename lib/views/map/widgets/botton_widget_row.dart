import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Model class representing each service with a title and icon asset path
class ServiceModel {
  final String title;
  final String iconPath;

  ServiceModel({required this.title, required this.iconPath});
}

/// ViewModel using GetX for state management of selected index and list of services
class ServiceViewModel extends GetxController {
  var selectedIndex = (-1).obs;

  final services = <ServiceModel>[
    ServiceModel(title: 'Hospital', iconPath: 'assets/icons/hospital.svg'),
    ServiceModel(title: 'Pharmacy', iconPath: 'assets/icons/pharmacy.svg'),
    ServiceModel(title: 'Lab', iconPath: 'assets/icons/lab.svg'),
    ServiceModel(title: 'Doctor', iconPath: 'assets/icons/doctor.svg'),
  ];
}

/// Main widget showing a title and 4 service tiles in a row
class BottonWidgetRow extends StatelessWidget {
  final ServiceViewModel controller = Get.put(ServiceViewModel());
  final String title;

  BottonWidgetRow({super.key, this.title = "Where to?"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 120), // 120px top space
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Text with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // 20px side padding
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20, // 20px text
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30), // 30px vertical gap

            // Row with 4 tiles, reactive to selection changes
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                controller.services.length,
                    (index) => SizedBox(
                  width: Get.width / 4 - 20, // responsive per tile width
                  child: ServiceTile(
                    model: controller.services[index],
                    isSelected: controller.selectedIndex.value == index,
                    onTap: () => controller.selectedIndex.value = index,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

/// Individual service tile widget showing floating icon and text below
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
    final double cardWidth = Get.width / 4 - 20;
    final double iconSize = 32.0; // fixed 32px icon
    final double clampedIconSize = iconSize.clamp(24.0, 48.0); // between 24–48px

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: cardWidth,
            padding: const EdgeInsets.only(top: 30, bottom: 20), // 30px top, 20px bottom
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF8F0) : const Color(0xFFF7F7FB),
              borderRadius: BorderRadius.circular(16), // 16px corner radius
              border: Border.all(
                color: isSelected ? const Color(0xFFFFA000) : Colors.transparent,
                width: 1, // 1px border
              ),
            ),
            child: Center(
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13, // 13px text
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Floating Icon
          Positioned(
            top: -20, // 20px above the card
            left: (cardWidth - 48) / 2, // center align
            child: Container(
              height: 48, // 48px circle
              width: 48,
              padding: const EdgeInsets.all(10), // 10px inner padding
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFA000) : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2), // subtle shadow
                  ),
                ],
              ),
              child: Semantics(
                label: model.title,
                child: SvgPicture.asset(
                  model.iconPath,
                  height: clampedIconSize,
                  width: clampedIconSize,
                  colorFilter: isSelected
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

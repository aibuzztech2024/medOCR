import 'dart:io';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/hospital/image_prescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PrescriptionView extends StatelessWidget {
  final ImagePrescriptionController controller = Get.put(
    ImagePrescriptionController(),
  );

  PrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            final items = controller.prescriptions;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // prevent internal scroll
                  itemCount: items.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: controller.pickImageFromGallery,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: LightThemeColors.prescriptionBorder,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: LightThemeColors.prescriptionBackground,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/lucide_plus.svg",
                                ),
                                const SizedBox(height: 8),
                                AppText.body(
                                  "Add\nPrescription",
                                  textAlign: TextAlign.center,
                                  color: LightThemeColors.orangeicon,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      final item = items[index - 1];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(item.imagePath),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap:
                                  () =>
                                      controller.removePrescription(index - 1),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor:
                                    LightThemeColors.prescriptionBackground,
                                child: SvgPicture.asset(
                                  "assets/icons/add_svgrepo.com.svg",
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

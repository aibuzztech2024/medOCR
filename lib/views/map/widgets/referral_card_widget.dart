import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/light/light_theme_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../viewModels/map/referral_conroller.dart';

//Todo:referal card

/// referral card which shown for discount and donation it is that thing
///
class ReferralCard extends StatelessWidget {
  final ReferController controller = Get.put(ReferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Obx(() {
          final current = controller.cards[controller.currentIndex.value];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(17),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: current.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.heading(
                            current.title,
                            textAlign: TextAlign.center,
                            color: current.titleColor,
                            fontSize: 22,
                          ),
                          SizedBox(height: 20),
                          AppButton(
                            type: ButtonType.filled,
                            onPressed:
                                () => controller.onButtonPressed(
                                  current.buttonLabel,
                                ),
                            color: LightThemeColors.scaffoldBackground,
                            textColor: LightThemeColors.titleText,
                            borderRadius: 30,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  current.icon,
                                  color: LightThemeColors.titleText,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  current.buttonLabel,
                                  style: TextStyle(
                                    color: LightThemeColors.titleText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Expanded(child: Image.asset(current.imagePath)),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.cards.length,
                  (i) => _buildDot(i == controller.currentIndex.value),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color:
            isActive
                ? const Color.fromARGB(255, 231, 111, 36)
                : LightThemeColors.scaffoldBackground,
        shape: BoxShape.circle,
      ),
    );
  }
}

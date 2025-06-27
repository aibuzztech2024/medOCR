import 'package:avatar/core/widgets/height_box.dart';
import 'package:avatar/core/widgets/width_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cards/card_model.dart';
import '../../viewModels/card/card_controller.dart';
import 'app_text.dart';

class ReferralCard extends StatelessWidget {
  final List<CardModel> cards;
  final Function(String) onButtonPressed;
  final Duration? autoScrollDuration;
  final int initialIndex;
  final EdgeInsets? margin;
  final double borderRadius;
  final double activeDotSize;
  final double inactiveDotSize;
  final Color activeDotColor;
  final Color inactiveDotColor;

  const ReferralCard({
    Key? key,
    required this.cards,
    required this.onButtonPressed,
    this.initialIndex = 0,
    this.margin,
    this.borderRadius = 16,
    this.activeDotSize = 12,
    this.inactiveDotSize = 8,
    this.activeDotColor = const Color.fromARGB(255, 231, 111, 36),
    this.inactiveDotColor = Colors.grey,
    this.autoScrollDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CardController(
        cards: cards,
        initialIndex: initialIndex,
        autoScrollDuration: autoScrollDuration,
      ),
    );

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .99,
            height: MediaQuery.of(context).size.height * 0.19,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: cards.length,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
                controller.resetAutoScrollTimer();
              },
              itemBuilder: (context, index) {
                final card = cards[index];
                return Container(
                  margin: margin ?? const EdgeInsets.all(17),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      colors: card.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: [
                          /// Left Text & Button Column
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText.heading(
                                  card.title,
                                  fontSize: constraints.maxHeight * 0.20,
                                  color: card.titleColor,
                                ),
                                const HeightBox(8),
                                if (card.subtitle != null)
                                  AppText.body(
                                    card.subtitle!,
                                    fontSize: constraints.maxHeight * 0.137,
                                    color:
                                        card.subtitleColor ??
                                        card.titleColor.withOpacity(0.8),
                                  ),
                                const Spacer(),
                                SizedBox(
                                  height: constraints.maxHeight * 0.30,
                                  child: ElevatedButton(
                                    onPressed:
                                        () => onButtonPressed(card.buttonLabel),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        card.icon,
                                        const WidthBox(8),
                                        AppText.body(
                                          card.buttonLabel,
                                          fontSize:
                                              constraints.maxHeight * 0.14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const WidthBox(10),

                          /// Right Image
                          Expanded(
                            flex: 2,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                card.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              cards.length,
              (i) => _buildDot(
                isActive: i == controller.currentIndex.value,
                onTap: () => controller.goToCard(i),
                activeSize: activeDotSize,
                inactiveSize: inactiveDotSize,
                activeColor: activeDotColor,
                inactiveColor: inactiveDotColor,
              ),
            ),
          ),
          HeightBox(10),
        ],
      );
    });
  }

  Widget _buildDot({
    required bool isActive,
    required VoidCallback onTap,
    required double activeSize,
    required double inactiveSize,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? activeSize : inactiveSize,
        height: isActive ? activeSize : inactiveSize,
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

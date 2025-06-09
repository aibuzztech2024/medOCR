import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/map/card_model.dart';
import '../../viewModels/map/referral_conroller.dart';

// TODO: It is promotion card or refferal card

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
    this.inactiveDotColor = Colors.white,
    this.autoScrollDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Add error handling for empty cards list
    final controller = Get.put(
      CardController(
        cards: cards,
        initialIndex: initialIndex,
        autoScrollDuration: autoScrollDuration,
      ),
    );

    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: Obx(() {
          final current = controller.currentCard;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.17,
                margin: margin ?? const EdgeInsets.all(17),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
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
                          Text(
                            current.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: current.titleColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (current.subtitle != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              current.subtitle!,
                              style: TextStyle(
                                color:
                                    current.subtitleColor ??
                                    current.titleColor.withOpacity(0.8),
                                // Use subtitleColor if provided
                                fontSize: 14,
                              ),
                            ),
                          ],
                          SizedBox(height: 10),

                          // TODO: Make button style customizable
                          ElevatedButton(
                            onPressed:
                                () => onButtonPressed(current.buttonLabel),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                current.icon,
                                const SizedBox(width: 8),
                                Text(current.buttonLabel),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      // TODO: Add error handling for missing image
                      Expanded(child: Image.asset(current.imagePath)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // TODO: Make dots navigation interactive
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  cards.length,
                  (i) => _buildDot(
                    i == controller.currentIndex.value,
                    activeSize: activeDotSize,
                    inactiveSize: inactiveDotSize,
                    activeColor: activeDotColor,
                    inactiveColor: inactiveDotColor,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDot(
    bool isActive, {
    required double activeSize,
    required double inactiveSize,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    // TODO: Add tap handler for dot navigation
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? activeSize : inactiveSize,
      height: isActive ? activeSize : inactiveSize,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/icons_paths.dart';
import '../../core/constants/image_paths.dart';
import '../../core/widgets/promotion_card_widget.dart';
import '../../models/cards/card_model.dart';

// TODO: Ui for refferal card

class HelpCardWidget extends StatelessWidget {
  final List<CardModel> helpcards = [
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath: ImagePaths.helpCard1,
      buttonLabel: "Chat Now",
      gradientColors: [
        Color(0xFFFAF6EC), // #FAF6EC (4.97%)
        Color(0xFFF6BF59),
      ],
      subtitleColor: Colors.black38,
      icon: SvgPicture.asset(IconsPaths.bxChat),
      titleColor: Colors.black54,
    ),
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath: ImagePaths.helpCard2,
      buttonLabel: "Mail Now",
      gradientColors: [
        Color(0xFFCAD4FF), // #CAD4FF
        Color(0xFF1443C1), // #1443C1
      ],
      icon: SvgPicture.asset(IconsPaths.mail),
      titleColor: Colors.black54,
      subtitleColor: Colors.black38,
    ),
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath: ImagePaths.helpCard3,
      buttonLabel: "Report Now",
      gradientColors: [
        Color(0xFFFFE1E2), // #FFE1E2
        Color(0xFFC2595B), // #C2595B
      ],
      icon: SvgPicture.asset(IconsPaths.solarDangerBroken),
      titleColor: Colors.black54,
      subtitleColor: Colors.black38,
    ),
  ];

  /// all thing which is required in the card is here

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // Fixed height for the help cards
      child: ReferralCard(
        autoScrollDuration: Duration(seconds: 5),
        cards: helpcards,
        onButtonPressed: (buttonLabel) {
          // TODO: Implement proper button action handling
          print('Button pressed: $buttonLabel');
          Get.snackbar(
            "Action",
            "$buttonLabel button clicked!",
            snackPosition: SnackPosition.TOP,
          );
        },
      ),
    );
  }
}

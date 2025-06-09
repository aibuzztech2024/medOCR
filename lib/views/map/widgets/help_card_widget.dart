import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/widgets/promotion_card_widget.dart';
import '../../../models/map/card_model.dart';

// TODO: Ui for refferal card

class HelpCardWidget extends StatelessWidget {
  final List<CardModel> helpcards = [
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath:
          "assets/images/gradient-affiliate-marketing-illustrationhelp1.png",
      buttonLabel: "Chat Now",
      gradientColors: [
        Color(0xFFFAF6EC), // #FAF6EC (4.97%)
        Color(0xFFF6BF59),
      ],
      subtitleColor: Colors.black38,
      icon: SvgPicture.asset('assets/icons/bx_chat.svg'),
      titleColor: Colors.black54,
    ),
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath:
          "assets/images/gradient-affiliate-marketing-illustrationhelp2.png",
      buttonLabel: "Mail Now",
      gradientColors: [
        Color(0xFFCAD4FF), // #CAD4FF
        Color(0xFF1443C1), // #1443C1
      ],
      icon: SvgPicture.asset('assets/icons/mail.svg'),
      titleColor: Colors.black54,
      subtitleColor: Colors.black38,
    ),
    CardModel(
      title: "Need Help?",
      subtitle: "Contact to our team for help",
      imagePath:
          "assets/images/gradient-affiliate-marketing-illustrationhelp3.png",
      buttonLabel: "Report Now",
      gradientColors: [
        Color(0xFFFFE1E2), // #FFE1E2
        Color(0xFFC2595B), // #C2595B
      ],
      icon: SvgPicture.asset('assets/icons/solar_danger-broken.svg'),
      titleColor: Colors.black54,
      subtitleColor: Colors.black38,
    ),
  ];

  /// all thing which is required in the card is here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReferralCard(
        autoScrollDuration: Duration(seconds: 3),
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

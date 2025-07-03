import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:avatar/viewModels/points/controller/invite_friends_controller.dart';
import 'package:flutter/material.dart';

// this is the innvite friends card used in points screen
class InviteFriendsCard extends StatelessWidget {
  final String referralCode;
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
    final Color colors;
  

  const InviteFriendsCard({
    super.key,
    required this.referralCode,
    required this.title,
    required this.subtitle,
    required this.imagePath, required this.color, required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final controller = InviteFriendsController(context);
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: LightThemeColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: AppText.heading(title)),

                    // copy text icon
                    InkWell(
                      //TODO chnage this function
                      onTap: () => controller.copyReferralCode(referralCode),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colors,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.copy,
                          size: 24,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Referral Code + Copy Icon
                Text(
                  'Referral code: $referralCode',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                /// Invite & Earn + Image
                GestureDetector(
                  onTap: () => controller.shareReferral(referralCode),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.body(
                        fontSize: 14,
                        subtitle,
                        color: color,
                        fontWeight: FontWeight.w400,
                      ),

                      Image.asset(imagePath, height: 80, width: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

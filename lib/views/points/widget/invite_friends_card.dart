import 'package:avatar/core/constants/image_paths.dart';
import 'package:avatar/core/themes/light/light_theme_colors.dart';
import 'package:avatar/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// this is the innvite friends card used in points screen
class InviteFriendsCard extends StatelessWidget {
  final String referralCode;
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onInvitePressed;

  const InviteFriendsCard({
    super.key,
    required this.referralCode,
    this.onInvitePressed,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
                    GestureDetector(
                      //TODO chnage this function
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: referralCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Code copied!')),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: LightThemeColors.advertisorColor15,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.copy,
                          size: 24,
                          color: LightThemeColors.advertisorColor,
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
                  onTap: onInvitePressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.body(
                        fontSize: 14,
                        subtitle,
                        color: LightThemeColors.advertisorColor,
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

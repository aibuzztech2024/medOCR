import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/viewModels/hospital/faq_controller.dart';
import 'package:avatar/views/endCustomer/help/chat/chat_screen.dart';
import 'package:avatar/views/help/ticket_history_page.dart';
import 'package:avatar/views/hospital/Widgets/newticket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../widgets/faq_category_tile.dart';
import '../../../widgets/cards/help_card_widget.dart';
import '../../../core/themes/light/light_theme_colors.dart';
import '../../../core/widgets/height_box.dart';
import '../../../core/widgets/width_box.dart';

class FAQView extends StatelessWidget {
  final FAQController controller = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            HelpCardWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 12.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SupportShadowButton(
                        icon: Icons.error_outline,
                        label: 'Report an issue',
                        onPressed: () => navigateTo(() => NewTicketPage()),
                      ),
                      WidthBox(12),
                      SupportShadowButton(
                        icon: Icons.receipt_long,
                        label: 'Ticket History',
                        onPressed: () => navigateTo(() => TicketHistoryPage()),
                      ),
                    ],
                  ),
                  HeightBox(12),
                  Row(
                    children: [
                      SupportShadowButton(
                        icon: Icons.email_outlined,
                        label: 'Email Support',
                        onPressed: () {},
                      ),
                      WidthBox(12),
                      SupportShadowButton(
                        icon: Icons.chat_bubble_outline,
                        label: 'Chat Support',
                        onPressed: () {
                          navigateTo(() => ChatScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 16.0),
                        child: AppText.heading(
                          'FAQ',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.faqCategories.length,
                          separatorBuilder:
                              (context, index) => Divider(
                                color: LightThemeColors.dividerColor,
                                thickness: 1,
                                height: 1,
                              ),
                          itemBuilder:
                              (context, index) => FAQCategoryTile(
                                category: controller.faqCategories[index],
                              ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportShadowButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SupportShadowButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: LightThemeColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: LightThemeColors.shadowColor,
              offset: Offset(2, 3),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: AppButton(
          type: ButtonType.outlined,
          color: LightThemeColors.cardBackground,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: LightThemeColors.orangeicon),
              WidthBox(8),
              AppText(
                label,
                style: TextStyle(
                  color: LightThemeColors.bodyText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

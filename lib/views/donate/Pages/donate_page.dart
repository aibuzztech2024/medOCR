import 'dart:ui'; // For blur filter
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar/views/donate/widgets/donate_campaign_card.dart';
import 'package:avatar/views/donate/widgets/recent_donation_card.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../../../viewModels/donate/recent_donation_view_model.dart';

class DonatePage extends StatelessWidget {
  DonatePage({super.key});

  final CampaignViewModel campaignController = Get.put(CampaignViewModel());
  final RecentDonationViewModel recentDonationController = Get.put(RecentDonationViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final expandedHeight = height * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: false,
                expandedHeight: expandedHeight,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double percent = ((constraints.maxHeight - kToolbarHeight) / (expandedHeight - kToolbarHeight))
                        .clamp(0.0, 1.0);
                    double elevation = (1 - percent) * 4;
                    double titleSize = lerpDouble(width * 0.06, width * 0.045, 1 - percent)!;

                    return Material(
                      elevation: elevation,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background Image fading out
                          Opacity(
                            opacity: percent,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                              child: Image.asset(
                                'assets/images/donate.jpg',
                                fit: BoxFit.cover,
                                alignment: Alignment.topRight,
                              ),
                            ),
                          ),

                          // Gradient with blur
                          Opacity(
                            opacity: 1 - percent,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Container(color: Colors.transparent),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFFE1AFD1).withOpacity(0.85),
                                          const Color(0xFF5293F2).withOpacity(0.85),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.2, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Title and Icons
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 12,
                              left: width * 0.04,
                              right: width * 0.04,
                              bottom: 12,
                            ),
                            child: Row(
                              children: [
                                // Left icon (search)
                                SizedBox(
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {},
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: width * 0.055,
                                      ),
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // Title
                                Text(
                                  "Donate",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: titleSize,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 6,
                                        color: Colors.black.withOpacity(0.6),
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // Right icon (close)
                                SizedBox(
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {},
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: width * 0.07,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Content
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.015),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _SimpleHeader(
                      text: "Need to help first !",
                      buttonText: "View All",
                      onButtonPressed: () {},
                      width: width,
                    ),
                    Obx(() => DonateCampaignCard(campaign: campaignController.campaign.value)),
                    SizedBox(height: height * 0.03),
                    _SimpleHeader(
                      text: "Recent Donations",
                      buttonText: "View All",
                      onButtonPressed: () {},
                      width: width,
                    ),
                    Obx(() {
                      return Column(
                        children: recentDonationController.donations
                            .take(2)
                            .map((donation) => RecentDonationCard(donation: donation))
                            .toList(),
                      );
                    }),
                    SizedBox(height: height * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: Text(
                        "Campaigns by Organization",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.045,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.08),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple header without animation
class _SimpleHeader extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final double width;

  const _SimpleHeader({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.onButtonPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.045,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onButtonPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.038,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:avatar/core/utils/methods/navigate_to.dart';
import 'package:avatar/views/donate/Pages/donate_checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../widgets/campaign_card_view.dart';
import '../widgets/organization_info.dart';

class CampaignDetailsPage extends StatelessWidget {
  CampaignDetailsPage({Key? key}) : super(key: key);

  final CampaignViewModel controller = Get.find<CampaignViewModel>();

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Save a child from hunger',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final campaign = controller.campaign.value;

        return SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CampaignCardView(), // ✅ Updated (no need to pass campaign)
              SizedBox(height: height * 0.02),

              Text(
                "Description",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.01),

              Text(
                campaign.description,
                style: TextStyle(fontSize: width * 0.037, height: 1.5),
              ),

              SizedBox(height: height * 0.04),

              OrganizationInfoRow(
                logoUrl: campaign.organizationLogoUrl,
                organizationName: campaign.organizationName,
                organizationWebsite: campaign.organizationWebsite,
              ),

              SizedBox(height: height * 0.04),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.3,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD2F3F2),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateTo(() => DonateCheckoutPage());

                        // TODO: Implement donation functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3AAFA9),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Donate Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        );
      }),
    );
  }
}

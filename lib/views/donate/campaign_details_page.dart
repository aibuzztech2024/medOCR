import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewModels/donate/campaign_view_model.dart';
import 'campaign_card_view.dart';

/// Main campaign details page that includes the CampaignCardPage and other sections.
class CampaignDetailsPage extends StatelessWidget {
  final CampaignViewModel controller = Get.put(CampaignViewModel());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Save a child from hunger',
          style: TextStyle(
            fontWeight: FontWeight.w500, // Makes the font normal weight
          ),
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
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Campaign Card
              CampaignCardView(campaign: campaign),

              SizedBox(height: height * 0.02),

              /// Description
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
                style: TextStyle(
                  fontSize: width * 0.037,
                  height: 1.5,
                ),
              ),

              SizedBox(height: height * 0.04),

              /// Organization Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      campaign.organizationLogoUrl,
                      width: width * 0.12,
                      height: width * 0.12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.organizationName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.042,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          campaign.organizationWebsite,
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () { },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Smaller padding
                      minimumSize: Size(0, 0), // Remove minimum size constraints
                    ),
                    child: const Text(
                      "Visit",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14, // Smaller font size
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: height * 0.04),

              /// Bottom Buttons
              Wrap(
                spacing: width * 0.04,
                runSpacing: height * 0.02,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.42, // Always use percentage
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF7E6),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.42, // Always use percentage
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle donation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF99F1B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Donate Now",
                        style: TextStyle(
                          fontSize: 18,
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

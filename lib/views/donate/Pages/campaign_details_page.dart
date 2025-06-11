import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewModels/donate/campaign_view_model.dart';
import '../../home/widgets/overview_page.dart';
import '../../purchase/widgets/card_page.dart';
import '../widgets/campaign_card_view.dart';

class CampaignDetailsPage extends StatelessWidget {
  // Initialize CampaignViewModel using GetX dependency injection
  final CampaignViewModel controller = Get.put(CampaignViewModel());

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive sizing
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      // AppBar with title, back button and basic styling
      appBar: AppBar(
        title: const Text(
          'Save a child from hunger',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back on tap
        ),
      ),
      // Body wrapped in Obx to reactively rebuild when campaign changes
      body: Obx(() {
        final campaign = controller.campaign.value;  // Current campaign data

        return SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom widget displaying campaign card with main info
              CampaignCardView(campaign: campaign),

              SizedBox(height: height * 0.02),

              // Section header for description
              Text(
                "Description",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.01),

              // Campaign description text with line height for readability
              Text(
                campaign.description,
                style: TextStyle(
                  fontSize: width * 0.037,
                  height: 1.5,
                ),
              ),

              SizedBox(height: height * 0.04),

              // Row containing organization logo, info, and Visit button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular clipped organization logo
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

                  // Organization name and website in a column
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
                          overflow: TextOverflow.ellipsis, // Prevent overflow
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

                  // Outlined button to visit organization website (add functionality)
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Open organization website in browser
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      minimumSize: Size(0, 0),
                    ),
                    child: const Text(
                      "Visit",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: height * 0.04),

              // Buttons for "Go Back" and "Donate Now" side by side
              Wrap(
                spacing: width * 0.04,
                runSpacing: height * 0.02,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // Go Back button - navigates back to previous screen
                  SizedBox(
                    width: width * 0.42,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF7E6), // Light orange background
                        foregroundColor: Colors.black, // Text color
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

                  // Donate Now button - placeholder for donation logic
                  SizedBox(
                    width: width * 0.42,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement donation functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF99F1B), // Orange background
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

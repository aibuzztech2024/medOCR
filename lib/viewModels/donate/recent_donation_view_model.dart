import 'package:get/get.dart';
import '../../../models/donate/recent_donation_model.dart';

class RecentDonationViewModel extends GetxController {
  // Observable list of recent donations
  var donations = <RecentDonationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDonations();
  }

  // Load donations (mock data for now)
  void loadDonations() {
    donations.value = [
      RecentDonationModel(
        category: "Healthcare",
        organizationName: "Bharat Seva Mandal",
        organizationLogoUrl: "assets/images/campaign.jpg",
        donationDate: "10/06/25, 12:45",
        amount: 10000,
        status: "Successful",
      ),
      RecentDonationModel(
        category: "Education",
        organizationName: "Bharat Seva Mandal",
        organizationLogoUrl: "assets/images/campaign.jpg",
        donationDate: "20/05/25, 14:30",
        amount: 10000,
        status: "Successful",
      ),
      // Add more donations here if needed
    ];
  }

  /// Optionally add a donation dynamically
  void addDonation(RecentDonationModel donation) {
    donations.add(donation);
  }
}

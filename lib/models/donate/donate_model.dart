// lib/models/donate/donate_model.dart

class CampaignModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double raisedAmount;
  final double goalAmount;
  final String organizationName;

  CampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.raisedAmount,
    required this.goalAmount,
    required this.organizationName,
  });
}

class RecentDonationModel {
  final String category;
  final String organizationName;
  final String organizationLogoUrl;
  final String donationDate;
  final double amount;
  final String status;

  RecentDonationModel({
    required this.category,
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.donationDate,
    required this.amount,
    required this.status,
  });
}

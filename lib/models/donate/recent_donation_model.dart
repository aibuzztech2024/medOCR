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

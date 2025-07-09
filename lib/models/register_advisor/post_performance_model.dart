class PostPerformanceModel {
  final int totalCoupons;
  final int totalRedemptions;
  final int activeCoupons;
  final String lastUpdated;

  PostPerformanceModel({
    required this.totalCoupons,
    required this.totalRedemptions,
    required this.activeCoupons,
    required this.lastUpdated,
  });

  // Factory constructor for creating from JSON
  factory PostPerformanceModel.fromJson(Map<String, dynamic> json) {
    return PostPerformanceModel(
      totalCoupons: json['totalCoupons'] ?? 0,
      totalRedemptions: json['totalRedemptions'] ?? 0,
      activeCoupons: json['activeCoupons'] ?? 0,
      lastUpdated: json['lastUpdated'] ?? 'Last 30 days',
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalCoupons': totalCoupons,
      'totalRedemptions': totalRedemptions,
      'activeCoupons': activeCoupons,
      'lastUpdated': lastUpdated,
    };
  }
}
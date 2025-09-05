import 'package:avatar/models/earnings/badge_model.dart';

class EarningsModel {
  final int totalPurchases;
  final int rewardPoints;
  final String linkedAccount;
  final List<BadgeModel> badges;

  EarningsModel({
    required this.totalPurchases,
    required this.rewardPoints,
    required this.linkedAccount,
    required this.badges,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      totalPurchases: json['totalPurchases'] ?? 0,
      rewardPoints: json['rewardPoints'] ?? 0,
      linkedAccount: json['linkedAccount'] ?? '',
      badges: (json['badges'] as List?)
          ?.map((badge) => BadgeModel.fromJson(badge))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPurchases': totalPurchases,
      'rewardPoints': rewardPoints,
      'linkedAccount': linkedAccount,
      'badges': badges.map((badge) => badge.toJson()).toList(),
    };
  }

  EarningsModel copyWith({
    int? totalPurchases,
    int? rewardPoints,
    String? linkedAccount,
    List<BadgeModel>? badges,
  }) {
    return EarningsModel(
      totalPurchases: totalPurchases ?? this.totalPurchases,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      linkedAccount: linkedAccount ?? this.linkedAccount,
      badges: badges ?? this.badges,
    );
  }
}
class CouponModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final String status; // 'Active', 'Expired', 'Used', etc.
  final DateTime expiryDate;
  final DateTime? usedDate;
  final double discountPercentage;
  final double? maxDiscountAmount;
  final double? minOrderAmount;
  final String? category;
  final String? imageUrl;
  final bool isCopyable;

  CouponModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.status,
    required this.expiryDate,
    this.usedDate,
    required this.discountPercentage,
    this.maxDiscountAmount,
    this.minOrderAmount,
    this.category,
    this.imageUrl,
    this.isCopyable = true,
  });

  // Factory constructor for creating from JSON
  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'Active',
      expiryDate: DateTime.parse(json['expiryDate']),
      usedDate:
          json['usedDate'] != null ? DateTime.parse(json['usedDate']) : null,
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      maxDiscountAmount: json['maxDiscountAmount']?.toDouble(),
      minOrderAmount: json['minOrderAmount']?.toDouble(),
      category: json['category'],
      imageUrl: json['imageUrl'],
      isCopyable: json['isCopyable'] ?? true,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'status': status,
      'expiryDate': expiryDate.toIso8601String(),
      'usedDate': usedDate?.toIso8601String(),
      'discountPercentage': discountPercentage,
      'maxDiscountAmount': maxDiscountAmount,
      'minOrderAmount': minOrderAmount,
      'category': category,
      'imageUrl': imageUrl,
      'isCopyable': isCopyable,
    };
  }

  // Helper method to format expiry date
  String get formattedExpiryDate {
    return '${expiryDate.day} ${_getMonthName(expiryDate.month)} ${expiryDate.year}';
  }

  // Helper method to check if coupon is expired
  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }

  // Helper method to get status color
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'active':
        return '#28A745';
      case 'expired':
        return '#DC3545';
      case 'used':
        return '#6C757D';
      default:
        return '#28A745';
    }
  }

  // Helper method to get status background color
  String get statusBackgroundColor {
    switch (status.toLowerCase()) {
      case 'active':
        return '#EBF9F1';
      case 'expired':
        return '#F8D7DA';
      case 'used':
        return '#F8F9FA';
      default:
        return '#EBF9F1';
    }
  }

  // Helper method to get month name
  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  // Copy with method for creating modified instances
  CouponModel copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? status,
    DateTime? expiryDate,
    DateTime? usedDate,
    double? discountPercentage,
    double? maxDiscountAmount,
    double? minOrderAmount,
    String? category,
    String? imageUrl,
    bool? isCopyable,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      expiryDate: expiryDate ?? this.expiryDate,
      usedDate: usedDate ?? this.usedDate,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
      minOrderAmount: minOrderAmount ?? this.minOrderAmount,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isCopyable: isCopyable ?? this.isCopyable,
    );
  }
}

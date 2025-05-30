class TransactionModel {
  final String status;
  final String fileType;
  final int rewardPoints;
  final DateTime dateTime;
  final String imagePath;

  TransactionModel({
    required this.status,
    required this.fileType,
    required this.rewardPoints,
    required this.dateTime,
    required this.imagePath,
  });

  // TODO: Add fromJson factory for API parsing
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      status: json['status'] as String,
      fileType: json['fileType'] as String,
      rewardPoints: json['rewardPoints'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      imagePath: json['imagePath'] as String,
    );
  }
}

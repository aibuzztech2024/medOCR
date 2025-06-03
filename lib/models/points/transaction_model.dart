class TransactionModel {
  final String fileType;
  final DateTime dateTime;
  final int rewardPoints;
  final String status;
  final String referenceId;
  final String uploadedBy;
  final DateTime downloadedOn;
  final String imagePath;

  TransactionModel({
    required this.fileType,
    required this.dateTime,
    required this.rewardPoints,
    required this.status,
    required this.referenceId,
    required this.uploadedBy,
    required this.downloadedOn,
    required this.imagePath,
  });

  // TODO: Add fromJson factory for API parsing
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      fileType: json['fileType'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      rewardPoints: json['rewardPoints'] as int,
      status: json['status'] as String,
      referenceId: json['postReferenceId'] as String,
      uploadedBy: json['uploadedBy'] as String,
      downloadedOn: DateTime.parse(json['downloadedOn'] as String),
      imagePath: json['imagePath'] as String,
    );
  }
}

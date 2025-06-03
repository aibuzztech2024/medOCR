class TransactionDetailsModel {
  final String fileType;
  final DateTime dateTime;
  final int rewardPoints;
  final String status;
  final String postReferenceId;
  final String uploadedBy;
  final DateTime downloadedOn;
  final String imagePath;

  TransactionDetailsModel({
    required this.fileType,
    required this.dateTime,
    required this.rewardPoints,
    required this.status,
    required this.postReferenceId,
    required this.uploadedBy,
    required this.downloadedOn,
    required this.imagePath,
  });

  // TODO: Add fromJson factory for API parsing
  factory TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailsModel(
      fileType: json['fileType'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      rewardPoints: json['rewardPoints'] as int,
      status: json['status'] as String,
      postReferenceId: json['postReferenceId'] as String,
      uploadedBy: json['uploadedBy'] as String,
      downloadedOn: DateTime.parse(json['downloadedOn'] as String),
      imagePath: json['imagePath'] as String,
    );
  }
}

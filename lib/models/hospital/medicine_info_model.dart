class MedicineInfoModel {
  String medicineName;
  String productPrice;
  String manufacture;
  String batchNo;
  String manufacturingDate;
  String expiryDate;
  String? saltComposition;

  MedicineInfoModel({
    required this.medicineName,
    required this.productPrice,
    required this.manufacture,
    required this.batchNo,
    required this.manufacturingDate,
    required this.expiryDate,
    this.saltComposition,
  });

  factory MedicineInfoModel.fromJson(Map<String, dynamic> json) {
    return MedicineInfoModel(
      medicineName: json['medicineName'] ?? '',
      productPrice: json['productPrice'] ?? '',
      manufacture: json['manufacture'] ?? '',
      batchNo: json['batchNo'] ?? '',
      manufacturingDate: json['manufacturingDate'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      saltComposition: json['saltComposition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineName': medicineName,
      'productPrice': productPrice,
      'manufacture': manufacture,
      'batchNo': batchNo,
      'manufacturingDate': manufacturingDate,
      'expiryDate': expiryDate,
      if (saltComposition != null) 'saltComposition': saltComposition,
    };
  }

  MedicineInfoModel copyWith({
    String? medicineName,
    String? productPrice,
    String? manufacture,
    String? batchNo,
    String? manufacturingDate,
    String? expiryDate,
    String? saltComposition,
  }) {
    return MedicineInfoModel(
      medicineName: medicineName ?? this.medicineName,
      productPrice: productPrice ?? this.productPrice,
      manufacture: manufacture ?? this.manufacture,
      batchNo: batchNo ?? this.batchNo,
      manufacturingDate: manufacturingDate ?? this.manufacturingDate,
      expiryDate: expiryDate ?? this.expiryDate,
      saltComposition: saltComposition ?? this.saltComposition,
    );
  }
}

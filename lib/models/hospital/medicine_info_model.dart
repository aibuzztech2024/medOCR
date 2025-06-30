class MedicineInfoModel {
  String medicineName;
  String productPrice;
  String manufacture;
  String batchNo;
  String manufacturingDate;
  String expiryDate;

  MedicineInfoModel({
    required this.medicineName,
    required this.productPrice,
    required this.manufacture,
    required this.batchNo,
    required this.manufacturingDate,
    required this.expiryDate,
  });

  factory MedicineInfoModel.fromJson(Map<String, dynamic> json) {
    return MedicineInfoModel(
      medicineName: json['medicineName'] ?? '',
      productPrice: json['productPrice'] ?? '',
      manufacture: json['manufacture'] ?? '',
      batchNo: json['batchNo'] ?? '',
      manufacturingDate: json['manufacturingDate'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
    );
  }
}

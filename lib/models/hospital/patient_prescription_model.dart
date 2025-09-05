class PatientInfoModel {
  String patientName;
  String gender;
  String age;
  String weight;

  PatientInfoModel({
    required this.patientName,
    required this.gender,
    required this.age,
    required this.weight,
  });

  factory PatientInfoModel.fromJson(Map<String, dynamic> json) {
    return PatientInfoModel(
      patientName: json['patientName'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? '',
      weight: json['weight'] ?? '',
    );
  }
}

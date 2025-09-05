import 'package:flutter/foundation.dart';

class PrescriptionCardModel {
  // Patient Info
  final String patientName;
  final String gender;
  final int age;
  final double weight;

  // Prescription Info
  final DateTime prescriptionDate;
  final String diagnosis;

  // Doctor Info
  final String doctorName;
  final String speciality;
  final String regNo;
  final String contact;

  // Medicine Info
  final String medicineName;
  final String frequency;
  final String duration;
  final String method;
  final String dosage;
  final String instructions;

  PrescriptionCardModel({
    required this.patientName,
    required this.gender,
    required this.age,
    required this.weight,
    required this.prescriptionDate,
    required this.diagnosis,
    required this.doctorName,
    required this.speciality,
    required this.regNo,
    required this.contact,
    required this.medicineName,
    required this.frequency,
    required this.duration,
    required this.method,
    required this.dosage,
    required this.instructions,
  });

  /// Create a new instance from a JSON map
  factory PrescriptionCardModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionCardModel(
      patientName: json['patientName'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      weight: (json['weight'] as num).toDouble(),
      prescriptionDate: DateTime.parse(json['prescriptionDate'] as String),
      diagnosis: json['diagnosis'] as String,
      doctorName: json['doctorName'] as String,
      speciality: json['speciality'] as String,
      regNo: json['regNo'] as String,
      contact: json['contact'] as String,
      medicineName: json['medicineName'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      method: json['method'] as String,
      dosage: json['dosage'] as String,
      instructions: json['instructions'] as String,
    );
  }

  /// Convert this instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'gender': gender,
      'age': age,
      'weight': weight,
      'prescriptionDate': prescriptionDate.toIso8601String(),
      'diagnosis': diagnosis,
      'doctorName': doctorName,
      'speciality': speciality,
      'regNo': regNo,
      'contact': contact,
      'medicineName': medicineName,
      'frequency': frequency,
      'duration': duration,
      'method': method,
      'dosage': dosage,
      'instructions': instructions,
    };
  }

  /// Optional: a convenient copyWith
  PrescriptionCardModel copyWith({
    String? patientName,
    String? gender,
    int? age,
    double? weight,
    DateTime? prescriptionDate,
    String? diagnosis,
    String? doctorName,
    String? speciality,
    String? regNo,
    String? contact,
    String? medicineName,
    String? frequency,
    String? duration,
    String? method,
    String? dosage,
    String? instructions,
  }) {
    return PrescriptionCardModel(
      patientName: patientName ?? this.patientName,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      diagnosis: diagnosis ?? this.diagnosis,
      doctorName: doctorName ?? this.doctorName,
      speciality: speciality ?? this.speciality,
      regNo: regNo ?? this.regNo,
      contact: contact ?? this.contact,
      medicineName: medicineName ?? this.medicineName,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      method: method ?? this.method,
      dosage: dosage ?? this.dosage,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  String toString() => describeEnum(runtimeType) + toJson().toString();
}

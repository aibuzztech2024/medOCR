// models/hospital_model.dart
class HospitalPlaceModel {
  final String name;
  final String address;
  final double rating;
  final int reviews;
  final String imageUrl;

  HospitalPlaceModel({
    required this.name,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  factory HospitalPlaceModel.fromJson(Map<String, dynamic> json) {
    return HospitalPlaceModel(
      name: json['name'],
      address: json['address'],
      rating: json['rating'],
      reviews: json['reviews'],
      imageUrl: json['imageUrl'],
    );
  }
}

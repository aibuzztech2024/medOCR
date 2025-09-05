class RegisterModel {
  final String email;
  final String phoneNumber1;
  final String companyName;
  final String dob;
  final String gender;
  final String address;
  final String dist;
  final String state;
  final String pincode;
  final String country;
  final String latitude;
  final String longitude;
  final String password;
  final String referral;

  RegisterModel({
    required this.email,
    required this.phoneNumber1,
    required this.companyName,
    required this.dob,
    required this.gender,
    required this.address,
    required this.dist,
    required this.state,
    required this.pincode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.password,
    required this.referral,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone-number1': phoneNumber1,
      'company-name': companyName,
      'dob': dob,
      'gender': gender,
      'address': address,
      'dist': dist,
      'state': state,
      'pincode': pincode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'password': password,
      'referral': referral,
    };
  }
}

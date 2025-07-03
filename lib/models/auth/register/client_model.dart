class ClientRequestModel {
  String? email;
  String? phoneNumber1;
  String? companyName;
  String? servicesIntrested;
  String? websiteUrl;
  String? address;
  String? dist;
  String? pincode;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? incorporationDoc;
  String? gstNumber;
  String? panNumber;
  String? tanNumber;
  String? password;
  String? contactName;
  String? contactRole;
  String? phoneNumber2;
  String? referralCode;

  ClientRequestModel({
    required this.email,
    required this.phoneNumber1,
    required this.companyName,
    required this.servicesIntrested,
    required this.websiteUrl,
    required this.address,
    required this.dist,
    required this.pincode,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.incorporationDoc,
    required this.gstNumber,
    required this.panNumber,
    required this.tanNumber,
    required this.password,
    required this.contactName,
    required this.contactRole,
    required this.phoneNumber2,
    required this.referralCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone-number1': phoneNumber1,
      'company-name': companyName,
      'services-intrested': servicesIntrested,
      'website-url': websiteUrl,
      'address': address,
      'dist': dist,
      'pincode': pincode,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'incorporation-doc': incorporationDoc,
      'gst-number': gstNumber,
      'pan-number': panNumber,
      'tan-number': tanNumber,
      'password': password,
      'contact-name': contactName,
      'contact-role': contactRole,
      'phone-number2': phoneNumber2,
      'referral-code': referralCode,
    };
  }
}

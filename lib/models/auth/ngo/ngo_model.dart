class NgoProfileModel {
  final String email;
  final String phoneNumber1;
  final String ngoName;
  final String websiteUrl;
  final String ngoServices;
  final String address;
  final String dist;
  final String state;
  final String pincode;
  final String country;
  final String latitude;
  final String longitude;
  final String ngoRegistrationDoc;
  final String gstNumber;
  final String panNumber;
  final String tanNumber;
  final String doc12A;
  final String section8Doc;
  final String brandImg;
  final String brandDesc;
  final String password;
  final String contactName;
  final String contactRole;
  final String phoneNumber2;
  final String referral;

  NgoProfileModel({
    required this.email,
    required this.phoneNumber1,
    required this.ngoName,
    required this.websiteUrl,
    required this.ngoServices,
    required this.address,
    required this.dist,
    required this.state,
    required this.pincode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.ngoRegistrationDoc,
    required this.gstNumber,
    required this.panNumber,
    required this.tanNumber,
    required this.doc12A,
    required this.section8Doc,
    required this.brandImg,
    required this.brandDesc,
    required this.password,
    required this.contactName,
    required this.contactRole,
    required this.phoneNumber2,
    required this.referral,
  });

  factory NgoProfileModel.fromJson(Map<String, dynamic> json) {
    return NgoProfileModel(
      email: json['email'],
      phoneNumber1: json['phone-number1'],
      ngoName: json['ngo-name'],
      websiteUrl: json['website-url'],
      ngoServices: json['ngo-services'],
      address: json['address'],
      dist: json['dist'],
      state: json['state'],
      pincode: json['pincode'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      ngoRegistrationDoc: json['ngo-registration-doc'],
      gstNumber: json['gst-number'],
      panNumber: json['pan-number'],
      tanNumber: json['tan-number'],
      doc12A: json['12A-doc'],
      section8Doc: json['section8-doc'],
      brandImg: json['brand-img'],
      brandDesc: json['brand-desc'],
      password: json['password'],
      contactName: json['contact-name'],
      contactRole: json['contact-role'],
      phoneNumber2: json['phone-number2'],
      referral: json['referral'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'email': email,
    'phone-number1': phoneNumber1,
    'ngo-name': ngoName,
    'website-url': websiteUrl,
    'ngo-services': ngoServices,
    'address': address,
    'dist': dist,
    'state': state,
    'pincode': pincode,
    'country': country,
    'latitude': latitude,
    'longitude': longitude,
    'ngo-registration-doc': ngoRegistrationDoc,
    'gst-number': gstNumber,
    'pan-number': panNumber,
    'tan-number': tanNumber,
    '12A-doc': doc12A,
    'section8-doc': section8Doc,
    'brand-img': brandImg,
    'brand-desc': brandDesc,
    'password': password,
    'contact-name': contactName,
    'contact-role': contactRole,
    'phone-number2': phoneNumber2,
    'referral': referral,
  };
}

}

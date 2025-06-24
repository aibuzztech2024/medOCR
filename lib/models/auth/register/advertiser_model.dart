class AdvertiserModel {
  String? email;
  String? phoneNumber1;
  String? companyName;
  String? advertiserType;
  String? adServiceRequired;
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
  String? brandImg;
  String? brandDesc;
  String? password;
  String? contactName;
  String? contactRole;
  String? phoneNumber2;
  String? referral;

  AdvertiserModel({
    required this.email,
    required this.phoneNumber1,
    required this.companyName,
    required this.advertiserType,
    required this.adServiceRequired,
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
    required this.brandImg,
    required this.brandDesc,
    required this.password,
    required this.contactName,
    required this.contactRole,
    required this.phoneNumber2,
    required this.referral,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone-number1': phoneNumber1,
      'company-name': companyName,
      'advertiser-type': advertiserType,
      'ad-service-required': adServiceRequired,
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

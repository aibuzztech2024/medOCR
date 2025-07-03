class MedicalProviderRequestModel {
  final String email;
  final String phoneNumber1;
  final String companyName;
  final String typeOfProvider;
  final String servicesYouOffer;
  final String websiteUrl;
  final String workingHrs;
  final String address;
  final String dist;
  final String pincode;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final String incorporationDoc;
  final String gstNumber;
  final String panNumber;
  final String tanNumber;
  final String medicalLicenseNumber;
  final String password;
  final String contactName;
  final String contactRole;
  final String phoneNumber2;
  final String referralCode;

  MedicalProviderRequestModel({
    required this.email,
    required this.phoneNumber1,
    required this.companyName,
    required this.typeOfProvider,
    required this.servicesYouOffer,
    required this.websiteUrl,
    required this.workingHrs,
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
    required this.medicalLicenseNumber,
    required this.password,
    required this.contactName,
    required this.contactRole,
    required this.phoneNumber2,
    required this.referralCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone-number1": phoneNumber1,
      "company-name": companyName,
      "type-of-provider": typeOfProvider,
      "services-you-offer": servicesYouOffer,
      "website-url": websiteUrl,
      "working-hrs": workingHrs,
      "address": address,
      "dist": dist,
      "pincode": pincode,
      "state": state,
      "country": country,
      "latitude": latitude,
      "longitude": longitude,
      "incorporation-doc": incorporationDoc,
      "gst-number": gstNumber,
      "pan-number": panNumber,
      "tan-number": tanNumber,
      "medical-license-number": medicalLicenseNumber,
      "password": password,
      "contact-name": contactName,
      "contact-role": contactRole,
      "phone-number2": phoneNumber2,
      "referral-code": referralCode,
    };
  }
}

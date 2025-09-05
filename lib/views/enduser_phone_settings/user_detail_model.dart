/// Data Model class representing user details
/// This class encapsulates all user information that can be edited
class UserDetailsModel {
  // Basic user information fields
  String name;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String address;
  String pincode;

  // Dropdown selection fields
  String? gender;
  String? country;
  String? state;
  String? city;

  /// Constructor with default empty values
  UserDetailsModel({
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.dateOfBirth = '',
    this.address = '',
    this.pincode = '',
    this.gender,
    this.country,
    this.state,
    this.city,
  });

  /// Create a copy of the current model with updated values
  /// This is useful for maintaining immutability in state management
  UserDetailsModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? address,
    String? pincode,
    String? gender,
    String? country,
    String? state,
    String? city,
  }) {
    return UserDetailsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  /// Convert model to JSON for API calls or storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'pincode': pincode,
      'gender': gender,
      'country': country,
      'state': state,
      'city': city,
    };
  }

  /// Create model from JSON data
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      gender: json['gender'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
    );
  }

  /// Validate if all required fields are filled
  bool get isValid {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        dateOfBirth.isNotEmpty &&
        address.isNotEmpty &&
        pincode.isNotEmpty &&
        gender != null &&
        country != null &&
        state != null &&
        city != null;
  }

  /// Static data lists for dropdowns
  static const List<String> genders = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  static const List<String> countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil',
    'South Africa',
    'Russia',
    'Singapore',
    'Malaysia',
    'Thailand',
    'Indonesia',
    'Philippines',
    'Vietnam',
    'South Korea',
    'UAE',
    'Saudi Arabia',
    'Qatar',
  ];

  static const List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Delhi',
    'Jammu and Kashmir',
    'Ladakh',
    'Puducherry',
    'Chandigarh',
    'Andaman and Nicobar Islands',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
  ];

  static const List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Chennai',
    'Kolkata',
    'Hyderabad',
    'Pune',
    'Ahmedabad',
    'Surat',
    'Jaipur',
    'Lucknow',
    'Kanpur',
    'Nagpur',
    'Indore',
    'Thane',
    'Bhopal',
    'Visakhapatnam',
    'Pimpri-Chinchwad',
    'Patna',
    'Vadodara',
    'Ghaziabad',
    'Ludhiana',
    'Agra',
    'Nashik',
    'Faridabad',
    'Meerut',
    'Rajkot',
    'Kalyan-Dombivali',
    'Vasai-Virar',
    'Varanasi',
    'Srinagar',
    'Aurangabad',
    'Dhanbad',
    'Amritsar',
    'Navi Mumbai',
    'Allahabad',
    'Ranchi',
    'Howrah',
    'Coimbatore',
    'Jabalpur',
    'Gwalior',
    'Vijayawada',
    'Jodhpur',
    'Madurai',
    'Raipur',
    'Kota',
    'Chandigarh',
    'Guwahati',
    'Solapur',
    'Hubli-Dharwad',
    'Tiruchirappalli',
    'Bareilly',
    'Mysore',
    'Tiruppur',
    'Gurgaon',
    'Aligarh',
    'Jalandhar',
    'Bhubaneswar',
    'Salem',
    'Warangal',
    'Guntur',
    'Bhiwandi',
    'Saharanpur',
    'Gorakhpur',
    'Bikaner',
    'Amravati',
    'Noida',
    'Jamshedpur',
    'Bhilai',
    'Cuttack',
    'Firozabad',
    'Kochi',
    'Nellore',
    'Bhavnagar',
    'Dehradun',
    'Durgapur',
    'Asansol',
    'Rourkela',
    'Nanded',
    'Kolhapur',
    'Ajmer',
    'Akola',
    'Gulbarga',
    'Jamnagar',
    'Ujjain',
    'Loni',
    'Siliguri',
    'Jhansi',
    'Ulhasnagar',
    'Jammu',
    'Sangli-Miraj & Kupwad',
    'Mangalore',
    'Erode',
    'Belgaum',
    'Ambattur',
    'Tirunelveli',
    'Malegaon',
    'Gaya',
    'Jalgaon',
    'Udaipur',
    'Maheshtala',
  ];

  @override
  String toString() {
    return 'UserDetailsModel(name: $name, email: $email, phoneNumber: $phoneNumber, '
        'dateOfBirth: $dateOfBirth, address: $address, pincode: $pincode, '
        'gender: $gender, country: $country, state: $state, city: $city)';
  }
}

class Doctor {
  final String id;
  final String doctorName;
  final String? qualification;
  final String? experience;
  final String? phoneNumber;
  final String? speciality;
  final String state;
  final String city;
  final double latitude;
  final double longitude;
  final int pincode;
  final String rating;
  final String reviews;

  Doctor({
    required this.id,
    required this.doctorName,
    this.qualification,
    this.experience,
    this.phoneNumber,
    this.speciality,
    required this.state,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.pincode,
    required this.rating,
    required this.reviews,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id']['\$oid'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      qualification: json['qualification'],
      experience: json['experience'],
      phoneNumber: json['phone_number'],
      speciality: json['speciality'],
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      pincode: json['Pincode'] ?? 0,
      rating: json['Rating'] ?? '',
      reviews: json['Reviews'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id},
      'doctor_name': doctorName,
      'qualification': qualification,
      'experience': experience,
      'phone_number': phoneNumber,
      'speciality': speciality,
      'state': state,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'Pincode': pincode,
      'Rating': rating,
      'Reviews': reviews,
    };
  }

  static List<Doctor> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Doctor.fromJson(json)).toList();
  }

  /// Extracts just the number of reviews (e.g., "315" from "315 reviews")
  int get reviewCount {
    final match = RegExp(r'\d+').firstMatch(reviews);
    return match != null ? int.parse(match.group(0)!) : 0;
  }

  /// Extracts just the numeric rating (e.g., 4.7 from "4.7 stars")
  double get ratingValue {
    final match = RegExp(r'[\d.]+').firstMatch(rating);
    return match != null ? double.parse(match.group(0)!) : 0.0;
  }
}

//WARN: This is just dummy data

var dummyDoctorJson = [
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9562"},
    "doctor_name": "Dr. Anantpal Singh's",
    "experience": "15yrs",
    "phone_number": "093222 45341",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.8922112,
    "longitude": 77.5812,
    "Pincode": 560041,
    "Rating": "4.9 stars",
    "Reviews": "315 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9563"},
    "doctor_name": "Dr Kashyap Dakshini",
    "phone_number": "077770 89473",
    "state": "Telangana",
    "city": "Hyderabad",
    "latitude": 17.415019,
    "longitude": 78.412153,
    "Pincode": 500033,
    "Rating": "5.0 stars",
    "Reviews": "383 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9564"},
    "doctor_name": "Dr SHIVARAM",
    "qualification": "HR MBBS MD DNB FIPC",
    "phone_number": "063630 73798",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.9078713,
    "longitude": 77.6518865,
    "Pincode": 560034,
    "Rating": "4.8 stars",
    "Reviews": "581 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9565"},
    "doctor_name": "Dr Leela Mohan PVR",
    "experience": "10 Years",
    "speciality": "Genaral Physician",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.8922112,
    "longitude": 77.5812,
    "Pincode": 560102,
    "Rating": "4.6 stars",
    "Reviews": "194 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9566"},
    "doctor_name": "Kailas S Khadamkar Dr",
    "experience": "12years",
    "phone_number": "079771 03849",
    "state": "Telangana",
    "city": "Hyderabad",
    "latitude": 17.4244775,
    "longitude": 78.4569097,
    "Pincode": 500084,
    "Rating": "4.9 stars",
    "Reviews": "209 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9567"},
    "doctor_name": "Dr. Digvijay Yadav",
    "phone_number": "0241 234 6533",
    "speciality": "Consultant Physician",
    "state": "Maharashtra",
    "city": "Andheri west",
    "latitude": 19.1106972,
    "longitude": 72.8265131,
    "Pincode": 400025,
    "Rating": "3.9 stars",
    "Reviews": "27 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9568"},
    "doctor_name": "Dr Rai's Clinic",
    "experience": "20 years",
    "phone_number": "077180 90127",
    "state": "Karnataka",
    "city": "Mangalore",
    "latitude": 12.9169788,
    "longitude": 77.6523451,
    "Pincode": 560078,
    "Rating": "5.0 stars",
    "Reviews": "62 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa9569"},
    "doctor_name": "Dr Hemalata Arora",
    "qualification": "MD",
    "phone_number": "081042 66385",
    "speciality": "General Physician",
    "state": "Maharashtra",
    "city": "Goregaon",
    "latitude": 19.0070815,
    "longitude": 72.8306153,
    "Pincode": 400614,
    "Rating": "4.9 stars",
    "Reviews": "73 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956a"},
    "doctor_name": "Dr. Leelamohan Pvr",
    "phone_number": "098673 88176",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.8905973,
    "longitude": 77.5820485,
    "Pincode": 560095,
    "Rating": "4.9 stars",
    "Reviews": "177 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956b"},
    "doctor_name": "Dr Darshana R",
    "experience": "5years",
    "phone_number": "092238 11556",
    "speciality": "General Physician Fever & Diabetes Doctor",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.9130914,
    "longitude": 77.6366336,
    "Pincode": 560078,
    "Rating": "4.5 stars",
    "Reviews": "26 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956c"},
    "doctor_name": "Dr. Amol Anil Manerkar",
    "experience": "2 Yrs",
    "phone_number": "090198 88883",
    "speciality": "General Physician",
    "state": "Maharashtra",
    "city": "Navi Mumbai",
    "latitude": 19.1739886,
    "longitude": 72.8406601,
    "Pincode": 400071,
    "Rating": "4.7 stars",
    "Reviews": "216 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956d"},
    "doctor_name": "Dr VK Dixit",
    "experience": "15yrs",
    "phone_number": "098673 88176",
    "speciality": "General Physician",
    "state": "Karnataka",
    "city": "Bangalore",
    "latitude": 12.8905973,
    "longitude": 77.5820485,
    "Pincode": 560078,
    "Rating": "4.7 stars",
    "Reviews": "216 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956e"},
    "doctor_name": "Dr VK Dixit",
    "qualification": "MBBS",
    "experience": "25yrs",
    "phone_number": "090198 88883",
    "speciality": "Oncologist",
    "state": "Gujrat",
    "city": "Ahmedabad",
    "latitude": 12.8905973,
    "longitude": 77.5820485,
    "Pincode": 560078,
    "Rating": "4.7 stars",
    "Reviews": "216 reviews",
  },
  {
    "_id": {"\$oid": "67efad8ceb07b6e502fa956f"},
    "doctor_name": "Dr VK Dixit",
    "qualification": "MBBS",
    "experience": "25yrs",
    "phone_number": "090198 88883",
    "speciality": "Oncologist",
    "state": "Gujrat",
    "city": "Ahmedabad",
    "latitude": 23.0276,
    "longitude": 72.5871,
    "Pincode": 0,
    "Rating": "4.7 stars",
    "Reviews": "216 reviews",
  },
];

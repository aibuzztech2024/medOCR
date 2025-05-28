// =============================================================================
// MODEL LAYER - Updated Data Models with Description Field
// =============================================================================

/// [MODEL] Represents a donation record or organization (extended with description)
class DonationModel {
  final String? imageUrl; // Optional image URL
  final String title; // Donation/Organization title
  final String status; // Status: 'Completed', 'Pending', etc.
  final String dateTime; // Date and time string
  final String amount; // Donation amount (formatted)
  final bool initialSaveState; // Initial bookmark state (donations only)

  // Extended fields for organization support
  final String? address; // Organization address/subtitle
  final String? distance; // Distance from user (e.g., "0.8 Miles away")
  final String? category; // Organization category (e.g., "Indian Poverty")
  final String? description; // Description for donation card display
  final String? websiteUrl; // Website URL for donation card

  const DonationModel({
    this.imageUrl,
    required this.title,
    required this.status,
    required this.dateTime,
    required this.amount,
    this.initialSaveState = false,
    this.address,
    this.distance,
    this.category,
    this.description,
    this.websiteUrl,
  });

  // JSON serialization
  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
    imageUrl: json['imageUrl'] as String?,
    title: json['title'] as String,
    status: json['status'] as String,
    dateTime: json['dateTime'] as String,
    amount: json['amount'] as String,
    initialSaveState: json['initialSaveState'] as bool? ?? false,
    address: json['address'] as String?,
    distance: json['distance'] as String?,
    category: json['category'] as String?,
    description: json['description'] as String?,
    websiteUrl: json['websiteUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'status': status,
    'dateTime': dateTime,
    'amount': amount,
    'initialSaveState': initialSaveState,
    'address': address,
    'distance': distance,
    'category': category,
    'description': description,
    'websiteUrl': websiteUrl,
  };

  // Create a new instance with updated fields
  DonationModel copyWith({
    String? imageUrl,
    String? title,
    String? status,
    String? dateTime,
    String? amount,
    bool? initialSaveState,
    String? address,
    String? distance,
    String? category,
    String? description,
    String? websiteUrl,
  }) {
    return DonationModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      amount: amount ?? this.amount,
      initialSaveState: initialSaveState ?? this.initialSaveState,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      category: category ?? this.category,
      description: description ?? this.description,
      websiteUrl: websiteUrl ?? this.websiteUrl,
    );
  }

  // // Convert to DonationCardModel for use with the donation card widget
  // DonationCardModel toDonationCardModel() {
  //   return DonationCardModel(
  //     imageUrl: imageUrl ?? 'https://via.placeholder.com/400x200',
  //     title: title,
  //     subtitle: address ?? status,
  //     distance: distance ?? '',
  //     category: category ?? '',
  //     description: description ?? 'No description available.',
  //     websiteUrl: websiteUrl ?? '',
  //   );
  // }

  // Factory constructor for creating organization-specific instances
  factory DonationModel.organization({
    String? imageUrl,
    required String title,
    required String address,
    required String distance,
    required String category,
    required String amount,
    required String description,
    String? websiteUrl,
    bool initialSaveState = false,
  }) => DonationModel(
    imageUrl: imageUrl,
    title: title,
    status: 'Active',
    dateTime: DateTime.now().toString(),
    amount: amount,
    initialSaveState: initialSaveState,
    address: address,
    distance: distance,
    category: category,
    description: description,
    websiteUrl: websiteUrl,
  );

  // Factory constructor for creating donation history instances
  factory DonationModel.donation({
    String? imageUrl,
    required String title,
    required String status,
    required String dateTime,
    required String amount,
    String? description,
    bool initialSaveState = false,
  }) => DonationModel(
    imageUrl: imageUrl,
    title: title,
    status: status,
    dateTime: dateTime,
    amount: amount,
    initialSaveState: initialSaveState,
    description: description,
  );

  @override
  String toString() =>
      'DonationModel(imageUrl: $imageUrl, title: $title, status: $status, dateTime: $dateTime, amount: $amount, initialSaveState: $initialSaveState, address: $address, distance: $distance, category: $category, description: $description, websiteUrl: $websiteUrl)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonationModel &&
          other.imageUrl == imageUrl &&
          other.title == title &&
          other.status == status &&
          other.dateTime == dateTime &&
          other.amount == amount &&
          other.initialSaveState == initialSaveState &&
          other.address == address &&
          other.distance == distance &&
          other.category == category &&
          other.description == description &&
          other.websiteUrl == websiteUrl);

  @override
  int get hashCode =>
      imageUrl.hashCode ^
      title.hashCode ^
      status.hashCode ^
      dateTime.hashCode ^
      amount.hashCode ^
      initialSaveState.hashCode ^
      address.hashCode ^
      distance.hashCode ^
      category.hashCode ^
      description.hashCode ^
      websiteUrl.hashCode;
}

// =============================================================================
// DATA ACCESS LAYER - Updated with Description Field
// =============================================================================

/// [DATA] Repository with enhanced data including descriptions
class DonationData {
  static List<DonationModel> getSampleDonations() => [
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/little-girl-with-backpack-studio_23-2147851792.jpg?semt=ais_hybrid&w=740',
      title: 'Bharat Seva Mandal',
      status: 'Completed',
      dateTime: '20 Mar 2025 10:30 AM',
      amount: '₹100',
      initialSaveState: false,
      address: 'Behind Zenith Hospital Malad East',
      distance: '0.8 Miles away',
      category: 'Indian Poverty',
      description:
          'Bharat Seva Mandal is dedicated to alleviating poverty in rural and urban India through sustainable development programs. We focus on providing education, healthcare, and livelihood opportunities to underprivileged communities. Our mission is to create lasting change by empowering individuals and families to break the cycle of poverty.',
      websiteUrl: 'https://bharatsevamandal.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-smiling-cute-little-girl_23-2147851843.jpg',
      title: 'Child Education Fund',
      status: 'Pending',
      dateTime: '18 Mar 2025 2:15 PM',
      amount: '₹250',
      initialSaveState: false,
      address: 'Andheri West, Mumbai',
      distance: '1.2 Miles away',
      category: 'Child Education',
      description:
          'The Child Education Fund works tirelessly to ensure every child has access to quality education. We provide scholarships, learning materials, and infrastructure support to schools in underserved areas. Our programs focus on early childhood development, primary education, and skill development for adolescents.',
      websiteUrl: 'https://childeducationfund.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/happy-child-playing-outdoors_23-2147851901.jpg',
      title: 'Healthcare Initiative',
      status: 'Completed',
      dateTime: '15 Mar 2025 11:45 AM',
      amount: '₹500',
      initialSaveState: false,
      address: 'Bandra East, Mumbai',
      distance: '2.1 Miles away',
      category: 'Healthcare',
      description:
          'Our Healthcare Initiative provides essential medical services to communities lacking access to quality healthcare. We operate mobile clinics, conduct health awareness programs, and support local healthcare infrastructure. Our focus areas include maternal health, child nutrition, and preventive care.',
      websiteUrl: 'https://healthcareinitiative.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/children-playing-together-park_23-2147851876.jpg',
      title: 'Community Development',
      status: 'Completed',
      dateTime: '12 Mar 2025 9:20 AM',
      amount: '₹150',
      initialSaveState: false,
      address: 'Powai, Mumbai',
      distance: '3.5 Miles away',
      category: 'Community Support',
      description:
          'Community Development programs aim to strengthen local communities through participatory development approaches. We support infrastructure projects, skill development workshops, and community organizing initiatives. Our goal is to build resilient communities that can sustain long-term growth and development.',
      websiteUrl: 'https://communitydev.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/volunteer-helping-charity_23-2147851820.jpg',
      title: 'Food Distribution Drive',
      status: 'Pending',
      dateTime: '10 Mar 2025 3:45 PM',
      amount: '₹300',
      initialSaveState: false,
      address: 'Kurla West, Mumbai',
      distance: '1.8 Miles away',
      category: 'Food Security',
      description:
          'Our Food Distribution Drive addresses hunger and malnutrition in vulnerable communities. We organize regular food distribution events, support community kitchens, and promote sustainable agriculture practices. Every donation helps us provide nutritious meals to families in need.',
      websiteUrl: 'https://foodsecurity.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/helping-hands-charity_23-2147851855.jpg',
      title: 'Disaster Relief Fund',
      status: 'Completed',
      dateTime: '8 Mar 2025 1:20 PM',
      amount: '₹750',
      initialSaveState: false,
      address: 'Chembur, Mumbai',
      distance: '4.2 Miles away',
      category: 'Emergency Relief',
      description:
          'The Disaster Relief Fund provides immediate assistance to communities affected by natural disasters and emergencies. We supply emergency shelter, food, water, and medical aid. Our rapid response teams are trained to provide critical support during crisis situations.',
      websiteUrl: 'https://disasterrelief.org',
    ),
    const DonationModel(
      imageUrl:
          'https://img.freepik.com/free-photo/school-supplies-donation_23-2147851888.jpg',
      title: 'Education Support Program',
      status: 'Pending',
      dateTime: '5 Mar 2025 4:30 PM',
      amount: '₹200',
      initialSaveState: false,
      address: 'Dadar West, Mumbai',
      distance: '2.7 Miles away',
      category: 'Education',
      description:
          'The Education Support Program focuses on improving educational outcomes through comprehensive support systems. We provide teacher training, educational resources, and technology access to schools. Our programs also include mentorship and counseling services for students.',
      websiteUrl: 'https://educationsupport.org',
    ),
  ];

  // Rest of the existing methods remain the same...
  static List<DonationModel> getFilteredDonations(String filter) {
    final all = getSampleDonations();
    switch (filter.toLowerCase()) {
      case 'completed':
        return all.where((d) => d.status.toLowerCase() == 'completed').toList();
      case 'pending':
        return all.where((d) => d.status.toLowerCase() == 'pending').toList();
      case 'all':
      default:
        return all;
    }
  }

  static List<DonationModel> searchDonations(String query) {
    final all = getSampleDonations();
    if (query.isEmpty) return all;
    return all
        .where((d) => d.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<DonationModel> searchOrganizations(String query) {
    final all = getSampleDonations();
    if (query.isEmpty) return all;
    return all
        .where(
          (org) =>
              org.title.toLowerCase().contains(query.toLowerCase()) ||
              (org.category?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (org.address?.toLowerCase().contains(query.toLowerCase()) ??
                  false),
        )
        .toList();
  }

  static List<DonationModel> getFilteredAndSearchedDonations({
    String filter = 'all',
    String searchQuery = '',
  }) {
    List<DonationModel> result = getSampleDonations();

    if (filter.toLowerCase() != 'all') {
      result =
          result
              .where((d) => d.status.toLowerCase() == filter.toLowerCase())
              .toList();
    }

    if (searchQuery.isNotEmpty) {
      result =
          result
              .where(
                (d) =>
                    d.title.toLowerCase().contains(searchQuery.toLowerCase()),
              )
              .toList();
    }

    return result;
  }

  static List<DonationModel> getFilteredAndSearchedOrganizations({
    String searchQuery = '',
  }) {
    List<DonationModel> result = getSampleDonations();

    if (searchQuery.isNotEmpty) {
      result =
          result
              .where(
                (org) =>
                    org.title.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ) ||
                    (org.category?.toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ) ??
                        false) ||
                    (org.address?.toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ) ??
                        false),
              )
              .toList();
    }

    return result;
  }

  static Map<String, int> getDonationStats() {
    final donations = getSampleDonations();
    final completed =
        donations.where((d) => d.status.toLowerCase() == 'completed').length;
    final pending =
        donations.where((d) => d.status.toLowerCase() == 'pending').length;
    return {
      'total': donations.length,
      'completed': completed,
      'pending': pending,
    };
  }

  static Map<String, int> getOrganizationStats() {
    final organizations = getSampleDonations();
    return {'total': organizations.length};
  }
}

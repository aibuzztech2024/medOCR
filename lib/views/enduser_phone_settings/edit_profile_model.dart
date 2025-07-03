import 'package:country_picker/country_picker.dart';

// ============================================================================
// MODEL: Data models for the account information
// ============================================================================

/// Model representing user account information
class EditProfileModel {
  final String name;
  final String email;
  final String phoneNumber;
  final Country? selectedCountry;

  const EditProfileModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.selectedCountry,
  });

  /// Creates a copy of this model with updated values
  EditProfileModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    Country? selectedCountry,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}

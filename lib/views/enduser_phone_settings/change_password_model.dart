// ========================================================================================
// MODEL: Data structure representing the change password form state
// ========================================================================================

/// Model class that encapsulates all data related to password change functionality
/// This class holds the state of the form and provides validation logic
class ChangePasswordModel {
  // Private fields to encapsulate the internal state
  String _currentPassword = '';
  String _newPassword = '';
  String _retypePassword = '';

  // Getters to provide read access to the private fields
  /// Gets the current password for display purposes
  String get currentPassword => _currentPassword;

  /// Gets the new password entered by the user
  String get newPassword => _newPassword;

  /// Gets the retyped password entered by the user
  String get retypePassword => _retypePassword;

  /// Gets the current password masked with asterisks for display
  String get currentPasswordDisplay =>
      _currentPassword.isEmpty ? 'No password set' : _currentPassword;

  // Setters to update the internal state
  /// Updates the current password field
  /// [value] - The new current password value
  set currentPassword(String value) {
    _currentPassword = value;
  }

  /// Updates the new password field
  /// [value] - The new password value
  set newPassword(String value) {
    _newPassword = value;
  }

  /// Updates the retyped password field
  /// [value] - The retyped password value
  set retypePassword(String value) {
    _retypePassword = value;
  }

  /// Validates if all required fields are filled
  /// Returns true if new password fields have values (current password is displayed, not input)
  bool get isFormValid {
    return _newPassword.isNotEmpty && _retypePassword.isNotEmpty;
  }

  /// Validates if the new password and retyped password match
  /// Returns true if both new password fields contain the same value
  bool get doPasswordsMatch {
    return _newPassword == _retypePassword;
  }

  /// Resets all password fields to empty strings
  /// Useful for clearing the form after successful submission or cancellation
  void clearForm() {
    _currentPassword = '';
    _newPassword = '';
    _retypePassword = '';
  }
}

import 'package:flutter/cupertino.dart';

/// A model class representing a user role during onboarding or registration.
///
/// Each role contains an identifier, a display title, and a descriptive caption
/// that explains the purpose or intent of the role.
class Role {
  /// The unique identifier for the role, used internally.
  final String role;

  /// The display title shown to the user for this role.
  final String title;

  /// A brief descriptive caption that provides additional context about the role.
  final String caption;

  /// The widget that will be displayed when this role is selected.
  final Widget page;

  /// Creates a new [Role] instance with the given [role], [title], [caption] and [page] .
  ///
  /// All fields are required and must not be null.
  Role({
    required this.role,
    required this.title,
    required this.caption,
    required this.page,
  });
}

import 'package:flutter/material.dart';

/// A model class representing steps to register.
///
/// Each step contains a title, and an icon
class StepModel {
  /// Title to explain what this step does
  final String title;

  /// Icon to give visual idea of what inside this step
  final Icon icon;

  /// All fields are required and must not be null.
  StepModel({required this.title, required this.icon});
}

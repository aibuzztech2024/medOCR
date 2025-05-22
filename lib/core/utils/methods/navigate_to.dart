import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

/// Navigates to a new page using GetX's navigation system.
///
/// This function wraps [Get.to] to allow consistent navigation throughout the app.
/// It accepts a widget builder function instead of a widget instance to ensure
/// a fresh instance of the page is created each time the navigation occurs.
void navigateTo(
  Widget Function() pageBuilder, {
  Duration? duration,
  Transition? transition,
}) {
  Get.to(
    pageBuilder,
    duration: duration ?? Durations.medium1,
    transition: transition ?? Transition.cupertino,
  );
}

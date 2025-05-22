extension BoolExtensions on bool {
  /// Toggles the current boolean value.
  ///
  /// Example:
  /// bool isOpen = true;
  /// isOpen = isOpen.toggle(); // isOpen becomes false
  bool toggle() => !this;
}

// Model for each overview card item (e.g., Bills, Purchases)
class OverviewItem {
  final String label;       // Item title
  final int value;          // Numeric value
  final String subtitle;    // Description text
  final String iconPath;    // Icon asset path

  OverviewItem({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.iconPath,
  });

  // Returns a copy with updated fields (used for state updates)
  OverviewItem copyWith({
    String? label,
    int? value,
    String? subtitle,
    String? iconPath,
  }) {
    return OverviewItem(
      label: label ?? this.label,
      value: value ?? this.value,
      subtitle: subtitle ?? this.subtitle,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
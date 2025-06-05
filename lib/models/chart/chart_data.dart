import 'dart:ui';

/// Represents a single data point in a chart with a timestamp and value
class ChartData {
  /// The date/time of this data point
  final DateTime date;

  /// The numeric value associated with this date
  final double value;

  ChartData({required this.date, required this.value});
}

/// Represents a series of data points in the chart
///
/// Includes metadata like name, color, visibility, and the data points themselves.
class ChartSeries {
  /// Name of the series (e.g., "Sales", "Users")
  final String name;

  /// List of data points in this series
  final List<ChartData> data;

  /// Color used for displaying this series in charts/legends
  final Color color;

  /// Whether this series is currently visible in the chart
  final bool isVisible;

  ChartSeries({
    required this.name,
    required this.data,
    required this.color,
    this.isVisible = true, // default visible
  });

  /// Returns a copy of this ChartSeries with optional new values for fields
  ///
  /// Useful for toggling visibility or updating data immutably
  ChartSeries copyWith({
    String? name,
    List<ChartData>? data,
    Color? color,
    bool? isVisible,
  }) {
    return ChartSeries(
      name: name ?? this.name,
      data: data ?? this.data,
      color: color ?? this.color,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

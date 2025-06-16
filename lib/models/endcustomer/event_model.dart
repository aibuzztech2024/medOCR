/// Model representing a calendar event
class EventModel {
  /// Title or name of the event
  final String title;

  /// Time or time range for the event, e.g., "8:00 - 8:15 AM"
  final String time;

  /// Local path or URL to the event's icon image
  final String imagePath;

  EventModel({
    required this.title,
    required this.time,
    required this.imagePath,
  });

  /// TODO: Add factory constructor to create EventModel from JSON when fetching from backend
  ///
  /// Example:
  /// factory EventModel.fromJson(Map<String, dynamic> json) {
  ///   return EventModel(
  ///     title: json['title'] as String,
  ///     time: json['time'] as String,
  ///     iconPath: json['iconPath'] as String,
  ///   );
  /// }
  
  /// TODO: Add toJson method if sending event data to backend
  ///
  /// Map<String, dynamic> toJson() {
  ///   return {
  ///     'title': title,
  ///     'time': time,
  ///     'iconPath': iconPath,
  ///   };
  /// }
}

class BadgeModel {
  final String name;
  final String description;
  final String pointsRange;
  final String color;

  BadgeModel({
    required this.name,
    required this.description,
    required this.pointsRange,
    required this.color,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pointsRange: json['pointsRange'] ?? '',
      color: json['color'] ?? 'orange',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'pointsRange': pointsRange,
      'color': color,
    };
  }
}

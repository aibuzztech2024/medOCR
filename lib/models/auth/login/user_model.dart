class UserModel {
  final String username;
  final String email;
  final String name;
  final String userType;

  UserModel({
    required this.username,
    required this.email,
    required this.name,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      name: json['name'],
      userType: json['user_type'],
    );
  }
}

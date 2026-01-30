class UserModel {
  final String token;
  final String username;
  final String email;

  UserModel({
    required this.token,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}

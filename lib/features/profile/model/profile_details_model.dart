class ProfileDetailsModel {
  final int id;
  final String username;
  final String email;
  final String image;

  ProfileDetailsModel({
    required this.id,
    required this.username,
    required this.email,
    required this.image,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email, 'image': image};
  }
}

import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String image;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

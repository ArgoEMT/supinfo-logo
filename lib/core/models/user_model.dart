import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String image;
  List<String>? classesAsAdmin;
  List<String>? classesAsStudent;

  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.image,
    this.classesAsAdmin,
    this.classesAsStudent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'image': image,
      'classesAsAdmin': classesAsAdmin,
      'classesAsStudent': classesAsStudent,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      classesAsAdmin: map['classesAsAdmin'] != null
          ? List<String>.from((map['classesAsAdmin'] as List))
          : null,
      classesAsStudent: map['classesAsStudent'] != null
          ? List<String>.from((map['classesAsStudent'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

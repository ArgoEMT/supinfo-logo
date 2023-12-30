// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassModel {
  final String id;
  final String name;
  final List<String> admins;
  final List<String> students;
   List<String>? homeworks;

  ClassModel({
    required this.id,
    required this.name,
    required this.admins,
    required this.students,
    required this.homeworks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'admins': admins,
      'students': students,
      'homeworks': homeworks,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] as String,
      name: map['name'] as String,
      admins: List<String>.from((map['admins'] as List)),
      students: List<String>.from((map['students'] as List)),
      homeworks: map['homeworks'] != null
          ? List<String>.from((map['homeworks'] as List))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) =>
      ClassModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

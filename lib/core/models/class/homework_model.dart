import 'dart:convert';

import '../user_model.dart';

class HomeworkModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime dueDate;
  final String classId;
  final UserModel creator;
  HomeworkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.dueDate,
    required this.classId,
    required this.creator,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'classId': classId,
      'creator': creator.toMap(),
    };
  }

  factory HomeworkModel.fromMap(Map<String, dynamic> map) {
    return HomeworkModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      classId: map['classId'] as String,
      creator: UserModel.fromMap(map['creator'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeworkModel.fromJson(String source) => HomeworkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

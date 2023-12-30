import 'dart:convert';

import '../user_model.dart';

class HomeworkAnswerModel {
  String? id;
  final UserModel user;
  String scriptId;
  String scriptName;
  final String homeworkId;
  int? score;
  HomeworkAnswerModel({
    this.id,
    required this.user,
    required this.scriptId,
    required this.homeworkId,
    required this.scriptName,
    this.score,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'scriptId': scriptId,
      'homeworkId': homeworkId,
      'scriptName': scriptName,
      'score': score,
    };
  }

  factory HomeworkAnswerModel.fromMap(Map<String, dynamic> map) {
    return HomeworkAnswerModel(
      id: map['id'] as String?,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      scriptId: map['scriptId'] as String,
      homeworkId: map['homeworkId'] as String,
      score: map['score'] as int?,
      scriptName: map['scriptName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeworkAnswerModel.fromJson(String source) =>
      HomeworkAnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeworkAnswer(id: $id, user: $user, scriptId: $scriptId, homeworkId: $homeworkId)';
  }

  @override
  bool operator ==(covariant HomeworkAnswerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.scriptId == scriptId &&
        other.homeworkId == homeworkId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        scriptId.hashCode ^
        homeworkId.hashCode;
  }
}

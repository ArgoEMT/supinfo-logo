import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supinfo_logo/core/models/class/homework_answer.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';
import 'package:supinfo_logo/core/services/admin_class_service.dart';

class HomeworkService {
  final _db = FirebaseFirestore.instance;
  final _classAdminService = AdminClassService();

  Future<List<HomeworkModel>> getHomeworks(List<String>? ids) async {
    if (ids == null || ids.isEmpty) return <HomeworkModel>[];
    final homeworks = await _db
        .collection('homeworks')
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    return homeworks.docs.map((e) => HomeworkModel.fromMap(e.data())).toList();
  }

  Future<bool> createHomework(
    String classId,
    HomeworkModel homeworkModel,
  ) async {
    try {
      // Create the homework and set the id
      final homeworkCreated = await _db.collection('homeworks').add(
            homeworkModel.toMap(),
          );
      await homeworkCreated.update({'id': homeworkCreated.id});
      await _classAdminService.addHomeworkToClass(classId, homeworkCreated.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addAnswer(HomeworkAnswerModel answer) async {
    try {
      final createdAnswer = await _db.collection('answers').add(answer.toMap());
      await createdAnswer.update({'id': createdAnswer.id});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAnswer(HomeworkAnswerModel answer) async {
    try {
      await _db.collection('answers').doc(answer.id).update(answer.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<HomeworkAnswerModel>> getHomeworkAnswers(
    String homeworkId,
  ) async {
    try {
      final answers = await _db
          .collection('answers')
          .where('homeworkId', isEqualTo: homeworkId)
          .get();
      if (answers.docs.isEmpty) return <HomeworkAnswerModel>[];
      return answers.docs
          .map((e) => HomeworkAnswerModel.fromMap(e.data()))
          .toList();
    } catch (_) {
      return <HomeworkAnswerModel>[];
    }
  }

  Future<HomeworkAnswerModel?> getUserAnswer(String userId) async {
    final answers = await _db
        .collection('answers')
        .where('userId', isEqualTo: userId)
        .get();
    if (answers.docs.isEmpty) return null;
    return HomeworkAnswerModel.fromMap(answers.docs.first.data());
  }

  Future scoreAnswer(String answerId, int score) async {
    await _db.collection('answers').doc(answerId).update({'score': score});
  }
}

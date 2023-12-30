import 'package:cloud_firestore/cloud_firestore.dart';
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
}

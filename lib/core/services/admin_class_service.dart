import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supinfo_logo/core/models/class/class_model.dart';
import 'package:supinfo_logo/core/services/class_service.dart';
import 'package:supinfo_logo/core/services/user_service.dart';

class AdminClassService {
  final _db = FirebaseFirestore.instance;
  final _userService = UserService();
  final _classService = ClassService();

  /// Create a new class
  Future createClass(ClassModel classModel) async {
    await _db.collection('classes').doc(classModel.id).set(classModel.toMap());
  }

  Future addStudentsToClass(String classId, List<String> userIds) async {
    final users = await _userService.getUsersByIds(userIds);
    final classModel = await _classService.getClass(classId);

    for (final user in users) {
      if (classModel.students.contains(user.id)) continue;
      if (user.classesAsStudent != null) {
        user.classesAsStudent!.add(classId);
      } else {
        user.classesAsStudent = [classId];
      }
      classModel.students.add(user.id);
    }

    await _db.collection('classes').doc(classId).update(classModel.toMap());
    await _userService.updateUsers(users);
  }

  Future addTeachersToClass(String classId, List<String> userIds) async {
    final users = await _userService.getUsersByIds(userIds);
    final classModel = await _classService.getClass(classId);

    for (final user in users) {
      if (classModel.admins.contains(user.id)) continue;
      if (classModel.students.contains(user.id)) continue;

      if (user.classesAsAdmin != null) {
        user.classesAsAdmin!.add(classId);
      } else {
        user.classesAsAdmin = [classId];
      }
      classModel.admins.add(user.id);
    }

    await _db.collection('classes').doc(classId).update(classModel.toMap());
    await _userService.updateUsers(users);
  }

  Future addHomeworkToClass(String classId, String homeworkId) async {
    final classModel = await _classService.getClass(classId);
    if (classModel.homeworks?.contains(homeworkId) == true) return;
    if (classModel.homeworks == null) {
      classModel.homeworks = [homeworkId];
    } else {
      classModel.homeworks!.add(homeworkId);
    }
    await _db.collection('classes').doc(classId).update(classModel.toMap());
  }
}

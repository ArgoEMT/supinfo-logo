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

  /// Add the user with the given [userId] to the class with the given [classId]
  Future addUserToClass(String classId, String userId) async {
    final user = await _userService.getUserById(userId);
    if (user == null) throw Exception('User not found');

    final classModel = await _classService.getClass(classId);

    if (user.classesAsStudent != null) {
      user.classesAsStudent!.add(classId);
    } else {
      user.classesAsStudent = [classId];
    }
    classModel.students.add(userId);

    await _db.collection('classes').doc(classId).update(classModel.toMap());
    await _userService.updateUser(user);
  }
}

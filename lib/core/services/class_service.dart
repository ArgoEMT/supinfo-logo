import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supinfo_logo/core/models/class/class_model.dart';
import 'package:supinfo_logo/core/services/user_service.dart';
import 'package:supinfo_logo/ui/ui_helpers/ui_snackbar_helper.dart';

class ClassService {
  final _db = FirebaseFirestore.instance;
  final _userService = UserService();

  Future<ClassModel> getClass(String id) async {
    final doc = await _db.collection('classes').doc(id).get();
    return ClassModel.fromMap(doc.data()!);
  }

  Future<List<ClassModel>> getClasses(List<String>? ids) async {
    if (ids == null) return <ClassModel>[];
    final classes = await _db
        .collection('classes')
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    return classes.docs.map((e) => ClassModel.fromMap(e.data())).toList();
  }

  Future createClass(ClassModel classModel) async {
    try {
      // Create the class and set the id
      final classCreated =
          await _db.collection('classes').add(classModel.toMap());
      await classCreated.update({'id': classCreated.id});

      // Update the user's classes 
      final me = await  _userService.getMe();
      final classesAsAdmin = me.classesAsAdmin ?? [];
      classesAsAdmin.add(classCreated.id);
      me.classesAsAdmin = classesAsAdmin;
      await _userService.updateUser(me);

      showSnackbar(titre: 'Classe créée avec succès');
    } catch (e) {
      debugPrint("error: $e");
      showSnackbar(
        titre: 'Erreur lors de la creation de la classe',
        isError: true,
      );
    }
  }
}

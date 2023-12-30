import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supinfo_logo/core/models/user_model.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  Future<UserModel?> getUserById(String userId) async {
    final user = await _db.collection('users').doc(userId).get();
    if (user.exists) {
      return UserModel.fromMap(user.data()!);
    }
    return null;
  }


  Future updateUser(UserModel userModel) async {
    final userExist = await _db.collection('users').doc(userModel.id).get();

    if (!userExist.exists) {
      return _db.collection('users').doc(userModel.id).set(userModel.toMap());
    } else {
      return _db
          .collection('users')
          .doc(userModel.id)
          .update(userModel.toMap());
    }
  }

  Future updateUsers(List<UserModel> users) async {
    for (final user in users) {
      await updateUser(user);
    }
  }

  Future<UserModel> getMe() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final me = await getUserById(currentUser!.uid);

    if (me == null) throw Exception('User not found');
    return me;
  }

  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    try {
      final users = await _db
          .collection('users')
          .where(FieldPath.documentId, whereIn: ids)
          .get();

      return users.docs.map((e) => UserModel.fromMap(e.data())).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final users = await _db.collection('users').get();
    return users.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }
}

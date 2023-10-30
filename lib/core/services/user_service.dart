import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future updateUser(UserModel userModel)async {
    final userExist = await _db.collection('users').doc(userModel.id).get();

    if (!userExist.exists) {
      return _db.collection('users').doc(userModel.id).set(userModel.toMap());
    }else {
      return _db.collection('users').doc(userModel.id).update(userModel.toMap());
    }
  }
}

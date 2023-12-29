import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supinfo_logo/core/models/script_model.dart';
import 'package:supinfo_logo/core/services/user_service.dart';

class ScriptService {
  final _db = FirebaseFirestore.instance;
  final _userService = UserService();

  Future<bool> uploadScript(ScriptModel script) async {
    try {
      final scriptCreated = await _db.collection('scripts').add(script.toMap());
      await scriptCreated.update({'id': scriptCreated.id});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ScriptModel>> getPublicScripts() async {
    final scripts = await _db
        .collection('scripts')
        .where('isPublic', isEqualTo: true)
        .get();

    return scripts.docs.map((e) => ScriptModel.fromMap(e.data())).toList();
  }

  Future<List<ScriptModel>> getMyScripts() async {
    final me = await _userService.getMe();
    final scripts =
        await _db.collection('scripts').where('userId', isEqualTo: me.id).get();

    return scripts.docs.map((e) => ScriptModel.fromMap(e.data())).toList();
  }

  Future<ScriptModel> getScript(String id) async {
    final doc = await _db.collection('scripts').doc(id).get();
    return ScriptModel.fromMap(doc.data()!);
  }
}

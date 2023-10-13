import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/database_routes.dart';

class CoreHiveHelper {
  /// Sauvegarde la collection pour ne pas avoir à la recréer à chaque fois.
  static BoxCollection? _collection;

  /// Si la collection est null, on l'initialise et la retourne. Sinon, on la retourne.
  static Future<BoxCollection> _getCollection() async =>
      _collection ??= await _initCollection();

  /// Créé une clé et la sauvegarde dans les shared preferences.
  ///
  /// Si la clé existe déjà, la méthode la retourne des shared preferences.
  static Future<List<int>> _getKey() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(PreferencesKeys.databaseKey)) {
      var keyString = prefs.getStringList(PreferencesKeys.databaseKey);
      if (keyString != null) {
        var intList = keyString.map((e) => int.parse(e)).toList();
        return intList;
      }
    }
    var key = Hive.generateSecureKey();
    var stringList = key.map((e) => e.toString()).toList();

    prefs.setStringList(PreferencesKeys.databaseKey, stringList);
    return key;
  }

  /// Créé la base et toutes les tables.
  static Future<BoxCollection> _initCollection() async {
    _collection = await BoxCollection.open(
      DatabaseRoutes.databaseName,
      DatabaseRoutes.allCollections,
      path: (await getTemporaryDirectory()).path,
      key: HiveAesCipher(await _getKey()),
    );
    return _collection!;
  }

  /// Supprime la base locale du disque.
  static Future clearDatabase() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear().then((value) async {
        if (value) {
          final collection = await _getCollection();
          collection.deleteFromDisk();
          collection.close();
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearBox(Box box) async {
    await box.clear();
  }
}

class PreferencesKeys {
  static const String databaseKey = 'databaseKey';
}

class DatabaseRoutes {
  static const String databaseName = 'db_name'; //TODO: change name

  static const String collectionName = 'collectionName';

  /// Liste des collections à créer à l'initisation de l'application.
  static Set<String> get allCollections => {
        collectionName,
        //TODO: add collections name
      };
}

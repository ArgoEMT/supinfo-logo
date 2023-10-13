import 'package:flutter/material.dart';

import 'app_config.dart';

enum Flavor {
  dev,
  qa,
  pprd,
  prod;

  @override
  String toString() {
    switch (this) {
      case qa:
        return 'Test';
      case dev:
        return 'Dev';
      case pprd:
        return 'PPRD';
      default:
        return '';
    }
  }
}

class EnvironmentConfig {
  static const envVariable = String.fromEnvironment('ENV_VARIABLE');
  ///TODO: Get [AppConfig] from environment
}

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    Color color = Colors.blue,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      _enumName(flavor.toString()),
      color,
    );
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color)
      : appConfig = AppConfig(envVariable: EnvironmentConfig.envVariable);

  static FlavorConfig? _instance;

  final AppConfig appConfig;
  final Color color;
  final Flavor flavor;
  final String name;

  static String _enumName(String enumToString) {
    var paths = enumToString.split('.');
    var path = paths[paths.length - 1];
    if (path == 'QA') path = 'TEST';
    return path;
  }

  static FlavorConfig? get instance {
    return _instance;
  }

  static bool get isDevelopment => _instance?.flavor == Flavor.dev;
  static bool get isProduction => _instance?.flavor == Flavor.prod;
  static bool get isQA => _instance?.flavor == Flavor.qa;
}

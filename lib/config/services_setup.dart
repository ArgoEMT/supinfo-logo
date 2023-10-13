import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../core/services/logs/logs_filter.dart';
import '../core/services/logs/logs_printer.dart';
import '../core/services/navigation_service.dart';

class ServicesSetup {
  /// Add a service to the GetIt locator if it is not already registered.
  static void _addService<T extends Object>(T service) {
    if (!GetIt.I.isRegistered<T>()) {
      GetIt.I.registerSingleton<T>(service);
    }
  }

  /// Initialize all services.
  static void init() {
    _addService<NavigationService>(NavigationService());
    _addService<Logger>(Logger(
      filter: LogsFilter(),
      printer: LogsPrinter(
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    ));

  }
}

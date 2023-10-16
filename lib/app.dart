import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'config/app_router.dart';
import 'config/bloc_setup.dart';
import 'config/flavor_config.dart';
import 'config/services_setup.dart';
import 'config/theme/app_theme.dart';
import 'core/services/navigation_service.dart';

void run(FlavorConfig flavorConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Keep appConfig in setup
  GetIt.I.registerSingleton(flavorConfig);

  /// Initialize services
  ServicesSetup.init();

  // Error handling and logging
  FlutterError.onError = (FlutterErrorDetails details) {
    GetIt.I<Logger>().log(
      Level.error,
      details.summary,
      time: DateTime.now(),
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    GetIt.I<Logger>().log(
      Level.error,
      error,
      time: DateTime.now(),
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: BlocSetup.globalBlocs,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GetIt.I<NavigationService>().navigatorKey,
        title: 'VDA Logo Interpreter',
        theme: AppTheme.defaultTheme,
        onGenerateRoute: AppRouter.generateRoute,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            AppRouter.generateRoute(
              const RouteSettings(
                name: RoutePaths.console,
              ),
            ),
          ];
        },
      ),
    );
  }
}

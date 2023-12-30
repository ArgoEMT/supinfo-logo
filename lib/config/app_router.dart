import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/class_details_screen.dart';

import '../ui/screens/classes_screen/classes_screen.dart';
import '../ui/screens/console_screen/console_screen.dart';
import '../ui/screens/init_user_screen/init_user_screen.dart';
import '../ui/screens/login_screen/login_screen.dart';
import '../ui/screens/script_screen/script_screen.dart';
import '../ui/screens/search_screen/search_screen.dart';
import '../ui/screens/splash_screen/splash_screen.dart';

class AppRouter {
  static MaterialPageRoute<T> routeBuilder<T extends Object?>({
    required Widget target,
    required RouteSettings? settings,
    bool maintainState = true,
  }) {
    return CustomPageRoute<T>(
      builder: (context) {
        return target;
      },
      settings: settings,
      maintainState: maintainState,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var name = settings.name;
    switch (name) {
      case RoutePaths.console:
        return routeBuilder(target: const ConsoleScreen(), settings: settings);

      case RoutePaths.scriptEditor:
        assert(settings.arguments is ArgumentsScriptScreen);
        final arguments = settings.arguments as ArgumentsScriptScreen;
        return routeBuilder(
          target: ScriptScreen(arguments: arguments),
          settings: settings,
        );

      case RoutePaths.classDetails:
        assert(settings.arguments is ArgumentsClassDetails);
        final arguments = settings.arguments as ArgumentsClassDetails;
        return routeBuilder(
          target: ClassDetailsScreen(arguments: arguments),
          settings: settings,
        );

      case RoutePaths.login:
        return routeBuilder(target: const LoginScreen(), settings: settings);

      case RoutePaths.initUser:
        return routeBuilder(target: const InitUserScreen(), settings: settings);

      case RoutePaths.splash:
        return routeBuilder(target: const SplashScreen(), settings: settings);

      case RoutePaths.myClasses:
        return routeBuilder(target: const ClassesScreen(), settings: settings);

      case RoutePaths.scriptSearch:
        return routeBuilder(target: const SearchScreen(), settings: settings);

      /// Handeling 404
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pas de route ${settings.name!}'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      onPressed: () => context.go(RoutePaths.console),
                      child: const Text("Aller à l'accueil"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}

class CustomPageRoute<T extends Object?> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    required bool maintainState,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 175);
}

class RoutePaths {
  static const console = '/';
  static const scriptEditor = '/scripts/editor';
  static const scriptSearch = '/scripts/search';
  static const login = '/login';
  static const initUser = '/initUser';
  static const splash = '/splash';
  static const myClasses = '/me/classes';
  static const classDetails = '/me/classes/details';
}

extension NavigationExtension on BuildContext {
  Future<T?> go<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool replace = false,
  }) {
    if (kIsWeb || replace) {
      return Navigator.pushReplacementNamed<T, T>(
        this,
        routeName,
        arguments: arguments,
      );
    }
    return Navigator.pushNamed<T?>(this, routeName, arguments: arguments);
  }

  Future<T?> goToUnamed<T extends Object?>(
    Widget child, {
    bool replace = false,
  }) {
    if (kIsWeb || replace) {
      return Navigator.pushReplacement(
        this,
        AppRouter.routeBuilder(target: child, settings: null),
      );
    }
    return Navigator.push(
      this,
      AppRouter.routeBuilder(target: child, settings: null),
    );
  }

  void pop<T extends Object?>([T? result]) {
    if (canPop) {
      Navigator.pop(this, result);
    } else {
      quitTo(RoutePaths.console);
    }
  }

  void popUntil<T extends Object?>(String routeName) {
    if (canPop) {
      Navigator.popUntil(this, ModalRoute.withName(routeName));
    } else {
      quitTo(RoutePaths.console);
    }
  }

  Future<T?> quitTo<T extends Object?>(String routeName,
      {Object? arguments}) async {
    return await Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  bool get canPop => Navigator.canPop(this);
}

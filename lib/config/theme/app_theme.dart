import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        background: appbackgroundColor,
        brightness: Brightness.dark,
        error: appRed,
        onBackground: appWhite,
        onError: appWhite,
        onPrimary: appWhite,
        onSecondary: appWhite,
        onSurface: appWhite,
        primary: appPurple,
        secondary: appGreen,
        surface: appDivider,
      ),
    );
  }
}

class FadeTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      route, context, animation, secondaryAnimation, child) {
    var curve = Curves.easeIn;

    var curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return FadeTransition(
      opacity: curvedAnimation,
      child: child,
    );
  }
}

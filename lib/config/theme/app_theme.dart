import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static AppBarTheme _appBarTheme(ThemeData base) {
    return base.appBarTheme.copyWith(
      iconTheme: const IconThemeData(color: homeBackgroundColor),
      color: homeBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: base.textTheme
          .copyWith(
            titleLarge: base.textTheme.titleLarge?.copyWith(
              color: homeBackgroundColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          )
          .bodyMedium,
      titleTextStyle: base.textTheme
          .copyWith(
            titleLarge: base.textTheme.titleLarge?.copyWith(
              color: homeBackgroundColor,
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          )
          .titleLarge,
    );
  }

  static ThemeData _buildTheme() {
    final base = ThemeData.light();

    var t = base.copyWith(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.windows: FadeTransitionBuilder(),
        TargetPlatform.macOS: FadeTransitionBuilder(),
        TargetPlatform.linux: FadeTransitionBuilder(),
        TargetPlatform.fuchsia: FadeTransitionBuilder(),
      }),
      primaryColor: homeBackgroundColor,
      primaryColorDark: appPurple,
      primaryColorLight: homeBackgroundColor,
      buttonTheme: base.buttonTheme.copyWith(
        disabledColor: appDivider,
        buttonColor: appGreen,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: _appBarTheme(base),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        foregroundColor: homeBackgroundColor, //TextColorTitle
        backgroundColor: appGreen,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: appWhite),
        fillColor: homeBackgroundColor,
        filled: true,
        focusColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: appWhite.withOpacity(0.8),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appDivider),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appGreen),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appRed),
        ),
      ),
      scaffoldBackgroundColor: homeBackgroundColor,
      cardColor: homeBackgroundColor,
      tabBarTheme: _tabBarTheme(base),
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: appGreen,
          fontFamily: 'Inter',
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          color: appWhite,
          fontFamily: 'Inter',
          fontSize: 16,
        ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: appDivider,
        selectedItemColor: appGreen,
      ),
      textSelectionTheme: base.textSelectionTheme.copyWith(
        cursorColor: appWhite,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: homeBackgroundColor,
          backgroundColor: appGreen,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: appGreen,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: appGreen,
          textStyle: const TextStyle(color: homeBackgroundColor),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: appGreen,
        contentTextStyle: normal14White.copyWith(color: homeBackgroundColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: appWhite,
        behavior: SnackBarBehavior.floating,
        disabledActionTextColor: appDivider,
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: normal14White.copyWith(color: homeBackgroundColor),
        decoration: BoxDecoration(
          color: appWhite,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      dividerColor: appDivider,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return appGreen;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return appGreen;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return appGreen;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return appGreen;
          }
          return null;
        }),
      ),
      colorScheme: const ColorScheme(
        primary: appGreen,
        secondary: appGreen,
        surface: homeBackgroundColor,
        background: homeBackgroundColor,
        error: appRed,
        onPrimary: homeBackgroundColor,
        onSecondary: appGreen,
        onSurface: appGreen,
        onBackground: appGreen,
        onError: homeBackgroundColor,
        brightness: Brightness.dark,
      ).copyWith(background: homeBackgroundColor),
    );

    t.copyWith(
      textTheme: t.textTheme.apply(fontFamily: 'Inter'),
      primaryTextTheme: t.primaryTextTheme.apply(fontFamily: 'Inter'),
    );

    return t;
  }

  static TabBarTheme _tabBarTheme(ThemeData base) {
    return base.tabBarTheme.copyWith(
      labelColor: appGreen,
      indicator: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: appGreen,
            width: 2.0,
          ),
        ),
      ),
      unselectedLabelColor: appGreen,
      indicatorSize: TabBarIndicatorSize.tab,
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

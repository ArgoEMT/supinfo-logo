import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static AppBarTheme _appBarTheme(ThemeData base) {
    return base.appBarTheme.copyWith(
      iconTheme: const IconThemeData(color: appWhite),
      color: appWhite,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: base.textTheme
          .copyWith(
            titleLarge: base.textTheme.titleLarge?.copyWith(
              color: appWhite,
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
            ),
          )
          .bodyMedium,
      titleTextStyle: base.textTheme
          .copyWith(
            titleLarge: base.textTheme.titleLarge?.copyWith(
              color: appWhite,
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
      primaryColor: appWhite,
      primaryColorDark: appBlack50,
      primaryColorLight: appWhite,
      buttonTheme: base.buttonTheme.copyWith(
        disabledColor: appBlack50,
        buttonColor: appGreen,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: _appBarTheme(base),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        foregroundColor: appWhite, //TextColorTitle
        backgroundColor: appGreen,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: appBlack),
        fillColor: appWhite,
        filled: true,
        focusColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: appBlack.withOpacity(0.8),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appBlack50),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appGreen),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: appRed),
        ),
      ),
      scaffoldBackgroundColor: appWhite,
      cardColor: appWhite,
      tabBarTheme: _tabBarTheme(base),
      textTheme: base.textTheme.copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: appGreen,
          fontFamily: 'Inter',
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          color: appBlack,
          fontFamily: 'Inter',
          fontSize: 16,
        ),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: appBlack50,
        selectedItemColor: appGreen,
      ),
      textSelectionTheme: base.textSelectionTheme.copyWith(
        cursorColor: appBlack,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: appWhite,
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
          textStyle: const TextStyle(color: appWhite),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: appGreen,
        contentTextStyle: normal14Black.copyWith(color: appWhite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        backgroundColor: appBlack,
        behavior: SnackBarBehavior.floating,
        disabledActionTextColor: appBlack50,
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: normal14Black.copyWith(color: appWhite),
        decoration: BoxDecoration(
          color: appBlack,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      dividerColor: appGrey, switchTheme: SwitchThemeData(
 thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return appGreen; }
 return null;
 }),
 trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return appGreen; }
 return null;
 }),
 ), radioTheme: RadioThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return appGreen; }
 return null;
 }),
 ), checkboxTheme: CheckboxThemeData(
 fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
 if (states.contains(MaterialState.disabled)) { return null; }
 if (states.contains(MaterialState.selected)) { return appGreen; }
 return null;
 }),
 ), colorScheme: const ColorScheme(
        primary: appGreen,
        secondary: appGreen,
        surface: appWhite,
        background: appWhite,
        error: appRed,
        onPrimary: appWhite,
        onSecondary: appGreen,
        onSurface: appGreen,
        onBackground: appGreen,
        onError: appWhite,
        brightness: Brightness.dark,
      ).copyWith(background: appWhite),
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

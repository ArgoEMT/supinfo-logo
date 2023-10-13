import 'package:flutter/material.dart';

/// 0xFF8AFF80 => Vert
const Color appGreen = Color(0xFF8AFF80);

/// 0xFF8AFF80 => Vert
const Color appPurple = Color(0xFF9580FF);

/// 0xFF80FFEA => Cyan
const Color appCyan = Color(0xFF80FFEA);

/// 0xFFFF80BF => Rose
const Color appPink = Color(0xFFFF80BF);

/// 0xFFFFFF80 => Jaune
const Color appYellow = Color(0xFFFFFF80);

/// 0xFFF8F8F2 => Blanc - Text
const Color appWhite = Color(0xFFF8F8F2);

/// 0xFFFFCA80 => Orange - En attente/Warning
const Color appOrange = Color(0xFFFFCA80);

/// 0xFFFF9580 => Rouge - Erreur/Danger
const Color appRed = Color(0xFFFF9580);

/// 0xFF7970A9 => Comment - Bordure champs/Divider
const Color appDivider = Color(0xFF7970A9);

/// 0xFF22212C => Background Homescreen
const Color appbackgroundColor = Color(0xFF22212C);

extension ColorExtension on Color {
  //? Ce code à été proposé par @mr_mmmmore sur StackOverflow
  //? https://stackoverflow.com/a/60191441

  /// Darken a color by [percent] amount (1 = black)
  // ........................................................
  Color darken([double percent = 0.1]) {
    assert(0.01 <= percent && percent <= 1);
    var f = 1 - percent;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }

  /// Lighten a color by [percent] amount (1 = white)
  // ........................................................
  Color lighten([double percent = 0.1]) {
    assert(0.01 <= percent && percent <= 1);

    return Color.fromARGB(
      alpha,
      red + ((255 - red) * percent).round(),
      green + ((255 - green) * percent).round(),
      blue + ((255 - blue) * percent).round(),
    );
  }

  bool get isLight =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.light;
}

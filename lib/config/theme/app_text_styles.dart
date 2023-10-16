import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Color: [appWhite] - FontSize: 12 - FontWeight: 400
const TextStyle normal12White = TextStyle(
  fontSize: 12,
  color: appWhite,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
);

/// Color: [appWhite] - FontSize: 12 - FontWeight: 600
TextStyle bold12White = const TextStyle(
  fontSize: 12,
  color: appWhite,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

/// Color: [appPurple] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Purple = TextStyle(
  fontSize: 12,
  color: appPurple,
  fontWeight: FontWeight.w600,
  fontFamily: 'Inter',
);

/// Color: [appOrange] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Orange = TextStyle(
  fontSize: 12,
  color: appOrange,
  fontWeight: FontWeight.w600,
  fontFamily: 'Inter',
);

/// Color: [appRed] - FontSize: 12 - FontWeight: 600
const TextStyle bold12Red = TextStyle(
  fontSize: 12,
  color: appRed,
  fontWeight: FontWeight.w600,
  fontFamily: 'Inter',
);

// -------------------------------------------- \\\

/// Color: [appWhite] - FontSize: 14 - FontWeight: 400
const normal14White = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: appWhite,
);

/// Color: [appGreen] - FontSize: 14 - FontWeight: 400
const normal14Green = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: appGreen,
);

/// Color: [appWhite] - FontSize: 14 - FontWeight: 600
const TextStyle bold14White = TextStyle(
  fontSize: 14,
  color: appWhite,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

/// Color: [appPurple] - FontSize: 14 - FontWeight: 600
const TextStyle bold14Purple = TextStyle(
  fontSize: 14,
  color: appGreen,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

// -------------------------------------------- \\\

/// Color: [appPurple] - FontSize: 16 - FontWeight: 400
const normal16Purple = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
  color: appPurple,
);

/// Color: [appPurple] - FontSize: 16 - FontWeight: 400
const normal16Background = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
  color: appbackgroundColor,
);

/// Color: [appWhite] - FontSize: 16 - FontWeight: 400
const normal16White = TextStyle(
  fontSize: 16,
  color: appWhite,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
);

/// Color: [appGreen] - FontSize: 16 - FontWeight: 400
const normal16Green = TextStyle(
  fontSize: 16,
  color: appGreen,
  fontWeight: FontWeight.w400,
  fontFamily: 'Inter',
);

/// Color: [appWhite] - FontSize: 16 - FontWeight: 600
const bold16White = TextStyle(
  fontSize: 16,
  color: appWhite,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

/// Color: [appPurple] - FontSize: 16 - FontWeight: 600
const TextStyle bold16Purple = TextStyle(
  fontSize: 16,
  color: appPurple,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

// -------------------------------------------- \\\

/// Color: [appWhite] - FontSize: 20 - FontWeight: 600
const bold20White = TextStyle(
  fontSize: 20,
  color: appWhite,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle withWeight(int weight) {
    if (weight < 0 || weight > 900) {
      return this;
    }
    var tempWeight = (weight / 100).round() - 1;
    if (tempWeight < 0) {
      tempWeight = 0;
    }
    return copyWith(fontWeight: FontWeight.values[tempWeight]);
  }
}

/// Color: [alGreen] - FontSize: 20 - FontWeight: 600
const TextStyle bold20Green = TextStyle(
  fontSize: 20,
  color: appGreen,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

/// Color: [alOrange] - FontSize: 20 - FontWeight: 600
const TextStyle bold20Orange = TextStyle(
  fontSize: 20,
  color: appOrange,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

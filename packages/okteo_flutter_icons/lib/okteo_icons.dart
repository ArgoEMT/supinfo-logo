import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'model/okteo_icons.dart';

class OkteoIcon extends Icon {
  const OkteoIcon(IconData icon,
      {super.key,
      super.color,
      super.size = 24.0,
      super.semanticLabel,
      super.shadows,
      super.textDirection})
      : super(icon);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    if (icon is OkteoIcons) {
      var tempIcon = icon as OkteoIcons;
      return SvgPicture.string(
        tempIcon.icon,
        color: color ?? iconTheme.color,
        height: size ?? iconTheme.size,
        width: size ?? iconTheme.size,
      );
    } else {
      return super.build(context);
    }
  }
}

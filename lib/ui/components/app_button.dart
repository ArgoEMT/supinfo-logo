import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.isActive,
    required this.label,
    this.isExpanded = false,
    this.isRound = true,
  });

  final Function()? onPressed;
  final bool isActive;
  final String label;
  final bool isExpanded;
  final bool isRound;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      hoverColor: appPurple.withOpacity(0.2),
      splashColor: appPurple.withOpacity(0.2),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: isRound ? BorderRadius.circular(8): null,
          color: isActive ? appGreen : null,
        ),
        width: isExpanded ? double.infinity : null,
        padding:  const EdgeInsets.all(8) ,
        child:
            Text(label, style: isActive ? normal16Background : normal16White),
      ),
    );
  }
}

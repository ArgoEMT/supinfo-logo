import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.isActive,
    required this.label,
    final this.isExpanded = false,
  });

  final Function()? onPressed;
  final bool isActive;
  final String label;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: appPurple.withOpacity(0.2),
      splashColor: appPurple.withOpacity(0.2),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? appGreen : null,
        ),
        width: isExpanded ? double.infinity : null,
        padding: const EdgeInsets.all(8),
        child:
            Text(label, style: isActive ? normal16Background : normal16White),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/config/theme/app_colors.dart';

import '../../../../core/constants/painter_constants.dart';
import '../../../../core/helpers/instruction_painter.dart';

class LogoPainter extends StatelessWidget {
  const LogoPainter({
    super.key,
    required this.painter,
    required this.backgroundColor,
  });

  final InstructionPainter painter;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: appPurple),
      ),
      child: CustomPaint(
        size: const Size(
          PainterConstants.painterHeight,
          PainterConstants.painterWidth,
        ),
        willChange: true,
        painter: painter,
      ),
    );
  }
}

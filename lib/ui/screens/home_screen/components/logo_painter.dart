import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/models/logo_model.dart';

import '../../../../core/constants/painter_constants.dart';

import 'dart:math' as math;

class LogoPainter extends StatelessWidget {
  const LogoPainter({
    super.key,
    required this.model,
    required this.backgroundColor,
  });

  final LogoModel model;
  final Color backgroundColor;

  /// Calculate the angle of the cursor
  double get _angle => model.angle == 0 ? 0 : math.pi / 180 * model.angle;

  String get calculatedPosition {
    final y = model.cursorPosition.dy == PainterConstants.painterHeight / 2
        ? 0
        : -(model.cursorPosition.dy - PainterConstants.painterHeight / 2)
            ;

    return 'x: ${model.cursorPosition.dx - PainterConstants.painterHeight / 2}, y: $y';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
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
            painter: model.painter,
          ),
        ),
        if (model.showCursor)
          Positioned(
            top: model.cursorPosition.dy - 15,
            left: model.cursorPosition.dx - 15,
            child: Transform.rotate(
              angle: _angle,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 30,
                color: appPink,
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Angle: ${model.angle}'),
                Text('Position: ($calculatedPosition)'),
                const Text(
                  'Taille de la zone: ${PainterConstants.painterHeight} x ${PainterConstants.painterWidth}',
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

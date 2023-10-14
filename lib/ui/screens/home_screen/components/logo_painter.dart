import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/models/logo_model.dart';

import '../../../../core/constants/painter_constants.dart';

class LogoPainter extends StatelessWidget {
  const LogoPainter({
    super.key,
    required this.model,
    required this.backgroundColor,
  });

  final LogoModel model;
  final Color backgroundColor;

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
        Positioned(
          top: model.lastOffset.dy - 15,
          left: model.lastOffset.dx - 15,
          child: Transform.rotate(
            angle: model.angle,
            child: const Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: model.lastOffset.dy - 10,
          left: model.lastOffset.dx - 10,
          child: Transform.rotate(
            angle: model.angle,
            child: Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 20,
              color: model.trailColor,
            ),
          ),
        ),
      ],
    );
  }
}

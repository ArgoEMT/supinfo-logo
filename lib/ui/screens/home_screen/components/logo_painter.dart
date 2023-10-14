import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/helpers/instruction_painter.dart';

class LogoPainter extends StatelessWidget {
  const LogoPainter({super.key, required this.painter});

  final InstructionPainter painter;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: painter);
  }
}

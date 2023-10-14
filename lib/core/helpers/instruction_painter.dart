import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/constants/painter_constants.dart';

class InstructionPainter extends CustomPainter {
  InstructionPainter({
    required Color trailColor,
  }) : _currentColor = trailColor {
    _points.add(
      InstructionPainterHistoryItem(
        offset: const Offset(
          PainterConstants.painterHeight / 2,
          PainterConstants.painterWidth / 2,
        ),
        trailColor: trailColor,
      ),
    );
  }
  final List<InstructionPainterHistoryItem> _points = [];

  Color _currentColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < _points.length - 1; i++) {
      paint.color = _points[i].trailColor;
      canvas.drawLine(_points[i].offset, _points[i + 1].offset, paint);
    }
  }

  void addOffsets(List<Offset> offsets) {
    _points.addAll(offsets.map(
      (e) => InstructionPainterHistoryItem(
        offset: e,
        trailColor: _currentColor,
      ),
    ));
  }

  void changeTrailColor(Color color) {
    _currentColor = color;
  }

  @override
  bool shouldRepaint(InstructionPainter oldDelegate) =>
      oldDelegate._points != _points;
}

class InstructionPainterHistoryItem {
  final Offset offset;
  final Color trailColor;

  const InstructionPainterHistoryItem({
    required this.offset,
    required this.trailColor,
  });
}

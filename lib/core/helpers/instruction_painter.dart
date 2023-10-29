import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/constants/painter_constants.dart';

class InstructionPainter extends CustomPainter {
  InstructionPainter({
    required Color trailColor,
  }) : _currentColor = trailColor {
    _points.add(
      InstructionPainterHistoryItem(
        offset: const Offset(
          PainterConstants.painterSize / 2,
          PainterConstants.painterSize / 2,
        ),
        trailColor: trailColor,
      ),
    );
  }

  /// The current color of the trail
  Color _currentColor;

  /// List of points to draw with the color of the trail
  final List<InstructionPainterHistoryItem> _points = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < _points.length - 1; i++) {
      paint.color = _points[i + 1].trailColor;
      canvas.drawLine(_points[i].offset, _points[i + 1].offset, paint);
    }
  }

  @override
  bool shouldRepaint(InstructionPainter oldDelegate) =>
      oldDelegate._points != _points;

  /// Add a new point to the list
  void addOffset(Offset offset) {
    final realOffset = Offset(
      offset.dx.roundToDouble(),
      offset.dy.roundToDouble(),
    );
    _points.add(InstructionPainterHistoryItem(
      offset: realOffset,
      trailColor: _currentColor,
    ));
  }

  /// Change the color of the trail
  void changeTrailColor(Color color) {
    _currentColor = color;
  }

  /// Clear the list of points
  void clear() {
    _points.clear();
  }
}

class InstructionPainterHistoryItem {
  const InstructionPainterHistoryItem({
    required this.offset,
    required this.trailColor,
  });

  /// The offset of the point
  final Offset offset;

  /// The color of the trail
  final Color trailColor;
}

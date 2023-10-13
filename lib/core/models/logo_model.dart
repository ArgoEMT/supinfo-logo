import 'package:flutter_bloc_template/core/models/instruction/base_instruction_model.dart';

class LogoModel {
  LogoModel({
    this.position = const LogoPosition(x: 0, y: 0),
    this.angle = 0,
    this.trailColor = 0,
    this.backgroundColor = 0,
  });

  final List<BaseInstructionModel> history = [];

  /// The angle of the turtle
  int angle;

  /// The background color of the canvas
  int backgroundColor;

  /// The position of the turtle
  LogoPosition position;

  /// The color of the trail
  int trailColor;
}

class LogoPosition {
  const LogoPosition({required this.x, required this.y});

  final int x;
  final int y;
}

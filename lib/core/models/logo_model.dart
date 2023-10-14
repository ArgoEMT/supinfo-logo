import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/config/theme/app_colors.dart';
import 'package:flutter_bloc_template/core/constants/painter_constants.dart';
import 'package:flutter_bloc_template/core/models/instruction/base_instruction_model.dart';

class LogoModel {
  LogoModel({
    this.position = const Offset(
      PainterConstants.painterHeight / 2,
      PainterConstants.painterWidth / 2,
    ),
    this.angle = 0,
    this.trailColor = appPurple,
    this.backgroundColor = appbackgroundColor,
  });

  final List<BaseInstructionModel> history = [];

  /// The angle of the turtle
  int angle;

  /// The background color of the canvas
  Color backgroundColor;

  /// The position of the turtle
  Offset position;

  /// The color of the trail
  Color trailColor;

  List<String> get historyString =>
      history.map((e) => e.instructionToString()).toList();
}

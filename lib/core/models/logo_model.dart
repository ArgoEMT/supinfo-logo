import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/helpers/instruction_interpretor_helper.dart';

import '../../config/theme/app_colors.dart';
import '../constants/painter_constants.dart';
import '../helpers/instruction_painter.dart';
import 'instruction/base_instruction_model.dart';

class LogoModel {
  LogoModel({
    this.position = const Offset(
      PainterConstants.painterHeight / 2,
      PainterConstants.painterWidth / 2,
    ),
    this.angle = 0,
    this.trailColor = appPurple,
    this.backgroundColor = appbackgroundColor,
  }) {
    painter = InstructionPainter(trailColor: trailColor);
  }

  final List<BaseInstructionModel> history = [];

  /// The angle of the turtle
  double angle;

  /// The background color of the canvas
  Color backgroundColor;

  /// The position of the turtle
  Offset position;

  /// The color of the trail
  Color trailColor;

  late final InstructionPainter painter;

  List<String> get historyString =>
      history.map((e) => e.instructionToString()).toList();

  void addInstruction(String instruction) {
    final instructionObject =
        InstructionInterpretorHelper.translateToLogoInstruction(
      instruction,
    );
    history.add(instructionObject);
    final newOffset = InstructionInterpretorHelper.calculatePosition(
      instructionModel: instructionObject,
      model: this,
    );
    painter.addOffsets(newOffset);
  }

  Offset get lastOffset => painter.lastOffset;
}

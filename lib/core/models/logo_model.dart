import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../constants/painter_constants.dart';
import '../helpers/instruction_interpretor.dart';
import '../helpers/instruction_painter.dart';
import '../helpers/instruction_translator.dart';
import 'instruction/base_instruction_model.dart';

class LogoModel {
  LogoModel({
    this.cursorPosition = const Offset(
      PainterConstants.painterHeight / 2,
      PainterConstants.painterWidth / 2,
    ),
    this.angle = 0,
    this.trailColor = appPurple,
    this.backgroundColor = appbackgroundColor,
  }) : _lastColor = trailColor {
    painter = InstructionPainter(trailColor: trailColor);
  }

  /// The angle of the turtle
  int angle;

  /// The background color of the canvas
  Color backgroundColor;

  /// The position of the turtle
  Offset cursorPosition;

  /// The history of the instructions
  final List<BaseInstructionModel> history = [];

  /// The painter to draw the trail
  late final InstructionPainter painter;

  Color _lastColor;

  /// The color of the trail
  Color trailColor;

  /// If the cursor should be shown
  var showCursor = true;

  /// The history of the instructions as a string
  List<String> get historyString =>
      history.map((e) => e.instructionToString()).toList();

  /// Add a new instruction to the history and run it
  void addInstruction(String instruction) {
    final instructionModel = InstructionTranslator.translateToLogoInstruction(
      instruction,
    );
    history.add(instructionModel);
    InstructionInterpretor.runInstruction(
      model: this,
      instructionModel: instructionModel,
    );
  }

  /// Add a new point to the painter
  void addOffset(Offset offset) {
    print('x: ${offset.dx}, y: ${offset.dy}');
    painter.addOffset(offset);
    cursorPosition = offset;
  }

  /// Clear the trails but keep the cursor position
  void clearPainter() {
    painter.clear();
    addOffset(cursorPosition);
  }

  /// Clear the trails and reset the cursor position
  void resetPainter() {
    cursorPosition = const Offset(
      PainterConstants.painterHeight / 2,
      PainterConstants.painterWidth / 2,
    );
    clearPainter();
  }
  
  /// Reset the cursor position without clearing the trails
  void resetPosition() {
    const center =  Offset(
      PainterConstants.painterHeight / 2,
      PainterConstants.painterWidth / 2,
    );
    jumpTo(center);
  }

  /// Change the color of the next trails
  void changeTrailColor(Color color) {
    trailColor = color;
    painter.changeTrailColor(color);
  }

  /// Change the visibility of the next trails
  void setTrailVisible(bool visible) {
    if (visible) {
      changeTrailColor(_lastColor);
    } else {
      _lastColor = trailColor;
      changeTrailColor(Colors.transparent);
    }
  }

  /// Jump to a new position without drawing a trail
  void jumpTo(Offset offset) {
    cursorPosition = offset;
    setTrailVisible(false);
    addOffset(cursorPosition);
    setTrailVisible(true);
  }
}

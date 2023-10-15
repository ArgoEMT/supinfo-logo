import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/painter_constants.dart';
import '../enum/instruction_enum.dart';
import '../models/instruction/base_instruction_model.dart';
import '../models/instruction/logo_instruction_model.dart';
import '../models/instruction/repete_instruction_model.dart';
import '../models/logo_model.dart';

class InstructionInterpretor {
  /// Add a new point to the painter
  static void _calculatePosition(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      final distance = instructionModel.instruction == InstructionEnum.av
          ? instructionModel.parameters.first
          : -instructionModel.parameters.first;
      final angle = model.angle;
      final position = model.cursorPosition;
      final x = position.dx + distance * sin(angle * pi / 180);
      final y = position.dy - distance * cos(angle * pi / 180);
      debugPrint('x: $x, y: $y');
      model.addOffset(Offset(x, y));
    }
  }

  /// Set the angle of the cursor
  static void _changeAngle(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      final newAngle = instructionModel.parameters.first % 360;
      model.angle = newAngle;
      debugPrint('new angle: ${model.angle}');
    }
  }

  /// Change the color of the trail or the background
  static void _changeColor(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      final r = instructionModel.parameters[0];
      final g = instructionModel.parameters[1];
      final b = instructionModel.parameters[2];
      final newColor = Color.fromRGBO(r, g, b, 1);
      debugPrint('new color: $newColor');
      if (instructionModel.instruction == InstructionEnum.fcc) {
        model.changeTrailColor(newColor);
      } else if (instructionModel.instruction == InstructionEnum.fcb) {
        model.backgroundColor = newColor;
      }
    }
  }

  /// Change the visibility of the cursor
  static void _changeVisibility(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      model.showCursor = instructionModel.instruction == InstructionEnum.mt;
    }
  }

  /// Rotate the cursor
  static void _rotateCursor(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      final angle = model.angle;
      final rotation = instructionModel.instruction == InstructionEnum.td
          ? instructionModel.parameters.first
          : -instructionModel.parameters.first;
      model.angle = (angle + rotation) % 360;
      debugPrint('new angle: ${model.angle}');
    }
  }

  static void _setCursorCoordonate(
    LogoModel model,
    BaseInstructionModel instructionModel,
  ) {
    if (instructionModel is LogoInstructionModel) {
      const centerOffset = Offset(
        PainterConstants.painterHeight / 2,
        PainterConstants.painterWidth / 2,
      );
      final x = instructionModel.parameters[0] as double;
      final y = instructionModel.parameters[1] as double;
      final position = Offset(x, y) + centerOffset;
      model.jumpTo(position);
    }
  }

  static void _invertAngle(LogoModel model) {
    model.angle = (model.angle + 180) % 360;
  }

  static void _invertPosition(LogoModel model) {
    final position = model.cursorPosition;
    debugPrint('current position: $position');
    final x = PainterConstants.painterHeight - position.dx;
    final y = PainterConstants.painterWidth - position.dy;

    final newOffset = Offset(x, y);
    debugPrint('new position: $newOffset');
    model.jumpTo(newOffset);
  }

  /// Run an instruction
  static void runInstruction({
    required LogoModel model,
    required BaseInstructionModel instructionModel,
  }) {
    if (instructionModel is RepeteInstructionModel) {
      for (var instruction in instructionModel.parameters) {
        runInstruction(model: model, instructionModel: instruction);
      }
    } else if (instructionModel is LogoInstructionModel) {
      switch (instructionModel.instruction) {
        case InstructionEnum.av:
        case InstructionEnum.re:
          _calculatePosition(model, instructionModel);
          break;

        case InstructionEnum.td:
        case InstructionEnum.tg:
          _rotateCursor(model, instructionModel);
          break;

        case InstructionEnum.ct:
        case InstructionEnum.mt:
          _changeVisibility(model, instructionModel);
          break;

        case InstructionEnum.nettoie:
          model.clearPainter();
          break;

        case InstructionEnum.origine:
          model.resetPosition();
          break;

        case InstructionEnum.ve:
          model.resetPainter();
          break;

        case InstructionEnum.fcap:
          _changeAngle(model, instructionModel);
          break;

        case InstructionEnum.fcc:
        case InstructionEnum.fcb:
          _changeColor(model, instructionModel);
          break;

        case InstructionEnum.lc:
          model.setTrailVisible(false);
          break;
        case InstructionEnum.bc:
          model.setTrailVisible(true);
          break;

        case InstructionEnum.vt:
          model.history.clear();
          break;

        case InstructionEnum.fpos:
          _setCursorCoordonate(model, instructionModel);
          break;

        case InstructionEnum.cap:
          _invertAngle(model);
          break;

        case InstructionEnum.position:
          _invertPosition(model);
          break;

        default:
      }
    }
  }
}

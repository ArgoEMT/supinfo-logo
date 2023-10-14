import 'dart:math';

import 'package:flutter/material.dart';

import '../enum/instruction_enum.dart';
import '../models/instruction/base_instruction_model.dart';
import '../models/instruction/logo_instruction_model.dart';
import '../models/instruction/repete_instruction_model.dart';
import '../models/logo_model.dart';

class InstructionInterpretorHelper {
  /// Take a string of instructions and return a list of [LogoInstructionModel]
  static List<LogoInstructionModel> _createInstructionList(
    String instructionString,
  ) {
    final instructionList = instructionString.split(' ');
    if (instructionList.isEmpty) {
      throw Exception('Instruction bloc is empty');
    }

    try {
      final returnList = <LogoInstructionModel>[];
      while (instructionList.isNotEmpty) {
        final instruction = InstructionEnum.fromString(instructionList.first);
        final parameterCount = instruction.parameterCount;
        final parameters = instructionList
            .sublist(1, parameterCount + 1)
            .map((e) => int.parse(e))
            .toList();
        if (parameters.length < parameterCount) {
          throw Exception(
              'Not enough parameters for instruction ${instruction.toString()}');
        } else if (parameters.length > parameterCount) {
          throw Exception(
            'Too many parameters for instruction $instructionString',
          );
        }
        returnList.add(LogoInstructionModel(
          instruction: instruction,
          parameters: parameters,
        ));
      }
      return returnList;
    } catch (e) {
      throw Exception('Instruction string is not valid');
    }
  }

  // Take a string of instructions and return a list of [BaseInstructionModel]
  static BaseInstructionModel translateToLogoInstruction(
      String instructionString) {
    final instructionList = (instructionString.toLowerCase()).split(' ');
    if (instructionList.isEmpty) {
      throw Exception('Instruction string is empty');
    }

    try {
      final instruction = InstructionEnum.fromString(instructionList.first);
      if (instruction == InstructionEnum.repete) {
        final count = int.parse(instructionList[1]);
        final instructionsString = instructionList.sublist(2).join(' ');
        final instructions = _createInstructionList(instructionsString);
        return RepeteInstructionModel(
          parameters: instructions,
          count: count,
        );
      }
      final parameters =
          instructionList.sublist(1).map((e) => int.parse(e)).toList();

      if (parameters.length < instruction.parameterCount) {
        throw Exception(
          'Not enough parameters for instruction $instructionString',
        );
      } else if (parameters.length > instruction.parameterCount) {
        throw Exception(
          'Too many parameters for instruction $instructionString',
        );
      }

      return LogoInstructionModel(
        instruction: instruction,
        parameters: parameters,
      );
    } catch (e) {
      throw Exception('Instruction is not valid');
    }
  }

  static List<Offset> calculatePosition({
    required LogoModel model,
    required BaseInstructionModel instructionModel,
  }) {
    if (instructionModel is LogoInstructionModel) {
      if (!instructionModel.instruction.isInstructionToMove) {
        return [];
      }
      final distance = instructionModel.instruction == InstructionEnum.av
          ? instructionModel.parameters.first
          : -instructionModel.parameters.first;
      final angle = model.angle;
      final position = model.position;
      final x = position.dx + distance * sin(angle * pi / 180);
      final y = position.dy - distance * cos(angle * pi / 180);
      print('x: $x, y: $y');
      return [Offset(x, y)];
    }
    return [];
  }
}

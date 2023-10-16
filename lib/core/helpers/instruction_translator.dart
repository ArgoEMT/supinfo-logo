import 'package:flutter_bloc_template/core/enum/instruction_enum.dart';
import 'package:flutter_bloc_template/core/models/instruction/base_instruction_model.dart';
import 'package:flutter_bloc_template/core/models/instruction/for_instruction_model.dart';
import 'package:flutter_bloc_template/core/models/instruction/logo_instruction_model.dart';
import 'package:flutter_bloc_template/core/models/instruction/repete_instruction_model.dart';

class InstructionTranslator {
  /// Remove the brackets from the instruction string
  static List<String> _cleanList(List<String> instructionList) {
    final newList = <String>[];
    for (var item in instructionList) {
      item = item.replaceAll('[', '');
      item = item.replaceAll(']', '');
      newList.add(item);
    }
    return newList;
  }

  /// Take a string of instructions and return a list of [LogoInstructionModel]
  /// If the parameter is not an int, its value will be -1
  static List<LogoInstructionModel> _createInstructionList(
      String instructionString,
      ) {
    final instructionList = instructionString.split(' ');
    if (instructionList.isEmpty) {
      throw Exception('Instruction bloc is empty');
    }
    try {
      final cleanedList = _cleanList(instructionList);
      final returnList = <LogoInstructionModel>[];
      for (var i = 0; i < cleanedList.length; i++) {
        final instruction = InstructionEnum.fromString(cleanedList[i]);
        final parameterCount = instruction.parameterCount;
        final parameters = cleanedList
            .sublist(i + 1, i + 1 + parameterCount)
            .toList();
        i = i + parameterCount;
        returnList.add(
          LogoInstructionModel(
            instruction: instruction,
            parameters: parameters,
          ),
        );
      }
      return returnList;
    } catch (e) {
      throw Exception('Instruction string is not valid');
    }
  }

  // Take a string of instructions and return a list of [BaseInstructionModel]
  static BaseInstructionModel translateToLogoInstruction(
    String instructionString,
  ) {
    final instructionList = (instructionString.toLowerCase()).split(' ');
    if (instructionList.isEmpty) {
      throw Exception('Instruction string is empty');
    }

    try {
      final instruction = InstructionEnum.fromString(instructionList.first);
      if (instruction == InstructionEnum.repete) {
        //TODO: try to use recursion
        final count = int.parse(instructionList[1]);
        final instructionsString = instructionList.sublist(2).join(' ');
        final instructions = _createInstructionList(instructionsString);
        return RepeteInstructionModel(
          parameters: instructions,
          count: count,
        );
      }

      if (instruction == InstructionEnum.pour) {
        final endIndex = instructionList.indexOf('fin');
        final name = instructionList[1];
        final parametersName = <String>[];
        var counter = 2;
        while (instructionList[counter][0] == ':') {
          parametersName.add(instructionList[counter]);
          counter++;
        }

        final instructionsString =
            instructionList.sublist(counter, endIndex).join(' ');
        final instructions = _createInstructionList(instructionsString);
        return ForInstructionModel(
          instructions: instructions,
          instructionName: name,
          parametersName: parametersName,
        );
      }

      final parameters =
          instructionList.sublist(1).toList();

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
}

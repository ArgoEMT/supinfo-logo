import 'package:flutter_bloc_template/core/models/instruction/base_instruction_model.dart';
import 'package:flutter_bloc_template/core/models/instruction/logo_instruction_model.dart';
import 'package:flutter_bloc_template/core/models/instruction/repete_instruction_model.dart';

class ForInstructionModel extends BaseInstructionModel {
  final List<String> parametersName;
  final String instructionName;

  final List<BaseInstructionModel> instructions;

  ForInstructionModel({
    required this.parametersName,
    required this.instructions,
    required this.instructionName,
  });
  @override
  String instructionToString() {
    return 'FOR $instructionName ${parametersName.join(' ')} ${instructions.map((e) => e.instructionToString()).join(' ')} FIN';
  }

  @override
  bool validate() {
    bool parametersNameValid = parametersName.isNotEmpty &&
        parametersName.every((element) => element.startsWith(':'));
    bool instructionsValid = instructions.isNotEmpty &&
        instructions.every((element) => element.validate());
    return parametersNameValid && instructionsValid;
  }

  /// Replace the parameters with the values
  List<BaseInstructionModel> getInstructionWithValue(List<String> values) {
    if (values.length != parametersName.length) {
      throw Exception(
          'The number of values must be equal to the number of parameters');
    }

    if (values.any((element) => int.tryParse(element) == null)) {
      throw Exception('The values must be int');
    }

    final newList = <BaseInstructionModel>[];
    for (var instruction in instructions) {
      if (instruction is RepeteInstructionModel) {
        final newRepeteInstructions = <LogoInstructionModel>[];
        final repeteInstructions = instruction.parameters;
        // replace the parameters with the values
        for (var repeteInstruction in repeteInstructions) {
          final newParameters = repeteInstruction.parameters
              .map((e) => parametersName.contains(e)
                  ? values[parametersName.indexOf(e)]
                  : e)
              .toList();
          newRepeteInstructions
              .add(repeteInstruction.copyWith(parameters: newParameters));
        }
        newList.add(instruction.copyWith(parameters: newRepeteInstructions));
      } else {
        final newParameters = (instruction as LogoInstructionModel)
            .parameters
            .map((e) => parametersName.contains(e)
                ? values[parametersName.indexOf(e)]
                : e)
            .toList();
        newList.add(instruction.copyWith(parameters: newParameters));
      }
    }
    return newList;
  }

  @override
  ForInstructionModel copyWith({
    List<String>? parametersName,
    String? instructionName,
    List<BaseInstructionModel>? instructions,
  }) {
    return ForInstructionModel(
      parametersName: parametersName ?? this.parametersName,
      instructionName: instructionName ?? this.instructionName,
      instructions: instructions ?? this.instructions,
    );
  }
}

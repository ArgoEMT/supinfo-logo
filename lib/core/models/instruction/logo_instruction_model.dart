import '../../enum/instruction_enum.dart';
import 'base_instruction_model.dart';

/// A model for the instruction
class LogoInstructionModel extends BaseInstructionModel {
  LogoInstructionModel({required this.instruction, required this.parameters});

  /// The instruction to execute
  final InstructionEnum instruction;

  /// The parameters of the instruction
  final List<int> parameters;

  @override
  String instructionToString() {
    String instructionString = instruction.toString();
    String parametersString = parameters.join(' ');
    return '$instructionString $parametersString';
  }

  @override
  bool validate(){
    return parameters.length == instruction.parameterCount;
  }
}
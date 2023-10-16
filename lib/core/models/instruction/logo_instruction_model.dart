import '../../enum/instruction_enum.dart';
import 'base_instruction_model.dart';

/// A model for the instruction
class LogoInstructionModel extends BaseInstructionModel {
  LogoInstructionModel({required this.instruction, required this.parameters});

  /// The instruction to execute
  final InstructionEnum instruction;

  /// The parameters of the instruction
  final List<String> parameters;

  @override
  String instructionToString() {
    String instructionString = instruction.toString();
    String parametersString = parameters.join(' ');
    return '$instructionString $parametersString';
  }

  @override
  bool validate() {
    return parameters.length == instruction.parameterCount;
  }

  /// Getter for the parameters as int
  List<int> get parametersAsInt {
    return parameters.map((e) => int.tryParse(e) ?? -1).toList();
  }

  @override
  LogoInstructionModel copyWith({
    InstructionEnum? instruction,
    List<String>? parameters,
  }) {
    return LogoInstructionModel(
      instruction: instruction ?? this.instruction,
      parameters: parameters ?? this.parameters,
    );
  }
}

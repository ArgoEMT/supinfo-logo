import 'base_instruction_model.dart';
import 'logo_instruction_model.dart';

/// A model for the repete instruction
class RepeteInstructionModel extends BaseInstructionModel {
  RepeteInstructionModel({required this.parameters, required this.count});

  /// The number of times to repeat
  final int count;

  /// The instructions to repeat
  final List<LogoInstructionModel> parameters;

  @override
  String instructionToString() {
    return 'REPETE $count [${parameters.map((e) => e.instructionToString()).join(' ')}]';
  }

  @override
  bool validate() {
    return parameters.isNotEmpty && count > 0;
  }

  @override
  RepeteInstructionModel copyWith({
    int? count,
    List<LogoInstructionModel>? parameters,
  }) {
    return RepeteInstructionModel(
      count: count ?? this.count,
      parameters: parameters ?? this.parameters,
    );
  }
}

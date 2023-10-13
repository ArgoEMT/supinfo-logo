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
    String parametersString = parameters.map((e) => e.instructionToString()).join(' ');
    for(int i = 0; i < count; i++){
      parametersString += parameters.map((e) => e.instructionToString()).join(' ');
    }
    return parametersString;
  }

  @override
  bool validate() {
    return parameters.isNotEmpty && count > 0;
  }
}

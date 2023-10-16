import 'base_instruction_model.dart';
import 'for_instruction_model.dart';

class ExecutableForInstruction extends BaseInstructionModel {
  ExecutableForInstruction({
    required this.baseInstruction,
    required this.values,
  });

  final ForInstructionModel baseInstruction;
  final List<String> values;

  @override
  ExecutableForInstruction copyWith({
    ForInstructionModel? baseInstruction,
    List<String>? values,
  }) {
    return ExecutableForInstruction(
      baseInstruction: baseInstruction ?? this.baseInstruction,
      values: values ?? this.values,
    );
  }

  @override
  String instructionToString() =>
      '${baseInstruction.instructionName} ${values.join(' ')}';

  @override
  bool validate() {
    return baseInstruction.validate() &&
        values.length == baseInstruction.parametersName.length;
  }

  List<BaseInstructionModel> getInstructionWithValue() {
    return baseInstruction.getInstructionWithValue(values);
  }
}

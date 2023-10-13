/// Base class for all instruction models
abstract class BaseInstructionModel {
  /// Return the instruction as a string
  String instructionToString();

  /// Check the validity of the instruction
  bool validate();

  //TODO: create the FOR instruction
}

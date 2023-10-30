class ScriptHelpers {
  /// Split instructions by line and remove empty lines
  static List<String> cleanupScript(String script) {
    final cleanInstructions = <String>[];
    final instructions = script.split('\n');

    var counter = 0;
    while (counter < instructions.length) {
      final instruction = instructions[counter];
      final isPour = instruction.toLowerCase().contains('pour');
      if (instruction.isNotEmpty && !isPour) {
        cleanInstructions.add(instruction);
        counter++;
      } else if (isPour) {
        counter++;
        var cleanInstruction = instruction;
        while (!cleanInstruction.toLowerCase().contains('fin')) {
          final forInstructionLine = instructions[counter];
          if (forInstructionLine.isNotEmpty) {
            cleanInstruction += ' $forInstructionLine';
          }
          counter++;
        }
        cleanInstructions.add(cleanInstruction);
      } else {
        counter++;
      }
    }
    //remove last space for every instruction
    for (var i = 0; i < cleanInstructions.length; i++) {
      cleanInstructions[i] = cleanInstructions[i].trim();
    }
    return cleanInstructions;
  }
}

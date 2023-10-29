import '../helpers/script_interpretor.dart';
import 'logo_model.dart';

class ScriptModel {
  String? name;
  String? scriptTxt;
  ScriptModel({
    this.name,
    this.scriptTxt,
  });

  final instructions = <String>[];

  void runScript(LogoModel model) {
    if (scriptTxt == null) return;
    instructions.clear();
    instructions.addAll(ScriptHelpers.cleanupScript(scriptTxt!));
    model.resetPainter();
    for (final instruction in instructions) {
      model.addInstruction(instruction);
    }
  }
}

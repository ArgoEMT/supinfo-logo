import '../helpers/script_interpretor.dart';
import 'logo_model.dart';

class ScriptModel {
  ScriptModel({
    this.name,
    this.scriptTxt,
    required this.userId,
    this.isPublic = false,
    List<String>? tags,
    List<String>? instructions,
    List<String>? shareLinks,
  }) {
    if (tags != null) this.tags.addAll(tags);
    if (instructions != null) this.instructions.addAll(instructions);
    if (shareLinks != null) this.shareLinks.addAll(shareLinks);
  }

  final instructions = <String>[];
  final shareLinks = <String>[];
  final tags = <String>[];
  final String userId;

  bool isPublic = false;

  String? name;
  String? scriptTxt;

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

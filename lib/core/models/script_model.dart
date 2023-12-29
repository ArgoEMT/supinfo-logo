// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../helpers/script_interpretor.dart';
import 'logo_model.dart';

class ScriptModel {
  ScriptModel({
    this.name,
    this.scriptTxt,
    required this.userId,
    required this.username,
    this.isPublic = false,
    List<String>? tags,
    List<String>? instructions,
    List<String>? shareLinks,
    this.id,
  }) {
    if (tags != null) this.tags.addAll(tags);
    if (instructions != null) this.instructions.addAll(instructions);
    if (shareLinks != null) this.shareLinks.addAll(shareLinks);
  }

  final instructions = <String>[];
  final shareLinks = <String>[];
  final tags = <String>[];
  String userId;
  String username;
  String? id;

  bool isPublic;

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'instructions': instructions,
      'shareLinks': shareLinks,
      'tags': tags,
      'isPublic': isPublic,
      'name': name,
      'username': username,
    };
  }

  factory ScriptModel.fromMap(Map<String, dynamic> map) {
    return ScriptModel(
      username: map['username'] as String,
      userId: map['userId'] as String,
      instructions: map['instructions'] != null
          ? List<String>.from(map['instructions'] as List<dynamic>)
          : null,
      shareLinks: map['shareLinks'] != null
          ? List<String>.from(map['shareLinks'] as List<dynamic>)
          : null,
      tags: map['tags'] != null
          ? List<String>.from(map['tags'] as List<dynamic>)
          : null,
      isPublic: map['isPublic'] as bool,
      name: map['name'] as String?,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScriptModel.fromJson(String source) =>
      ScriptModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

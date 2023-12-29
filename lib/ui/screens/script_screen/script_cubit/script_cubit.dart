// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:supinfo_logo/core/models/script_model.dart';
import 'package:supinfo_logo/core/services/script_service.dart';
import 'package:supinfo_logo/core/services/user_service.dart';
import 'package:supinfo_logo/ui/ui_helpers/ui_snackbar_helper.dart';

import '../../../../core/models/logo_model.dart';

part 'script_state.dart';

class ScriptCubit extends Cubit<ScriptState> {
  ScriptCubit() : super(ScriptInitialState());

  final _userService = UserService();
  final _scriptService = ScriptService();

  final scriptController = CodeController();
  late final ScriptModel script;

  /// The [LogoModel] that interprets the instructions
  final LogoModel logoModel = LogoModel();

  String? _importedScriptName;

  /// The background color of the canvas
  Color get backgroundColor => logoModel.backgroundColor;

  String get scriptName =>
      _importedScriptName ?? 'script-${DateTime.now().millisecondsSinceEpoch}';

  /// Export the script to a local file
  void download(String name) {
    if (scriptController.text.isNotEmpty) {
      final script = scriptController.text;
      // Encode our file in base64
      Codec<String, String> stringToBase64 = utf8.fuse(base64);

      final encodedString = stringToBase64.encode(script);
      // Create the link with the file
      final anchor = AnchorElement(
          href: 'data:application/octet-stream;base64,$encodedString')
        ..target = 'blank';

      anchor.download = name;

      // trigger download
      document.body?.append(anchor);
      anchor.click();
      anchor.remove();
    }
  }

  Future exportScriptRemote(bool isPrivate, String scriptName) async {
    if (scriptController.text.isEmpty) {
      showSnackbar(titre: 'Le script ne peut être vide.', isError: true);
      return;
    }

    final me = await _userService.getMe();

    script.userId = me.id;
    script.username = me.username;
    script.isPublic = !isPrivate;
    script.name = scriptName;
    script.scriptTxt = scriptController.text;

    final result = await _scriptService.uploadScript(script);
    if (result) {
      showSnackbar(titre: 'Script upload avec succès');
    } else {
      showSnackbar(titre: 'Erreur lors de l\'upload du script', isError: true);
    }
  }

  /// Import a script from a local file
  Future importScriptLocal() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['txt'],
      type: FileType.custom,
      allowMultiple: false,
    );
    if (result != null) {
      final fileBytes = result.files.first.bytes;
      final decodedFile = String.fromCharCodes(fileBytes!);
      scriptController.text = decodedFile;
      _importedScriptName = result.files.first.name;
      emit(ScriptDrawState());
    }
  }

  Future init(String? scriptId) async {
    if (scriptId == null) {
      final me = await _userService.getMe();
      script = ScriptModel(userId: me.id, username: me.username);
    } else {
      script = await _scriptService.getScript(scriptId);
      final instructionString = script.instructions.join('\n');
      scriptController.text = instructionString;
    }
    emit(ScriptDrawState());
  }

  /// Run the script
  void runScript() {
    if (scriptController.text.isNotEmpty) {
      script.scriptTxt = scriptController.text;
      script.runScript(logoModel);
      emit(ScriptDrawState());
    }
  }
}

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/models/script_model.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

import '../../../../core/models/logo_model.dart';

part 'script_state.dart';

class ScriptCubit extends Cubit<ScriptState> {
  ScriptCubit() : super(ScriptInitialState());

  final scriptController = CodeController();
  final script = ScriptModel();

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

  Future exportScriptRemote() async {}

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

  Future importScriptRemote() async {}

  void init() {
    emit(ScriptLoadingState());
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

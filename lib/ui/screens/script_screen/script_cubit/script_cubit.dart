import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/logo_model.dart';

part 'script_state.dart';

class ScriptCubit extends Cubit<ScriptState> {
  ScriptCubit() : super(ScriptInitialState());

  /// The [LogoModel] that interprets the instructions
  final LogoModel logoModel = LogoModel();

  /// The background color of the canvas
  Color get backgroundColor => logoModel.backgroundColor;

  void init() {
    emit(ScriptLoadingState());
    emit(ScriptDrawState());
  }

  Future importScriptLocal() async {}

  Future exportScriptLocal() async {}

  Future importScriptRemote() async {}

  Future exportScriptRemote() async {}

  void runScript() {}
}

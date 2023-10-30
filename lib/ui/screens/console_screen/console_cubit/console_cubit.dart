import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/logo_model.dart';

part 'console_state.dart';

class ConsoleCubit extends Cubit<ConsoleState> {
  ConsoleCubit() : super(ConsoleInitialState());

  /// The focus node of the text field
  final focusNode = FocusNode();

  /// The [LogoModel] that interprets the instructions
  final LogoModel logoModel = LogoModel();

  /// The background color of the canvas
  Color get backgroundColor => logoModel.backgroundColor;

  /// Add an instruction to the [logoModel]
  void addInstruction(String instruction) {
    logoModel.addInstruction(instruction);
    emit(ConsoleDrawState(history: logoModel.historyString));
    focusNode.requestFocus();
  }

  /// Initialize the cubit
  Future init() async {
    //TODO: get saved scripts, load classroom...
    emit(ConsoleDrawState(history: logoModel.historyString));
  }
}

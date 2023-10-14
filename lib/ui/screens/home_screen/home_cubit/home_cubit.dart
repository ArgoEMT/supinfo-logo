import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/helpers/instruction_painter.dart';

import '../../../../core/helpers/instruction_interpretor_helper.dart';
import '../../../../core/models/logo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  final LogoModel logo = LogoModel();
  final painter = InstructionPainter(_points);
  static List<Offset> _points = <Offset>[];
  final focusNode = FocusNode();

  Future init() async {
    //TODO: get saved scripts, load classroom...
    emit(HomeDrawState(history: logo.historyString));
  }

  void addInstruction(String instruction) {
    final instructionObject =
        InstructionInterpretorHelper.translateToLogoInstruction(
      instruction,
    );
    logo.history.add(instructionObject);
    emit(HomeDrawState(history: logo.historyString));
    focusNode.requestFocus();
  }

  void addOffset(Offset offset) {
    _points.add(offset);
    emit(HomeDrawState(history: logo.historyString));
  }
}

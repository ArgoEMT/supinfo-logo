import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/helpers/instruction_painter.dart';

import '../../../../core/helpers/instruction_interpretor_helper.dart';
import '../../../../core/models/logo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  final LogoModel logo = LogoModel();
  late final InstructionPainter painter;
  final focusNode = FocusNode();

  Future init() async {
    //TODO: get saved scripts, load classroom...
    painter = InstructionPainter(trailColor: logo.trailColor);
    emit(HomeDrawState(history: logo.historyString));
  }

  void addInstruction(String instruction) {
    final instructionObject =
        InstructionInterpretorHelper.translateToLogoInstruction(
      instruction,
    );
    logo.history.add(instructionObject);
    final newOffset = InstructionInterpretorHelper.calculatePosition(
      instructionModel: instructionObject,
      model: logo,
    );
    addOffsets(newOffset);
    emit(HomeDrawState(history: logo.historyString));
    focusNode.requestFocus();
  }

  void addOffsets(List<Offset> offsets) {
    painter.addOffsets(offsets);
    emit(HomeDrawState(history: logo.historyString));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/logo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  final LogoModel logoModel = LogoModel();
  final focusNode = FocusNode();

  Color get backgroundColor => logoModel.backgroundColor;

  Future init() async {
    //TODO: get saved scripts, load classroom...
    emit(HomeDrawState(history: logoModel.historyString));
  }

  void addInstruction(String instruction) {
    logoModel.addInstruction(instruction);
    emit(HomeDrawState(history: logoModel.historyString));
    focusNode.requestFocus();
  }
}

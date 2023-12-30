import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/services/script_service.dart';

import '../../../../core/models/script_model.dart';

part 'script_search_dialog_state.dart';

class ScriptSearchDialogCubit extends Cubit<ScriptSearchDialogState> {
  ScriptSearchDialogCubit() : super(ScriptSearchDialogInitialState());

  final _scriptService = ScriptService();

  late final List<ScriptModel> _scripts;

  var _query = '';

  ScriptModel? selectedScript;

  Future init(String? scriptId) async {
    _scripts = await _scriptService.getMyScripts();

    if (scriptId != null) {
      selectedScript = _scripts.firstWhere((script) => script.id == scriptId);
    }
    emit(ScriptSearchDialogLoadedState(scripts: _scripts));
  }

  void toggleScript(ScriptModel script) {
    selectedScript = script;
    search(_query);
  }

  void search(String query) {
    _query = query;
    final scripts = _scripts.where((script) {
      final name = script.name!.toLowerCase();
      return name.contains(query);
    }).toList();

    emit(ScriptSearchDialogLoadedState(scripts: scripts));
  }

  bool isSelected(ScriptModel script) {
    return selectedScript?.id == script.id;
  }

  bool get canConfirm {
    return selectedScript != null;
  }
}

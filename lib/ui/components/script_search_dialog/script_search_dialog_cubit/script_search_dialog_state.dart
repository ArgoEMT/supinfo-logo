part of 'script_search_dialog_cubit.dart';

sealed class ScriptSearchDialogState {}

final class ScriptSearchDialogInitialState extends ScriptSearchDialogState {}

final class ScriptSearchDialogLoadedState extends ScriptSearchDialogState {
  ScriptSearchDialogLoadedState({required this.scripts});

  final List<ScriptModel> scripts;
}

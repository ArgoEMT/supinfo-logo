part of 'script_cubit.dart';

sealed class ScriptState {}

final class ScriptInitialState extends ScriptState {}

final class ScriptLoadingState extends ScriptState {}

final class ScriptDrawState extends ScriptState {}

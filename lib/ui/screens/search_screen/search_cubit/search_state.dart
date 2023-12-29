part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<ScriptModel> scripts;
  final SearchType type;

  SearchLoadedState({
    required this.scripts,
    required this.type,
  });
}

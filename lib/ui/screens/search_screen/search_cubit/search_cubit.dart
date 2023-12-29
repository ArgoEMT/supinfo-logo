import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/models/script_model.dart';
import 'package:supinfo_logo/core/services/script_service.dart';

part 'search_state.dart';

enum SearchType {
  public,
  my;

  String get name {
    switch (this) {
      case SearchType.public:
        return 'Tous';
      case SearchType.my:
        return 'Mes scripts';
    }
  }
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  final _scriptService = ScriptService();

  var _currentType = SearchType.public;

  late final List<ScriptModel> _scripts;
  late final List<ScriptModel> _myScripts;

  var _query = '';

  Future init() async {
    _scripts = await _scriptService.getPublicScripts();
    _myScripts = await _scriptService.getMyScripts();
    emit(SearchLoadedState(scripts: _scripts, type: _currentType));
  }

  void search(String query) {
    _query = query;
    final listToFilter =
        _currentType == SearchType.public ? _scripts : _myScripts;
    final filteredScripts = listToFilter
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(SearchLoadedState(scripts: filteredScripts, type: _currentType));
  }

  void changeType(SearchType type) {
    _currentType = type;
    search(_query);
  }
}

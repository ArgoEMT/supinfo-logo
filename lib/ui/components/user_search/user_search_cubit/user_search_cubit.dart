import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/services/user_service.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit() : super(UserSearchInitialState());

  final _userService = UserService();

  late final List<UserModel> _users;

  var _query = '';

  final selectedUsers = <UserModel>[];

  Future init() async {
    _users = await _userService.getAllUsers();
    emit(UserSearchLoadedState(users: _users));
  }

  void toggleUser(UserModel user) {
    if (selectedUsers.contains(user)) {
      selectedUsers.remove(user);
    } else {
      selectedUsers.add(user);
    }
    search(_query);
  }

  void search(String query) {
    _query = query;
    final users = _users.where((user) {
      final username = user.username.toLowerCase();
      final email = user.email.toLowerCase();

      return username.contains(query) || email.contains(query);
    }).toList();

    emit(UserSearchLoadedState(users: users));
  }

  bool isSelected(UserModel user) {
    return selectedUsers.contains(user);
  }

  bool get canConfirm {
    return selectedUsers.isNotEmpty;
  }
}

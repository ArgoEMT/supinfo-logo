import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());
  final _userService = UserService();

  /// Get the current connected user
  Future fetchMe() async {
    final user = FirebaseAuth.instance.currentUser;
    final connectedUser = await _userService.getUserById(user!.uid);
    if (connectedUser == null) {
      emit(UserIsNotInitState());
    } else {
      emit(UserInitializedState(connectedUser));
    }
    isUserFecth = true;
  }

  var isUserFecth = false;
  bool get userIsInit => state is UserInitializedState;
}

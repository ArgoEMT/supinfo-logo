import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_blocs/user_cubit/user_cubit.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/user_service.dart';

part 'init_user_state.dart';

class InitUserCubit extends Cubit<InitUserState> {
  InitUserCubit(UserCubit userCubit)
      : _userCubit = userCubit,
        super(InitUserInitialState(data: null, index: 0));

  var index = 0;

  String? email;
  String? profilPicture;
  String? username;

  final _userService = UserService();
  final UserCubit _userCubit;

  Future initUser() async {
    if (email == null || profilPicture == null || username == null) {
      return;
    }
    final currentUser = FirebaseAuth.instance.currentUser;
    final userModel = UserModel(
      id: currentUser!.uid,
      email: email!,
      image: profilPicture!,
      username: username!,
    );

    await _userService.updateUser(userModel);
    await _userCubit.fetchMe();
    emit(InitUserSuccessState());
  }

  Future emitNext() async {
    if (index < 2) {
      index += 1;
      emit(InitUserInitialState(data: value, index: index));
    } else if (index == 2) {
      await initUser();
    }
  }

  String? get value => index == 0
      ? username
      : index == 1
          ? email
          : profilPicture;
}

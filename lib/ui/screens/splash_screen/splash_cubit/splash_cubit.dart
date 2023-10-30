import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/core/global_blocs/user_cubit/user_cubit.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(UserCubit userCubit)
      : _userCubit = userCubit,
        super(SplashInitial());

  final UserCubit _userCubit;

  void init() {
    if (_userCubit.isUserFecth) {
      if (_userCubit.userIsInit) {
        emit(SplashSuccessState(RoutePaths.console));
      } else {
        emit(SplashSuccessState(RoutePaths.initUser));
      }
    }
  }
}

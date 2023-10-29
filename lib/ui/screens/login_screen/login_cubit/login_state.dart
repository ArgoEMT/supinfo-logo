part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitialState extends LoginState {
  final bool isLogin;

  LoginInitialState({this.isLogin = true});
}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}

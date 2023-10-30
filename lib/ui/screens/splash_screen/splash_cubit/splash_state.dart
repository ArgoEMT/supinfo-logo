part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashSuccessState extends SplashState {
  final String route;

  SplashSuccessState(this.route);
}

final class SplashUserNotInitState extends SplashState {}

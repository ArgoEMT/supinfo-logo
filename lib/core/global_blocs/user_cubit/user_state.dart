part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserInitializedState extends UserState {
  final UserModel user;

  UserInitializedState(this.user);
}

final class UserIsNotInitState extends UserState {}

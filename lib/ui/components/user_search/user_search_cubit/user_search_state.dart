part of 'user_search_cubit.dart';

sealed class UserSearchState {}

final class UserSearchInitialState extends UserSearchState {}

final class UserSearchLoadedState extends UserSearchState {
  UserSearchLoadedState({required this.users});

  final List<UserModel> users;
}

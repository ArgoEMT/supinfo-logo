part of 'init_user_cubit.dart';

sealed class InitUserState {
  final String? data;
  final int index;

  InitUserState({required this.data, required this.index});
}

final class InitUserInitialState extends InitUserState {
  InitUserInitialState({required super.data, required super.index});
}

final class InitUserSuccessState extends InitUserState {
  InitUserSuccessState(): super(data: null, index: 2);
}

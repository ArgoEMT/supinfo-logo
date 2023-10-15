part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeDrawState extends HomeState {
  HomeDrawState({required this.history});

  final List<String> history;
}

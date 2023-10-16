part of 'console_cubit.dart';

sealed class ConsoleState {}

final class ConsoleInitialState extends ConsoleState {}

final class ConsoleLoadingState extends ConsoleState {}

final class ConsoleDrawState extends ConsoleState {
  ConsoleDrawState({
    required this.history,
  });
  final List<String> history;
}

part of 'homework_details_cubit.dart';

sealed class HomeworkDetailsState {}

final class HomeworkDetailsInitialState extends HomeworkDetailsState {}

final class HomeworkDetailsLoadedState extends HomeworkDetailsState {
  HomeworkDetailsLoadedState({
    required this.homework,
    required this.isTeacher,
    required this.classModel,
    required this.homeworkAnswers,
    required this.students,
  });

  final HomeworkModel homework;
  final bool isTeacher;
  final ClassModel? classModel;
  final List<HomeworkAnswerModel>? homeworkAnswers;
  final List<UserModel>? students;
}

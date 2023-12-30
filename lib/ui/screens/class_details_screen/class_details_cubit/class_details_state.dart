part of 'class_details_cubit.dart';

sealed class ClassDetailsState {}

final class ClassDetailsInitialState extends ClassDetailsState {}

final class ClassDetailsLoadedState extends ClassDetailsState {
  ClassDetailsLoadedState({
    required this.classModel,
    required this.isTeacher,
    required this.homeworks,
    required this.students,
    required this.teachers,
  });

  final ClassModel classModel;
  final List<HomeworkModel> homeworks;
  final bool isTeacher;
  final List<UserModel> students;
  final List<UserModel> teachers;
}

final class ClassDetailsLoadingState extends ClassDetailsState {}

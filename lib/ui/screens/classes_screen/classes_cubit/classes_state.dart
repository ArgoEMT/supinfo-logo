part of 'classes_cubit.dart';

sealed class ClassesState {
  bool isLoading;

  ClassesState({required this.isLoading});
}

final class ClassesInitialState extends ClassesState {
  ClassesInitialState() : super(isLoading: true);
}

final class ClassesLoadedState extends ClassesState {
  ClassesLoadedState({
    super.isLoading = false,
    required this.classesAsAdmin,
    required this.classesAsStudent,
  });
  final List<ClassModel> classesAsAdmin;
  final List<ClassModel> classesAsStudent;

  ClassesLoadedState toggleLoading() {
    return ClassesLoadedState(
      classesAsAdmin: classesAsAdmin,
      classesAsStudent: classesAsStudent,
      isLoading: !isLoading,
    );
  }
}

final class ClassesNoClassState extends ClassesState {
  ClassesNoClassState({super.isLoading = false});
}

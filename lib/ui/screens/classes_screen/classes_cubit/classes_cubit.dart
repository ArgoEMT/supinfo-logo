import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/class/class_model.dart';
import '../../../../core/services/class_service.dart';
import '../../../../core/services/user_service.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit() : super(ClassesInitialState());

  final _userService = UserService();
  final _classService = ClassService();

  Future init() async {
    await _loadClasses();
  }

  Future _loadClasses() async {
    try {
      final me = await _userService.getMe();

      final classesAsAdmin = await _classService.getClasses(me.classesAsAdmin);
      final classesAsStudent = await _classService.getClasses(
        me.classesAsStudent,
      );

      emit(ClassesLoadedState(
        classesAsAdmin: classesAsAdmin,
        classesAsStudent: classesAsStudent,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(ClassesNoClassState(isLoading: false));
    }
  }

  Future createClasse(String className) async {
    final me = await _userService.getMe();
    final classModel = ClassModel(
      id: className,
      name: className,
      students: [],
      admins: [me.id],
      homeworks: [],
    );

    final currentState = state as ClassesLoadedState;
    emit(currentState.toggleLoading());
    await _classService.createClass(classModel);

    _loadClasses();
  }
}

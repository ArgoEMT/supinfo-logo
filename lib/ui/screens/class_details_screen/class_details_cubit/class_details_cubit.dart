import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';
import 'package:supinfo_logo/core/models/user_model.dart';
import 'package:supinfo_logo/core/services/admin_class_service.dart';
import 'package:supinfo_logo/core/services/homework_service.dart';
import 'package:supinfo_logo/core/services/user_service.dart';

import '../../../../core/models/class/class_model.dart';
import '../../../../core/services/class_service.dart';

part 'class_details_state.dart';

class ClassDetailsCubit extends Cubit<ClassDetailsState> {
  ClassDetailsCubit() : super(ClassDetailsInitialState());

  final _classService = ClassService();
  final _userService = UserService();
  final _homeworkService = HomeworkService();
  final _adminClassService = AdminClassService();

  Future init(String classId) async {
    emit(ClassDetailsInitialState());
    final classModel = await _classService.getClass(classId);
    final me = await _userService.getMe();
    final isTeacher = classModel.admins.contains(me.id);
    final homeworks = await _homeworkService.getHomeworks(classModel.homeworks);

    final students = await _userService.getUsersByIds(classModel.students);
    final teachers = await _userService.getUsersByIds(classModel.admins);

    emit(ClassDetailsLoadedState(
      classModel: classModel,
      isTeacher: isTeacher,
      homeworks: homeworks,
      students: students,
      teachers: teachers,
    ));
  }

  Future addStudentsToClass(String classId, List<String> userId) async {
    await _adminClassService.addStudentsToClass(classId, userId);
    await init(classId);
  }

  Future addTeacherToClass(String classId, List<String> userId) async {
    await _adminClassService.addTeachersToClass(classId, userId);
    await init(classId);
  }

  Future createHomework(String classId, HomeworkModel homeworkModel) async {
    final me = await _userService.getMe();
    homeworkModel.createdAt = DateTime.now();
    homeworkModel.classId = classId;
    homeworkModel.creator = me;
    await _homeworkService.createHomework(classId, homeworkModel);
    await init(classId);
  }
}

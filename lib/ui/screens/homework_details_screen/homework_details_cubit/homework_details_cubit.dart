import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/models/user_model.dart';
import 'package:supinfo_logo/core/services/class_service.dart';
import 'package:supinfo_logo/core/services/homework_service.dart';
import 'package:supinfo_logo/core/services/script_service.dart';
import 'package:supinfo_logo/core/services/user_service.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/homework_details_screen.dart';

import '../../../../core/models/class/class_model.dart';
import '../../../../core/models/class/homework_answer.dart';
import '../../../../core/models/class/homework_model.dart';

part 'homework_details_state.dart';

class HomeworkDetailsCubit extends Cubit<HomeworkDetailsState> {
  HomeworkDetailsCubit() : super(HomeworkDetailsInitialState());

  final _userService = UserService();
  final _classService = ClassService();
  final _homeworkService = HomeworkService();
  final _scriptService = ScriptService();

  Future init(ArgumentsHomeworkDetailsScreen arguments) async {
    emit(HomeworkDetailsInitialState());
    final homework =
        (await _homeworkService.getHomeworks([arguments.homeworkId])).first;
    if (!arguments.isTeacher) {
      final me = await _userService.getMe();
      final homeworkAnswers = await _homeworkService.getHomeworkAnswers(
        homework.id!,
      );
      HomeworkAnswerModel? myAnswer;
      try {
        myAnswer = homeworkAnswers.firstWhere(
          (answer) => answer.user.id == me.id,
        );
      } catch (_) {}
      emit(HomeworkDetailsLoadedState(
        homeworkAnswers: myAnswer != null ? [myAnswer] : [],
        classModel: null,
        students: [],
        homework: homework,
        isTeacher: false,
      ));
    } else {
      final classModel = await _classService.getClass(homework.classId!);
      final answers = await _homeworkService.getHomeworkAnswers(homework.id!);
      final students = await _userService.getUsersByIds(classModel.students);
      emit(HomeworkDetailsLoadedState(
        homeworkAnswers: answers,
        classModel: classModel,
        students: students,
        homework: homework,
        isTeacher: arguments.isTeacher,
      ));
    }
  }

  Future addAnswer(String homeworkId, String scriptId) async {
    final me = await _userService.getMe();
    final script = await _scriptService.getScript(scriptId);
    final answer = HomeworkAnswerModel(
      scriptId: scriptId,
      homeworkId: homeworkId,
      scriptName: script.name!,
      user: me,
    );
    await _homeworkService.addAnswer(answer);
    await init(ArgumentsHomeworkDetailsScreen(
      homeworkId: answer.homeworkId,
      isTeacher: false,
    ));
  }

  Future updateAnswer(HomeworkAnswerModel answer, String scriptId) async {
    final script = await _scriptService.getScript(scriptId);
    answer.scriptId = scriptId;
    answer.scriptName = script.name!;
    await _homeworkService.updateAnswer(answer);
    await init(ArgumentsHomeworkDetailsScreen(
      homeworkId: answer.homeworkId,
      isTeacher: false,
    ));
  }
}

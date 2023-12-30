import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/components/script_search_dialog/script_search_dialog.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/components/homework_student_body.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/components/homework_teacher_body.dart';

import '../../components/app_body.dart';
import 'homework_details_cubit/homework_details_cubit.dart';

class ArgumentsHomeworkDetailsScreen {
  final String homeworkId;
  final String? classId;
  final bool isTeacher;
  ArgumentsHomeworkDetailsScreen({
    required this.homeworkId,
    this.classId,
    required this.isTeacher,
  }) : assert((isTeacher && classId != null) || !isTeacher);
}

class HomeworkDetailsScreen extends StatelessWidget {
  const HomeworkDetailsScreen({super.key, required this.arguments});

  final ArgumentsHomeworkDetailsScreen arguments;

  @override
  Widget build(BuildContext context) {
    final cubit = HomeworkDetailsCubit()..init(arguments);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Details du devoir',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<HomeworkDetailsCubit, HomeworkDetailsState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is HomeworkDetailsInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeworkDetailsLoadedState) {
                return state.isTeacher
                    ? HomeworkTeacherBody(
                        homework: state.homework,
                        homeworkAnswers: state.homeworkAnswers,
                        students: state.students,
                        onScoreChanged: (homeworkAnswer, score) =>
                            cubit.updateScore(
                          classId: state.classModel!.id,
                          answerModel: homeworkAnswer,
                          score: score,
                        ),
                      )
                    : HomeworkStudentBody(
                        createHomeworkAnswer: () {
                          showDialog(
                            context: context,
                            builder: (context) => ScriptSearchDialog(
                              onConfirm: (scriptId) {
                                cubit.addAnswer(
                                  state.homework.id!,
                                  scriptId,
                                );
                              },
                              title: 'Ajouter une réponse',
                            ),
                          );
                        },
                        updateHomeworkAnswer: () {
                          showDialog(
                            context: context,
                            builder: (context) => ScriptSearchDialog(
                              scriptId: state.homeworkAnswers?.first.scriptId,
                              onConfirm: (scriptId) {
                                cubit.updateAnswer(
                                  state.homeworkAnswers!.first,
                                  scriptId,
                                );
                              },
                              title: 'Mettre à jour la réponse',
                            ),
                          );
                        },
                        homework: state.homework,
                        homeworkAnswer:
                            state.homeworkAnswers?.isNotEmpty == true
                                ? state.homeworkAnswers!.first
                                : null,
                      );
              }
              return const Center(child: Text('Error'));
            },
          ),
        ),
      ),
    );
  }
}

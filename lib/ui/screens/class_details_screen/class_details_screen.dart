import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/components/app_body.dart';
import 'package:supinfo_logo/ui/components/user_search/app_user_search_dialog.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/class_details_cubit/class_details_cubit.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/components/class_details_body.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/components/create_homework_dialog.dart';

class ArgumentsClassDetails {
  final String classId;

  ArgumentsClassDetails({required this.classId});
}

class ClassDetailsScreen extends StatelessWidget {
  const ClassDetailsScreen({super.key, required this.arguments});

  final ArgumentsClassDetails arguments;

  @override
  Widget build(BuildContext context) {
    final cubit = ClassDetailsCubit()..init(arguments.classId);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Details de la classe',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<ClassDetailsCubit, ClassDetailsState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is ClassDetailsInitialState ||
                  state is ClassDetailsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClassDetailsLoadedState) {
                return ClassDetailsBody(
                  classModel: state.classModel,
                  homeworks: state.homeworks,
                  students: state.students,
                  teachers: state.teachers,
                  isTeacher: state.isTeacher,
                  onAddStudents: () => showDialog(
                    context: context,
                    builder: (context) => AppUserSearchDialog(
                      title: 'Ajouter un étudiant',
                      onConfirm: (students) => cubit.addStudentsToClass(
                        state.classModel.id,
                        students,
                      ),
                    ),
                  ),
                  onAddTeachers: () => showDialog(
                    context: context,
                    builder: (context) => AppUserSearchDialog(
                      title: 'Ajouter un étudiant',
                      onConfirm: (teachers) => cubit.addTeacherToClass(
                        state.classModel.id,
                        teachers,
                      ),
                    ),
                  ),
                  onCreateHomework: state.isTeacher
                      ? () async {
                          showDialog(
                              context: context,
                              builder: (context) => CreateHomeworkDialog(
                                    onConfirm: (homework) =>
                                        cubit.createHomework(
                                      state.classModel.id,
                                      homework,
                                    ),
                                  ));
                        }
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

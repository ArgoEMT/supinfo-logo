import 'package:flutter/material.dart';
import 'package:supinfo_logo/core/models/class/class_model.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';
import 'package:supinfo_logo/core/models/user_model.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/components/homework_container.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/components/user_container.dart';

class ClassDetailsBody extends StatelessWidget {
  const ClassDetailsBody({
    super.key,
    required this.classModel,
    required this.homeworks,
    required this.students,
    required this.teachers,
    required this.isTeacher,
    required this.onAddStudents,
    required this.onAddTeachers,
    required this.onCreateHomework,
  });

  final ClassModel classModel;
  final List<HomeworkModel> homeworks;
  final List<UserModel> students;
  final List<UserModel> teachers;
  final bool isTeacher;
  final Function()? onAddStudents;
  final Function()? onAddTeachers;
  final Function()? onCreateHomework;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeworkContainer(
          homeworks: homeworks,
          isTeacher: isTeacher,
          onCreateHomework: onCreateHomework,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: UserContainer(
                isTeacher: false,
                users: students,
                onTapButton: isTeacher ? onAddStudents : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: UserContainer(
                isTeacher: true,
                users: teachers,
                onTapButton: isTeacher ? onAddTeachers : null,
              ),
            ),
          ],
        )
      ],
    );
  }
}

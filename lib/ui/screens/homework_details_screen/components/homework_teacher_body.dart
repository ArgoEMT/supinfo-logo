import 'package:flutter/widgets.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/components/student_rendu_container.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/helpers/date_helpers.dart';
import '../../../../core/models/class/homework_answer.dart';
import '../../../../core/models/class/homework_model.dart';
import '../../../../core/models/user_model.dart';

class HomeworkTeacherBody extends StatelessWidget {
  const HomeworkTeacherBody({
    super.key,
    required this.homework,
    required this.homeworkAnswers,
    required this.students,
    required this.onScoreChanged,
  });

  final HomeworkModel homework;
  final List<HomeworkAnswerModel>? homeworkAnswers;
  final List<UserModel>? students;
  final Function(HomeworkAnswerModel, int) onScoreChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(homework.title, style: bold20White),
        const SizedBox(height: 8),
        Text(homework.description),
        const SizedBox(height: 8),
        Text('Date de rendu: ${DateHelpers.dateToFrString(homework.dueDate)}'),
        const SizedBox(height: 16),
        StudentRenduContainer(
          onScoreChanged: onScoreChanged,
          homeworkAnswers: homeworkAnswers,
          students: students,
        ),
      ],
    );
  }
}

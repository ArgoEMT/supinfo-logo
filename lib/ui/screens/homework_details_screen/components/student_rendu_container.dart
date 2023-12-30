import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';
import 'package:supinfo_logo/core/models/class/homework_answer.dart';
import 'package:supinfo_logo/core/models/user_model.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/components/score_row.dart';
import 'package:supinfo_logo/ui/screens/script_screen/script_screen.dart';

class StudentRenduContainer extends StatelessWidget {
  const StudentRenduContainer({
    super.key,
    this.homeworkAnswers,
    this.students,
    required this.onScoreChanged,
  });

  final List<HomeworkAnswerModel>? homeworkAnswers;
  final List<UserModel>? students;
  final Function(HomeworkAnswerModel, int) onScoreChanged;

  @override
  Widget build(BuildContext context) {
    final renduMap = <UserModel, HomeworkAnswerModel>{};

    if (homeworkAnswers != null && students != null) {
      for (final answer in homeworkAnswers!) {
        final student = students!.firstWhere(
          (student) => student.id == answer.user.id,
        );
        renduMap[student] = answer;
      }
    }

    final listNonRendu =
        students?.where((element) => !renduMap.containsKey(element)).toList();

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text('Rendu', style: normal16Green),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: appPurple, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final entry in renduMap.entries)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(entry.key.username),
                            const SizedBox(width: 8),
                            if (entry.value.score != null)
                              Text('Note: ${entry.value.score}')
                            else
                              ScoreRow(
                                onScoreChanged: (score) => onScoreChanged(
                                  entry.value,
                                  score,
                                ),
                              ),
                            const Spacer(),
                            AppButton(
                              label: 'Voir le rendu',
                              onPressed: () => context.go(
                                RoutePaths.scriptEditor,
                                arguments: ArgumentsScriptScreen(
                                  scriptId: entry.value.scriptId,
                                ),
                              ),
                              isActive: true,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Non rendu', style: normal16Green),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: appPurple, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    for (final student in listNonRendu ?? [])
                      Text(student.username),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

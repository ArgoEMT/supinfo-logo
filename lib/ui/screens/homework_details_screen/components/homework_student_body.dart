import 'package:flutter/widgets.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';
import 'package:supinfo_logo/core/helpers/date_helpers.dart';
import 'package:supinfo_logo/core/models/class/homework_answer.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/script_screen/script_screen.dart';

class HomeworkStudentBody extends StatelessWidget {
  const HomeworkStudentBody({
    super.key,
    required this.homework,
    required this.homeworkAnswer,
    required this.updateHomeworkAnswer,
    required this.createHomeworkAnswer,
  });

  final HomeworkModel homework;
  final HomeworkAnswerModel? homeworkAnswer;

  final Function() updateHomeworkAnswer;
  final Function() createHomeworkAnswer;

  @override
  Widget build(BuildContext context) {
    final canModify = (homework.dueDate.compareTo(DateTime.now()) > 0) &&
        homeworkAnswer?.score == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(homework.title, style: bold20White),
        const SizedBox(height: 8),
        Text(homework.description),
        const SizedBox(height: 8),
        Text('Date de rendu: ${DateHelpers.dateToFrString(homework.dueDate)}'),
        const SizedBox(height: 16),
        const Text('Ma réponse', style: normal16Green),
        const SizedBox(height: 8),
        Row(
          children: [
            if (homeworkAnswer != null)
              Text(homeworkAnswer!.scriptName)
            else
              const Text('Pas de réponse'),
            const SizedBox(width: 16),
            if (canModify)
              AppButton(
                isActive: true,
                label: homeworkAnswer != null ? 'Modifier' : 'Ajouter',
                onPressed: () {
                  if (homeworkAnswer != null) {
                    updateHomeworkAnswer();
                  } else {
                    createHomeworkAnswer();
                  }
                },
              ),
            if (homeworkAnswer != null) ...[
              const SizedBox(width: 16),
              AppButton(
                isActive: true,
                label: 'Voir',
                onPressed: () => context.go(
                  RoutePaths.scriptEditor,
                  arguments: ArgumentsScriptScreen(
                    scriptId: homeworkAnswer!.scriptId,
                  ),
                ),
              ),
            ]
          ],
        ),
        const SizedBox(height: 16),
        const Text('Ma note', style: normal16Green),
        if (homeworkAnswer == null || homeworkAnswer?.score == null)
          const Text('Pas de note')
        else
          Text(homeworkAnswer!.score.toString()),
      ],
    );
  }
}

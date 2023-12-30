import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';
import 'package:supinfo_logo/core/helpers/date_helpers.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/homework_details_screen/homework_details_screen.dart';

class HomeworkContainer extends StatelessWidget {
  const HomeworkContainer({
    super.key,
    required this.homeworks,
    required this.isTeacher,
    required this.onCreateHomework,
    required this.classId,
  });

  final List<HomeworkModel> homeworks;
  final bool isTeacher;
  final Function()? onCreateHomework;
  final String classId;

  @override
  Widget build(BuildContext context) {
    final lenght = isTeacher ? homeworks.length + 1 : homeworks.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Devoirs', style: bold20Green),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: appPurple, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: homeworks.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: lenght,
                  itemBuilder: (context, index) {
                    if (isTeacher && index == lenght - 1) {
                      return AppButton(
                        isExpanded: false,
                        isActive: true,
                        label: 'Ajouter un devoir',
                        onPressed: onCreateHomework,
                      );
                    }
                    final homework = homeworks[index];
                    return Container(
                      decoration: homework == homeworks.last
                          ? null
                          : const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: appPurple, width: 2),
                              ),
                            ),
                      child: InkWell(
                        onTap: () => context.go(
                          RoutePaths.homeworkDetails,
                          arguments: ArgumentsHomeworkDetailsScreen(
                            homeworkId: homework.id!,
                            isTeacher: isTeacher,
                            classId: classId,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    homework.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  DateHelpers.dateToFrString(homework.dueDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(homework.description),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : isTeacher
                  ? AppButton(
                      isExpanded: false,
                      isActive: true,
                      label: 'Ajouter un devoir',
                      onPressed: onCreateHomework)
                  : const Center(child: Text('Aucun devoir')),
        ),
      ],
    );
  }
}

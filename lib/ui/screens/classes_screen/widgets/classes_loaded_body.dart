import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/core/models/class/class_model.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/screens/class_details_screen/class_details_screen.dart';

class ClassesLoadedBody extends StatelessWidget {
  const ClassesLoadedBody({
    super.key,
    required this.classesAsAdmin,
    required this.classesAsStudent,
    required this.onCreateClass,
  });

  final List<ClassModel> classesAsAdmin;
  final List<ClassModel> classesAsStudent;
  final Function() onCreateClass;

  List<Widget> _buildClassesList(BuildContext context,
      {required List<ClassModel> classes, required bool isAdmin}) {
    if (classes.isEmpty && !isAdmin) return [];
    return [
      Text(
        isAdmin
            ? 'Classes dont je suis professeur'
            : 'Classes dont je suis élève',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 24),
      ...classes.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: AppButton(
            isActive: false,
            label: e.name,
            showBorders: true,
            onPressed: () => context.go(
              RoutePaths.classDetails,
              arguments: ArgumentsClassDetails(classId: e.id),
            ),
          ),
        ),
      ),
      if (isAdmin) ...[
        const SizedBox(height: 24),
        AppButton(
          isActive: true,
          label: 'Créer une classe',
          onPressed: onCreateClass,
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildClassesList(
          context,
          classes: classesAsStudent,
          isAdmin: false,
        ),
        if (classesAsStudent.isNotEmpty) ...[
          const SizedBox(height: 48),
          const Divider(color: appPurple, thickness: 2),
          const SizedBox(height: 48),
        ],
        ..._buildClassesList(context, classes: classesAsAdmin, isAdmin: true),
      ],
    );
  }
}

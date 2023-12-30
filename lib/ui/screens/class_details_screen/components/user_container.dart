import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

import '../../../../core/models/user_model.dart';

class UserContainer extends StatelessWidget {
  const UserContainer({
    super.key,
    required this.users,
    required this.isTeacher,
    required this.onTapButton,
  });

  final List<UserModel> users;
  final bool isTeacher;
  final Function()? onTapButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isTeacher ? 'Professeurs' : 'Étudiants', style: bold20Green),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: appPurple, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Text(user.username);
            },
          ),
        ),
        if (onTapButton != null) ...[
          const SizedBox(height: 16),
          AppButton(
            isActive: true,
            onPressed: onTapButton,
            label: isTeacher ? 'Ajouter un professeur' : 'Ajouter un étudiant',
          ),
        ]
      ],
    );
  }
}

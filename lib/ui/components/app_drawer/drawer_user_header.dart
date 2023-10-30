import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';
import 'package:supinfo_logo/config/theme/app_text_styles.dart';

import '../../../core/models/user_model.dart';

class DrawerUserHeader extends StatelessWidget {
  const DrawerUserHeader({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      final byteImage = base64Decode(user!.image);
      return Column(
        children: [
          const SizedBox(height: 16),
          Text(
            user!.username,
            style: bold16White,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 180,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(byteImage)),
            ),
          ),
          const Divider(
            color: appPurple,
            height: 1,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 16),
          Container(height: 16, width: 50, color: Colors.white),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 180, width: 180, color: Colors.white),
          ),
          const Divider(
            color: appPurple,
            height: 1,
          ),
        ],
      );
    }
  }
}

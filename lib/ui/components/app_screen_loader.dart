import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class AppScreenLoader extends StatelessWidget {
  const AppScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appDivider.withOpacity(0.4),
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                );
  }
}
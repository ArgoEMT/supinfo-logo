import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';

class InitBreadcrumb extends StatelessWidget {
  const InitBreadcrumb({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final list = List.generate(3, (index) => index);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list
          .map(
            (e) => Expanded(
              child: Container(
                height: 8,
                color: e <= index ? appGreen : appPurple,
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          )
          .toList(),
    );
  }
}

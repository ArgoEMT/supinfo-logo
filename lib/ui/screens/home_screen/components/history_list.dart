import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/config/theme/app_colors.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.history});

  final List<String> history;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: appDivider)),
      height: 750,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final item in history)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(item),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

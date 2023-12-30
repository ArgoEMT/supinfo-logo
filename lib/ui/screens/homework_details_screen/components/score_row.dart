import 'package:flutter/material.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

class ScoreRow extends StatelessWidget {
  const ScoreRow({super.key, required this.onScoreChanged});

  final Function(int) onScoreChanged;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AppButton(
            label: 'Noter',
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onScoreChanged(int.parse(controller.text));
              }
            },
            isActive: true,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

class ConsoleWidget extends StatelessWidget {
  const ConsoleWidget({
    super.key,
    required this.onSaved,
    required this.focusNode,
  });
  final Function(String) onSaved;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            onSubmitted: (value) => onSaved(value.toLowerCase()),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrez une instruction',
            ),
          ),
        ),
        const SizedBox(width: 8),
        AppButton(
          isActive: true,
          onPressed: () {
            if (controller.text.isEmpty) return;
            onSaved(controller.text.toLowerCase());
          },
          label: 'Envoyer',
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
            onSubmitted: onSaved,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrez une instruction',
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isEmpty) return;
            onSaved(controller.text);
          },
          child: const Text('Envoyer'),
        ),
      ],
    );
  }
}

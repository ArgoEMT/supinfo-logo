import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/core/models/class/homework_model.dart';

class CreateHomeworkDialog extends StatelessWidget {
  const CreateHomeworkDialog({super.key, required this.onConfirm});

  final Function(HomeworkModel) onConfirm;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    var dueDate = DateTime.now();
    return AlertDialog(
      title: const Text('Créer un devoir'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Titre du devoir',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description du devoir',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                dueDate = date;
              }
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  dueDate.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty) {
              final homework = HomeworkModel(
                title: titleController.text,
                description: descriptionController.text,
                dueDate: dueDate,
              );
              onConfirm(homework);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Créer'),
        ),
      ],
    );
  }
}

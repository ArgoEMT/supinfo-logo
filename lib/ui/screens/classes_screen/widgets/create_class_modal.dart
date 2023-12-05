import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/config/theme/app_colors.dart';

class CreateClassModal extends StatelessWidget {
  const CreateClassModal({super.key, required this.onCreate});

  final Function(String) onCreate;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: appbackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Créer une classe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Nom de la classe',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annuler'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        onCreate(controller.text);
                        context.pop();
                      }
                    },
                    child: const Text('Créer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

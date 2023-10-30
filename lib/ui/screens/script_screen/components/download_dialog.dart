import 'package:flutter/material.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog({
    super.key,
    required this.onDownload,
    required this.initialName,
  });
  final Function(String) onDownload;
  final String initialName;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialName);
    return AlertDialog(
      title: const Text('Télécharger le script'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nom du script',
            ),
          )
        ],
      ),
      actions: [
        AppButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              var finalName = controller.text;
              if (finalName.contains('.txt')) {
                finalName = finalName.replaceAll('.txt', '');
              }
              onDownload('${controller.text}.txt');
            } else {
              onDownload(initialName);
            }
            context.pop();
          },
          label: 'Télécharger',
          isActive: true,
        ),
      ],
    );
  }
}

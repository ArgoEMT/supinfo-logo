import 'package:flutter/material.dart';

class UploadCloudDialog extends StatefulWidget {
  const UploadCloudDialog({super.key, required this.onUpload});

  final Function(bool, String) onUpload;

  @override
  State<UploadCloudDialog> createState() => _UploadCloudDialogState();
}

class _UploadCloudDialogState extends State<UploadCloudDialog> {
  var isPrivateScript = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload le script'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nom du script',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text('Privé'),
              const SizedBox(width: 8),
              Switch(
                value: isPrivateScript,
                onChanged: (value) {
                  setState(() {
                    isPrivateScript = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              return;
            }
            widget.onUpload(isPrivateScript, controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}

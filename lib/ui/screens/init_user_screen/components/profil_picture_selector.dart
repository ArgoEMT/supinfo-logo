import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';

class ProfilPictureSelector extends StatefulWidget {
  const ProfilPictureSelector({
    super.key,
    required this.onSave,
    required this.image,
  });
  final Function(String) onSave;
  final String? image;

  @override
  State<ProfilPictureSelector> createState() => _ProfilPictureSelectorState();
}

class _ProfilPictureSelectorState extends State<ProfilPictureSelector> {
  String? image;

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null) Image.memory(base64Decode(image!), height: 250),
        const SizedBox(height: 16),
        AppButton(
          isActive: true,
          label: 'Choisir une image',
          onPressed: () async {
            final image = await FilePicker.platform.pickFiles(
              type: FileType.image,
            );
            if (image == null) return;
            final bytes = image.files.first.bytes;
            final base64Image = base64Encode(bytes!);
            setState(() {
              this.image = base64Image;
              widget.onSave(base64Image);
            });
          },
        ),
      ],
    );
  }
}

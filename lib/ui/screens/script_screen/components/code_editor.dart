// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/config/theme/app_colors.dart';
import 'package:flutter_bloc_template/ui/components/app_button.dart';
import 'package:flutter_bloc_template/ui/components/template_appbar.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({super.key, required this.controller});
  final CodeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppButton(
                isActive: true,
                label: 'Importer un script',
                onPressed: () {
                  //TODO: import script
                }),
            const SizedBox(width: 16),
            AppButton(
              isActive: true,
              label: 'Sauvegarder le script',
              onPressed: () {
                //TODO: save script
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppButton(
                  isActive: true,
                  label: 'Lancer le script',
                  onPressed: () {
                    //TODO: launch script
                  }),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: CodeTheme(
            data: CodeThemeData(styles: monokaiSublimeTheme),
            child: SingleChildScrollView(
              child: CodeField(
                controller: controller,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/components/app_button.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({
    super.key,
    required this.controller,
    required this.onDownload,
    required this.onImport,
    required this.onRun,
  });
  final CodeController controller;

  final Function() onDownload;
  final Future Function() onImport;
  final Function() onRun;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Column(
      children: [
        Row(
          children: [
            AppButton(
              isActive: true,
              label: 'Importer un script',
              onPressed: onImport,
            ),
            const SizedBox(width: 16),
            AppButton(
              isActive: true,
              label: 'Télécharger le script',
              onPressed: onDownload,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppButton(
                isActive: true,
                label: 'Lancer le script',
                onPressed: onRun,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => focusNode.requestFocus(),
            child: Container(
              color: const Color(0xff23241f),
              child: CodeTheme(
                data: CodeThemeData(styles: monokaiSublimeTheme),
                child: SingleChildScrollView(
                  child: CodeField(
                    gutterStyle: GutterStyle(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    focusNode: focusNode,
                    controller: controller,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

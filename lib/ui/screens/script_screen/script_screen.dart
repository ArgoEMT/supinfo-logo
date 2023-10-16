import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

import '../../../config/theme/app_colors.dart';
import '../../../core/constants/painter_constants.dart';
import '../../components/app_body.dart';
import '../../components/logo_painter.dart';
import '../../components/template_appbar.dart';
import 'components/code_editor.dart';
import 'script_cubit/script_cubit.dart';

class ScriptScreen extends StatelessWidget {
  const ScriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ScriptCubit()..init();
    final controller = CodeController();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Interpréteur de script',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (BuildContext context, ScriptState state) {
              if (state is ScriptInitialState || state is ScriptLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ScriptDrawState) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: appPurple,
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height -
                            48 -
                            TemplateAppbar.height,
                        child: CodeEditor(controller: controller),
                      ),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: PainterConstants.painterSize,
                      height: PainterConstants.painterSize,
                      child: LogoPainter(
                        backgroundColor: cubit.backgroundColor,
                        model: cubit.logoModel,
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('Error'));
            },
          ),
        ),
      ),
    );
  }
}

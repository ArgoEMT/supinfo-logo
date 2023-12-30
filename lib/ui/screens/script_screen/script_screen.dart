import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/screens/script_screen/components/download_dialog.dart';
import 'package:supinfo_logo/ui/screens/script_screen/components/upload_cloud_dialog.dart';

import '../../../config/theme/app_colors.dart';
import '../../../core/constants/painter_constants.dart';
import '../../components/app_body.dart';
import '../../components/logo_painter.dart';
import '../../components/template_appbar.dart';
import 'components/code_editor.dart';
import 'script_cubit/script_cubit.dart';

class ArgumentsScriptScreen {
  final String? scriptId;

  ArgumentsScriptScreen({this.scriptId});
}

class ScriptScreen extends StatelessWidget {
  const ScriptScreen({super.key, required this.arguments});

  final ArgumentsScriptScreen arguments;

  @override
  Widget build(BuildContext context) {
    final cubit = ScriptCubit()..init(arguments.scriptId);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Editeur de script',
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
                              width: 2,
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height -
                            48 -
                            TemplateAppbar.height,
                        child: CodeEditor(
                          onExportCloud: () {
                            showDialog(
                              context: context,
                              builder: (context) => UploadCloudDialog(
                                onUpload: cubit.exportScriptRemote,
                              ),
                            );
                          },
                          controller: cubit.scriptController,
                          onDownload: () {
                            showDialog(
                              context: context,
                              builder: (context) => DownloadDialog(
                                onDownload: cubit.download,
                                initialName: cubit.scriptName,
                              ),
                            );
                          },
                          onImport: cubit.importScriptLocal,
                          onRun: cubit.runScript,
                        ),
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

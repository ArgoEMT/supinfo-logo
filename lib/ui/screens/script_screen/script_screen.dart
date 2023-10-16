import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/painter_constants.dart';
import '../../components/app_body.dart';
import '../../components/logo_painter.dart';
import 'script_cubit/script_cubit.dart';

class ScriptScreen extends StatelessWidget {
  const ScriptScreen({super.key});

    @override
  Widget build(BuildContext context) {
    final cubit = ScriptCubit()..init();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Interpréteur console',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (BuildContext context, ScriptState state) {
              if (state is ScriptInitialState || state is ScriptLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ScriptDrawState) {
                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: 900,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: PainterConstants.painterSize,
                                height: PainterConstants.painterSize,
                                child: LogoPainter(
                                  backgroundColor: cubit.backgroundColor,
                                  model: cubit.logoModel,
                                ),
                              ),
                              const SizedBox(width: 24),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
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
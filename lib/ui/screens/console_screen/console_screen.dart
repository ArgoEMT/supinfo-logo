import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/painter_constants.dart';
import '../../components/app_body.dart';
import 'components/console_widget.dart';
import 'components/history_list.dart';
import '../../components/logo_painter.dart';
import 'console_cubit/console_cubit.dart';


class ConsoleScreen extends StatelessWidget {
  const ConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ConsoleCubit()..init();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Interpréteur console',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (BuildContext context, ConsoleState state) {
              if (state is ConsoleInitialState || state is ConsoleLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ConsoleDrawState) {
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
                              Expanded(
                                child: HistoryList(history: state.history),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ConsoleWidget(
                            onSaved: cubit.addInstruction,
                            focusNode: cubit.focusNode,
                          ),
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

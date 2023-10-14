import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/home_screen/components/logo_painter.dart';

import '../../components/app_body.dart';
import 'components/console_widget.dart';
import 'components/history_list.dart';
import 'home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit()..init();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AppBody(
        title: 'Home',
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (BuildContext context, HomeState state) {
              if (state is HomeInitialState || state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeDrawState) {
                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: 900,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                color: Colors.grey,
                                width: 750,
                                height: 750,
                                child: LogoPainter(
                                  painter: cubit.painter,
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: HistoryList(
                                  history: state.history,
                                ),
                              ),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: () {
                              final painter = cubit.painter;

                              final offset = Offset(
                                500 * Random().nextDouble(),
                                500 * Random().nextDouble(),
                              );
                              cubit.addOffset(offset);
                            },
                            child: Text('click me'),
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/painter_constants.dart';
import '../../components/app_body.dart';
import 'components/console_widget.dart';
import 'components/history_list.dart';
import 'components/logo_painter.dart';
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
                              SizedBox(
                                width: PainterConstants.painterHeight,
                                height: PainterConstants.painterWidth,
                                child: LogoPainter(
                                  backgroundColor: cubit.logo.backgroundColor,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_body.dart';
import 'home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit()..init();
    return AppBody(
      title: 'Home',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder(
          bloc: cubit,
          builder: (BuildContext context, HomeState state) {
            if (state is HomeLoadingState || state is HomeInitialState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadedState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: state.data.map((e) => Text(e)).toList(),
                  ),
                  const SizedBox(height: 24.0),
                  OutlinedButton(
                    onPressed: cubit.loadMore,
                    child: const Text('Load More'),
                  ),
                ],
              );
            }
            return const Center(child: Text('Error'));
          },
        ),
      ),
    );
  }
}

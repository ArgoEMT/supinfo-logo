import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/config/app_router.dart';
import 'package:supinfo_logo/ui/screens/splash_screen/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SplashCubit(context.read())..init();
    return Scaffold(
        body: BlocBuilder<SplashCubit, SplashState>(
      bloc: cubit,
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is SplashSuccessState) {
            context.go(state.route);
          }
        });
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    ));
  }
}

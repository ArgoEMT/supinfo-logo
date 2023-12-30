import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/ui/components/app_button.dart';
import 'package:supinfo_logo/ui/ui_helpers/ui_snackbar_helper.dart';

import '../../../config/app_router.dart';
import '../../../config/theme/app_colors.dart';
import 'login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = LoginCubit(connectivityCubit: context.read())..tryAutoLogin();
    return Scaffold(
      body: Center(
        child: BlocBuilder<LoginCubit, LoginState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const CircularProgressIndicator();
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is LoginErrorState) {
                showSnackbar(titre: state.message, isError: true);
                cubit.goBackToLastState();
              }
              if (state is LoginSuccessState) {
                context.go(RoutePaths.splash);
              }
            });

            return Container(
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(color: appPurple, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      state is LoginInitialState && state.isLogin
                          ? 'Se connecter'
                          : 'Créer un compte',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: cubit.emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      controller: cubit.passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mot de passe',
                      ),
                    ),
                    if (state is LoginInitialState && !state.isLogin) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        validator: (value) => !state.isLogin &&
                                value != cubit.passwordController.text
                            ? 'Les mots de passe ne correspondent pas'
                            : null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirmer le mot de passe',
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    AppButton(
                      isActive: true,
                      onPressed: () {
                        if (state is LoginInitialState) {
                          if (formKey.currentState!.validate()) {
                            state.isLogin
                                ? cubit.login()
                                : cubit.createAccount();
                          }
                        }
                      },
                      label: state is LoginInitialState && state.isLogin
                          ? 'Se connecter'
                          : 'Créer un compte',
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      isActive: false,
                      onPressed: () => cubit.toggleScreen(),
                      label: state is LoginInitialState && state.isLogin
                          ? 'Créer un compte'
                          : 'J\'ai déjà un compte',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

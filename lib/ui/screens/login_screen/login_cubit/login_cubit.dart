import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supinfo_logo/core/global_blocs/connectivity_cubit/user_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required UserCubit connectivityCubit})
      : _connectivityCubit = connectivityCubit,
        super(LoginInitialState());

  /// The last initial state of the cubit
  LoginState? _lastState;

  /// Controller of the emai field in the screen
  final emailController = TextEditingController();

  /// Controller of the password field in the screen
  final passwordController = TextEditingController();

  final UserCubit _connectivityCubit;

  /// Change the state and save the last state
  Future _changeState(LoginState newState) async {
    if (state is LoginInitialState) {
      _lastState = state;
    }
    if (newState is LoginSuccessState) {
      await _connectivityCubit.fetchUser(newState.user);
    }
    emit(newState);
  }

  /// Check the given error and change the state accordingly
  void _checkError(FirebaseAuthException exception) {
    debugPrint(exception.code);
    switch (exception.code) {
      case 'email-already-in-use':
        _changeState(LoginErrorState('Email already in use.'));
        break;
      case 'invalid-email':
        _changeState(LoginErrorState('Email is invalid.'));
        break;
      case 'weak-password':
        _changeState(LoginErrorState('Password is too weak.'));
        break;
      case 'wrong-password':
        _changeState(LoginErrorState('Password is invalid.'));
        break;
      case 'user-not-found':
        _changeState(LoginErrorState('User not found.'));
        break;
      case 'invalid-login-credentials':
        _changeState(LoginErrorState('Email or password is invalid.'));
        break;

      default:
        _changeState(LoginErrorState('Unknown error occured'));
    }
  }

  /// Create an account with the given email and password
  Future createAccount() async {
    _changeState(LoginLoadingState());
    try {
      final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _changeState(LoginSuccessState(credentials.user!));
    } on FirebaseAuthException catch (e) {
      _checkError(e);
    } catch (e) {
      _changeState(LoginErrorState('Unknown error occured'));
    }
  }

  /// Go back to the last state
  void goBackToLastState() {
    emit(_lastState ?? LoginInitialState());
  }

  /// Login the user with the given email and password
  Future login() async {
    _changeState(LoginLoadingState());
    try {
      final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _changeState(LoginSuccessState(credentials.user!));
    } on FirebaseAuthException catch (e) {
      _checkError(e);
    } catch (e) {
      debugPrint(e.toString());
      _changeState(LoginErrorState('Unknown error occured'));
    }
  }

  /// Toggle the screen between login and create account
  void toggleScreen() {
    if ((state as LoginInitialState).isLogin) {
      _changeState(LoginInitialState(isLogin: false));
    } else {
      _changeState(LoginInitialState(isLogin: true));
    }
    passwordController.text = '';
  }

  /// Try to login automatically
  Future tryAutoLogin() async {
    _changeState(LoginLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _changeState(LoginSuccessState(user));
    } else {
      _changeState(LoginInitialState());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginCubit() : super(LoginInitialState());

  Future tryAutoLogin() async {
    _changeState(LoginLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _changeState(LoginSuccessState());
    } else {
      _changeState(LoginInitialState());
    }
  }

  Future login() async {
    _changeState(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _changeState(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      switch (e.code.toLowerCase()) {
        case 'invalid-email':
          _changeState(LoginErrorState('Email is invalid.'));
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
    } catch (e) {
      debugPrint(e.toString());
      _changeState(LoginErrorState('Unknown error occured'));
    }
  }

  Future createAccount() async {
    _changeState(LoginLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      _changeState(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          _changeState(LoginErrorState('Email already in use.'));
          break;
        case 'invalid-email':
          _changeState(LoginErrorState('Email is invalid.'));
          break;
        case 'weak-password':
          _changeState(LoginErrorState('Password is too weak.'));
          break;
        default:
          _changeState(LoginErrorState('Unknown error occured'));
      }
    } catch (e) {
      _changeState(LoginErrorState('Unknown error occured'));
    }
  }

  void toggleScreen() {
    if ((state as LoginInitialState).isLogin) {
      _changeState(LoginInitialState(isLogin: false));
    } else {
      _changeState(LoginInitialState(isLogin: true));
    }
    passwordController.text = '';
  }

  void _changeState(LoginState newState) {
    if (state is LoginInitialState) {
      _lastState = state;
    }
    emit(newState);
  }

  LoginState? _lastState;
  void goBackToLastState() {
    emit(_lastState ?? LoginInitialState());
  }
}

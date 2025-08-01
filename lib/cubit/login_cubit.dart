import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  userLogin({required String userName, required String password}) async {
    try {
      String email = userName.trim();
      String localPassword = password.trim();
      if (userName.isEmpty || password.isEmpty) {
        emit(LoginErrorState(msg: "enter username or password"));
        _stateChanges();
        return;
      } else if (!userName.contains("@") || password.length < 6) {
        emit(LoginErrorState(msg: "enter valid value"));
        return;
      }

      final data = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: localPassword,
      );

      print("date... $data");
    } catch (e) {
      emit(LoginErrorState(msg: e.toString()));
    }
  }

  _stateChanges() {
    emit(LoginInitialState());
  }

  void showHidePassword(bool value) {

  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  userLoginAndSignUp({
    required String userName,
    required String password,
    required LoginType type,
  }) async {
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

    if (type == LoginType.signIn) {
      try {
        final data = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: localPassword,
        );

        print("date... $data");
      } catch (e) {
        emit(LoginErrorState(msg: e.toString()));
      }
    } else {
      try {
        final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: localPassword,
        );

        print("date... $data");
      } catch (e) {
        emit(LoginErrorState(msg: e.toString()));
      }
    }
  }

  _stateChanges({LoginState? state}) {
    if (state != null && state != LoginInitialState()) {
      emit(state);
      emit(LoginInitialState());
    } else {
      emit(LoginInitialState());
    }
  }

  void showHidePassword(bool value, LoginSuccessState state) {
    state.passwordObscureText = !value;
    _stateChanges(state: state);
  }

  void loginSignup(bool value, LoginSuccessState state) {
    state.isLogin = !value;
    _stateChanges(state: state);
  }
}

enum LoginType { signIn, signUp }

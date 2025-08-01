import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginErrorState extends LoginState{
  final String msg;
  LoginErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
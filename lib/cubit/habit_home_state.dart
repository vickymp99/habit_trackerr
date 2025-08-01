import 'package:equatable/equatable.dart';

abstract class HabitHomeState extends Equatable {}

class HabitHomeInitialState extends HabitHomeState {
  @override
  List<Object?> get props => [];
}

class HabitHomeLoadingState extends HabitHomeState{
  @override
  List<Object?> get props => [];
}

class HabitHomeSuccessState extends HabitHomeState{
  @override
  List<Object?> get props => [];
}
class HabitHomeErrorState extends HabitHomeState{
  final String msg;
  HabitHomeErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
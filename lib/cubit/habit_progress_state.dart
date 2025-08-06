import 'package:equatable/equatable.dart';

abstract class HabitProgressState extends Equatable {}

class HabitProgressInitialState extends HabitProgressState {
  @override
  List<Object?> get props => [];
}

class HabitProgressLoadingState extends HabitProgressState{
  @override
  List<Object?> get props => [];
}

class HabitProgressSuccessState extends HabitProgressState{

  @override
  List<Object?> get props => [];
}
class HabitProgressErrorState extends HabitProgressState{
  final String msg;
  HabitProgressErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}
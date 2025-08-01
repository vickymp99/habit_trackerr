import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/habit_home_state.dart';

class HabitHomeCubit extends Cubit<HabitHomeState> {
  HabitHomeCubit() : super(HabitHomeInitialState());
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/habit_progress_state.dart';

class HabitProgressCubit extends Cubit<HabitProgressState>{
  HabitProgressCubit():super(HabitProgressInitialState());

}
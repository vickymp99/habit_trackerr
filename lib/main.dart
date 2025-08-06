import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/habit_home_cubit.dart';
import 'package:habit_tracker/cubit/habit_progress_cubit.dart';
import 'package:habit_tracker/cubit/login_cubit.dart';
import 'package:habit_tracker/firebase_options.dart';
import 'package:habit_tracker/pages/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HabitTracker());
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HabitHomeCubit()),
        BlocProvider(create: (context) => HabitProgressCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.transparent,
        home: Login(),
      ),
    );
  }
}

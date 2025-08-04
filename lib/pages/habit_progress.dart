import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/widgets/habit_progress_widget.dart';

class HabitProgress extends StatelessWidget {
  const HabitProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: HabitProgressWidget()),
    );
  }
}

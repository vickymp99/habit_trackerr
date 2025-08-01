import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/new_habit_widget.dart';

class NewHabit extends StatelessWidget {
  const NewHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: NewHabitWidget()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/new_habit.dart';
import 'package:habit_tracker/widgets/habit_home_widget.dart';

class HabitHome extends StatelessWidget {
  const HabitHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: YourHabitWidget()),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create New Habit",
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewHabit()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

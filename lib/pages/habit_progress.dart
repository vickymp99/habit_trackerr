import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/habit_progress_widget.dart';

class HabitProgress extends StatelessWidget {
  const HabitProgress({required this.docs, super.key});
  final QueryDocumentSnapshot<Map<String, dynamic>> docs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: HabitProgressWidget(docs: docs)),
    );
  }
}

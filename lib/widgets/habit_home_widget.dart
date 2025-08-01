import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YourHabitWidget extends StatelessWidget {
  const YourHabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0,24.0,24.0,0.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Text("Your Habits"),
              IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: Icon(Icons.person)),
            ],
          ),
          SizedBox(height: 24),
          HabitList(habitList: []),
        ],
      ),
    );
  }
}

class HabitList extends StatelessWidget {
  final List habitList;
  const HabitList({required this.habitList, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey),
            ),
            shadowColor: Colors.black,
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Image.asset(""),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text("Habit Name"),
                      SizedBox(height: 8),
                      Text("Duration"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

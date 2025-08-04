import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/pages/habit_progress.dart';

class YourHabitWidget extends StatelessWidget {
  const YourHabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Text("Your Habits", style: AppStyle.appbarTitle()),
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(height: 24),
          HabitList(),
        ],
      ),
    );
  }
}

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("habit-list")
          .where("uId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return snap.data!.docs.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: snap.data!.docs.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HabitProgress(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5.0,
                          color: Colors.blueGrey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
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
                                    Text(
                                      snap.data!.docs[index]["title"]
                                          .toString()
                                          .toUpperCase(),
                                      style: AppStyle.labelText(),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Duration : ${snap.data!.docs[index]["days"]} days",
                                      style: AppStyle.hintText(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(child: Text("No data", style: AppStyle.labelText()));
      },
    );
  }
}

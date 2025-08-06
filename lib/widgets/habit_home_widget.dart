import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/core/utils/Commonutils.dart';
import 'package:habit_tracker/core/utils/circular_indicator.dart';
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
              Flexible(child: SizedBox()),
              Text("Your Habits", style: AppStyle.appbarTitle()),
              IconButton(
                onPressed: () {
                  CommonUtils.logOut(context);
                },
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

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _assignValue(
    String docId,
  ) async {
    QueryDocumentSnapshot<Map<String, dynamic>>? data;
    var d1 = await FirebaseFirestore.instance
        .collection("habit-progress")
        .get();
    for (var s in d1.docs) {
      print("s id  ... ${s["id"]}");
      if (s["id"] == docId) {
        data = s;
      }
    }
    return data;
  }

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
                        onTap: () async {
                          var data = await _assignValue(
                            snap.data!.docs[index].id,
                          );
                          if (data != null) {
                            navigate(context, data);
                          }
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),

                                  child: Image.asset(
                                    width: 75.0,
                                    height: 75.0,
                                    fit: BoxFit.fill,
                                    "assets/images/swimming.png",
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "Duration : ${snap.data!.docs[index]["totalDays"]} days",
                                        style: AppStyle.hintText(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomCircularIndicator(
                                  currentValue: double.parse(
                                    snap.data!.docs[index]["completeDays"],
                                  ),
                                  totalValue: double.parse(
                                    snap.data!.docs[index]["totalDays"],
                                  ),
                                  size: 60,
                                ),
                                SizedBox(width: 8.0),
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("habit-list")
                                        .doc(snap.data!.docs[index].id)
                                        .delete()
                                        .then((val) async {
                                          deleteID(snap.data!.docs[index].id);
                                        });
                                  },
                                  icon: Icon(Icons.delete),
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

  Future<void> deleteID(String id) async {
    print("id .. $id");
    var snap = await FirebaseFirestore.instance
        .collection("habit-progress")
        .get();
    for (var s in snap.docs) {
      if (s["id"] == id) {
        FirebaseFirestore.instance
            .collection("habit-progress")
            .doc(s.id)
            .delete();
      }
    }
  }

  void navigate(BuildContext context, var data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HabitProgress(docs: data)),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubit/habit_home_state.dart';

class HabitHomeCubit extends Cubit<HabitHomeState> {
  HabitHomeCubit() : super(HabitHomeInitialState());

  startNewHabit({
    required String name,
    required String desc,
    required String days,
    required String startDate,
  }) async {
    String localName = name.trim();
    String localDesc = desc.trim();
    String localDay = days.trim();
    String endDate = DateTime.parse(
      startDate,
    ).add(Duration(days: int.parse(days))).toString();

    print("$localDay $localDesc $localName $startDate");
    try {
      final docId = await FirebaseFirestore.instance
          .collection("habit-list")
          .add({
            "title": localName,
            "description": localDesc,
            "days": localDay,
            "uId": FirebaseAuth.instance.currentUser!.uid,
            "startDate": startDate,
            "endDate": endDate,
          });
      print(docId.id);

      await FirebaseFirestore.instance.collection("habit-progress").add({
        "id": docId.id,
        "startDate": startDate,
        "endDate": endDate,
        "completeDay": "0",
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

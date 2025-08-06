import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/app_enum.dart';
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
    ).add(Duration(days: int.parse(days) - 1)).toString();

    print("$localDay $localDesc $localName $startDate");
    try {
      final docId = await FirebaseFirestore.instance
          .collection("habit-list")
          .add({
            "title": localName,
            "description": localDesc,
            "totalDays": localDay,
            "completeDays": "0",
            "uId": FirebaseAuth.instance.currentUser!.uid,
            "startDate": startDate,
            "endDate": endDate,
          });
      print(docId.id);

      await FirebaseFirestore.instance.collection("habit-progress").add({
        "id": docId.id,
        "title": localName,
        "description": localDesc,
        "totalDays": localDay,
        "completeDays": "0",
        "startDate": startDate,
        "endDate": endDate,
        "date": loopDate(sDate: startDate, eDate: endDate),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  List<Map<String, String>> loopDate({
    required String sDate,
    required String eDate,
  }) {
    DateTime localSDate = DateTime.parse(sDate);
    DateTime localEDate = DateTime.parse(eDate);
    List<Map<String, String>> localMap = [];

    print("_sdate start $localSDate");
    print("_edate start $localEDate");

    while (localSDate.isBefore(localEDate) ||
        localSDate.isAtSameMomentAs(localEDate)) {
      print("_sdate $localSDate");
      localMap.add({
        "date": localSDate.toString(),
        "status": ActionType.notStart.name,
      });
      localSDate = localSDate.add(Duration(days: 1));
    }
    return localMap;
  }
}

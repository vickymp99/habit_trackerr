import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/core/utils/Commonutils.dart';
import 'package:habit_tracker/core/utils/app_enum.dart';
import 'package:habit_tracker/core/utils/circular_indicator.dart';
import 'package:habit_tracker/cubit/habit_progress_cubit.dart';
import 'package:habit_tracker/cubit/habit_progress_state.dart';

import 'package:table_calendar/table_calendar.dart';

class HabitProgressWidget extends StatefulWidget {
  const HabitProgressWidget({required this.docs, super.key});
  final QueryDocumentSnapshot<Map<String, dynamic>> docs;

  @override
  State<HabitProgressWidget> createState() => _HabitProgressWidgetState();
}

class _HabitProgressWidgetState extends State<HabitProgressWidget> {
  List dates = [];
  String notCompletedDays = "";
  String completedDays = "";
  String remainingDays = "";
  @override
  void initState() {
    dates = widget.docs["date"];
    dayCalculation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
              ),
              Text("Habit Progress", style: AppStyle.appbarTitle()),
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(height: 24),
          BlocConsumer<HabitProgressCubit, HabitProgressState>(
            listener: (previous, current) {},
            builder: (context, state) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Starts on ${CommonUtils.formatDate("d MMMM yyyy", widget.docs["startDate"])}",
                          style: AppStyle.labelText(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 34),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //   child: CalendarHomePage(
                      //     startDay: DateTime.parse(widget.docs["startDate"]),
                      //     endDay: DateTime.parse(widget.docs["endDate"]),
                      //   ),
                      // ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: dates.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              elevation: 4.0,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey.shade100,
                                ),
                              ),
                              shadowColor: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      CommonUtils.formatDate(
                                        "d MMM yyyy",
                                        dates[index]["date"].toString(),
                                      ),
                                      style: AppStyle.normalText(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: statusColor(
                                          dates[index]["status"],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 50.0),

                      Row(
                        children: [
                          CustomCircularIndicator(
                            currentValue: double.parse(completedDays),
                            totalValue: dates.length.toDouble(),
                            strokeWidth: 25,
                            size: 170,
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Total Days : ${dates.length}",
                                  style: AppStyle.normalText(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Completed Days : $completedDays",
                                  style: AppStyle.normalText(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Not Completed Days : $notCompletedDays",
                                  style: AppStyle.normalText(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Remaining Days: $remainingDays",
                                  style: AppStyle.normalText(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void dayCalculation() {
    print("dates $dates");
    // if (action == ActionType.notStart.name) {
    completedDays = dates
        .where((val) => val["status"] == ActionType.completed.name)
        .toList()
        .length
        .toString();
    notCompletedDays = dates
        .where((val) => val["status"] == ActionType.notCompleted.name)
        .toList()
        .length
        .toString();
    remainingDays = dates
        .where((val) => val["status"] == ActionType.notStart.name)
        .toList()
        .length
        .toString();
    // }
  }

  Color statusColor(String action) {
    if (action == ActionType.notStart.name) {
      return Colors.black;
    } else if (action == ActionType.completed.name) {
      return Colors.green;
    } else if (action == ActionType.notCompleted.name) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  bottomSheet() async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Habit Action', style: AppStyle.labelText()),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text("Completed", style: AppStyle.buttonText()),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        "Not Completed",
                        style: AppStyle.buttonText(),
                      ),
                    ),
                  ),

                  SizedBox(height: 75),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextFieldEditingWidget extends StatelessWidget {
  final String title;
  const TextFieldEditingWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}

class CalendarHomePage extends StatefulWidget {
  final DateTime startDay;
  final DateTime endDay;

  const CalendarHomePage({
    super.key,
    required this.endDay,
    required this.startDay,
  });

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  List<DateTime> dates = [];

  @override
  void initState() {
    _focusedDay = DateTime.now().add(Duration(days: 5));
    loopDate();

    super.initState();
  }

  bottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Habit Action', style: AppStyle.labelText()),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text("Completed", style: AppStyle.buttonText()),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        "Not Completed",
                        style: AppStyle.buttonText(),
                      ),
                    ),
                  ),

                  SizedBox(height: 75),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isWithinRange(DateTime day) {
    return day.isAfter(widget.startDay.subtract(Duration(days: 0))) &&
        day.isBefore(widget.endDay.add(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2025, 7, 1),
      lastDay: DateTime.utc(2025, 9, 10),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        print(selectedDay);
        print(focusedDay);

        print(selectedDay.isAtSameMomentAs(DateTime.now()));
        print(selectedDay.isBefore(DateTime.now()));

        if (selectedDay.isAtSameMomentAs(DateTime.now()) ||
            selectedDay.isBefore(DateTime.now())) {
          bottomSheet();
        }

        // bottomSheet();
        // print("fffff");
        // setState(() {
        //   _selectedDay = selectedDay;
        //   _focusedDay = focusedDay;
        // });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        // selectedDecoration: BoxDecoration(
        //   color: Colors.blue,
        //   shape: BoxShape.circle,
        // ),
      ),

      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          print(
            "day $day ${day.isAtSameMomentAs(widget.startDay.add(Duration(days: 0)))}",
          );
          print("focus ${widget.startDay}");
          if (_isWithinRange(day) && DateTime.now().isAfter(day)) {
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('${day.day}', style: TextStyle(color: Colors.white)),
            );
          } else if (day.isAtSameMomentAs(widget.startDay)) {
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('${day.day}', style: TextStyle(color: Colors.white)),
            );
          }
          return null; // use default for other dates
        },
        // defaultBuilder: (context, day, focusedDay) {
        //   final colors = {
        //     // DateTime(2025, 8, 1): Colors.red,
        //     // DateTime(2025, 8, 2): Colors.red,
        //     // DateTime(2025, 8, 3): Colors.green,
        //     // DateTime(2024, 8, 4): Colors.green,
        //     // DateTime(2024, 8, 5): Colors.blue,
        //   };
        //
        //   DateTime formattedDay = DateTime(day.year, day.month, day.day);
        //
        //   if (colors.containsKey(formattedDay)) {
        //     return Container(
        //       margin: EdgeInsets.all(6),
        //       decoration: BoxDecoration(
        //         color: colors[formattedDay],
        //         shape: BoxShape.circle,
        //       ),
        //       alignment: Alignment.center,
        //       child: Text('${day.day}', style: TextStyle(color: Colors.white)),
        //     );
        //   }
        //
        //   return null; // use default rendering
        // },
      ),
    );
  }

  void loopDate() {
    DateTime _sdate = widget.startDay;
    DateTime _edate = widget.endDay;

    print("_sdate start $_sdate");
    print("_edate start $_edate");

    while (_sdate.isBefore(_edate) || _sdate.isAtSameMomentAs(_edate)) {
      print("_sdate $_sdate");
      dates.add(_sdate);
      _sdate = _sdate.add(Duration(days: 1));
    }

    print("list ${dates.toString()}");
  }
}

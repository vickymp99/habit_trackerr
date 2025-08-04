import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/core/utils/Commonutils.dart';

import 'package:table_calendar/table_calendar.dart';

class HabitProgressWidget extends StatelessWidget {
  const HabitProgressWidget({super.key});

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
              IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
              Text("Habit Progress", style: AppStyle.appbarTitle()),
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      // "Starts on ${CommonUtils.formatDate("d MMMM yyyy", "")}",
                      "Starts on ",
                      style: AppStyle.labelText(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 34),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CalendarHomePage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarHomePage extends StatefulWidget {
  // final String startDate;
  // final String endDate;

  const CalendarHomePage({
    // required this.startDate,
    // required this.endDate,
    super.key,
  });

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    // _focusedDay = DateTime.parse(widget.startDate);
    _focusedDay = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        // todayDecoration: BoxDecoration(
        //   color: Colors.orange,
        //   shape: BoxShape.circle,
        // ),
        // selectedDecoration: BoxDecoration(
        //   color: Colors.blue,
        //   shape: BoxShape.circle,
        // ),
      ),

      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final colors = {
            // DateTime(2025, 8, 1): Colors.red,
            // DateTime(2025, 8, 2): Colors.red,
            // DateTime(2025, 8, 3): Colors.green,
            // DateTime(2024, 8, 4): Colors.green,
            // DateTime(2024, 8, 5): Colors.blue,
          };

          DateTime formattedDay = DateTime(day.year, day.month, day.day);

          if (colors.containsKey(formattedDay)) {
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colors[formattedDay],
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('${day.day}', style: TextStyle(color: Colors.white)),
            );
          }

          return null; // use default rendering
        },
      ),
    );
  }
}

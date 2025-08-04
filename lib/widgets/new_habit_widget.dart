import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:habit_tracker/core/utils/Commonutils.dart';
import 'package:habit_tracker/cubit/habit_home_cubit.dart';

enum FieldType { number, string, date }

class NewHabitWidget extends StatelessWidget {
  NewHabitWidget({super.key});

  String habitName = "";
  String habitDesc = "";
  String habitDays = "";
  String startDate = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back, size: 24),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text("New Habit", style: AppStyle.appbarTitle()),
              ),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWithTextFieldWidget(
                    hintText: "Habit Name",
                    textName: "Habit Name",
                    type: FieldType.string,
                    fn: (String val) {
                      habitName = val;
                    },
                  ),
                  TextWithTextFieldWidget(
                    hintText: "Enter description (optional)",
                    textName: "Habit Description",
                    type: FieldType.string,
                    fn: (String val) {
                      habitDesc = val;
                    },
                  ),

                  TextWithTextFieldWidget(
                    hintText: "how many days you want to do",
                    textName: "Challenge Days",
                    type: FieldType.number,
                    fn: (String val) {
                      habitDays = val;
                    },
                  ),
                  TextWithTextFieldWidget(
                    hintText: "Start date",
                    textName: "Start date",
                    type: FieldType.number,
                    enable: false,
                    fn: (dynamic val) {
                      if (val != null) {
                        startDate = val.toString();
                        print(DateTime.parse(startDate));
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HabitHomeCubit>(
                            context,
                          ).startNewHabit(
                            name: habitName,
                            desc: habitDesc,
                            days: habitDays,
                            startDate: startDate,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Start a New Habit",
                            style: AppStyle.buttonText(),
                          ),
                        ),
                      ),
                    ),
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

class TextWithTextFieldWidget extends StatelessWidget {
  final String textName;
  final String hintText;
  final FieldType type;
  final Function fn;
  final bool enable;
  final TextEditingController _textController = TextEditingController();
  TextWithTextFieldWidget({
    required this.textName,
    required this.type,
    super.key,
    required this.fn,
    required this.hintText,
    this.enable = true,
  });

  TextInputType inputType(FieldType type) {
    switch (type) {
      case FieldType.number:
        return TextInputType.number;
      case FieldType.string:
        return TextInputType.text;
      case FieldType.date:
        return TextInputType.datetime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textName, style: AppStyle.fieldLabelText()),
        SizedBox(height: 16.0),
        Focus(
          onFocusChange: (value) {
            if (!value) {
              fn(_textController.text);
            }
          },
          child: InkWell(
            onTap: () {
              if (!enable) {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(
                    DateTime.now().year + 10,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                ).then((val) {
                  print("Val...$val");
                  if (val != null) {
                    _textController.text = CommonUtils.formatDate(
                      "d MMMM yyyy",
                      val.toString(),
                    );
                    fn(val);
                  }
                });
              }
            },

            child: TextField(
              enabled: enable,
              keyboardType: inputType(type),
              controller: _textController,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: hintText,
                suffixIcon: !enable ? Icon(Icons.lock_clock) : null,
                hintStyle: AppStyle.hintText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}

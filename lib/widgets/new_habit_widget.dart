import 'package:flutter/material.dart';

enum FieldType { number, string, date }

class NewHabitWidget extends StatelessWidget {
  const NewHabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 24,),
              Center(child: Text("Your Habits")),
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
                  ),
                  SizedBox(height: 24.0),
                  TextWithTextFieldWidget(
                    hintText: "Enter description (optional)",
                    textName: "Habit Description",
                    type: FieldType.string,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Start a New Habit",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
  final TextEditingController _textController = TextEditingController();
  TextWithTextFieldWidget({
    required this.textName,
    required this.type,
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textName),
        SizedBox(height: 16.0),
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

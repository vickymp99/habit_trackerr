import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/app_style_constants.dart';
import 'package:intl/intl.dart';

class CommonUtils {
  static String formatDate(String formatString, String date) {
    DateTime localDate = DateTime.parse(date);
    return DateFormat(formatString).format(localDate);
  }

  static logOut(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure to logout?",
            style: AppStyle.fieldLabelText(),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                "Cancel",
                style: AppStyle.normalText(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                "Log out",
                style: AppStyle.normalText(color: Colors.white),
              ),
            ),
          ],
        );
      },
    ).then((val) {
      if (val != null && val) {
        FirebaseAuth.instance.signOut();
      }
    });
  }
}

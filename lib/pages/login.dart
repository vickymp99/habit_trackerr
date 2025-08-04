import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/habit_home.dart';
import 'package:habit_tracker/widgets/login_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          key: GlobalKey(debugLabel: "login-key"),
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (FirebaseAuth.instance.currentUser == null) {
              return LoginWidget();
            } else {
              return HabitHome();
            }
          },
        ),
      ),
    );
  }
}

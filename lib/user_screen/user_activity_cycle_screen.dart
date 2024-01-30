import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserActivityCycleScreen extends StatelessWidget {
  const UserActivityCycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(child: AppUtils.customProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Waiting for Connection...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          // Display an error message on the UI
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          //if homeScreen
          return const HomeScreen();
        } else {
          ///login
          return const LogInScreen();
        }
      },
    );
  }
}

import 'package:bloodunity/user_screen/user_activity_cycle_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///title
      title: 'Blood Unity',

      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///theme
      theme: ThemeData(
        ///colorScheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

        ///cardTheme
        cardTheme: const CardTheme(color: Colors.white),

        ///primaryColor
        primaryColor: Colors.red,

        ///app bar theme
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),

        ///useMaterial3
        useMaterial3: true,
      ),

      ///home initial screen
      home: const UserActivityCycleScreen(),
    );
  }
}

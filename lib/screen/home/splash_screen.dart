import 'dart:async';

import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///timer
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 8), (timer) async {
      await Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const LogInScreen();
      }));
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/182236982/photo/blood.jpg?s=612x612&w=0&k=20&c=xnO5tu_2LcCMpQalXDEVLorUQoXU0GAggG4qQ7lesNM='),
              ),
            ),

            const SizedBox(height: 50),

            ///title
            const Text(
              'WELCOME TO BLOOD UNITY',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 70),

            ///progress bar
            Container(child: AppUtils.customProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

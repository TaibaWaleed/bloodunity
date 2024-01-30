import 'dart:async';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/initial_screen/user_way_entry_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///timer
  Timer? timer;

  ///init state
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const UserWayEntryScreen();
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
    ///

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///logo
            Container(
              child: const CircleAvatar(
                radius: 100,
              ),
            ),
            const SizedBox(height: 20),

            ///title
            const Text(
              'WELCOME TO SHOPBIZ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            AnimatedTextKit(
                repeatForever: true,
                isRepeatingAnimation: true,
                totalRepeatCount: 5,
                animatedTexts: [
                  TyperAnimatedText('Buy Anything you want',
                      textAlign: TextAlign.center,
                      textStyle: AppUtils.animationStyle()),
                  TyperAnimatedText('Just in 1 click',
                      textAlign: TextAlign.center,
                      textStyle: AppUtils.animationStyle()),
                  TyperAnimatedText(
                      'We Deliver Your products at your door step',
                      textAlign: TextAlign.center,
                      textStyle: AppUtils.animationStyle()),
                ]),

            const SizedBox(height: 20),

            ///progress bar
            Container(child: AppUtils.customProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/screen/credientals/signup_screen.dart';
import 'package:flutter/material.dart';

class UserWayEntryScreen extends StatelessWidget {
  const UserWayEntryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

            ///
            const SizedBox(height: 20),

            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: AppUtils.animationStyle(),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Shopbiz',
                      textStyle: AppUtils.animationStyle(),
                      speed: const Duration(milliseconds: 600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            ///
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    shape: const StadiumBorder(),
                    color: Colors.blue,
                    child: const Center(child: Text('LOGIN')),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_) {
                        return const LogInScreen();
                      }), (route) => false);
                    },
                  ),
                ),
                const SizedBox(width: 16), // Adjusted spacing
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    shape: const StadiumBorder(),
                    color: Colors.red,
                    child: const Center(child: Text('SIGNUP')),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (_) {
                        return const SignUpScreen();
                      }), (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

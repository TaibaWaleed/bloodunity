import 'package:bloodunity/screen/blood_user_screen/blood_rate_app_screen.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_share_app.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/screen/privacy_screen/privacy_screen.dart';
import 'package:bloodunity/screen/profile/blood_group_tips/blood_group_tips.dart';
import 'package:bloodunity/screen/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BloodUserMenuScreen extends StatefulWidget {
  const BloodUserMenuScreen({Key? key}) : super(key: key);

  @override
  State<BloodUserMenuScreen> createState() => _BloodUserMenuScreenState();
}

class _BloodUserMenuScreenState extends State<BloodUserMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://t4.ftcdn.net/jpg/06/81/51/81/240_F_681518121_LN4LfnyObzdsL7RPG00BQOAvp7sdv1Al.jpg'),
                        fit: BoxFit.fill),
                  ),
                  height: 200,
                ),
              ),
            ),

            ListTile(
              title: Text(
                'General',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            ///blood profile
            _listTile(
              context,
              () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return BloodProfileScreen();
                }));
              },
              Icons.person_outline,
              'Profile',
            ),

            ///
            _listTile(
              context,
              () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const BloodTipScreen();
                }));
              },
              Icons.tips_and_updates_outlined,
              'Blood Tips',
            ),

            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PrivacyScreen();
              }));
            }, Icons.privacy_tip, 'Privacy'),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RateAppScreen();
              }));
            }, Icons.rate_review, 'Rate App'),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const ShareApp();
              }));
            }, Icons.share, 'Share App'),

            _listTile(context, () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                return const LogInScreen();
              }), (route) => false);
            }, Icons.logout, 'LogOut'),
          ],
        ),
      ),
    );
  }

  static Widget _listTile(
    BuildContext context,
    void Function()? onTap,
    IconData leadingIcon,
    String title,
  ) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(leadingIcon),
          title: Text(title),
          trailing: const Icon(Icons.forward_outlined),
        ),
      ],
    );
  }
}

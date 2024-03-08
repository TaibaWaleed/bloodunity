import 'package:bloodunity/screen/blood_user_screen/blood_add_request.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_rate_app_screen.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_share_app.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/screen/profile/blood_group_tips/blood_group_tips.dart';
import 'package:bloodunity/screen/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget drawerComponent(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Drawer(
    backgroundColor: Colors.red,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const SizedBox(
          height: 200,
          child: Center(
            child: Text(
              'WELCOME  TO BLOOD UNITY ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              _listTileComponent(context, () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return BloodProfileScreen();
                  }),
                );
              }, Icons.person, 'User Profile'),
              const Divider(),
              _listTileComponent(context, () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return BloodTipScreen();
                  }),
                );
              }, Icons.tips_and_updates, 'Blood Tips'),
              Divider(),
              _listTileComponent(context, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return RateAppScreen();
                }));
              }, Icons.rate_review, 'Rate App'),
              Divider(),
              _listTileComponent(context, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const ShareApp();
                }));
              }, Icons.share, 'Share App'),
              Divider(),
              _listTileComponent(context, () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) {
                  return const LogInScreen();
                }), (route) => false);
              }, Icons.logout, 'LogOut'),
              Divider(),
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget for each ListTile in the drawer
Widget _listTileComponent(
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
        trailing: Icon(Icons.forward_outlined),
      )
    ],
  );
}

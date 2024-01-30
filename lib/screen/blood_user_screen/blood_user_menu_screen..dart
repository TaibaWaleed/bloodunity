import 'package:bloodunity/screen/blood_user_screen/blood_rate_app_screen.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_request_screen.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_share_app.dart';
import 'package:bloodunity/screen/blood_user_screen/donor_detail_screen.dart';
import 'package:bloodunity/screen/credientals/login_screen.dart';
import 'package:bloodunity/screen/crud/update_blood_screen.dart';
import 'package:bloodunity/screen/privacy_screen/privacy_screen.dart';
import 'package:bloodunity/screen/profile/profile_screen.dart';
import 'package:bloodunity/screen/review_screen/review_screen.dart';
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
              height: 5,
            ),
            ListTile(
              title: Text(
                'Requests',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const RequestScreen();
              }));
            }, Icons.image, 'Manage Requests'),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'General',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
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
            _listTile(
              context,
              () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const UpdateBloodScreen();
                }));
              },
              Icons.update,
              'Update Blood',
            ),
            _listTile(
              context,
              () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const ReviewScreen();
                }));
              },
              Icons.feedback,
              'Review/Feedback',
            ),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const DonorDetailScreen();
              }));
            }, Icons.details, 'Blood Detail'),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const PrivacyScreen();
              }));
            }, Icons.privacy_tip, 'Privacy'),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RateAppScreen();
              }));
            }, Icons.rate_review, 'Rate'),
            _listTile(context, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const ShareApp();
              }));
            }, Icons.share, 'ShareApp'),
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
